inpolygonc = @(z,w) inpolygon(real(z), imag(z),real(w),imag(w));

w = [2-1i,-1-1i,-1+1i,2+1i,2+2i,-2+2i,-2-2i,2-2i]./2;
bcs = [nan nan nan 1 nan nan nan -1];

[U,MAXERR,F,Z,ZPLOT,A,Gn,c,psi,II,III] = laplace(w,bcs,'noplots','tol',1e-4);

ww = [w w(1)];
wr = sort(real(ww)); wr = wr([1 end]);
wi = sort(imag(ww)); wi = wi([1 end]);
wc = mean(wr+1i*wi);
scl = max([diff(wr),diff(wi)]);

sx = linspace(wr(1),wr(2),100); sy = linspace(wi(1),wi(2),100);
[xx,yy] = meshgrid(sx,sy); zz = xx + 1i*yy;

u = @(z) real(F(z));
v = @(z) imag(F(z));

uu = u(zz); uu(~inpolygonc(zz,ww)) = nan;
vv = v(zz); vv(~inpolygonc(zz,ww)) = nan;
uu_levels = linspace(min(min(uu)),max(max(uu)),20);
vv_levels = linspace(min(min(vv)),max(max(vv)),10);

LW = 'linewidth'; MS = 'markersize'; FS = 'fontsize';
fs = 14; PO = 'position'; FW = 'fontweight'; NO = 'normal';
ax = [-1 1 -1 1];

subplot(1,2,1)
contour(sx,sy,uu,uu_levels,LW,2), colorbar, axis equal, hold on
plot(ww,'-k',LW,1);
set(gca,FS,fs-1), axis(ax);
title('Contours of constant Re(u)')
hold off

subplot(1,2,2)
contour(sx,sy,vv,vv_levels,LW,2), colorbar, axis equal, hold on
plot(ww,'-k',LW,1);
set(gca,FS,fs-1), axis(ax);
title('Contours of constant Im(u)')
hold off

% exportgraphics(t,'test.png','BackgroundColor','none')