Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BCF41765A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346509AbhIXN6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:58:14 -0400
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231]:34171 "EHLO
        8.mo548.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhIXN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:58:13 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.235])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id D6BCF214DD;
        Fri, 24 Sep 2021 13:56:37 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Fri, 24 Sep
 2021 15:56:37 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-97G002cc673897-dfc8-439b-bd13-e8669eeec224,
                    EA4874C54EC1FB151381C7D8681494D1EB26EF60) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <0c180f94-50df-1cbe-3cf6-62904b017a8c@kaod.org>
Date:   Fri, 24 Sep 2021 15:56:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 1/3 v2] clocksource/drivers/fttmr010: Be stricter on IRQs
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Guenter Roeck <linux@roeck-us.net>
References: <20210922195656.1822268-1-linus.walleij@linaro.org>
 <f183c017-7a60-bce5-a440-7010ea3d90b8@kaod.org>
 <CACRpkdareKNQndBDyPE_oHE0RgUcSfutAR9GZZhiNAWNQa8whA@mail.gmail.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CACRpkdareKNQndBDyPE_oHE0RgUcSfutAR9GZZhiNAWNQa8whA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: f69528f4-e6e2-4fa6-b697-ec534f6e555b
X-Ovh-Tracer-Id: 15642408884650478374
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudejuddgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepieegvdffkeegfeetuddttddtveduiefhgeduffekiedtkeekteekhfffleevleelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvght
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/21 23:05, Linus Walleij wrote:
> On Thu, Sep 23, 2021 at 10:11 PM Cédric Le Goater <clg@kaod.org> wrote:
> 
>> I think we should start by dropping all the AST2600 code which
>> is unused.
> 
> I don't see why, the hardware is there is it not?

The TMC34 register is different on the AST2600.

The only piece of code that makes sense is in ast2600_timer_interrupt() :
     
	writel(0x1, fttmr010->base + TIMER_INTR_STATE);

which clears the status.

If you really insist on keeping the AST2600 support, then I would
rework a bit ast2600_timer_interrupt() : drop TIMER_1_INT_OVERFLOW
and may be use BIT(0) instead of TIMER_1_INT_MATCH1, since the
register layout is different.

There are 8 timers on the AST2600.

Thanks,

C.

> In my experience it is unwise to try to system manage the kernel,
> decide what hardware gets exposed to the frameworks and which
> does not.
> 
> There have been instances in the past where we have first said we don't
> need another timer on the system (so it is "dark silicon") and later brought
> it back because it has some upside.
> 
> For example for a while the Ux500 was using clksrc-dbx500-prcmu.c
> exclusively because it was the only clocksource that would not stop
> during sleep, and nomadik-mtu.c was unused. Then we invented a
> way to grade the different clocksources and switch between them
> before sleep, but tagging one of them with
> CLOCK_SOURCE_SUSPEND_NONSTOP and giving them the right
> rating, see commit bc0750e464d4.
> 
> This was good because nomadi-mtu.c has higher granularity and
> higher frequency when the system is awake but clksrc-dbx500-prcmu.c
> is always ticking, so each is used for different purposes.
> 
> Lesson learned: register all hardware with the timekeeping core and
> let the kernel decide what timer to use at what point and for what.
> 
> Yours,
> Linus Walleij
> 

