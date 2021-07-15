Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC82C3C9C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 12:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbhGOKcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 06:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhGOKcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:32:13 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF84C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:29:20 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h6so5834825iok.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kyAUEtVezo404CIhWOUhgzbjRjPd8h5hzpJdBeSKQTA=;
        b=MgSlsyn3Nhbd3AUpNvhT2NNSOEuryc1QPty6/CeUj7ZT/L8YGN9vfY/5WhcT8oFpLq
         +ZzDbI1DcXeY1bi612mypZhwKG1kbXlZuvQJEuYfkNWtHqrj196LtO9j93x2Xlo8GWk/
         P2pJZFPwBtHM27073EVY13e4IEJ+71ppA5W2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kyAUEtVezo404CIhWOUhgzbjRjPd8h5hzpJdBeSKQTA=;
        b=T0fohOuCkyMMdvooxu1DMuAljlS7CGV4GQzANzKDe24VcHR/8ksx9yy/55w8typ+S3
         kL/0gmMF0hN6fb/KoGp63nAtj8pHXgbDuLxUeRIdme0jwdthy2inMYjHxkQKAylsefVl
         c7PfDyqkuLLUuhWTPP+Iwngh4jdeLXZb6rxQip58FMv5Z4M168jG6N1qtFKvOR09OQRe
         XoiGW8sWkOaKN6mryD+zGysAYom/EDpKF7EQMfaf+oESegtBIvNa0G/nRHvuLYPtSFSd
         cDRL6AV4D+ED4XpKEe0XMfD/Lg/Zt4pPK3EITWCr/lGdwrE3j+v9iQpJWyyC95HVnKpz
         LVYw==
X-Gm-Message-State: AOAM531coUbhFDm36WZhziGffoc6BtYvaNXyXUp8DHAhGApOs9TKDsIQ
        X+SdHrxMxV2Fhc6SawhvmO9WNUb0h+4dPUKMI18cVg==
X-Google-Smtp-Source: ABdhPJw2mxWU+xXAkJO3mI+OX6znH1/i0GZ7cnWBtNO+Lv/xTP1hKsZ7ryl5bIuMk2imtrZIb2VbdDupmxJUEhRymko=
X-Received: by 2002:a02:cce6:: with SMTP id l6mr3377311jaq.114.1626344959355;
 Thu, 15 Jul 2021 03:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210712080736.116435-1-linux@fw-web.de>
In-Reply-To: <20210712080736.116435-1-linux@fw-web.de>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 15 Jul 2021 18:28:53 +0800
Message-ID: <CAJMQK-i9cGUUXLDr95nCghLd6jmR0tmdPv_PiyN1gC1+JD-2Mw@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: dpi: fix NULL dereference in mtk_dpi_bridge_atomic_check
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 4:08 PM Frank Wunderlich <linux@fw-web.de> wrote:
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> bridge->driver_private is not set (NULL) so use bridge_to_dpi(bridge)
> like it's done in bridge_atomic_get_output_bus_fmts
>
> Fixes: ec8747c52434 ("drm/mediatek: dpi: Add bus format negotiation")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

Tested on a mt8183 device.


> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index bced555648b0..a2eca1f66984 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -605,7 +605,7 @@ static int mtk_dpi_bridge_atomic_check(struct drm_bridge *bridge,
>                                        struct drm_crtc_state *crtc_state,
>                                        struct drm_connector_state *conn_state)
>  {
> -       struct mtk_dpi *dpi = bridge->driver_private;
> +       struct mtk_dpi *dpi = bridge_to_dpi(bridge);
>         unsigned int out_bus_format;
>
>         out_bus_format = bridge_state->output_bus_cfg.format;
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
