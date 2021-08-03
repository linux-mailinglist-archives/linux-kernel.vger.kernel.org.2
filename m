Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E6A3DED57
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbhHCMFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:05:42 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51624 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234524AbhHCMFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:05:40 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173C3m05018550;
        Tue, 3 Aug 2021 14:05:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=5Q4U+U2m1O+Y43ad5UZDx0CiOKspNOb9BzRnMvVLV10=;
 b=O1b3bKEiyP816Rcb1GXpnsVnPgaIJsKpQdMkDvIXxSUVxlUN8NV3WyFxkgM/nVLKvGng
 LJVTRC9PVD952kp1gosH0Ty9Ge4CzgKQxhRYGDl8vRkx8Z4pUBGJrorrD4VdyqdzMO8Z
 A8qyJK9em8zYtoN8rzCapOBw8W8NWKalULRPp/f46i4m/41mjMsoLZ7NKrjIpCs6EDHc
 qoTfBbmyJxedzBubc+87yMPvc8fwjBJDjHGPcCoZ2e/eIgfEGVTgRkpKD5i08llQLOc7
 YDNwF6lN+DfVZzAflIys5H9zr1+BY4NLTGPP6wI9Y3RUIEJOBH4P4hYFqKVBxVgJMzsB DQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3a70js1np4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 14:05:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A957210002A;
        Tue,  3 Aug 2021 14:05:18 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9CC87220F39;
        Tue,  3 Aug 2021 14:05:18 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.46) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 14:05:18 +0200
Subject: Re: [PATCH v3 05/13] ARM: dts: sti: update clkgen-pll entries in
 stih410-clock
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210331204228.26107-1-avolmat@me.com>
 <20210331204228.26107-6-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <95e6d88a-9447-b268-c321-4c978a241fcd@foss.st.com>
Date:   Tue, 3 Aug 2021 14:05:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210331204228.26107-6-avolmat@me.com>
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
> The clkgen-pll driver now embed the clock names (assuming the
> right compatible is used). Remove all clock-output-names property
> and update when necessary the compatible.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/stih410-clock.dtsi | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
> index 04b0d7080353..3aeabdd6e305 100644
> --- a/arch/arm/boot/dts/stih410-clock.dtsi
> +++ b/arch/arm/boot/dts/stih410-clock.dtsi
> @@ -39,8 +39,6 @@
>  				compatible = "st,stih407-clkgen-plla9";
>  
>  				clocks = <&clk_sysin>;
> -
> -				clock-output-names = "clockgen-a9-pll-odf";
>  			};
>  		};
>  
> @@ -74,12 +72,9 @@
>  
>  			clk_s_a0_pll: clk-s-a0-pll {
>  				#clock-cells = <1>;
> -				compatible = "st,clkgen-pll0";
> +				compatible = "st,clkgen-pll0-a0";
>  
>  				clocks = <&clk_sysin>;
> -
> -				clock-output-names = "clk-s-a0-pll-ofd-0";
> -				clock-critical = <0>; /* clk-s-a0-pll-ofd-0 */
>  			};
>  
>  			clk_s_a0_flexgen: clk-s-a0-flexgen {
> @@ -112,21 +107,16 @@
>  
>  			clk_s_c0_pll0: clk-s-c0-pll0 {
>  				#clock-cells = <1>;
> -				compatible = "st,clkgen-pll0";
> +				compatible = "st,clkgen-pll0-c0";
>  
>  				clocks = <&clk_sysin>;
> -
> -				clock-output-names = "clk-s-c0-pll0-odf-0";
> -				clock-critical = <0>; /* clk-s-c0-pll0-odf-0 */
>  			};
>  
>  			clk_s_c0_pll1: clk-s-c0-pll1 {
>  				#clock-cells = <1>;
> -				compatible = "st,clkgen-pll1";
> +				compatible = "st,clkgen-pll1-c0";
>  
>  				clocks = <&clk_sysin>;
> -
> -				clock-output-names = "clk-s-c0-pll1-odf-0";
>  			};
>  
>  			clk_s_c0_flexgen: clk-s-c0-flexgen {
> 
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
