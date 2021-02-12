Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A952319B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 09:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBLIJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 03:09:52 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60942 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229598AbhBLIJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 03:09:49 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11C86l2M029175;
        Fri, 12 Feb 2021 09:08:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=DHLRE2UmB8C4wlDYI8k7uWIN7I9RjaZ2KYe3yihptMU=;
 b=SgPTIN9lqgwaVVpkZ+RZC5gItARGIhGqsdMWlXL1ng4qFgK0ZH84btADnmv2q3JCF1Kz
 Dmm8a8gSrwSDMO0D/E6d5q5JaEgv4K3d87myhQStAeUWyuC7qJOksxTAQBeSwdOWURPx
 ADunrwMYfVxgYkq92XrWDWIargGuzOOt21Smh5SMBGs+RR4AUNP8Ppm3HJlgp8Wl1L3L
 qpyzqABA08S0MaSiIztNlXwubfAVtZjlMe/h6QK33DVRHc1uo3jFzQ+SGyQzc+mgnteI
 Qp8BlbUt3PgDCwhlMPga9upVHJ81MNFkgF1QFs9PlyRuIRW2bpgZ5t0JkMJYhHd8OGUg jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36hravbcje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 09:08:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DCD72100034;
        Fri, 12 Feb 2021 09:08:41 +0100 (CET)
Received: from Webmail-eu.st.com (gpxdag2node6.st.com [10.75.127.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B967B219D40;
        Fri, 12 Feb 2021 09:08:41 +0100 (CET)
Received: from lmecxl0572.lme.st.com (10.75.127.121) by GPXDAG2NODE6.st.com
 (10.75.127.70) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Feb
 2021 09:08:40 +0100
Subject: Re: [PATCH v2 02/14] clk: stm32mp1: merge 'ck_hse_rtc' and 'ck_rtc'
 into one clock
To:     Stephen Boyd <sboyd@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Etienne Carriere <etienne.carriere@st.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>, <marex@denx.de>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210126090120.19900-1-gabriel.fernandez@foss.st.com>
 <20210126090120.19900-3-gabriel.fernandez@foss.st.com>
 <161285764074.418021.15522379930579131077@swboyd.mtv.corp.google.com>
From:   "gabriel.fernandez@foss.st.com" <gabriel.fernandez@foss.st.com>
Message-ID: <5cc12945-0347-820c-1125-30ab4a947a00@foss.st.com>
Date:   Fri, 12 Feb 2021 09:08:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <161285764074.418021.15522379930579131077@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.75.127.121]
X-ClientProxiedBy: GPXDAG1NODE5.st.com (10.75.127.66) To GPXDAG2NODE6.st.com
 (10.75.127.70)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_02:2021-02-12,2021-02-12 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/9/21 9:00 AM, Stephen Boyd wrote:
> Quoting gabriel.fernandez@foss.st.com (2021-01-26 01:01:08)
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> 'ck_rtc' has multiple clocks as input (ck_hsi, ck_lsi, and ck_hse).
>> A divider is available only on the specific rtc input for ck_hse.
>> This Merge will facilitate to have a more coherent clock tree
>> in no trusted / trusted world.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> ---
>>   drivers/clk/clk-stm32mp1.c | 49 +++++++++++++++++++++++++++++++++-----
>>   1 file changed, 43 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
>> index 35d5aee8f9b0..0e1d4427a8df 100644
>> --- a/drivers/clk/clk-stm32mp1.c
>> +++ b/drivers/clk/clk-stm32mp1.c
>> @@ -245,7 +245,7 @@ static const char * const dsi_src[] = {
>>   };
>>   
>>   static const char * const rtc_src[] = {
>> -       "off", "ck_lse", "ck_lsi", "ck_hse_rtc"
>> +       "off", "ck_lse", "ck_lsi", "ck_hse"
>>   };
>>   
>>   static const char * const mco1_src[] = {
>> @@ -1031,6 +1031,42 @@ static struct clk_hw *clk_register_cktim(struct device *dev, const char *name,
>>          return hw;
>>   }
>>   
>> +/* The divider of RTC clock concerns only ck_hse clock */
>> +#define HSE_RTC 3
>> +
>> +static unsigned long clk_divider_rtc_recalc_rate(struct clk_hw *hw,
>> +                                                unsigned long parent_rate)
>> +{
>> +       if (clk_hw_get_parent(hw) == clk_hw_get_parent_by_index(hw, HSE_RTC))
>> +               return clk_divider_ops.recalc_rate(hw, parent_rate);
>> +
>> +       return parent_rate;
>> +}
>> +
>> +static long clk_divider_rtc_round_rate(struct clk_hw *hw, unsigned long rate,
>> +                                      unsigned long *prate)
>> +{
>> +       if (clk_hw_get_parent(hw) == clk_hw_get_parent_by_index(hw, HSE_RTC))
> This clk op can be called at basically any time. Maybe this should use
> the determine rate op and then look to see what the parent is that comes
> in via the rate request structure? Or is the intention to keep this
> pinned to one particular parent? Looking at this right now it doesn't
> really make much sense why the current parent state should play into
> what rate the clk can round to, unless there is some more clk flags
> going on that constrain the ability to change this clk's parent.

Yes the intention is to keep this pinned for one particular parent.

This divider is only applied on the 4th input of the MUX of the RTC and

doesn't affect the HSE frequency for all the system.


Oscillators
  -----
| lse |----------------+----------------> ck_lse
  -----                 |
  -----                 |
| lsi |------------+--------------------> ck_lsi
  -----             |   |
                    |   |
  -----             |   |
| hse |----+-------|---|----------------> ck_hse
  -----     |       |   |
            |       |   |         |\ mux
            |       |   |  OFF -->| \
            |       |   |         |  \     gate
            |       |   --------->|  |     ---
            |       |             |  |--->|   |--> ck_rtc
            |       ------------->|  |     ---
            |    -----------      |  |
             ----| % 1 to 64 |--->| /
                  -----------     |/
                    divider

I manage the RTC with a clock composite with a gate a mux and a specific 
rate ops for hse input.

That why i need to the parent state.

Best Regards

Gabriel


>> +               return clk_divider_ops.round_rate(hw, rate, prate);
>> +
>> +       return *prate;
>> +}
>> +
>> +static int clk_divider_rtc_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                                   unsigned long parent_rate)
>> +{
>> +       if (clk_hw_get_parent(hw) == clk_hw_get_parent_by_index(hw, HSE_RTC))
>> +               return clk_divider_ops.set_rate(hw, rate, parent_rate);
>> +
>> +       return parent_rate;
>> +}
>> +
