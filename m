Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2F93DED55
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbhHCMFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:05:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51292 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234524AbhHCMFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:05:14 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173C3sge018574;
        Tue, 3 Aug 2021 14:04:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=3qSWV7R/m9gi3vfw/bu65CVmlUVMadm7Fki5yEvQArE=;
 b=v7KBr9tzPvCOZTMZYdIY7r3RUaRZuMLRKCpRw0b3gpG8G4+jmBsdPTo4u1+r+8saZhfP
 MBNZ1tZz2LUelgYCW2N3b3Hzm8v7osUZyCB1C+47LAhhQCJrxvbfoWXcF3nOCjx6YtKR
 Zw01vSwrsNVllXTFc6/8bWLcIlYeJqSv6/TCkxJkpBIUC38HFlGoHJigCSgH3vjmW5hw
 3NsQpi0ZXYxeH1FxgGG3roJjmT4KTjrXfV54MIX4NxcEqyzajALw2nrB1H95USgjraCd
 /t7cwlyF3AY0yIwGULubtlmLFkzHzvOwYDAUnhhIVTVHEdiCdXy4//sUDqbldck6CcUR dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3a70js1njm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 14:04:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6EA9010002A;
        Tue,  3 Aug 2021 14:04:46 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5FF25220F33;
        Tue,  3 Aug 2021 14:04:46 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.46) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 14:04:45 +0200
Subject: Re: [PATCH v3 03/13] ARM: dts: sti: update flexgen compatible within
 stih410-clock
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210331204228.26107-1-avolmat@me.com>
 <20210331204228.26107-4-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <5c50c236-7bc6-5307-fd9a-a03b3f3512b1@foss.st.com>
Date:   Tue, 3 Aug 2021 14:04:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210331204228.26107-4-avolmat@me.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
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
>  arch/arm/boot/dts/stih410-clock.dtsi | 95 ++--------------------------
>  1 file changed, 6 insertions(+), 89 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
> index 81a8c25d7ba5..04b0d7080353 100644
> --- a/arch/arm/boot/dts/stih410-clock.dtsi
> +++ b/arch/arm/boot/dts/stih410-clock.dtsi
> @@ -83,16 +83,12 @@
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
> -				clock-critical = <CLK_IC_LMI0>;
>  			};
>  		};
>  
> @@ -135,7 +131,7 @@
>  
>  			clk_s_c0_flexgen: clk-s-c0-flexgen {
>  				#clock-cells = <1>;
> -				compatible = "st,flexgen";
> +				compatible = "st,flexgen", "st,flexgen-stih410-c0";
>  
>  				clocks = <&clk_s_c0_pll0 0>,
>  					 <&clk_s_c0_pll1 0>,
> @@ -145,52 +141,6 @@
>  					 <&clk_s_c0_quadfs 3>,
>  					 <&clk_sysin>;
>  
> -				clock-output-names = "clk-icn-gpu",
> -						     "clk-fdma",
> -						     "clk-nand",
> -						     "clk-hva",
> -						     "clk-proc-stfe",
> -						     "clk-proc-tp",
> -						     "clk-rx-icn-dmu",
> -						     "clk-rx-icn-hva",
> -						     "clk-icn-cpu",
> -						     "clk-tx-icn-dmu",
> -						     "clk-mmc-0",
> -						     "clk-mmc-1",
> -						     "clk-jpegdec",
> -						     "clk-ext2fa9",
> -						     "clk-ic-bdisp-0",
> -						     "clk-ic-bdisp-1",
> -						     "clk-pp-dmu",
> -						     "clk-vid-dmu",
> -						     "clk-dss-lpc",
> -						     "clk-st231-aud-0",
> -						     "clk-st231-gp-1",
> -						     "clk-st231-dmu",
> -						     "clk-icn-lmi",
> -						     "clk-tx-icn-disp-1",
> -						     "clk-icn-sbc",
> -						     "clk-stfe-frc2",
> -						     "clk-eth-phy",
> -						     "clk-eth-ref-phyclk",
> -						     "clk-flash-promip",
> -						     "clk-main-disp",
> -						     "clk-aux-disp",
> -						     "clk-compo-dvp",
> -						     "clk-tx-icn-hades",
> -						     "clk-rx-icn-hades",
> -						     "clk-icn-reg-16",
> -						     "clk-pp-hades",
> -						     "clk-clust-hades",
> -						     "clk-hwpe-hades",
> -						     "clk-fc-hades";
> -				clock-critical = <CLK_PROC_STFE>,
> -						 <CLK_ICN_CPU>,
> -						 <CLK_TX_ICN_DMU>,
> -						 <CLK_EXT2F_A9>,
> -						 <CLK_ICN_LMI>,
> -						 <CLK_ICN_SBC>;
> -
>  				/*
>  				 * ARM Peripheral clock for timers
>  				 */
> @@ -227,20 +177,13 @@
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
> @@ -263,7 +206,7 @@
>  
>  			clk_s_d2_flexgen: clk-s-d2-flexgen {
>  				#clock-cells = <1>;
> -				compatible = "st,flexgen-video", "st,flexgen";
> +				compatible = "st,flexgen", "st,flexgen-stih407-d2";
>  
>  				clocks = <&clk_s_d2_quadfs 0>,
>  					 <&clk_s_d2_quadfs 1>,
> @@ -272,24 +215,7 @@
>  					 <&clk_sysin>,
>  					 <&clk_sysin>,
>  					 <&clk_tmdsout_hdmi>;
> -
> -				clock-output-names = "clk-pix-main-disp",
> -						     "clk-pix-pip",
> -						     "clk-pix-gdp1",
> -						     "clk-pix-gdp2",
> -						     "clk-pix-gdp3",
> -						     "clk-pix-gdp4",
> -						     "clk-pix-aux-disp",
> -						     "clk-denc",
> -						     "clk-pix-hddac",
> -						     "clk-hddac",
> -						     "clk-sddac",
> -						     "clk-pix-dvo",
> -						     "clk-dvo",
> -						     "clk-pix-hdmi",
> -						     "clk-tmds-hdmi",
> -						     "clk-ref-hdmiphy";
> -						     };
> +			};
>  		};
>  
>  		clk_s_d3_quadfs: clk-s-d3-quadfs@9107000 {
> @@ -311,22 +237,13 @@
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
