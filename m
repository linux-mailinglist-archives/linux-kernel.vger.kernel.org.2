Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71682357AA0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 05:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhDHDGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 23:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhDHDGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:06:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5E8C061760;
        Wed,  7 Apr 2021 20:05:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x15so455445wrq.3;
        Wed, 07 Apr 2021 20:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lKdC7/GcRXi27PrRJOiKv/q3uAt6xtJXZS5BkSoqVpo=;
        b=QCYbsJwi7mVyLz54b6rFrS/IpMYje8RRL4+QaisFDbpD/CoVq4YjeISHcKQFUd7pXC
         UYJ8OqyZpGz3QMkzN0GQXTO7fYE9VxWvYkCMNfBiO3WuvT2lGrZZTCiHT0wUIp0xvMRL
         t6PqZRncHxNCFY72TQ/yuh9gS0cGS4PeGMvBOAU9JqHO5cSIp2O1dFz6sgw1NkwYUbn2
         0nUOS67MWtdwDF7VlGY8d5tBQ3IvaRIRtHR+CmKWtkBiI4f6FpDvWxDS1H+oYD3BUNqW
         /M2wwAJ9F6TNBRnwlPFm+n/gk0bUKPPXnqDYO4miGjH2qRlK2z3LIRXsTkN9Hj/p7ie7
         8uRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lKdC7/GcRXi27PrRJOiKv/q3uAt6xtJXZS5BkSoqVpo=;
        b=soZqH9QJQBUBVauAcKGhADEKfybi5dhNfEZI1tU4ogOYAU6tPMDo/eYEinb1/5j3RD
         DVW+gFYWHi6bn2cEdTOlCu+4SMTBrbgn+JtnJ6um4x2ghIhLYjym084Tx2v+xhkd7376
         GtAbYMIIVIEecRKkOGeocRMe9rNUQ+xEVmCfHuVHVsSIk+02K5Pv7Q/ZYdVC3x9gZgSZ
         +85yYg3rlwgMcoRUhn2ybTafS4tRd2/kpLtclwC4ZashkQvbf4LutA2nwupFqPbFvGeb
         XT8/3PlW+5pRpRqZsb701a274IOagagwSEPnYtNHHX5pIJ6g9/EF08yOb/oa41Y11bkQ
         KRDw==
X-Gm-Message-State: AOAM5308IJUwgS5E+Xn7gEmoj+FBZ0xYttbI58eh8S/zJ+fr/O9Ib5YC
        8pDWx1dJ9YqMyacU5Wmbo53Kr0oszR/j86/erGM=
X-Google-Smtp-Source: ABdhPJxNQd4+4yhuhkX2f7r1jIUhHtLjWDG+yJqOXbjN166L0IteEXHwasPFD6pqPSus9wr/EjobVkx3914icAR1GQU=
X-Received: by 2002:adf:e5c2:: with SMTP id a2mr6421779wrn.201.1617851148713;
 Wed, 07 Apr 2021 20:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210222132822.7830-1-kevin3.tang@gmail.com> <20210222132822.7830-5-kevin3.tang@gmail.com>
 <20210324111019.og6d3w47swjim2mq@gilmour> <CAFPSGXZ3DjKt87Kc=wc9YKVzTjkQ38Ok6HnHm+VEdqXyHv54Eg@mail.gmail.com>
 <20210407104538.cvssdck26rejrfye@gilmour>
In-Reply-To: <20210407104538.cvssdck26rejrfye@gilmour>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 8 Apr 2021 11:05:12 +0800
Message-ID: <CAAfSe-sGAF9JUvKdipHtTvQ2Ss1VXs-ZuJ=VKJPOvd-bMQvY4Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] drm/sprd: add Unisoc's drm display controller driver
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Kevin Tang <kevin3.tang@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 at 18:45, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> Adding J=C3=B6rg, Will and Robin,

You forgot to add them actually :)
I've added Robin and Joerg.

