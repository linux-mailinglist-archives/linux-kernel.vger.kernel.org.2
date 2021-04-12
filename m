Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224DF35C399
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbhDLKUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:20:01 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:57942 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237695AbhDLKT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:19:59 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CAGEDt020722;
        Mon, 12 Apr 2021 12:19:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : from : to
 : cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=YJkcntAZUXkIgNIIrAREWE1IbHO+eVFlSLGHgdZHNeI=;
 b=Z0WGRoFU3q+IPxELbd8wub9WE78/OqzQ7022qaUQsDwPGuGJlrNvSEw4HF6fFvmRboM4
 PDxjks6K1okKU7kaVQxWc9kYBj9JzJ2MCxw0mJl5fm9MvMMSmLV1R+Hh/6bR099Eyl+E
 Jh4hw+yLxi7xCdTc899PiSkxA/RA0mcbwt13B062yrIBBCNoCzRTYm5G9Gh2mAxKfRI1
 Yv27PVB2DS6Eg0dgR1ysF2D69jzWGW9wQwiFoPW0PWuWnEKOPNZETaaM+NV4ReK8TcJI
 VU3/OprC/GFPmzEj7HyTHNeRVBiUeZ6KIqQyfPyuSIU47I/BnrFgp4I7HZeT4g+mPuYm hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37uv9md613-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 12:19:36 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3001710002A;
        Mon, 12 Apr 2021 12:19:36 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1B898231DD0;
        Mon, 12 Apr 2021 12:19:36 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.49) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 12:19:35 +0200
Subject: Re: [Linux-stm32] [RESEND PATCH 0/3] MAINTAINERS: update
 STMicroelectronics email
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
To:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     <linux-stm32@st-md-mailman.stormreply.com>
References: <20210216074929.29033-1-patrice.chotard@foss.st.com>
 <1cd91834-6df8-a655-a3b1-0e16f5fe470d@foss.st.com>
Message-ID: <52c32145-7f29-8944-58dc-dc2fb406ffb0@foss.st.com>
Date:   Mon, 12 Apr 2021 12:19:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1cd91834-6df8-a655-a3b1-0e16f5fe470d@foss.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_09:2021-04-12,2021-04-12 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I think this series has been forgotten, any chance to see it merged into v5.13 ?

Thanks
Patrice


On 3/11/21 4:24 PM, Patrice CHOTARD wrote:
> Hi 
> 
> It's just a gentle reminder to not forgot this series.
> 
> Thanks
> 
> Patrice
> 
> On 2/16/21 8:49 AM, patrice.chotard@foss.st.com wrote:
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> This series:
>>   _ Update st.com to foss.st.com email for some maintainers.
>>   _ Remove Vincent Abriou as STI/STM DRM driver
>>   _ Add Alain Volmat as STM32 I2C/SMBUS driver maintainer
>>
>> Patrice Chotard (3):
>>   MAINTAINERS: Update some st.com email addresses to foss.st.com
>>   MAINTAINERS: Remove Vincent Abriou for STM/STI DRM drivers.
>>   MAINTAINERS: Add Alain Volmat as STM32 I2C/SMBUS maintainer
>>
>>  MAINTAINERS | 31 +++++++++++++++----------------
>>  1 file changed, 15 insertions(+), 16 deletions(-)
>>
> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32
> 
