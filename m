Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC23233705A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhCKKnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:43:46 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:28714 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232357AbhCKKnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:43:24 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12BAb1YP012246;
        Thu, 11 Mar 2021 11:43:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=reVD2nFbVEp8gb4z7l9Lsc03zMkyrWzjlZogLvrIq8g=;
 b=CcxY2U0ZH0Ze2pjopc2xYv8LVNwhXqq5LIcIQ7ca2HjtCsz7114dmPZ+fj1B55+Xw8D2
 Qu8oclX35DsVjWohNW4+T2p61GRiAWcntzOcGYzhtvW6qr7aT+Ux1omvcQRWJqu8c23H
 O5LbsLU1v3EtlDg5vvY6/Ka/P6qpnZIpHrY0hEFTdnO8JdbQev4bfQsgvSDRJ7kcnjgW
 tTbvY/L8y1sUPDPsqDhy110SRxg/J2ekoa1Y8/m/WPAzrMV+U/GsC6MGOQRY/IuobH9Q
 6HPnWsqZdD0qA5ygpBZwAU+K0yVa6LmZBSoxeHPNl58ypG2+n5aHXNt5sZp51t5ei7Lo mA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37403766k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 11:43:12 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 655DC100034;
        Thu, 11 Mar 2021 11:43:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4EA8322D624;
        Thu, 11 Mar 2021 11:43:12 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Mar
 2021 11:43:11 +0100
Subject: Re: [PATCH 8/8] ARM: stm32: add initial support for stm32h750
To:     <dillon.minfei@gmail.com>, <robh+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
        <vladimir.murzin@arm.com>, <afzal.mohd.ma@gmail.com>
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
 <1614758717-18223-9-git-send-email-dillon.minfei@gmail.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <a5b4a06c-60c4-ba56-5f5b-dd7a8c5a0d6d@foss.st.com>
Date:   Thu, 11 Mar 2021 11:43:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614758717-18223-9-git-send-email-dillon.minfei@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_04:2021-03-10,2021-03-11 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dillon

On 3/3/21 9:05 AM, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 

No empty commit message please

> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
>   arch/arm/mach-stm32/board-dt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
> index 011d57b488c2..a766310d8dca 100644
> --- a/arch/arm/mach-stm32/board-dt.c
> +++ b/arch/arm/mach-stm32/board-dt.c
> @@ -17,6 +17,7 @@ static const char *const stm32_compat[] __initconst = {
>   	"st,stm32f746",
>   	"st,stm32f769",
>   	"st,stm32h743",
> +	"st,stm32h750",
>   	"st,stm32mp157",
>   	NULL
>   };
> 
