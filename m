Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3CA3FB210
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 09:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbhH3HsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:48:02 -0400
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231]:60125 "EHLO
        8.mo548.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbhH3Hr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:47:59 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.249])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4073F2079B;
        Mon, 30 Aug 2021 07:47:04 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Mon, 30 Aug
 2021 09:47:03 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-100R00323d219df-5663-47f2-b4cd-9fc470d5d05b,
                    A410DCCBFF6448DFF799E1C977766415213BDB3F) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Subject: Re: [PATCH 2/2]: Be stric clocksource/drivers/fttmr010 on IRQs
To:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
References: <20210724224424.2085404-1-linus.walleij@linaro.org>
 <20210724224424.2085404-2-linus.walleij@linaro.org>
 <20210821042010.GA1759866@roeck-us.net>
 <CACRpkdYObGTWni3sSa21iNsgikzj7t9MA6y4TNgkBTTYQt+coA@mail.gmail.com>
 <4d87c7af-d2e3-9456-130a-b35b507ff3a2@roeck-us.net>
 <567a65a8-077b-7394-c8e2-dbd9f063e02c@kaod.org>
 <4c87cee3-2dfb-41e7-a18b-5ed4687a6f7a@www.fastmail.com>
 <f71cbfb9-b72c-39d2-6acb-dc83b6a496f8@roeck-us.net>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cc934baf-75a9-d7f6-44ac-e7fa1c6f69b6@kaod.org>
Date:   Mon, 30 Aug 2021 09:47:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f71cbfb9-b72c-39d2-6acb-dc83b6a496f8@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 0a51df70-3316-4a7a-bb6a-740fc67eb451
X-Ovh-Tracer-Id: 10157587485558541161
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddruddukedguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegvdeijeefvdfhudfhffeuveehledufffhvdekheelgedttddthfeigeevgefhffenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvght
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/21 6:58 AM, Guenter Roeck wrote:
> On 8/29/21 9:16 PM, Andrew Jeffery wrote:
> [ ... ]
>>>
>>>> I don't have the manuals, so I can't say what the correct behavior is,
>>>> but at least there is some evidence that TIMER_INTR_STATE may not exist
>>>> on ast2400 and ast2500 SOCs.
>>>
>>> On Aspeed SoCs AST2400 and AST2500, the TMC[34] register is a
>>> "control register #2" whereas on the AST2600 it is an "interruptarch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi:#include
>>> status register" with bits [0-7] holding the timers status.
>>>
>>> I would say that the patch simply should handle the "is_aspeed" case.
>>
>> Well, is_aspeed is set true in the driver for all of the 2400, 2500 and
>> 2600. 0x34 behaves the way this patch expects on the 2600. So I think
>> we need something less coarse than is_aspeed?
>>
> 
> If I understand the code correctly, ast2400 and ast2500 execute
> fttmr010_timer_interrupt(), while ast2600 has its own interrupt handler.
> To make this work, it would probably be necessary to check for is_aspeed
> in fttmr010_timer_interrupt(), and only execute the new code if the flag
> is false. The existing flag in struct fttmr010 should be good enough
> for that.

yes. 

I wonder why we have ast2600 support in fttmr010. The AST2600 boards use 
the arm_arch_timer AFAICT.

C.

