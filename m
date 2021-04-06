Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866D2355175
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245307AbhDFLAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245299AbhDFLAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:00:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F9BC06174A;
        Tue,  6 Apr 2021 04:00:02 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id g10so7269440plt.8;
        Tue, 06 Apr 2021 04:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uAfHURTLSwkVlAhOdumUV/peFHBBPWxoa4MMAdiyslg=;
        b=WaZTnSHwiOhUV40kXOg1zlC6O1HgGEvjnzGK6Mk3vdlneD7+ZwALwOWfVjoBZ+J/cl
         sfAXoEcYofIJsEQAUqK66xm0qTSpBd9tjJabOhJo21NwaI8SfPvKaFDFtYblLk9r6Fmk
         GzohY/tcvY2K6/f7/GOeKkSn/f20zYhM10/NUwO92bPhBlNDZbCsExt8HTHip/mx3KAZ
         n6OM30M6mFH72tUcXXLHBSyF2w9jFvj3PnWr7P6AksR5tEyfErtToQWqUQGbzb81MUJw
         mo/kSXVtdNDzHHEc/XkGkrTnOQS5dOYpDfvksOpv5vFfjcJDJ+jw0oDKpLT9W2qxaUt/
         QtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uAfHURTLSwkVlAhOdumUV/peFHBBPWxoa4MMAdiyslg=;
        b=X8ZeLDAY5N93owfeK0xqu6HdBggUYnuwlchAuLVQpD6TqHIoJ0qloK1qbJE7YJtbu7
         YsOWYjwfXX3Ze8s4AziKSnJ6L/LGEgXZCYK5KeKvoce9b810+7XczcIDQGlOKvcVvvg/
         /HzD/Qn5QqEmzmfNDHZiDqC6Ed5oCmRnle/WTuuATBpDViu0ERq7CFCHKLGGHdp8Z15D
         /N1D8GIBefXAc6MjZUUEHNqdZt4rJBRgqkktU8XjB5dl6OmFu/5XczqhKiTginLXfqUd
         TzqkrkR+PqxlBYWMUe1AD2MnxiO9+y7HTBr38HttVS5LAQo4jV6oXIOzzzZk2bkOLelr
         5fSw==
X-Gm-Message-State: AOAM531FNB7vNHnw9T6gx8P97IQJhlHb8BAZfj8gQwyCYPssJ+uV/nD3
        Vvau2T2Z1Nn6t2CAi5ALmL6SCcu8DiZkmQ==
X-Google-Smtp-Source: ABdhPJyyrYIPTkV8Iim1aaWdrWukRhx3MarZcSFNSq21hNpifBFgLBmRi/z2FOk1ZAh2qBm8JMVW+w==
X-Received: by 2002:a17:902:aa8a:b029:e6:64bd:e29d with SMTP id d10-20020a170902aa8ab02900e664bde29dmr28523527plr.24.1617706802339;
        Tue, 06 Apr 2021 04:00:02 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id v8sm18128204pfm.128.2021.04.06.03.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 04:00:01 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: mediatek: mt8167: add power domains
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     mkorpershoek@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210405172836.2038526-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <7e8532e1-710c-3239-4384-cbb10348c4b4@gmail.com>
Date:   Tue, 6 Apr 2021 12:59:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210405172836.2038526-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/2021 19:28, Fabien Parent wrote:
> Add support for the MT8167 power domains.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Applied to v5.12-next/dts64-2

Thanks

> ---
>  arch/arm64/boot/dts/mediatek/mt8167.dtsi | 68 ++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> index 1c5639ead622..156fbdad01fb 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> @@ -7,6 +7,7 @@
>  
>  #include <dt-bindings/clock/mt8167-clk.h>
>  #include <dt-bindings/memory/mt8167-larb-port.h>
> +#include <dt-bindings/power/mt8167-power.h>
>  
>  #include "mt8167-pinfunc.h"
>  
> @@ -34,6 +35,73 @@ apmixedsys: apmixedsys@10018000 {
>  			#clock-cells = <1>;
>  		};
>  
> +		scpsys: syscon@10006000 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0 0x10006000 0 0x1000>;
> +			#power-domain-cells = <1>;
> +
> +			spm: power-controller {
> +				compatible = "mediatek,mt8167-power-controller";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				#power-domain-cells = <1>;
> +
> +				/* power domains of the SoC */
> +				power-domain@MT8167_POWER_DOMAIN_MM {
> +					reg = <MT8167_POWER_DOMAIN_MM>;
> +					clocks = <&topckgen CLK_TOP_SMI_MM>;
> +					clock-names = "mm";
> +					#power-domain-cells = <0>;
> +					mediatek,infracfg = <&infracfg>;
> +				};
> +
> +				power-domain@MT8167_POWER_DOMAIN_VDEC {
> +					reg = <MT8167_POWER_DOMAIN_VDEC>;
> +					clocks = <&topckgen CLK_TOP_SMI_MM>,
> +						 <&topckgen CLK_TOP_RG_VDEC>;
> +					clock-names = "mm", "vdec";
> +					#power-domain-cells = <0>;
> +				};
> +
> +				power-domain@MT8167_POWER_DOMAIN_ISP {
> +					reg = <MT8167_POWER_DOMAIN_ISP>;
> +					clocks = <&topckgen CLK_TOP_SMI_MM>;
> +					clock-names = "mm";
> +					#power-domain-cells = <0>;
> +				};
> +
> +				power-domain@MT8167_POWER_DOMAIN_MFG_ASYNC {
> +					reg = <MT8167_POWER_DOMAIN_MFG_ASYNC>;
> +					clocks = <&topckgen CLK_TOP_RG_AXI_MFG>,
> +						 <&topckgen CLK_TOP_RG_SLOW_MFG>;
> +					clock-names = "axi_mfg", "mfg";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					#power-domain-cells = <1>;
> +					mediatek,infracfg = <&infracfg>;
> +
> +					power-domain@MT8167_POWER_DOMAIN_MFG_2D {
> +						reg = <MT8167_POWER_DOMAIN_MFG_2D>;
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +						#power-domain-cells = <1>;
> +
> +						power-domain@MT8167_POWER_DOMAIN_MFG {
> +							reg = <MT8167_POWER_DOMAIN_MFG>;
> +							#power-domain-cells = <0>;
> +							mediatek,infracfg = <&infracfg>;
> +						};
> +					};
> +				};
> +
> +				power-domain@MT8167_POWER_DOMAIN_CONN {
> +					reg = <MT8167_POWER_DOMAIN_CONN>;
> +					#power-domain-cells = <0>;
> +					mediatek,infracfg = <&infracfg>;
> +				};
> +			};
> +		};
> +
>  		imgsys: syscon@15000000 {
>  			compatible = "mediatek,mt8167-imgsys", "syscon";
>  			reg = <0 0x15000000 0 0x1000>;
> 
