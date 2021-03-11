Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D181B337712
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhCKPXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:23:51 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11646 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234255AbhCKPXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:23:39 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12BF72Gh030672;
        Thu, 11 Mar 2021 16:23:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=v+c1CwgHEdj0dQK0n2xQKNTW00bhBAc+aNy3B1sUE1s=;
 b=MM/4B72DppwMxijMqWZ1+D0idIJJuexFaVBlAKSwoz3i2LuTO/wir0GK9qNzQoatZdtJ
 CoHMDwgiSAi0uMG0llF5QmuZf/WKto07tOv2ecH7VTRrIWhmuxuQoFGs/uBxnAU0dxkL
 BknXIo/M01tLRe+5Kk2kjkub1aDewpSkc5jW6WmAnRwNTDzEiWG+5ZBhwz6Bglso5Jzv
 YtnvIDyGtt42mgP4/xVDV8xDsNY+sOpTcp+TzwOJZj2seET58Sefy+QKUhhzEwOb4/ct
 bX1q58KWr/YuMiNiHum59XdmbA8nqi3As/E/dnL/hF67RIz3sjoz42qNc44lYEd89ivC 2w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 373yrf0ce2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 16:23:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0661710002A;
        Thu, 11 Mar 2021 16:23:34 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F028B250E3E;
        Thu, 11 Mar 2021 16:23:33 +0100 (CET)
Received: from lmecxl0573.lme.st.com (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Mar
 2021 16:23:33 +0100
Subject: Re: [RESEND PATCH 0/3] MAINTAINERS: update STMicroelectronics email
To:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        "patrice.chotard@st.com" <patrice.chotard@st.com>
References: <20210216074929.29033-1-patrice.chotard@foss.st.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <d54db26a-a5c9-e60b-d699-e2a19c229833@foss.st.com>
Date:   Thu, 11 Mar 2021 16:23:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210216074929.29033-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
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
