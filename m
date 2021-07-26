Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383CB3D5750
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhGZJks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhGZJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:40:47 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04820C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 03:21:15 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f12so10714181ljn.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 03:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70X+o4gxoqVmOcvp7WeXhrzKKX6eGZ5QMDEYtNs6KMA=;
        b=B/vovlhWPxahAXgxBeGB7sRBwdK9X/gPTel9zf2v93GlvKIc/3xPxEBu1pAUg4Ht+y
         htvG8VA7My/I7sobqOofsQkt1nm+2ZKfDI0Pgr7jwLU9txHrfC4NbazSlCGZmB0LvkpA
         eoLYsmPTyHq7PMUGCRp52/P2mQSHA+FzSYG2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70X+o4gxoqVmOcvp7WeXhrzKKX6eGZ5QMDEYtNs6KMA=;
        b=lsXBh3UzT2+4x5AdJyKAAIF2WiZ8dkipO6qu/WnVZjN03+WygHPbjjG/fup4ZQrfnP
         iKt9DvF6zhReXg/m3W71fjJqNAFIaNr5ulpW+i1duVDbkE3CLDefwRAeDRloyVBbYFZ6
         BS22YMViFsVxu2qSQcuJMkBYLbnyOr+mFh2Ss6p7DXpPtG4Ld7uexIEQWkRwjpiZ7Mmi
         A36SozooXEqJOSDkMBj4UqXXeuSPowdFWwz2FvCtyFl63NVffOpTpmfmIGZmKOLgaEZ9
         rZZnZLQpXQyXfsPPxodUmLQoSCc67pVRtn6jKa/PsLGKPIoIP0MPEDaJGF5d12jKqbJp
         tgVw==
X-Gm-Message-State: AOAM531XRWzpC9Ut5U4MMJjZqgzFNtK/ZZljFLT5lZ2e98Fie7gIXcAh
        MV44j8spJrSo+XBkxTRTRXFvkahiICsERFSvPzHvWQ==
X-Google-Smtp-Source: ABdhPJxkenPZbBydwKHClv/1HF5JInmSLFW/smf/ijGDtLgwcs2N1oTLO8pBBQNVgoPO0r6jmzMPSV9WgKG+X60d9nI=
X-Received: by 2002:a2e:9215:: with SMTP id k21mr12364515ljg.91.1627294874239;
 Mon, 26 Jul 2021 03:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210726101451.2118076-1-hsinyi@chromium.org>
In-Reply-To: <20210726101451.2118076-1-hsinyi@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Jul 2021 18:21:02 +0800
Message-ID: <CAGXv+5E+NATyk+QHwi2d_+QAM0ByHB_id9_xOpwHw9kc01hm=w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8173: elm: Use aliases to mmc nodes
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Eizan Miyamoto <eizan@chromium.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 6:15 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Use aliases to mmc nodes so the partition name for eMMC and SD card will
> be consistent across boots.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index 21452c51a20a8..be21740d682d0 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -10,6 +10,13 @@
>  #include "mt8173.dtsi"
>
>  / {
> +       aliases {
> +               mmc0 = &mmc0;
> +               mmc1 = &mmc1;
> +               mmc2 = &mmc2;

mmc2 is not used or enabled anywhere. Just skip it.
You can have

        mmc2 = &mmc3;

so that the numbers are consecutive.


ChenYu

> +               mmc3 = &mmc3;
> +       };
> +
>         memory@40000000 {
>                 device_type = "memory";
>                 reg = <0 0x40000000 0 0x80000000>;
> --
> 2.32.0.432.gabb21c7263-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
