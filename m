Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEC73B595C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhF1HEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:04:04 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:6600 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230287AbhF1HD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:03:59 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S6wbOj006266;
        Mon, 28 Jun 2021 09:01:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=nmTbU+JNNbp7VzmAnslcoU+Y5KpKRuaSAbCAIK3+uWI=;
 b=VofqB4aMsyZqTqEHQ4oBSVVX1u4XranJVcWAuHhfwwkurpeWajARGnlCXjX0xAOsC8gL
 ebtA9jAhBIUfx54jc7kV1RETl+FLJUGukqmkn455D/cffx/aRmf/iA2N8JGQEnx6R6WJ
 MC6GocIE6Kys32j3/0NnnW4uJqRTPTOUwZ1K7NPjP+q7sleM+TxSumE7nQeUQgxIqJwc
 SEdArbq0wdA5brreGjgZA3FTDWe7gM9wGJ/Iq8PvXM6AZdfWa5AvIeoIFAm3x1yu0kFz
 eThlKPBz3IR/EgfhySXWKZBeVVypmOe4/TNJMQ1BbfSJ0+IAB/h3tiGmctyB+3AiABIo +A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39f1xshvdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 09:01:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3C55A10002A;
        Mon, 28 Jun 2021 09:01:13 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E7BD20E3A5;
        Mon, 28 Jun 2021 09:01:13 +0200 (CEST)
Received: from lmecxl0572.lme.st.com (10.75.127.49) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Jun
 2021 09:01:12 +0200
Subject: Re: [RESEND PATCH v3 06/11] reset: stm32mp1: remove stm32mp1 reset
To:     Stephen Boyd <sboyd@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Etienne Carriere <etienne.carriere@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, <marex@denx.de>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210617051814.12018-1-gabriel.fernandez@foss.st.com>
 <20210617051814.12018-7-gabriel.fernandez@foss.st.com>
 <162484414661.3259633.15807994186850314510@swboyd.mtv.corp.google.com>
From:   "gabriel.fernandez@foss.st.com" <gabriel.fernandez@foss.st.com>
Message-ID: <d53bc6e0-523f-b13c-9e87-a3a2f0301802@foss.st.com>
Date:   Mon, 28 Jun 2021 09:01:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <162484414661.3259633.15807994186850314510@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_05:2021-06-25,2021-06-28 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, many thanks Stephen.

Best regards
Gabriel

On 6/28/21 3:35 AM, Stephen Boyd wrote:
> Quoting gabriel.fernandez@foss.st.com (2021-06-16 22:18:09)
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> st32mp1 RCC reset driver was moved into stm32mp1 RCC clock driver.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> ---
> 
> Applied to clk-next although it would be nice to get Philipp's ack
> 
