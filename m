Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBF2307264
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhA1JOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhA1JMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:12:06 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01537C061574;
        Thu, 28 Jan 2021 01:11:22 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id a109so4543765otc.1;
        Thu, 28 Jan 2021 01:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpH8ufxoi7Wf0OvvYg4DlAzvPrwoTT0dl+FXt2N9bdw=;
        b=ZG3D9l1mrE8u11+4t1oKrakZ8yoNRc3iqYfBA5JFX711kPox/GdilHmoQd34vIz5q7
         nW/1iTSXzQzCf4rWRapemQKLf4bA3RswLUmLKCWQg40dRNG7ozxOCgYdIn33SS2SnqOF
         1lTlgz9Hf5oOYTlzqYoItp+GObYybgOWDw27u8orGRbM5SmX1+IbZt0sny2HDGxYlvgr
         R6Nk+sFAWjyoL0YTv4yfbn1Wsm/JG2gDMahzUjPX40k1CcUuZpKK8nkFAn+X74fJnyiN
         nPmElhgFBvCCLEy1E6S3C23NUM4xZxeh3NcnHdRxUWoI1/tg0FaY95iiYGIXAeCXND+H
         5mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpH8ufxoi7Wf0OvvYg4DlAzvPrwoTT0dl+FXt2N9bdw=;
        b=gsBJu6XBChcLz7pux9fkUaxnLEFP8kk6jgmTTJIcFYgzIMBbIUy1NYDVfaICjK1Nj3
         /i7G93/IMzsUWalT2O3nywxFHd5OQHR/wOMGaAbv/MJyAUatU1N6zY5FhQ61xyCR1rzb
         UU5NrhdMDmigbd9khvwAn2QHm1UhJ2yMp46shGG3duZPDHBzJKqpUIzX65PC+0DDPveG
         1CBNlJpH8MU3PMi/Lj43jDMfpUARwO7hQM9Aq7KC2rhXit43NrqR8GpsPdHUi2VIjq7p
         jUUV+TS3oalKewzsq2JPyaHryeE1Tqzs7iDs55ur+OtlaxdsGQw3emT6FMvLSHW39uoL
         q2kw==
X-Gm-Message-State: AOAM5328tUw4dgmNVLEyMgb/yGjHWYR/gg6aGpvvA/HzU8HJfis1xZ7f
        sbSe5JCFgYX/paFo0D8jXjwhMob64WTMnvGRtwI=
X-Google-Smtp-Source: ABdhPJwmVwbpJuVCu7aP1ss+R20SLHhCSoSintnWm2cqEvOWeAq3xFHQVy5TXM8vV1E/vhrdcmfiXUh2L7R41WY/m08=
X-Received: by 2002:a05:6830:230b:: with SMTP id u11mr10952979ote.184.1611825081403;
 Thu, 28 Jan 2021 01:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20210128072802.830971-1-hsinyi@chromium.org> <20210128072802.830971-3-hsinyi@chromium.org>
In-Reply-To: <20210128072802.830971-3-hsinyi@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 28 Jan 2021 10:11:09 +0100
Message-ID: <CAFqH_53kVHh2Phyd=xoM7A3g0qz2HACAJHYcgX24eRTo_YE5Cg@mail.gmail.com>
Subject: Re: [PATCH v11 2/9] arm64: dts: mt8183: refine gamma compatible name
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for your patch.

Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dj., 28 de gen.
2021 a les 8:28:
>
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
>
> mt8183 gamma is different with mt8173
> remove mt8173 compatible name for mt8183 gamma
>

Should this patch contain?

Fixes: 91f9c963ce79 ("arm64: dts: mt8183: Add display nodes for MT8183")

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 6c84ccb709af6..9c0073cfad452 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1055,8 +1055,7 @@ aal0: aal@14010000 {
>                 };
>
>                 gamma0: gamma@14011000 {
> -                       compatible = "mediatek,mt8183-disp-gamma",
> -                                    "mediatek,mt8173-disp-gamma";
> +                       compatible = "mediatek,mt8183-disp-gamma";
>                         reg = <0 0x14011000 0 0x1000>;
>                         interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_LOW>;
>                         power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> --
> 2.30.0.280.ga3ce27912f-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
