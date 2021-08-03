Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D134A3DED50
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhHCMES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:04:18 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:57030 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234765AbhHCMEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:04:12 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173C3Ziu018186;
        Tue, 3 Aug 2021 14:03:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=jw6gMzhdrYDpRjBtcHAO9uzKDNHmY4GkLu1zo7F2tTM=;
 b=bYg1rW5ZANPVwO93MeIH4b/11JgT6h4LVToydA+QpQxxpq79axK7tvtEaV5keGP9+8sa
 Nefm31vGvH0l2f/oenFsezMz/rJxcJ1eb12skHI46ZWwvSYx50G7WFBOqlU4yyE6yx2k
 k99ADbfRHZu+BcTRDYIv/5caMUyS3Mu2vlpsFpPEtYiUxC76WfELw00+vCDdsA25p45A
 LLoFFZTTNhm6/YFTTjhBtg0ckA7VjpoWRNodm58IK8jzxVijFeBK4GsWTiexym1wyoH9
 xPhNNRi88LWAanZWIwbUzk7U+5RpUN6pc2wVMBL6Ops3Odd4VlJZswvB2ozudMe+xXNB OQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3a73jugj0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 14:03:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F0BE410002A;
        Tue,  3 Aug 2021 14:03:36 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C593C220F30;
        Tue,  3 Aug 2021 14:03:36 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.45) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 14:03:36 +0200
Subject: Re: [PATCH v3 01/13] ARM: dts: sti: update flexgen compatible within
 stih418-clock
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210331204228.26107-1-avolmat@me.com>
 <20210331204228.26107-2-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <1d5c9ee4-a025-8520-0ab1-4b7f2f80bcc4@foss.st.com>
Date:   Tue, 3 Aug 2021 14:03:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210331204228.26107-2-avolmat@me.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_02:2021-08-03,2021-08-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