>
> On Wed, Mar 31, 2021 at 09:21:19AM +0800, Kevin Tang wrote:
> > > > +static u32 check_mmu_isr(struct sprd_dpu *dpu, u32 reg_val)
> > > > +{
> > > > +     struct dpu_context *ctx =3D &dpu->ctx;
> > > > +     u32 mmu_mask =3D BIT_DPU_INT_MMU_VAOR_RD |
> > > > +                     BIT_DPU_INT_MMU_VAOR_WR |
> > > > +                     BIT_DPU_INT_MMU_INV_RD |
> > > > +                     BIT_DPU_INT_MMU_INV_WR;
> > > > +     u32 val =3D reg_val & mmu_mask;
> > > > +     int i;
> > > > +
> > > > +     if (val) {
> > > > +             drm_err(dpu->drm, "--- iommu interrupt err: 0x%04x --=
-\n",
> > > val);
> > > > +
> > > > +             if (val & BIT_DPU_INT_MMU_INV_RD)
> > > > +                     drm_err(dpu->drm, "iommu invalid read error, =
addr:
> > > 0x%08x\n",
> > > > +                             readl(ctx->base + REG_MMU_INV_ADDR_RD=
));
> > > > +             if (val & BIT_DPU_INT_MMU_INV_WR)
> > > > +                     drm_err(dpu->drm, "iommu invalid write error,
> > > addr: 0x%08x\n",
> > > > +                             readl(ctx->base + REG_MMU_INV_ADDR_WR=
));
> > > > +             if (val & BIT_DPU_INT_MMU_VAOR_RD)
> > > > +                     drm_err(dpu->drm, "iommu va out of range read
> > > error, addr: 0x%08x\n",
> > > > +                             readl(ctx->base + REG_MMU_VAOR_ADDR_R=
D));
> > > > +             if (val & BIT_DPU_INT_MMU_VAOR_WR)
> > > > +                     drm_err(dpu->drm, "iommu va out of range writ=
e
> > > error, addr: 0x%08x\n",
> > > > +                             readl(ctx->base + REG_MMU_VAOR_ADDR_W=
R));
> > >
> > > Is that the IOMMU page fault interrupt? I would expect it to be in th=
e
> > > iommu driver.
> >
> > Our iommu driver is indeed an separate driver, and also in upstreaming,
> > but iommu fault interrupts reporting by display controller, not iommu
> >  itself,
> > if use iommu_set_fault_handler() to hook in our reporting function, the=
re
> > must be cross-module access to h/w registers.
>
> Can you explain a bit more the design of the hardware then? Each device
> connected to the IOMMU has a status register (and an interrupt) that
> reports when there's a fault?

On Unisoc's platforms, one IOMMU serves one master device only, and interru=
pts
are handled by master devices rather than IOMMUs, since the registers are i=
n the
physical address range of master devices.

>
> I'd like to get an ack at least from the IOMMU maintainers and
> reviewers.
>
> > > > +static void sprd_dpi_init(struct sprd_dpu *dpu)
> > > > +{
> > > > +     struct dpu_context *ctx =3D &dpu->ctx;
> > > > +     u32 int_mask =3D 0;
> > > > +     u32 reg_val;
> > > > +
> > > > +     if (ctx->if_type =3D=3D SPRD_DPU_IF_DPI) {
> > > > +             /* use dpi as interface */
> > > > +             dpu_reg_clr(ctx, REG_DPU_CFG0, BIT_DPU_IF_EDPI);
> > > > +             /* disable Halt function for SPRD DSI */
> > > > +             dpu_reg_clr(ctx, REG_DPI_CTRL, BIT_DPU_DPI_HALT_EN);
> > > > +             /* select te from external pad */
> > > > +             dpu_reg_set(ctx, REG_DPI_CTRL,
> > > BIT_DPU_EDPI_FROM_EXTERNAL_PAD);
> > > > +
> > > > +             /* set dpi timing */
> > > > +             reg_val =3D ctx->vm.hsync_len << 0 |
> > > > +                       ctx->vm.hback_porch << 8 |
> > > > +                       ctx->vm.hfront_porch << 20;
> > > > +             writel(reg_val, ctx->base + REG_DPI_H_TIMING);
> > > > +
> > > > +             reg_val =3D ctx->vm.vsync_len << 0 |
> > > > +                       ctx->vm.vback_porch << 8 |
> > > > +                       ctx->vm.vfront_porch << 20;
> > > > +             writel(reg_val, ctx->base + REG_DPI_V_TIMING);
> > > > +
> > > > +             if (ctx->vm.vsync_len + ctx->vm.vback_porch < 32)
> > > > +                     drm_warn(dpu->drm, "Warning: (vsync + vbp) < =
32, "
> > > > +                             "underflow risk!\n");
> > >
> > > I don't think a warning is appropriate here. Maybe we should just
> > > outright reject any mode that uses it?
> > >
> >  This issue has been fixed on the new soc, maybe I should remove it.
>
> If it still requires a workaround on older SoC, you can definitely add
> it but we should prevent any situation where the underflow might occur
> instead of reporting it once we're there.
>
> > > > +static enum drm_mode_status sprd_crtc_mode_valid(struct drm_crtc *=
crtc,
> > > > +                                     const struct drm_display_mode
> > > *mode)
> > > > +{
> > > > +     struct sprd_dpu *dpu =3D to_sprd_crtc(crtc);
> > > > +
> > > > +     drm_dbg(dpu->drm, "%s() mode: "DRM_MODE_FMT"\n", __func__,
> > > DRM_MODE_ARG(mode));
> > > > +
> > > > +     if (mode->type & DRM_MODE_TYPE_PREFERRED) {
> > > > +             drm_display_mode_to_videomode(mode, &dpu->ctx.vm);
> > >
> > > You don't seem to use that anywhere else? And that's a bit fragile,
> > > nothing really guarantees that it's the mode you're going to use, and
> > > even then it can be adjusted.
> > >
> >  drm_mode convert to video_mode is been use in "sprd_dpu_init" and
> > "sprd_dpi_init "
> >  Preferred mode should be fixed mode, we generally don=E2=80=99t adjust=
 it.
>
> That's not really the assumption DRM is built upon though. The userspace
> is even allowed to setup its own mode and try to configure it, and your
> driver should take that into account.
>
> I'd just drop that mode_valid hook, and retrieve the videomode if you
> need it in atomic_enable or mode_set_no_fb
>
> > >
> > > > +
> > > > +             if ((mode->hdisplay =3D=3D mode->htotal) ||
> > > > +                 (mode->vdisplay =3D=3D mode->vtotal))
> > > > +                     dpu->ctx.if_type =3D SPRD_DPU_IF_EDPI;
> > > > +             else
> > > > +                     dpu->ctx.if_type =3D SPRD_DPU_IF_DPI;
> > >
> > > From an API PoV, you would want that to be in atomic_check. However, =
I'm
> > > not even sure what it's doing in the first place?
> > >
> > dpi interface mode: DPI(dsi video mode panel) and EDPI(dsi cmd mode pan=
el)
> > dpi interface mode has been used on crtc atomic_enable foo, so we need
> > check dpi interface
> > mode before atomic_enable.
> >
> > Must be put it in atomic_check? Here is the dpi interface mode selectio=
n,
> > maybe here is better?
>
> This doesn't have any relationship to the htotal and vtotal though? it's
> something that is carried over by the MIPI-DSI functions and struct
> mipi_dsi_device.
>
> > >
> > > > +     }
> > > > +
> > > > +     return MODE_OK;
> > > > +}
> > > > +
> > > > +static void sprd_crtc_atomic_enable(struct drm_crtc *crtc,
> > > > +                                struct drm_atomic_state *state)
> > > > +{
> > > > +     struct sprd_dpu *dpu =3D to_sprd_crtc(crtc);
> > > > +
> > > > +     sprd_dpu_init(dpu);
> > > > +
> > > > +     sprd_dpi_init(dpu);
> > > > +
> > > > +     enable_irq(dpu->ctx.irq);
> > >
> > > Shouldn't this be in enable_vblank? And I would assume that you would
> > > have the interrupts enabled all the time, but disabled in your device=
?
> > >
> > It seems better to put in enable_vblank, i will try and test it... Thks
> >
> >   And I would assume that you would
> > have the interrupts enabled all the time, but disabled in your device?
> > [kevin]I don=E2=80=99t quite understand this, can you help me explain i=
t in
> > detail?
>
> You seem to have a register that enables and disables the interrupt in
> that device. The way we usually deal with them in this case is just to
> call request_irq in your bind/probe with the interrupts enabled at the
> controller level, and mask them when needed at the device level by
> clearing / setting that bit.
>
> Maxime
