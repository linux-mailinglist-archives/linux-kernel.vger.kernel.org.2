Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B0B4596CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 22:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbhKVVix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 16:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239667AbhKVVit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 16:38:49 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC7CC06173E;
        Mon, 22 Nov 2021 13:35:41 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x15so82554807edv.1;
        Mon, 22 Nov 2021 13:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jxcp1t1jcgEPRxeeckii7tW4wro+np5DGUH/lNOO0xM=;
        b=RfPu443cxFF1lfs0hsJBsCk3fi4tGnJqYNg+mZZ61hKo9Gzetk03i65VEtBXSR1oW2
         34hxJrqcsvXSclJUfdyI8UY0w8WWyamjk2f9tfpYXfLZ2g12Me3Rqcl5XIMwomzCWqnT
         FickAI3y6lj/RyUpMYF/E+k7hHukCY3LTOC+0cvcU5AvPIQ4sAbgxMdEp728WUpAt28a
         fuA8olcYcjBDpFQ94HNrE0NUKfA3jJx/qIS6g5eIWTw14FK5SNpZCoZ8GZdHl/bP92qu
         sexwgkBDtg1HTi7poFf4r0ovw1TCLxKFUpkkyBfXlMb23cYj/xx7tVz4HeO3XUs3z+8f
         fvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jxcp1t1jcgEPRxeeckii7tW4wro+np5DGUH/lNOO0xM=;
        b=KNVU2UoHAtSB+uTC6uOl390/xZZ3eG4xU4zFSoA+f+DbkmEWOOuveu2Yl/IS8UkChU
         ZpdXpBkyZKGIDTFTQyvqwKXHkd1n11xIiG8Q3E5kw1/Ncs41pcQ1rpcWrMXgqs0Ej7gw
         flefRDw+fGWnEwUIgrM/5/B13QYa+TaoCdCz0jWKHQCtsXlfCaqjO5JdU7Ifu6BVagpy
         Y9TVRNDP/kZ++jyFq0JHUgVUkOKiBNa2ubJwCBJ9lJ0xw6TeSLBmgIAC/qx/Ju63kLND
         acN8o/MSlbXtrO7qz6VuhC7OB9p6PV7p74bu4/1WgHpedUh/vfnpQOkInEN+SAzGck1L
         9xWw==
X-Gm-Message-State: AOAM532JgxReFNAG3Do2G7g1qnCsoYTxMaZz23ChR4kZiyu59Gq3Y/r0
        oL7je6bROo5Zp6tc5q4vICM=
X-Google-Smtp-Source: ABdhPJwjzngykSKS3UTTHJIzpb60YhKlrzsM6PxUIzbfs8zTdslOHCk39y5MoSxlHVdDaNHocMbPww==
X-Received: by 2002:a50:ab44:: with SMTP id t4mr323367edc.105.1637616940506;
        Mon, 22 Nov 2021 13:35:40 -0800 (PST)
Received: from kista.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id d3sm4653418edx.79.2021.11.22.13.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 13:35:40 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: h6: Add Hantro G2 node
Date:   Mon, 22 Nov 2021 22:35:39 +0100
Message-ID: <2081942.irdbgypaU6@kista>
In-Reply-To: <20211122213429.921919-1-jernej.skrabec@gmail.com>
References: <20211122213429.921919-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 22. november 2021 ob 22:34:29 CET je Jernej Skrabec 
napisal(a):
> H6 SoC has a second VPU, dedicated to VP9 decoding. It's a slightly
> older design, though.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com

Sorry, wrong patch, please ignore.

Regards,
Jernej

> >
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/
dts/allwinner/sun50i-h6.dtsi
> index 4c4547f7d0c7..878061e75098 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -153,6 +153,15 @@ mixer0_out_tcon_top_mixer0: endpoint {
>  			};
>  		};
>  
> +		video-codec-g2@1c00000 {
> +			compatible = "allwinner,sun50i-h6-vpu-g2";
> +			reg = <0x01c00000 0x1000>;
> +			interrupts = <GIC_SPI 90 
IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_VP9>, <&ccu CLK_VP9>;
> +			clock-names = "bus", "mod";
> +			resets = <&ccu RST_BUS_VP9>;
> +		};
> +
>  		video-codec@1c0e000 {
>  			compatible = "allwinner,sun50i-h6-video-
engine";
>  			reg = <0x01c0e000 0x2000>;
> -- 
> 2.34.0
> 
> 


