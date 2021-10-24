Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88C643866A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 05:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhJXDGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 23:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhJXDGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 23:06:39 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24F4C061767
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 20:04:19 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so9790650ote.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 20:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=09khimdAjQRi8HKATJj9Yiw14F//GZIJY/3Fe7+1+Ew=;
        b=lHDyo+4Dao/LPjRiG1bPgSM38hRwp9NmMy+FE4x4UHptLKk5sQX82TX7R+yqo/Sx1k
         vpmwoKDWHfskPP7m3dpCjBSwcLHkZ3OZ+0rZ/xNTX+qi/cB3O2MvU2BGYzrCOPP73+Ko
         Nz8xruVnyHemho7jFWSjyfS7glTYTx1jInbqcttKImabSlDLIUzh/yHzieGAVxO6OGyl
         ZFY2B2eYCP466an727i+vHIuOWDzkDSQJnH0Z9tl0KsQDXQEeGSoYySzgw8cQZooqebY
         XvKTE6zrAC2cCr3Btcl0mS/SOtSmfMNTy8SaWiLYgK3mK3YtlUMpbnLXL9AkO36Vni/Z
         1WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=09khimdAjQRi8HKATJj9Yiw14F//GZIJY/3Fe7+1+Ew=;
        b=neriIKIxoGNG7qxVZvNAiNSemuSkvMTPUb31wQ1rYfEMJIF01JcFJVA3G3z3BqalxY
         qpOWg06+sdpAlCTsJ7fy8gw55pG3eblgGTTn7LTCYH5mRCGGLjK1yGbwo53s6mG93y1L
         OhzBPabLqcL9KxLA1SLAEU9OR4DXo7BY++wVUEyY1ZnSfMgVqq2d8/4nPo0gGYc3nZQP
         pr2rUuK4B0Sw1vQZE8ZMnmbc0nV40QW41H0eiXZykw3LNOcnWXpdZU7OmZWk/FsZ+SuR
         aiDFf3s+uXnlLntfuioP9NCAXXLuTfpRsprCbSKAWTn1uifP4vMgtE8nmuCwWsV7dMi8
         WRYg==
X-Gm-Message-State: AOAM531vIsWd2pg+fU4Qom5uyttEYuygRfLUcGM+3YNu89CATFxnbUGf
        uxwg/YnfDITTcD8Y9WCplZ5Rjw==
X-Google-Smtp-Source: ABdhPJxXIK+1OUczhalebYJ7/W4p3n75GDzIHUTDynp8eQPC+UOq1fcxo3/zmNL2HgmGyBdZhEfL9A==
X-Received: by 2002:a9d:20a3:: with SMTP id x32mr6982286ota.91.1635044658537;
        Sat, 23 Oct 2021 20:04:18 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id h2sm2679287otr.37.2021.10.23.20.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 20:04:17 -0700 (PDT)
Date:   Sat, 23 Oct 2021 22:04:15 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] arm64: dts: qcom: msm8996: Revamp reserved memory
Message-ID: <YXTNL7boyiRFKQiV@builder.lan>
References: <20210926190555.278589-1-y.oudjana@protonmail.com>
 <20210926190555.278589-2-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926190555.278589-2-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 26 Sep 14:06 CDT 2021, Yassine Oudjana wrote:

> Fix a total overlap between zap_shader_region and slpi_region, and rename
> all regions to match the naming convention in other Qualcomm SoC device trees.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

FYI, I like this series, but I held off applying it because I wanted to
verify that the shuffling of the memory regions works on the existing
8996 boards.

Unfortunately it didn't work, either with or without the shuffling on
the db820c - and I've not found the time to figure out why that is. I
hope to get back to this shortly (or that someone else will figure it
out and provide a tested-by)

Regards,
Bjorn

