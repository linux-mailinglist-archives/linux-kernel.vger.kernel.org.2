Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A91343EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhCVK7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:59:42 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:23834 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230453AbhCVK7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:59:30 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MAuxI5010598;
        Mon, 22 Mar 2021 11:59:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=URFJaqu4KP8rQ9APNeKDRJ//qCNcWIl4l8JzimvPV5c=;
 b=tz5JeK+H43b+lanXzOzY5yP1onDEcCO5vh2+Q1GT0nwgKqwgSZvrhNr9q05xt2ixtnJ9
 KQaA2s0ZtKJ+ntbO6ZDeFAhIlEKKPERwq596Ckt19LpcneSo6XPSRBpY6Hrfa9Xl5/0r
 K3xYmMVnu3KVIIk/u73b0hhaHtcaikdeSgAcGg3/W/eC09vFXML1BFCik5t/4RRjLoYz
 tiaf9RZBCGdT2pKncWQdY6AHxOWVIZQ5/vvJrwxuOhOnbdLZuy1MUyMQDp586bfEx9KY
 dX87zT6Jx0h2EZRy9CHk0NeTicYVCGQk0ddC1F5asN8n6Lo0SOaGQRzRlLWiGKY423ff tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37d7d7s83f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 11:59:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4B35810002A;
        Mon, 22 Mar 2021 11:59:20 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36870244736;
        Mon, 22 Mar 2021 11:59:20 +0100 (CET)
Received: from [10.211.8.180] (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 22 Mar
 2021 11:59:19 +0100
Subject: Re: [PATCH] mfd: stm32-timers: avoid clearing auto reload register
To:     <lee.jones@linaro.org>
CC:     <vilhelm.gray@gmail.com>, <alexandre.torgue@foss.st.com>,
        <mcoquelin.stm32@gmail.com>, <olivier.moysan@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1614793895-10504-1-git-send-email-fabrice.gasnier@foss.st.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <ce30adb7-fe58-6b56-9cc9-3f19692b56c2@foss.st.com>
Date:   Mon, 22 Mar 2021 11:59:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614793895-10504-1-git-send-email-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_04:2021-03-22,2021-03-22 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/21 6:51 PM, Fabrice Gasnier wrote:
> The ARR register is cleared unconditionally upon probing, after the maximum
> value has been read. This initial condition is rather not intuitive, when
> considering the counter child driver. It rather expects the maximum value
> by default:
> - The counter interface shows a zero value by default for 'ceiling'
>   attribute.
> - Enabling the counter without any prior configuration makes it doesn't
>   count.
> 
> The reset value of ARR register is the maximum. So Choice here
> is to backup it, and restore it then, instead of clearing its value.
> It also fixes the initial condition seen by the counter driver.
> 
> Fixes: d0f949e220fd ("mfd: Add STM32 Timers driver")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  drivers/mfd/stm32-timers.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Hi,

It's just a gentle reminder to review this patch.

Best Regards,
Fabrice

> 
> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
> index add6033..44ed2fc 100644
> --- a/drivers/mfd/stm32-timers.c
> +++ b/drivers/mfd/stm32-timers.c
> @@ -158,13 +158,18 @@ static const struct regmap_config stm32_timers_regmap_cfg = {
>  
>  static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
>  {
> +	u32 arr;
> +
> +	/* Backup ARR to restore it after getting the maximum value */
> +	regmap_read(ddata->regmap, TIM_ARR, &arr);
> +
>  	/*
>  	 * Only the available bits will be written so when readback
>  	 * we get the maximum value of auto reload register
>  	 */
>  	regmap_write(ddata->regmap, TIM_ARR, ~0L);
>  	regmap_read(ddata->regmap, TIM_ARR, &ddata->max_arr);
> -	regmap_write(ddata->regmap, TIM_ARR, 0x0);
> +	regmap_write(ddata->regmap, TIM_ARR, arr);
>  }
>  
>  static int stm32_timers_dma_probe(struct device *dev,
> 
