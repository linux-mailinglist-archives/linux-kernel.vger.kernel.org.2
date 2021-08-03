Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EDC3DED5B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbhHCMFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:05:54 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:48754 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235758AbhHCMFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:05:52 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173C1UUN031215;
        Tue, 3 Aug 2021 14:05:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=7KRlkna5Jzh40v7BetqNYRYZrFtGuQKxk/VjxOX4w3s=;
 b=OvrDQhEhVpv7+UVKQ5o4CSCoHeeIrU/EHNBglQGHdNwQFoxH+Hs2bezg303JsTqlxZsP
 kOOLaN63Y0ldUQHTTesrv20GLlMoXylwD1Z9F5+tn2rf7nlMN2SRJSlzg1+ukTQ4czpU
 cI110TQxOGVU6yp/9ctcPgNpeaynFq5CLy0mKqpxsPDGAeShBjgzmGVkmdiI7y1v+VLw
 v4vfY8Kkv/l58abiPa8WlHf9ajchRpNx9X2pcaOEaK2AdgEVk32rRDC7JRGRUlmu1caQ
 Wbo0+0OTJVKfQSxEvYKDjjhH5uTtc4joWP/9AjeGyckch4R24lNOW8mopUoJioZ/TSVO Zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3a6tqkk4q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 14:05:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F0C7C10002A;
        Tue,  3 Aug 2021 14:05:30 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E42D5220F39;
        Tue,  3 Aug 2021 14:05:30 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.44) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 14:05:30 +0200
Subject: Re: [PATCH v3 06/13] ARM: dts: sti: update clkgen-pll entries in
 stih418-clock
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210331204228.26107-1-avolmat@me.com>
 <20210331204228.26107-7-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <8793dc22-93dd-eee0-3f57-412dcf8c579c@foss.st.com>
Date:   Tue, 3 Aug 2021 14:05:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210331204228.26107-7-avolmat@me.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
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
>  arch/arm/boot/dts/stih418-clock.dtsi | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
> index 35d12979cdf4..d628e656458d 100644
> --- a/arch/arm/boot/dts/stih418-clock.dtsi
> +++ b/arch/arm/boot/dts/stih418-clock.dtsi
> @@ -39,8 +39,6 @@
>  				compatible = "st,stih418-clkgen-plla9";
>  
>  				clocks = <&clk_sysin>;
> -
> -				clock-output-names = "clockgen-a9-pll-odf";
>  			};
>  		};
>  
> @@ -75,11 +73,9 @@
>  
>  			clk_s_a0_pll: clk-s-a0-pll {
>  				#clock-cells = <1>;
> -				compatible = "st,clkgen-pll0";
> +				compatible = "st,clkgen-pll0-a0";
>  
>  				clocks = <&clk_sysin>;
> -
> -				clock-output-names = "clk-s-a0-pll-ofd-0";
>  			};
>  
>  			clk_s_a0_flexgen: clk-s-a0-flexgen {
> @@ -111,20 +107,16 @@
>  
>  			clk_s_c0_pll0: clk-s-c0-pll0 {
>  				#clock-cells = <1>;
> -				compatible = "st,clkgen-pll0";
> +				compatible = "st,clkgen-pll0-c0";
>  
>  				clocks = <&clk_sysin>;
> -
> -				clock-output-names = "clk-s-c0-pll0-odf-0";
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