> ---
>  .../dts/qcom/msm8996-sony-xperia-tone.dtsi    | 18 ++++--
>  .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  | 18 +++---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi         | 63 ++++++++++---------
>  3 files changed, 55 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
> index 507396c4d23b..4c26e66f0610 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
> @@ -13,9 +13,10 @@
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
>  
> -/delete-node/ &slpi_region;
> -/delete-node/ &venus_region;
> -/delete-node/ &zap_shader_region;
> +/delete-node/ &adsp_mem;
> +/delete-node/ &slpi_mem;
> +/delete-node/ &venus_mem;
> +/delete-node/ &gpu_mem;
>  
>  / {
>  	qcom,msm-id = <246 0x30001>; /* MSM8996 V3.1 (Final) */
> @@ -46,18 +47,23 @@ cont_splash_mem: memory@83401000 {
>  			no-map;
>  		};
>  
> -		zap_shader_region: gpu@90400000 {
> +		adsp_mem: adsp@8ea00000 {
> +			reg = <0x0 0x8ea00000 0x0 0x1a00000>;
> +			no-map;
> +		};
> +
> +		gpu_mem: gpu@90400000 {
>  			compatible = "shared-dma-pool";
>  			reg = <0x0 0x90400000 0x0 0x2000>;
>  			no-map;
>  		};
>  
> -		slpi_region: memory@90500000 {
> +		slpi_mem: memory@90500000 {
>  			reg = <0 0x90500000 0 0xa00000>;
>  			no-map;
>  		};
>  
> -		venus_region: memory@90f00000 {
> +		venus_mem: memory@90f00000 {
>  			reg = <0 0x90f00000 0 0x500000>;
>  			no-map;
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> index d239b01b8505..a5e7bccadba2 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> @@ -66,32 +66,32 @@ memory@88800000 {
>  
>  		/* This platform has all PIL regions offset by 0x1400000 */
>  		/delete-node/ mpss@88800000;
> -		mpss_region: mpss@89c00000 {
> +		mpss_mem: mpss@89c00000 {
>  			reg = <0x0 0x89c00000 0x0 0x6200000>;
>  			no-map;
>  		};
>  
>  		/delete-node/ adsp@8ea00000;
> -		adsp_region: adsp@8ea00000 {
> +		adsp_mem: adsp@8fe00000 {
>  			reg = <0x0 0x8fe00000 0x0 0x1b00000>;
>  			no-map;
>  		};
>  
> -		/delete-node/ slpi@90b00000;
> -		slpi_region: slpi@91900000 {
> +		/delete-node/ slpi@90500000;
> +		slpi_mem: slpi@91900000 {
>  			reg = <0x0 0x91900000 0x0 0xa00000>;
>  			no-map;
>  		};
>  
> -		/delete-node/ gpu@8f200000;
> -		zap_shader_region: gpu@92300000 {
> +		/delete-node/ gpu@90f00000;
> +		gpu_mem: gpu@92300000 {
>  			compatible = "shared-dma-pool";
>  			reg = <0x0 0x92300000 0x0 0x2000>;
>  			no-map;
>  		};
>  
>  		/delete-node/ venus@91000000;
> -		venus_region: venus@90400000 {
> +		venus_mem: venus@92400000 {
>  			reg = <0x0 0x92400000 0x0 0x500000>;
>  			no-map;
>  		};
> @@ -107,7 +107,7 @@ ramoops@92900000 {
>  			pmsg-size = <0x40000>;
>  		};
>  
> -		/delete-node/ rmtfs@86700000;
> +		/delete-node/ rmtfs;
>  		rmtfs@f6c00000 {
>  			compatible = "qcom,rmtfs-mem";
>  			reg = <0 0xf6c00000 0 0x200000>;
> @@ -118,7 +118,7 @@ rmtfs@f6c00000 {
>  		};
>  
>  		/delete-node/ mba@91500000;
> -		mba_region: mba@f6f00000 {
> +		mba_mem: mba@f6f00000 {
>  			reg = <0x0 0xf6f00000 0x0 0x100000>;
>  			no-map;
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index eb3ec5ff46eb..1495fff6ffc9 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -384,60 +384,65 @@ reserved-memory {
>  		#size-cells = <2>;
>  		ranges;
>  
> -		mba_region: mba@91500000 {
> -			reg = <0x0 0x91500000 0x0 0x200000>;
> +		hyp_mem: memory@85800000 {
> +			reg = <0x0 0x85800000 0x0 0x600000>;
>  			no-map;
>  		};
>  
> -		slpi_region: slpi@90b00000 {
> -			reg = <0x0 0x90b00000 0x0 0xa00000>;
> +		xbl_mem: memory@85e00000 {
> +			reg = <0x0 0x85e00000 0x0 0x200000>;
>  			no-map;
>  		};
>  
> -		venus_region: venus@90400000 {
> -			reg = <0x0 0x90400000 0x0 0x700000>;
> +		smem_mem: smem-mem@86000000 {
> +			reg = <0x0 0x86000000 0x0 0x200000>;
>  			no-map;
>  		};
>  
> -		adsp_region: adsp@8ea00000 {
> -			reg = <0x0 0x8ea00000 0x0 0x1a00000>;
> +		tz_mem: memory@86200000 {
> +			reg = <0x0 0x86200000 0x0 0x2600000>;
>  			no-map;
>  		};
>  
> -		mpss_region: mpss@88800000 {
> -			reg = <0x0 0x88800000 0x0 0x6200000>;
> +		rmtfs_mem: rmtfs {
> +			compatible = "qcom,rmtfs-mem";
> +
> +			size = <0x0 0x200000>;
> +			alloc-ranges = <0x0 0xa0000000 0x0 0x2000000>;
>  			no-map;
> +
> +			qcom,client-id = <1>;
> +			qcom,vmid = <15>;
>  		};
>  
> -		smem_mem: smem-mem@86000000 {
> -			reg = <0x0 0x86000000 0x0 0x200000>;
> +		mpss_mem: mpss@88800000 {
> +			reg = <0x0 0x88800000 0x0 0x6200000>;
>  			no-map;
>  		};
>  
> -		memory@85800000 {
> -			reg = <0x0 0x85800000 0x0 0x800000>;
> +		adsp_mem: adsp@8ea00000 {
> +			reg = <0x0 0x8ea00000 0x0 0x1b00000>;
>  			no-map;
>  		};
>  
> -		memory@86200000 {
> -			reg = <0x0 0x86200000 0x0 0x2600000>;
> +		slpi_mem: slpi@90500000 {
> +			reg = <0x0 0x90500000 0x0 0xa00000>;
>  			no-map;
>  		};
>  
> -		rmtfs@86700000 {
> -			compatible = "qcom,rmtfs-mem";
> -
> -			size = <0x0 0x200000>;
> -			alloc-ranges = <0x0 0xa0000000 0x0 0x2000000>;
> +		gpu_mem: gpu@90f00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0x90f00000 0x0 0x100000>;
>  			no-map;
> +		};
>  
> -			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> +		venus_mem: venus@91000000 {
> +			reg = <0x0 0x91000000 0x0 0x500000>;
> +			no-map;
>  		};
>  
> -		zap_shader_region: gpu@8f200000 {
> -			compatible = "shared-dma-pool";
> -			reg = <0x0 0x90b00000 0x0 0xa00000>;
> +		mba_mem: mba@91500000 {
> +			reg = <0x0 0x91500000 0x0 0x200000>;
>  			no-map;
>  		};
>  	};
> @@ -1013,7 +1018,7 @@ opp-133000000 {
>  			};
>  
>  			zap-shader {
> -				memory-region = <&zap_shader_region>;
> +				memory-region = <&gpu_mem>;
>  			};
>  		};
>  
> @@ -2001,7 +2006,7 @@ venus: video-codec@c00000 {
>  				 <&venus_smmu 0x2c>,
>  				 <&venus_smmu 0x2d>,
>  				 <&venus_smmu 0x31>;
> -			memory-region = <&venus_region>;
> +			memory-region = <&venus_mem>;
>  			status = "disabled";
>  
>  			video-decoder {
> @@ -3008,7 +3013,7 @@ adsp_pil: remoteproc@9300000 {
>  			clocks = <&xo_board>;
>  			clock-names = "xo";
>  
> -			memory-region = <&adsp_region>;
> +			memory-region = <&adsp_mem>;
>  
>  			qcom,smem-states = <&smp2p_adsp_out 0>;
>  			qcom,smem-state-names = "stop";
> -- 
> 2.33.0
> 
> 