On 3/31/21 10:42 PM, Alain Volmat wrote:
> With the introduction of new flexgen compatible within the clk-flexgen
> driver, remove the clock-output-names entry from the flexgen nodes
> and set the new proper compatible corresponding.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/stih418-clock.dtsi | 96 ++--------------------------
>  1 file changed, 5 insertions(+), 91 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
> index 8fa092462102..35d12979cdf4 100644
> --- a/arch/arm/boot/dts/stih418-clock.dtsi
> +++ b/arch/arm/boot/dts/stih418-clock.dtsi
> @@ -83,15 +83,12 @@
>  			};
>  
>  			clk_s_a0_flexgen: clk-s-a0-flexgen {
> -				compatible = "st,flexgen";
> +				compatible = "st,flexgen", "st,flexgen-stih410-a0";
>  
>  				#clock-cells = <1>;
>  
>  				clocks = <&clk_s_a0_pll 0>,
>  					 <&clk_sysin>;
> -
> -				clock-output-names = "clk-ic-lmi0",
> -						     "clk-ic-lmi1";
>  			};
>  		};
>  
> @@ -132,7 +129,7 @@
>  
>  			clk_s_c0_flexgen: clk-s-c0-flexgen {
>  				#clock-cells = <1>;
> -				compatible = "st,flexgen";
> +				compatible = "st,flexgen", "st,flexgen-stih418-c0";
>  
>  				clocks = <&clk_s_c0_pll0 0>,
>  					 <&clk_s_c0_pll1 0>,
> @@ -142,49 +139,6 @@
>  					 <&clk_s_c0_quadfs 3>,
>  					 <&clk_sysin>;
>  
> -				clock-output-names = "clk-icn-gpu",
> -						     "clk-fdma",
> -						     "clk-nand",
> -						     "clk-hva",
> -						     "clk-proc-stfe",
> -						     "clk-tp",
> -						     "clk-rx-icn-dmu",
> -						     "clk-rx-icn-hva",
> -						     "clk-icn-cpu",
> -						     "clk-tx-icn-dmu",
> -						     "clk-mmc-0",
> -						     "clk-mmc-1",
> -						     "clk-jpegdec",
> -						     "clk-icn-reg",
> -						     "clk-proc-bdisp-0",
> -						     "clk-proc-bdisp-1",
> -						     "clk-pp-dmu",
> -						     "clk-vid-dmu",
> -						     "clk-dss-lpc",
> -						     "clk-st231-aud-0",
> -						     "clk-st231-gp-1",
> -						     "clk-st231-dmu",
> -						     "clk-icn-lmi",
> -						     "clk-tx-icn-1",
> -						     "clk-icn-sbc",
> -						     "clk-stfe-frc2",
> -						     "clk-eth-phyref",
> -						     "clk-eth-ref-phyclk",
> -						     "clk-flash-promip",
> -						     "clk-main-disp",
> -						     "clk-aux-disp",
> -						     "clk-compo-dvp",
> -						     "clk-tx-icn-hades",
> -						     "clk-rx-icn-hades",
> -						     "clk-icn-reg-16",
> -						     "clk-pp-hevc",
> -						     "clk-clust-hevc",
> -						     "clk-hwpe-hevc",
> -						     "clk-fc-hevc",
> -						     "clk-proc-mixer",
> -						     "clk-proc-sc",
> -						     "clk-avsp-hevc";
> -
>  				/*
>  				 * ARM Peripheral clock for timers
>  				 */
> @@ -221,20 +175,13 @@
>  
>  			clk_s_d0_flexgen: clk-s-d0-flexgen {
>  				#clock-cells = <1>;
> -				compatible = "st,flexgen-audio", "st,flexgen";
> +				compatible = "st,flexgen", "st,flexgen-stih410-d0";
>  
>  				clocks = <&clk_s_d0_quadfs 0>,
>  					 <&clk_s_d0_quadfs 1>,
>  					 <&clk_s_d0_quadfs 2>,
>  					 <&clk_s_d0_quadfs 3>,
>  					 <&clk_sysin>;
> -
> -				clock-output-names = "clk-pcm-0",
> -						     "clk-pcm-1",
> -						     "clk-pcm-2",
> -						     "clk-spdiff",
> -						     "clk-pcmr10-master",
> -						     "clk-usb2-phy";
>  			};
>  		};
>  
> @@ -257,7 +204,7 @@
>  
>  			clk_s_d2_flexgen: clk-s-d2-flexgen {
>  				#clock-cells = <1>;
> -				compatible = "st,flexgen-video", "st,flexgen";
> +				compatible = "st,flexgen", "st,flexgen-stih418-d2";
>  
>  				clocks = <&clk_s_d2_quadfs 0>,
>  					 <&clk_s_d2_quadfs 1>,
> @@ -266,30 +213,6 @@
>  					 <&clk_sysin>,
>  					 <&clk_sysin>,
>  					 <&clk_tmdsout_hdmi>;
> -
> -				clock-output-names = "clk-pix-main-disp",
> -						     "",
> -						     "",
> -						     "",
> -						     "",
> -						     "clk-tmds-hdmi-div2",
> -						     "clk-pix-aux-disp",
> -						     "clk-denc",
> -						     "clk-pix-hddac",
> -						     "clk-hddac",
> -						     "clk-sddac",
> -						     "clk-pix-dvo",
> -						     "clk-dvo",
> -						     "clk-pix-hdmi",
> -						     "clk-tmds-hdmi",
> -						     "clk-ref-hdmiphy",
> -						     "", "", "", "", "",
> -						     "", "", "", "", "",
> -						     "", "", "", "", "",
> -						     "", "", "", "", "",
> -						     "", "", "", "", "",
> -						     "", "", "", "", "",
> -						     "", "clk-vp9";
>  			};
>  		};
>  
> @@ -312,22 +235,13 @@
>  
>  			clk_s_d3_flexgen: clk-s-d3-flexgen {
>  				#clock-cells = <1>;
> -				compatible = "st,flexgen";
> +				compatible = "st,flexgen", "st,flexgen-stih407-d3";
>  
>  				clocks = <&clk_s_d3_quadfs 0>,
>  					 <&clk_s_d3_quadfs 1>,
>  					 <&clk_s_d3_quadfs 2>,
>  					 <&clk_s_d3_quadfs 3>,
>  					 <&clk_sysin>;
> -
> -				clock-output-names = "clk-stfe-frc1",
> -						     "clk-tsout-0",
> -						     "clk-tsout-1",
> -						     "clk-mchi",
> -						     "clk-vsens-compo",
> -						     "clk-frc1-remote",
> -						     "clk-lpc-0",
> -						     "clk-lpc-1";
>  			};
>  		};
>  	};
> 
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
