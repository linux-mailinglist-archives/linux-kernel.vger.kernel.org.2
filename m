Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E776634C59B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 10:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhC2IBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 04:01:37 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:6380 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231596AbhC2IA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:00:58 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12T7w1iT002406;
        Mon, 29 Mar 2021 10:00:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=YARP2pjSPKUGCU0uuAV6W5anS3B8C1Bjy68KpzSsA10=;
 b=476iQQ/ln+z8k2S6OM44WSlaUduFXgR3sPWrk7EGcvnGpTSfV4PsJ3whyb6fFFUAAijL
 kphHP5Upu8cPLnbEZ1ohP+9bvlV+bV4uieGCHOdpDKlL7gRAT2VeXgYoPXXQT3uSrAvs
 MuYk0TJvuqeuAYBl8fHi7qZUa35Lf2ZM6f+aFtrQoc51IVLgQFWkQE5BAGbKQwYrRjzU
 dycYNFrHmS/RNulAPdCDLucbv0eREmRBbGIXQm3cDX3gbFYubWTMYBiA9WJbMe1vtG8O
 HcbHTjLkSFcSSDOCr/aLbdXyv3A4KF6DjUTRaTg6KB/TptjMFjvUjG+hNt6fJaVuWhPi ZA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37jy132qvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 10:00:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 79E6110002A;
        Mon, 29 Mar 2021 10:00:13 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 58DB92397B8;
        Mon, 29 Mar 2021 10:00:13 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 29 Mar
 2021 10:00:12 +0200
Subject: Re: [PATCH v2 8/8] pinctrl: stm32: Add STM32H750 MCU pinctrl support
To:     <dillon.minfei@gmail.com>, <robh+dt@kernel.org>,
        <a.fatoum@pengutronix.de>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
        <vladimir.murzin@arm.com>, <afzal.mohd.ma@gmail.com>
References: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
 <1615530274-31422-9-git-send-email-dillon.minfei@gmail.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <eb2437ef-ecd2-e258-b77b-2fe9f70205f2@foss.st.com>
Date:   Mon, 29 Mar 2021 10:00:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1615530274-31422-9-git-send-email-dillon.minfei@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_04:2021-03-26,2021-03-29 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dillon

On 3/12/21 7:24 AM, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> This patch adds STM32H750 pinctrl and GPIO support
> since stm32h750 has the same pin alternate functions
> with stm32h743, so just reuse the stm32h743's pinctrl
> driver
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
> v2:
> - add compatible string st,stm32h750-pinctrl to pinctl-stm32h743.c as they
>    have same pin alternate functions
> - add STM32H750 to Kconfig description
> 
>   drivers/pinctrl/stm32/Kconfig             | 2 +-
>   drivers/pinctrl/stm32/pinctrl-stm32h743.c | 3 +++
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/stm32/Kconfig b/drivers/pinctrl/stm32/Kconfig
> index f36f29113370..fb1ffc94c57f 100644
> --- a/drivers/pinctrl/stm32/Kconfig
> +++ b/drivers/pinctrl/stm32/Kconfig
> @@ -35,7 +35,7 @@ config PINCTRL_STM32F769
>   	select PINCTRL_STM32
>   
>   config PINCTRL_STM32H743
> -	bool "STMicroelectronics STM32H743 pin control" if COMPILE_TEST && !MACH_STM32H743
> +	bool "STMicroelectronics STM32H743/STM32H750 pin control" if COMPILE_TEST && !MACH_STM32H743
>   	depends on OF && HAS_IOMEM
>   	default MACH_STM32H743
>   	select PINCTRL_STM32
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32h743.c b/drivers/pinctrl/stm32/pinctrl-stm32h743.c
> index ffe7b5271506..700206c7bc11 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32h743.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32h743.c
> @@ -1966,6 +1966,9 @@ static const struct of_device_id stm32h743_pctrl_match[] = {
>   		.compatible = "st,stm32h743-pinctrl",
>   		.data = &stm32h743_match_data,
>   	},
> +	{	.compatible = "st,stm32h750-pinctrl",
> +		.data = &stm32h743_match_data,
> +	},

If you use exactly the same driver (i.e. same ball out and AF mux) then 
you don't have to create a new compatible for that. Just use the same 
than h743.(so you don't have to factorize DT files).

Regards
Alex

>   	{ }
>   };
>   
> 
