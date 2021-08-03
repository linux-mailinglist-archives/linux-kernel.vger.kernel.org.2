Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B173DED9A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbhHCMIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:08:41 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53298 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236023AbhHCMIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:08:32 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173C7nkU025649;
        Tue, 3 Aug 2021 14:08:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=8lgJu5bx5yzt1lEimXHfTqJLmOOg3YBQVetg+EKDB7c=;
 b=NrvFBeMYYpkys7NRG/N/tL3/6tE+FT/P9JPp7tICxe8Hlb/xVZhtcJuHC1X84CWUi16X
 t1edTHRnu1vw1WljLcZGNVhu6Fh4HtYyCnSPJNZmVNcsfi1vXWPh0JVPXQNBibbFRwjP
 VCHFtktUIy1x6zjFqwHfHP8DdO11q+otoFe7WRrnbh3FTeOmuK3Fb1Gse4OP3b9Ooivv
 FJwwZ81rUt2pr8z6uekL51J1G/VD3bfWQVlEbM+gHnmn3BuuskzADc3etkGh0qpAME9p
 YO8HbMJRnSBuCPj85wPU5M/uAasjxWrEIxSIjuketXBEBF6h3LRta6hfKSn2kX0//xcv Ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3a70js1p5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 14:08:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1766110002A;
        Tue,  3 Aug 2021 14:08:06 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 093D8220F3F;
        Tue,  3 Aug 2021 14:08:06 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.45) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Aug
 2021 14:08:05 +0200
Subject: Re: [PATCH v3 10/13] ARM: dts: sti: add the spinor controller node
 within stih407-family
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210331204228.26107-1-avolmat@me.com>
 <20210331204228.26107-11-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <2ddabd06-d247-5486-979c-b9df2f596490@foss.st.com>
Date:   Tue, 3 Aug 2021 14:08:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210331204228.26107-11-avolmat@me.com>
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
> The STiH407 family (and further versions STiH410/STiH418) embedded
> a serial flash controller allowing fast access to SPI-NOR.
> This commit adds the corresponding node, relying on the st-spi-fsm
> drivers.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> v2: commit log improvement
> 
>  arch/arm/boot/dts/stih407-family.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index 23a1746f3baa..21f3347a91d6 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -616,6 +616,21 @@
>  			st,lpc-mode = <ST_LPC_MODE_CLKSRC>;
>  		};
>  
> +		spifsm: spifsm@9022000{
> +			compatible = "st,spi-fsm";
> +			reg = <0x9022000 0x1000>;
> +			reg-names = "spi-fsm";
> +			clocks = <&clk_s_c0_flexgen CLK_FLASH_PROMIP>;
> +			clock-names = "emi_clk";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_fsm>;
> +			st,syscfg = <&syscfg_core>;
> +			st,boot-device-reg = <0x8c4>;
> +			st,boot-device-spi = <0x68>;
> +
> +			status = "disabled";
> +		};
> +
>  		sata0: sata@9b20000 {
>  			compatible = "st,ahci";
>  			reg = <0x9b20000 0x1000>;
> 
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
