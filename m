Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB43939E6C6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhFGSnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:43:43 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:42667 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhFGSnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:43:42 -0400
Received: by mail-ua1-f47.google.com with SMTP id w5so10260320uaq.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 11:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zN+Q8dgsMzp5svrusLksGWwBggAOjvLUcL+jRhmL2dI=;
        b=SQVA8E6RjJLNBOL9dbK69hBHUkKdfRviB4kGidz9fKEEiBJ6C5ZZjhfjIdB1lfvKMI
         QWGNtGaV1E7wraHhURiulfcu4vYnfkdMdJqXR2b0BfUOFdBQdc8wGaqFuTJEdujkAGx4
         n2k+Evx8s5Cqhdn47fmyOjzQtQQW4WVifnuo5k4HWsCcJiETqIDldhAhRtyfPyE8iQB5
         3++KbIcSDtIrL+QJ27kLeiE9oz3PHIG1yA3PvDNB0/LnqMKrRfs6iI9shhxN0SmfZB/P
         Nx0ECO+UjFzcKKTww2Bu6Ace9rab1PQOB4BCI2mwbJ6u9GDzqw+b2uwQlMnkKhtosu9T
         fr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zN+Q8dgsMzp5svrusLksGWwBggAOjvLUcL+jRhmL2dI=;
        b=T0KSac0l0LCiC8NBqpWzhsD5o+PIj5rCS2r5AGF6JAZCW1o58lVWZFduuQGR5eTCNf
         liQvx0RyB/U1yons/AkRhKuyUM+NoWZ4Y7Unnj/xSBYJjVXbWo7mLTlkganA+LROGMl6
         SGd9NFB11TIdDSs9/DT0r45bVEDZi9lKEBZ5zAZ2TioqcfCKPkokRkHnL/kBBEAkt6FC
         xyueyhX4LyaDsi+YjrCiLsErqNVi8M6W6bbbFo8Pov6K74+6loFJbMqoapyXqMU2T4Uy
         YBRn3EoPMtQ7NfgdPCIePgx0IC/ao9M5aloRs0jTqXAoiMs6npVcIcVgpq2N/xRUiIZN
         ilxQ==
X-Gm-Message-State: AOAM530ah2BJeFg2TiDfxU/IH2jIe/8L0InS2F6kPKzygmw+9KDgDGxb
        tnvpQfCZeo3zFzvvmPB7NYNEN6I0SBXxOqCojzg=
X-Google-Smtp-Source: ABdhPJzmoZOJiKTKN2ANcor0bAuDPWhU5HM92R3OmDGVNSrGSdQr6wQRhWdD5xKfwOVxUsMyDCBnTWnkBESl93cfZD8=
X-Received: by 2002:a9f:31b1:: with SMTP id v46mr10684948uad.22.1623091236278;
 Mon, 07 Jun 2021 11:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210602080212.4992-1-jrdr.linux@gmail.com> <8027801c-5260-8b1b-c758-fdfb8c18e9a7@arm.com>
In-Reply-To: <8027801c-5260-8b1b-c758-fdfb8c18e9a7@arm.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 8 Jun 2021 00:10:24 +0530
Message-ID: <CAFqt6zYh+tAdpDzwQY7KhUSq2t-ZkMJW7P51pX6SnYACRETofQ@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: defined struct rockchip_dp_dt_ids[] under CONFIG_OF
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hjc@rock-chips.com, Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 3:37 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-06-02 09:02, Souptick Joarder wrote:
> > Kernel test robot throws below warning when CONFIG_OF
> > is not set.
> >
> >>> drivers/gpu/drm/rockchip/analogix_dp-rockchip.c:457:34:
> > warning: unused variable 'rockchip_dp_dt_ids' [-Wunused-const-variable]
> >     static const struct of_device_id rockchip_dp_dt_ids[] = {
> >
> > Fixed it by defining rockchip_dp_dt_ids[] under CONFIG_OF.
>
> I think the __maybe_unused annotation is generally preferred over
> #ifdefs these days. However, since these drivers only work with
> devicetree anyway, it probably makes more sense to just remove the
> of_match_ptr() uses which lead to these warnings in the first place.

Ok. Will remove of_match_ptr().
>
> Robin.
>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >   drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> > index ade2327a10e2..9b79ebaeae97 100644
> > --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> > +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> > @@ -454,12 +454,14 @@ static const struct rockchip_dp_chip_data rk3288_dp = {
> >       .chip_type = RK3288_DP,
> >   };
> >
> > +#ifdef CONFIG_OF
> >   static const struct of_device_id rockchip_dp_dt_ids[] = {
> >       {.compatible = "rockchip,rk3288-dp", .data = &rk3288_dp },
> >       {.compatible = "rockchip,rk3399-edp", .data = &rk3399_edp },
> >       {}
> >   };
> >   MODULE_DEVICE_TABLE(of, rockchip_dp_dt_ids);
> > +#endif
> >
> >   struct platform_driver rockchip_dp_driver = {
> >       .probe = rockchip_dp_probe,
> >
