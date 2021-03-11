Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAC9337717
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhCKPYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:24:52 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:34539 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234049AbhCKPYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:24:47 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12BF74Zo011771;
        Thu, 11 Mar 2021 16:24:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=v+c1CwgHEdj0dQK0n2xQKNTW00bhBAc+aNy3B1sUE1s=;
 b=BTfNMr9l0h2mjKOtsPNeZvKzT9gD4Tbjdy1JwpBUA+fpqsNPkFqQ4o6xqz+R91HSKM5T
 D3AS4A6EDBLG7Zcsw8sBAgyAthYFWMFEFmc6N41VfPOclbZavZ5IOfj8GugLHoOFYb9r
 10q7Bo4AGBAsJWr32ff9BwooKnUDANoeh2X27zK/stZXzfrXxVPMWi0E40q5twQj5EXz
 GcG4FhAMvmPHE8JnWyVnU9QYWDLK/csq+ScpQ8xNYJdsIGncf3lQaC8FNJMpKIeLJlwv
 Tvx50fUL9KScYPd8l9WeHyeNkndcLPgLMQlOSFTWlobfbXuJJiWOixur/GkVw/W5/bko Qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3740377k8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 16:24:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E0E9410002A;
        Thu, 11 Mar 2021 16:24:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D7D4B24CFD6;
        Thu, 11 Mar 2021 16:24:40 +0100 (CET)
Received: from lmecxl0573.lme.st.com (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Mar
 2021 16:24:40 +0100
Subject: Re: [RESEND PATCH 0/3] MAINTAINERS: update STMicroelectronics email
To:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>
References: <20210216074929.29033-1-patrice.chotard@foss.st.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <1cd91834-6df8-a655-a3b1-0e16f5fe470d@foss.st.com>
Date:   Thu, 11 Mar 2021 16:24:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210216074929.29033-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_05:2021-03-10,2021-03-11 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

It's just a gentle reminder to not forgot this series.

Thanks

Patrice

On 2/16/21 8:49 AM, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> This series:
>   _ Update st.com to foss.st.com email for some maintainers.
>   _ Remove Vincent Abriou as STI/STM DRM driver
>   _ Add Alain Volmat as STM32 I2C/SMBUS driver maintainer
> 
> Patrice Chotard (3):
>   MAINTAINERS: Update some st.com email addresses to foss.st.com
>   MAINTAINERS: Remove Vincent Abriou for STM/STI DRM drivers.
>   MAINTAINERS: Add Alain Volmat as STM32 I2C/SMBUS maintainer
> 
>  MAINTAINERS | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
