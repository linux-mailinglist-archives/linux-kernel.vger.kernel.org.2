Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C336C3DED81
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbhHCMHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:07:55 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:49926 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235959AbhHCMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:07:52 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173C7O23011537;
        Tue, 3 Aug 2021 14:07:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=WUNpkbkc4FdOiKj0qz9HKrLEb+cDZt9EYvAhqvV+nwA=;
 b=fmN+awE1TTJUYD89SvvusGrLBm3MX1RtMYyAKZ87iHtNrRGM47kgSzVXlpozkvxg9EqQ
 dxgCnwv+nr0oIUmdkdKa/6EhMLXN2JrXaPmV3MM3zeGOq0O9fQO/cA79aUdQQ/S+hpxa
 lEb9nDF1VwddYQ/rO54cvKipBVuuDa7eFvMfXtypOzmRx80AqwJSNxN287UZlfxUvSAo
 BB/FIUeU+YrxMu0ptlwq3VrNHMDT7bw+AeZXr0hlgOgnNfZUPe4n456Z5RB0s3gvmoN/
 dlhVZtocIvxWhgkqTqpdviAJ3KGzlNTuiwzzS72HQ4KHI08jhjrjFW0YnHBZJKTetYr7 jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3a6tqkk50g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 14:07:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1B10010002A;
        Tue,  3 Aug 2021 14:07:18 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E855215134;
        Tue,  3 Aug 2021 14:07:18 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.47) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 14:07:17 +0200
Subject: Re: [PATCH v3 08/13] ARM: dts: sti: update clkgen-fsyn entries in
 stih410-clock
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210331204228.26107-1-avolmat@me.com>
 <20210331204228.26107-9-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <b2817d9f-5afe-5f26-77d9-641c6b17bea7@foss.st.com>
Date:   Tue, 3 Aug 2021 14:07:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210331204228.26107-9-avolmat@me.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
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
>  arch/arm/boot/dts/stih410-clock.dtsi | 27 +++------------------------
>  1 file changed, 3 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
> index 3aeabdd6e305..6b0e6d4477a3 100644
> --- a/arch/arm/boot/dts/stih410-clock.dtsi
> +++ b/arch/arm/boot/dts/stih410-clock.dtsi
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
