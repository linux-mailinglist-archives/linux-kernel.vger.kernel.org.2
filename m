Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F313FB8F2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbhH3PZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 11:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbhH3PZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:25:09 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06183C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:24:16 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w19so20270831oik.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kdKX/WdvQSzx9pQXGoy8ez521PWgUs/3p6zZNO54TOk=;
        b=mCcwGzQBCEV7kaKBDZ+mKs9zCnTxaB/cXCMTVqN8ci22CAk9ZkhnvJZGJH8DAcBpa2
         dNg6UkbZoQWtXey9pf9Ur/ltJiwGlpxyUxkUZ8pDt6ooqWkUQUjiQQLir0xGc9tSiq9T
         N4862s32a6zMJZ6KaQgXGLLfc3/7dc5AJVDfQLT12EeXHVkQoE8r87bJQjEEejtOgdy/
         gdTHP1OkGAn2wjPmYNmhQf+XifhqmLJ2cg9/Q709tzPghRffl1z4VGeShVW+bxSUxuLT
         GtPlrHHTTeETiGekUfRijQLfQnmVy38c0R7JXkzjEgnDg/N7dlqgXo3Vr519phHxWdtV
         csgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kdKX/WdvQSzx9pQXGoy8ez521PWgUs/3p6zZNO54TOk=;
        b=l0g9NoDog5cDPJBSqcpZwLAKYeBuOjzF37E3uRURLri92rA9c6FNz4WBBioirZ9IAs
         FKVm4nSNlX/d3eMGwpLP6eA3AGkEyhgraBkAwn1IduKMFy8gT5tMSA0T5SvGtCyTsy18
         kMSyBkuJsT10QHzrMLmyQ/EWKxwWKplJQU3pXvCoJoIkQ7H6bzU1pNGhkwZpGNxrAsqV
         Wb7dY0CdyAaRTWJkjkf8sluUIrq7pbLVG65yILOm7xjEDRdDQNByj9PjgOVcYE/0hlNz
         /uK2aKkg0whclovqtoOvLvBjRrU5iHRNZpDtsYuKMaOJWE49S/0trETIKl2wDbbLZ2Dm
         f9EA==
X-Gm-Message-State: AOAM533WlzltNKPYLuqrUGJ60B6I2ZVIKy3B8lS2ZbFN5crJPhODs9wi
        1SPGd7PvuFNkCG50Y17ZMz0=
X-Google-Smtp-Source: ABdhPJzR2fhFZNwo31g0Djakp0hSnjpxpIuv3QLldV3hwIHop+e3sKlNduAUeYmDGh2FjQMDPNQkBA==
X-Received: by 2002:a05:6808:1892:: with SMTP id bi18mr9373936oib.105.1630337055289;
        Mon, 30 Aug 2021 08:24:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p81sm1209421oia.48.2021.08.30.08.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 08:24:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
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
 <cc934baf-75a9-d7f6-44ac-e7fa1c6f69b6@kaod.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2]: Be stric clocksource/drivers/fttmr010 on IRQs
Message-ID: <7f46191c-2400-2679-9abd-e517fb78b57b@roeck-us.net>
Date:   Mon, 30 Aug 2021 08:24:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cc934baf-75a9-d7f6-44ac-e7fa1c6f69b6@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/21 12:47 AM, Cédric Le Goater wrote:
> On 8/30/21 6:58 AM, Guenter Roeck wrote:
>> On 8/29/21 9:16 PM, Andrew Jeffery wrote:
>> [ ... ]
>>>>
>>>>> I don't have the manuals, so I can't say what the correct behavior is,
>>>>> but at least there is some evidence that TIMER_INTR_STATE may not exist
>>>>> on ast2400 and ast2500 SOCs.
>>>>
>>>> On Aspeed SoCs AST2400 and AST2500, the TMC[34] register is a
>>>> "control register #2" whereas on the AST2600 it is an "interruptarch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi:#include
>>>> status register" with bits [0-7] holding the timers status.
>>>>
>>>> I would say that the patch simply should handle the "is_aspeed" case.
>>>
>>> Well, is_aspeed is set true in the driver for all of the 2400, 2500 and
>>> 2600. 0x34 behaves the way this patch expects on the 2600. So I think
>>> we need something less coarse than is_aspeed?
>>>
>>
>> If I understand the code correctly, ast2400 and ast2500 execute
>> fttmr010_timer_interrupt(), while ast2600 has its own interrupt handler.
>> To make this work, it would probably be necessary to check for is_aspeed
>> in fttmr010_timer_interrupt(), and only execute the new code if the flag
>> is false. The existing flag in struct fttmr010 should be good enough
>> for that.
> 
> yes.
> 
> I wonder why we have ast2600 support in fttmr010. The AST2600 boards use
> the arm_arch_timer AFAICT.
> 

It was introduced and enabled, but later disabled with commit c998f40f2ae6a4
("ARM: dts: aspeed: ast2600: Set arch timer always-on"):

"According to ASPEED, FTTMR010 is not intended to be used in the AST2600.
  The arch timer should be used, but Linux doesn't enable high-res timers
  without being assured that the arch timer is always on, so set that
  property in the devicetree."

That commit also disables the FTTMR010 timer, but doesn't remove the devicetree
node. Maybe it would make sense to remove the ast2600 code from the fttmr010
driver, including the devicetree node. After all, it looks like it is dead.

Guenter
