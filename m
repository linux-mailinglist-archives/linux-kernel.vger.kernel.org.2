Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452C13A81A4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFOOD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:03:27 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:38069 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231184AbhFOODZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:03:25 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FDwt6s019190;
        Tue, 15 Jun 2021 16:00:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=IKD+RpCl8nLVNtvU4/7edHnqgK4f17HFXGoXzvKZ8IQ=;
 b=qRULmr2a7vPLpNXUYa0F3km/BAQxGollFfMHNzfl+RWw0KSuR9JDOSOr4M0Xod4WUKCR
 NR6orCEGl+MgbSSddB0tVtEOWH+jouoiLQ0jMilwSTYmuEWLnAkAL+2A7Q9wdvEaiiyR
 NPP2ypHUWI/ImkKiFZJWA8jPCyw4Lf10tmtb88FLp+mpxAiGiUXZ2eR31nOsO5zxsMBF
 MTIHgpBfSf8seMoYs9veeurPI865yFJasnY0J2h7H76WI88UVGV0qw/g9fCoQtSXhA27
 5WhYTwCYBNFaSnG9u4TVpRFJ3I5NHtaG+rzjgxZUF86BVyfVOjIcYLGe4vjOtqR/ZOxc YQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 396qngtca6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 16:00:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C2E3310002A;
        Tue, 15 Jun 2021 16:00:51 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B3FC322B9A2;
        Tue, 15 Jun 2021 16:00:51 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.45) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Jun
 2021 16:00:51 +0200
Subject: Re: [PATCH] clocksource: Remove duplicated argument in
 arm_global_timer
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210615115440.8881-1-wanjiabing@vivo.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <68d52cab-ad24-c480-88be-e8be9b8731fb@foss.st.com>
Date:   Tue, 15 Jun 2021 16:00:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210615115440.8881-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-15_07:2021-06-14,2021-06-15 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wan

On 6/15/21 1:54 PM, Wan Jiabing wrote:
> Fix the following coccicheck warning:
> drivers/clocksource/arm_global_timer.c:107:4-23: 
> duplicated argument to & or |
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/clocksource/arm_global_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index 60a8047fd32e..fdf32a0c86d1 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -104,7 +104,7 @@ static void gt_compare_set(unsigned long delta, int periodic)
>  	counter += delta;
>  	ctrl = readl(gt_base + GT_CONTROL);
>  	ctrl &= ~(GT_CONTROL_COMP_ENABLE | GT_CONTROL_IRQ_ENABLE |
> -		  GT_CONTROL_AUTO_INC | GT_CONTROL_AUTO_INC);
> +		  GT_CONTROL_AUTO_INC);
>  	ctrl |= GT_CONTROL_TIMER_ENABLE;
>  	writel_relaxed(ctrl, gt_base + GT_CONTROL);
>  	writel_relaxed(lower_32_bits(counter), gt_base + GT_COMP0);
> 

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Thanks
Patrice
