Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544D43ACC1B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhFRN1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:27:30 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:8084 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232546AbhFRN12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:27:28 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IDDV7W029190;
        Fri, 18 Jun 2021 15:25:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=TGRIuYa1RneAyuabvPhXlPbKaYa/GapaD9l0+sSWxuw=;
 b=dYE9THOnJzJSBCZl456P8kNA/msyy19+tGQb5Vx6BD38esDf/EU4cnqS7tsS6PhHm/CA
 tWTYLmsUyq58RsUrUbDSsVekrCj4lN3+BEED0Hd8z1W8lTsHS0rh8ItWTz1KI1lsjhue
 yzPC/OGmaNq6/Ye0Lrb2vveUo/H7/2X6tuvgJpGb0FY/Vy+WhXUlFtIMShGDNmoHYMLn
 5/LQN6xCeSTh47SvBfT3sTjgwlRDJiYFBrXikeLb2NZz3B75r92EzmmIz1Qh/xEdQJ2E
 TA58zqL77NJyFzTMkU5IZ9peZnUbaaQY6zl8MeYN5/yxwvvdFLfJ/vBeCec/T4SGTeGP RA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 398qqg9nvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 15:25:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8259E10002A;
        Fri, 18 Jun 2021 15:25:00 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 60ED122B9C0;
        Fri, 18 Jun 2021 15:25:00 +0200 (CEST)
Received: from lmecxl0572.lme.st.com (10.75.127.45) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Jun
 2021 15:24:59 +0200
Subject: Re: [RESEND PATCH v3 11/11] clk: stm32mp1: new compatible for secure
 RCC support
To:     Marek Vasut <marex@denx.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Etienne Carriere <etienne.carriere@foss.st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210617051814.12018-1-gabriel.fernandez@foss.st.com>
 <20210617051814.12018-12-gabriel.fernandez@foss.st.com>
 <14a81ad2-d646-30ca-46f0-d2078b09c4f2@denx.de>
From:   "gabriel.fernandez@foss.st.com" <gabriel.fernandez@foss.st.com>
Message-ID: <e7952251-b3bb-5042-65bd-7ab7ef37ac93@foss.st.com>
Date:   Fri, 18 Jun 2021 15:24:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <14a81ad2-d646-30ca-46f0-d2078b09c4f2@denx.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_07:2021-06-18,2021-06-18 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes we could have considered it as a feature but we think it's better to 
manage it as a layer of our driver via a compatible.

On 6/17/21 8:46 AM, Marek Vasut wrote:
> On 6/17/21 7:18 AM, gabriel.fernandez@foss.st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> Platform STM32MP1 can be used in configuration where some clock
>> resources cannot be accessed by Linux kernel when executing in non-secure
>> state of the CPU(s).
>> In such configuration, the RCC clock driver must not register clocks
>> it cannot access.
>> They are expected to be registered from another clock driver such
>> as the SCMI clock driver.
>> This change uses specific compatible string "st,stm32mp1-rcc-secure"
>> to specify RCC clock driver configuration where RCC is secure.
> 
> Should this really be a new compatible string or rather a DT property ? 
> I think the later, since this is the same clock IP, only operating in 
> different "mode" , no ?
