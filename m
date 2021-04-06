Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDB7355245
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245622AbhDFLdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242922AbhDFLdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:33:36 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39008C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 04:33:27 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id n4so5939427ili.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 04:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WieXwc6mS+AtUYkNra6+bBu4m3Tu6pHMOzAqHJrznfc=;
        b=QYJFNglHc4lpjNudI/R3Fey6LFOo8gdrDYe3kxhQLJrb0+M+rGQdOW2p+9lFaDnNTs
         q2A+2Ze6SXEJSLdFwh9vIKuB3fmdXRvNjNusXf64VYb7esnp7NMlGqIMY1LM+K9nCdtR
         aKkjPB6U+nnzVl1F3xuGkV5keyoxvBXAYm/JJoO9ILAWzCZ4U5pzJ6uClSE/zZd8Xhe0
         mn1+XIin71hyZffexeG9qjkFUYDwArIBtNwnunLEufNjMlTsVg0R1gWAj0zb4oMpHhjm
         ZrfqS2E249g88C/iIQebCUJbZ90gLWT9wpE1dytgvLpfc0JcvjQuKAR12281VSXLyXRy
         tcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WieXwc6mS+AtUYkNra6+bBu4m3Tu6pHMOzAqHJrznfc=;
        b=euaFs3RXcLQAYZn/yfQLy9cHX9J+uGJ7GpdU6yGwLbyA6gOpVhLT4JnQb3M/BiZju9
         DneijnjrQSrCQC3FAZhApdvJ/Z3wMZbkQopPNswO4gN6tE68yP7VPbaHPjHR4KfT7rRU
         29S3WdllehXhaSYOfKyW3kNgPUFRhy4A9+Ldm1EBi3sK9woS7Y6ePC+1sjiMoM4SX7I/
         etQD6b+BgBFqIK7aegJHZyB38dWBLZ57gnRQMa4+dqUFaxuznWrdfc1bpS/W0ida/8St
         mPM2FqEUiG2qPvU6FOYVq9lphsiHeGL7qUPs7K9TW3NtuJtiE2GSzhHej30LWqZ1EmBI
         4Xzg==
X-Gm-Message-State: AOAM531rPY1uYiW788bivrruaD8SUjiMk7hC0UaLZXz/Vgr3tJumM3+d
        DPxaivkkMtAYXGAHKPexFqiLLlFCJAC7kXFGd9vm6A7wfW5MyA==
X-Google-Smtp-Source: ABdhPJwuT2aSBPHnn1aXEf6nMsd8tqPS91Ogr1ash1axfraDusRzGRBkAcnSY2IANo3i4D/q2nspZkzcmYKas9ccVxc=
X-Received: by 2002:a92:7f03:: with SMTP id a3mr23464910ild.203.1617708806688;
 Tue, 06 Apr 2021 04:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210406113243.2665847-1-fparent@baylibre.com>
In-Reply-To: <20210406113243.2665847-1-fparent@baylibre.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Tue, 6 Apr 2021 13:33:15 +0200
Message-ID: <CAOwMV_zSU9q71djtit1qK4muV3MDcVeYRmFwmGUvNf=9b_ufiw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAxLzNdIPCfk6QgYXJtNjQ6IGR0czogbWVkaWF0ZWs6IG10ODE2Nw==?=
        =?UTF-8?B?OiBhZGQgbGFyYiBub2Rlcw==?=
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, some unicode character ended up in the patch. Removing them in v3

On Tue, Apr 6, 2021 at 1:32 PM Fabien Parent <fparent@baylibre.com> wrote:
>
> Add larb nodes for MT8167:
> * larb0 is used for display (dsi and hdmi)
> * larb1 is used for camera (csi)
> * larb2 is used for the video hardware decoder
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>
> Note: This series is based on https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/log/?h=v5.12-next/dts64-2
>
> V2:
>         * Removed unneeded mediatek,larb-id property
>
>  arch/arm64/boot/dts/mediatek/mt8167.dtsi | 30 ++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> index 4b951f81db9e..bbddd4b22d3e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> @@ -140,5 +140,35 @@ smi_common: smi@14017000 {
>                         clock-names = "apb", "smi";
>                         power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
>                 };
> +
> +               larb0: larb@14016000 {
> +                       compatible = "mediatek,mt8167-smi-larb";
> +                       reg = <0 0x14016000 0 0x1000>;
> +                       mediatek,smi = <&smi_common>;
> +                       clocks = <&mmsys CLK_MM_SMI_LARB0>,
> +                                <&mmsys CLK_MM_SMI_LARB0>;
> +                       clock-names = "apb", "smi";
> +                       power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +               };
> +
> +               larb1: larb@15001000 {
> +                       compatible = "mediatek,mt8167-smi-larb";
> +                       reg = <0 0x15001000 0 0x1000>;
> +                       mediatek,smi = <&smi_common>;
> +                       clocks = <&imgsys CLK_IMG_LARB1_SMI>,
> +                                <&imgsys CLK_IMG_LARB1_SMI>;
> +                       clock-names = "apb", "smi";
> +                       power-domains = <&spm MT8167_POWER_DOMAIN_ISP>;
> +               };
> +
> +               larb2: larb@16010000 {
> +                       compatible = "mediatek,mt8167-smi-larb";
> +                       reg = <0 0x16010000 0 0x1000>;
> +                       mediatek,smi = <&smi_common>;
> +                       clocks = <&vdecsys CLK_VDEC_CKEN>,
> +                                <&vdecsys CLK_VDEC_LARB1_CKEN>;
> +                       clock-names = "apb", "smi";
> +                       power-domains = <&spm MT8167_POWER_DOMAIN_VDEC>;
> +               };
>         };
>  };
> --
> 2.31.0
>
