Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181313DED6C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbhHCMHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:07:14 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52528 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235826AbhHCMHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:07:13 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173C3m0C018550;
        Tue, 3 Aug 2021 14:06:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=cpOasNmmxCtrdhYdESiFIDCAH9Q0g6h2uvzTxVADI7c=;
 b=e1VmzIdW0MPNQY3itCKXfKmqozHQqUr1APfi5pgM6ix6zaYTu4qQ37yhZZ6OwnD8GCTK
 XK93IbrgS6vI7Jo/+q/WXJqx0AF1E7zNnv4npEE7LGtVJdjR2QOBgCorhgUQMLVEcPdn
 IE6hwaYt6PUfUSh56K18170s/Q6ju60FOe0uQt+hIJpn3wQzuBFHieV3fQNG6K/xIYds
 I2om+FBojQ43TEYMhIJrCf8Z5RvebY9Hz2++uqT/fy+Bw1ar6OPk1CZZKHWCfNBaGoFq
 xSqYG/3SEAyEfzceOG4oss30C6clfugtTcG6Wy9qcPUIWenxCMg0FNSnsHKLD+COx6oN +g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3a70js1nxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 14:06:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1324E100034;
        Tue,  3 Aug 2021 14:06:52 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 068A4220F3E;
        Tue,  3 Aug 2021 14:06:52 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.45) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 14:06:51 +0200
Subject: Re: [PATCH v3 07/13] ARM: dts: sti: update clkgen-fsyn entries in
 stih407-clock
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210331204228.26107-1-avolmat@me.com>
 <20210331204228.26107-8-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <8125585a-84b2-7914-17a1-52f4d1b4ef37@foss.st.com>
Date:   Tue, 3 Aug 2021 14:06:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210331204228.26107-8-avolmat@me.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_02:2021-08-03,2021-08-03 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

On 3/31/21 10:42 PM, Alain Volmat wrote:
> The clkgen-fsyn driver now embed the clock names (assuming the
> right compatible is used). Remove all clock-output-names property
> and update when necessary the compatible.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/stih407-clock.dtsi | 27 +++------------------------
>  1 file changed, 3 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
> index 2603226a6ca8..9cce9541e26b 100644
> --- a/arch/arm/boot/dts/stih407-clock.dtsi
> +++ b/arch/arm/boot/dts/stih407-clock.dtsi
> @@ -93,12 +93,6 @@
>  			reg = <0x9103000 0x1000>;
>  
>  			clocks = <&clk_sysin>;
> -
> -			clock-output-names = "clk-s-c0-fs0-ch0",
> -					     "clk-s-c0-fs0-ch1",
> -					     "clk-s-c0-fs0-ch2",
> -					     "clk-s-c0-fs0-ch3";
> -			clock-critical = <0>; /* clk-s-c0-fs0-ch0 */
>  		};
>  
>  		clk_s_c0: clockgen-c@9103000 {
> @@ -150,15 +144,10 @@
>  
>  		clk_s_d0_quadfs: clk-s-d0-quadfs@9104000 {
>  			#clock-cells = <1>;
> -			compatible = "st,quadfs";
> +			compatible = "st,quadfs-d0";
>  			reg = <0x9104000 0x1000>;
>  
>  			clocks = <&clk_sysin>;
> -
> -			clock-output-names = "clk-s-d0-fs0-ch0",
> -					     "clk-s-d0-fs0-ch1",
> -					     "clk-s-d0-fs0-ch2",
> -					     "clk-s-d0-fs0-ch3";
>  		};
>  
>  		clockgen-d0@9104000 {
> @@ -179,15 +168,10 @@
>  
>  		clk_s_d2_quadfs: clk-s-d2-quadfs@9106000 {
>  			#clock-cells = <1>;
> -			compatible = "st,quadfs";
> +			compatible = "st,quadfs-d2";
>  			reg = <0x9106000 0x1000>;
>  
>  			clocks = <&clk_sysin>;
> -
> -			clock-output-names = "clk-s-d2-fs0-ch0",
> -					     "clk-s-d2-fs0-ch1",
> -					     "clk-s-d2-fs0-ch2",
> -					     "clk-s-d2-fs0-ch3";
>  		};
>  
>  		clockgen-d2@9106000 {
> @@ -210,15 +194,10 @@
>  
>  		clk_s_d3_quadfs: clk-s-d3-quadfs@9107000 {
>  			#clock-cells = <1>;
> -			compatible = "st,quadfs";
> +			compatible = "st,quadfs-d3";
>  			reg = <0x9107000 0x1000>;
>  
>  			clocks = <&clk_sysin>;
> -
> -			clock-output-names = "clk-s-d3-fs0-ch0",
> -					     "clk-s-d3-fs0-ch1",
> -					     "clk-s-d3-fs0-ch2",
> -					     "clk-s-d3-fs0-ch3";
>  		};
>  
>  		clockgen-d3@9107000 {
> 
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
