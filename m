Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95073554BF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344382AbhDFNNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344369AbhDFNN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:13:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190A1C061760;
        Tue,  6 Apr 2021 06:13:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e18so14186000wrt.6;
        Tue, 06 Apr 2021 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1reTPibzqrGVFT+HaxpJOSIl23ImGuDdQsAq06ZO/Os=;
        b=DI2zdnbiorjV/BiuA/2TO8JnwtvPJSK9Xrnt88nEYjGhmwM6LyfHehFMO6oNLKslNm
         qCJq/kBlKsePKFw6+8+OFE3TAmOzgXRbKDmbhcuu0JiiUB+V8wMfxwYtHQaLP/veILVv
         3iWaBMyxxQ1TnIt+dBqfvDbul3Tmnk48yhClA9cuYXB9GEXou1uU4Uc6U8A3XP4WNsc+
         WkYtO3s9jZ7oMSi01wV8Y/GYkDcXMJrZXDU0FHH2klFcgNXKQDECAJambHjADx+MQ1ks
         88kbF9JWkQGHK+koms02/S+b27akuptWxivt28eRQu2NoJ9uF7D9pgxOKkDJleWbKSZ9
         4qbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1reTPibzqrGVFT+HaxpJOSIl23ImGuDdQsAq06ZO/Os=;
        b=XYmRtQGpV7yUOSpORhe7vagkS3f07veFAhUR/s7GcT4w+Q+CtxwHtzYhES9fg4kVEG
         m4YwIPXUAiYnP+HNUuSO4ZVMjaxMgkPRb+BZ0S0OGXUvtX06/DzJMwWjr0yJ4VLLVxOg
         7GwjAeC8q0ACi0yzKUwYsHOuOyljdWmfLlDvTvQ+Tt783kxXEtQy99meV5U+0F62uQk5
         Xn8BaThBM1wVvAMxPCnQydK/05FQH2rS5MWmF5bAYI5sr8SJU4qOz1dxvBOAqgqxUWko
         kBKNunq/yICrc195mToHUVpHuujvWQ4DryFQOcPPkSXUMOcLjvwEI/+gnnaVXzQOLPRq
         yBtg==
X-Gm-Message-State: AOAM533rphsOuga5vQQpVYn2jnzqOhco2jzbSTEahOShFjVG141YqTM5
        qIe7ONqSHGltcmsNXNvdI/vg+btddLJU9g==
X-Google-Smtp-Source: ABdhPJyHZmEn6eYBVg4t6dkfp3oa8GKNP6QfNTV/r9jX0JOf60dAFWffxjiwkJV89hjkfCyiTheTqw==
X-Received: by 2002:adf:8b4e:: with SMTP id v14mr34526578wra.103.1617714796849;
        Tue, 06 Apr 2021 06:13:16 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id 24sm2752663wmg.19.2021.04.06.06.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 06:13:16 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] arm64: dts: mediatek: mt8167: add larb nodes
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     mkorpershoek@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210406113631.2675029-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d554d512-34c2-db46-990f-ac3b4fc18557@gmail.com>
Date:   Tue, 6 Apr 2021 15:13:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210406113631.2675029-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/04/2021 13:36, Fabien Parent wrote:
> Add larb nodes for MT8167:
> * larb0 is used for display (dsi and hdmi)
> * larb1 is used for camera (csi)
> * larb2 is used for the video hardware decoder
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Whole series applied to v5.12-next/dts64-2

Thanks!

> ---
> 
> Note: This series is based on https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/log/?h=v5.12-next/dts64-2
> 
> V3:
> 	* Removed unicode character in commit summary
> V2:
> 	* Removed unneeded mediatek,larb-id property
> 
>  arch/arm64/boot/dts/mediatek/mt8167.dtsi | 30 ++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> index 4b951f81db9e..bbddd4b22d3e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> @@ -140,5 +140,35 @@ smi_common: smi@14017000 {
>  			clock-names = "apb", "smi";
>  			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
>  		};
> +
> +		larb0: larb@14016000 {
> +			compatible = "mediatek,mt8167-smi-larb";
> +			reg = <0 0x14016000 0 0x1000>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&mmsys CLK_MM_SMI_LARB0>,
> +				 <&mmsys CLK_MM_SMI_LARB0>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
> +		};
> +
> +		larb1: larb@15001000 {
> +			compatible = "mediatek,mt8167-smi-larb";
> +			reg = <0 0x15001000 0 0x1000>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&imgsys CLK_IMG_LARB1_SMI>,
> +				 <&imgsys CLK_IMG_LARB1_SMI>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8167_POWER_DOMAIN_ISP>;
> +		};
> +
> +		larb2: larb@16010000 {
> +			compatible = "mediatek,mt8167-smi-larb";
> +			reg = <0 0x16010000 0 0x1000>;
> +			mediatek,smi = <&smi_common>;
> +			clocks = <&vdecsys CLK_VDEC_CKEN>,
> +				 <&vdecsys CLK_VDEC_LARB1_CKEN>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT8167_POWER_DOMAIN_VDEC>;
> +		};
>  	};
>  };
> 
