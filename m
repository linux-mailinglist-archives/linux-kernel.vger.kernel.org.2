Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93733396DE6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhFAH1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:27:08 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:40176 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229984AbhFAH1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:27:07 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15176McM001417;
        Tue, 1 Jun 2021 09:25:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=45wLACesYLdx/fidHq/10HQRw+yA+2NLYy1OFfLkUY0=;
 b=w3LJSOAvjXw9Q9LG0VhLXGNkA8xUi4mR1jWtoV+NbfDMcnXn4JJsqFjMGtXhpEf/iNA0
 PLZyM3hkbR4CRFR4/0Z8Y6kFClYwi+UxRR9P0sq+dOj5AAye7BPzaET3le+tB3yMxezp
 gkbhtnXzecBtYYQT5jm99q7r7j/yC6jYxnBoB1KznU2MgbHymi+ng04lgYHHWA7cJVfO
 BX1rsNySwDDQQS0aRjh2aSJGPWYU9AwFNHhM0R9IKaQk1C54D3Mmle8R/tiwD+gY/mgC
 H/iv1HR5zzDb/UxcW/ouRIMeTZ8BdYID2ZI8+qAEfa8yQLRPAFLX8FL1YZiJW31LUPUJ iA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38w49cju3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 09:25:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F035510002A;
        Tue,  1 Jun 2021 09:25:11 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9D846212317;
        Tue,  1 Jun 2021 09:25:11 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.47) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Jun
 2021 09:25:10 +0200
Subject: Re: [PATCH 1/1] ARM: dts: stm32: Configure qspi's mdma transfer to
 block for stm32mp151
To:     <patrice.chotard@foss.st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Christophe Kerello <christophe.kerello@foss.st.com>
References: <20210426104536.29576-1-patrice.chotard@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <21433a39-979a-b7ea-295a-fae208b9a52a@foss.st.com>
Date:   Tue, 1 Jun 2021 09:25:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210426104536.29576-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_03:2021-05-31,2021-06-01 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrice

On 4/26/21 12:45 PM, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Configure qspi's mdma from buffer transfer (max 128 bytes) to
> block transfer (max 64K bytes).
> 
> mtd_speedtest shows that write throughtput increases :
>    - from 734 to 782 KiB/s (~6.5%) with s25fl512s SPI-NOR.
>    - from 4848 to 5319 KiB/s (~9.72%) with Micron SPI-NAND.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp151.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index 4b8031782555..cb326c1e12bc 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -1358,8 +1358,8 @@
>   			reg = <0x58003000 0x1000>, <0x70000000 0x10000000>;
>   			reg-names = "qspi", "qspi_mm";
>   			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> -			dmas = <&mdma1 22 0x2 0x100002 0x0 0x0>,
> -			       <&mdma1 22 0x2 0x100008 0x0 0x0>;
> +			dmas = <&mdma1 22 0x2 0x10100002 0x0 0x0>,
> +			       <&mdma1 22 0x2 0x10100008 0x0 0x0>;
>   			dma-names = "tx", "rx";
>   			clocks = <&rcc QSPI_K>;
>   			resets = <&rcc QSPI_R>;
> 

Applied on stm32-next.

Thanks.
Alex
