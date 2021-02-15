Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B07631BA2C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 14:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhBONSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 08:18:52 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:1527 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229802AbhBONSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 08:18:48 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11FDHwmI009467;
        Mon, 15 Feb 2021 14:17:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=E5obh1h20v4bvprIe4TXMd89+JhUEv4uPNW7pZZM+fo=;
 b=r+IkvzdJAz2Q1adOcgWIPnuY/E1/Y6HxCV0/ulpDGFFq2POCmKUyKGVcAyue9rUFyO0Z
 lvas48HJQ+ya1gPwKgUT1YSOKWMo/jjasL9Ryjb9DAHLhmIKmJ5PTAz4V/IdFOe3SU6p
 z8Sk/kf46ODRAHADuSzL/ZfpXdqT2MG9G7YSfGhwdlJcypyD3XKLxK/S3qr1Fn/Q7UWg
 nmMtyol9pDK0hFu7WBgIpVd+6+W+GRCAybkhGiE/PuyIwH8k3grbtiM3b/izjfbgkAdT
 tOzhlqdck2OSDHCByQevML1T91NNya88rmISTjmGIkXf1S/6dEYiAtLHbcPI3lrZeEFT kQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36p547aj3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 14:17:58 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E642010002A;
        Mon, 15 Feb 2021 14:17:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C0D6622B3D3;
        Mon, 15 Feb 2021 14:17:57 +0100 (CET)
Received: from lmecxl0573.lme.st.com (10.75.127.48) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Feb
 2021 14:17:57 +0100
Subject: Re: [PATCH 0/3] MAINTAINERS: update STMicroelectronics email
To:     <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Olof Johansson" <olof@lixom.net>,
        "khilman@baylibre.com" <khilman@baylibre.com>
CC:     Alexandre TORGUE <alexandre.torgue@st.com>
References: <20210201100023.10985-1-patrice.chotard@foss.st.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <800f8dfa-0949-ddf8-1635-15311c2c9623@foss.st.com>
Date:   Mon, 15 Feb 2021 14:17:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201100023.10985-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_08:2021-02-12,2021-02-15 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof, Kevin

What is the best way to get this series merged ?
Do you pick it and apply it directly, or do we integrate it in the next STM32 pull request ?

Thanks
Patrice

On 2/1/21 11:00 AM, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> This series:
>   _ Update st.com to foss.st.com email for some maintainers.
>   _ Remove Vincent Abriou as STI/STM DRM driver
>   _ Add Alain Volmat as I2C/SMBUS driver maintainer
> 
> Patrice Chotard (3):
>   MAINTAINERS: Update some st.com email addresses to foss.st.com
>   MAINTAINERS: Remove Vincent Abriou for STM/STI DRM drivers.
>   MAINTAINERS: Add Alain Volmat as STM32 I2C/SMBUS maintainer
> 
>  MAINTAINERS | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
