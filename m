Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CDE3EAE06
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 02:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbhHMAy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 20:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbhHMAyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 20:54:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE2CC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 17:54:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso13546210pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 17:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nmttyYqttgac7auAyOdsh4Z+STqNVjkjfbXu+XGmeHk=;
        b=PhQ7eJ9uG6+LgT//Wa2+LpH0aQBr5NWGczDHJpNqNPmUVkjZNa1S4GRgT4BQHt3I2A
         FuPKS2r39ryAHmA4/ZNl4/Ony9FAfriBhBekugGgUzduOd/OZ6keItE7wkR95pg5s+Y7
         4gmlw6BuG/uEuzIL0LOblZPdGQzqJ2EVXp5/NAtAwNk0e5vb5TD6ATatXh3WW+jm0GKx
         jOezNCR7HOaLz2JiqP9VkTJfPfhxDUS5GrfRHKozIPd7tsRQ4ZgfRFeUkWcoylf7P57n
         Xc9KBJa03JOK66KUvUF4C8ZKh/V7kgLiH6XgCTFEpd2urgFtYvLTL+dvUW+MeJk9ed/V
         wN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nmttyYqttgac7auAyOdsh4Z+STqNVjkjfbXu+XGmeHk=;
        b=s6x/DZ1MFJczGGk1D/k4HES8P4aDB/0ER2UYsvxdKEPuD6M0HPS6L1WJfapThPhJfk
         9gWnv37P/II0okV26Rp48ABEgkQ880VBcfG8s60zugy44Um7q6VRoIFK6M66ApZvxlJV
         G8ZqgbKrYL68SrYrCcdWE+zDsGyml0eTVZI0RIlJ7tgZ6pfViXmsKJuUOItR635Pi28V
         NJxPC0Ucm9cwpJrMGTWrsWLcj1mgt3EcbVlqOTUELE8ONmBBtKbNMcfkx79KMFdEI1sh
         ZYL2Sli9JVuCY8GvhnUrCrvLiEALEk95eVxJjPGlUb0CTCX/uNOPEasL7A7HYYvgFxed
         kDcw==
X-Gm-Message-State: AOAM533qKWCqk5C88jlRn4/IXN/vDeHv3Ye1otW+nOhiLElpJz8pJw0B
        +7n9Zi3yuLdp731YW8EqB4L09m7ct8gJMA==
X-Google-Smtp-Source: ABdhPJwucGma3sHI4VSnV8fwx2moFIb2zLpdB8agZLJ2lXNwKqMh/gXSz+tJI0tzmvaNM63Hq7nLIg==
X-Received: by 2002:a63:5fcc:: with SMTP id t195mr6248343pgb.146.1628816069232;
        Thu, 12 Aug 2021 17:54:29 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.114])
        by smtp.gmail.com with ESMTPSA id i13sm4821174pfr.79.2021.08.12.17.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 17:54:28 -0700 (PDT)
Subject: Re: [RFC PATCH] clocksource: skip check while watchdog hung up or
 unstable
To:     Thomas Gleixner <tglx@linutronix.de>, john.stultz@linaro.org,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <63064a758eb087febce3eff5b2c736a5449b3dd2.1628675461.git.brookxu@tencent.com>
 <877dgsp2vp.ffs@tglx> <2614d5ac-3392-20d1-d772-7a18bec40fa2@gmail.com>
 <87wnoshyhi.ffs@tglx> <acbc5aaa-0d19-3144-5299-a66a49b20542@gmail.com>
 <87fsvfhr2b.ffs@tglx>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <5ef35e9e-3a91-282c-4254-0abcd10e0a7f@gmail.com>
Date:   Fri, 13 Aug 2021 08:54:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87fsvfhr2b.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Thomas Gleixner wrote on 2021/8/12 6:53 下午:
> On Wed, Aug 11 2021 at 23:26, brookxu wrote:
>> Thomas Gleixner wrote on 2021/8/11 22:01:
>>>> To be precise, we are processing interrupts in handle_edge_irq() for a long
>>>> time. Since the interrupts of multiple hardware queues are mapped to a single
>>>> CPU, multiple cores are continuously issuing IO, and then a single core is
>>>> processing IO. Perhaps the test case can be optimized, but shouldn't this lead
>>>> to switching clocks in principle?
>>>
>>> The clocksource watchdog failure is only _ONE_ consequence. Processing
>>> hard interrupts for 155 seconds straight will trigger lockup detectors
>>> of all sorts if you have them enabled.
>>>
>>> So just papering over the clocksource watchdog does not solve anything,
>>> really. Next week you have to add similar hacks to the lockup detectors,
>>> RCU and whatever.
>>
>> Yeah, we have observed soft lockup and RCU stall, but these behaviors are
>> expected because the current CPU scheduling is disabled. However, marking
>> TSC unstable is inconsistent with the actual situation. The worst problem
>> is that after the clocksource switched to hpet, the abnormal time will be
>> greatly prolonged due to the degradation of performance. We have not found
>> that soft lockup and RCU stall will affect the machine for a long time in
>> this test. Aside from these, as the watchdog is scheduled periodically, when
>> wd_nsec is 0, it means that something maybe abnormal, do we readlly still
>> need to continue to verify TSC? and how to ensure the correctness of the
>> results?
> 
> Sorry no. While softlockups and RCU stalls might have no long term
> effect in the first place, this argumentation vs. the clocksource
> watchdog is just a strawman. You're abusing the system in a way which
> causes it to malfunction so you have to live with the consequences.
> 
> Aside of that this 'workaround' is just duct taping a particular part of
> the problem. What guarantees that after the interrupt storm subsided the
> clocksource delta of the watchdog becomes 0 (negative)?
> 
> Absolutely nothing. The delta can be positive, but then the watchdog and
> the TSC are not in sync anymore which will disable the TSC as well.
> 
> A 24MHz HPET has a wraparound time of ~178s which means during:
> 
>   89s < tdelta < 178s
> 
> your hack papers over the problem. Any interrupt storm time outside of
> that window results in fail.
> 
> Now run the same test on a machine with a 14MHz HPET and you get
> 
>  153s < tdelta < 306s
> 
> so your 155s interrupt storm barely fits. And what are you doing with
> your next test which runs only 80 seconds?
> 
> Not to talk about the fact that you wreckage detection of a watchdog
> clocksource going stale.
> 
> So no, we are not adding hacks to support abuse.
> 
> What we really want to do is to add detection for interrupt storms of
> this sort and shut those interrupts down for good.

ok, thanks for your suggestion.

> Thanks,
> 
>         tglx
> ---
> Patient: "Doctor, it hurts when I hammer on my toe."
> Doctor:  "Don't do that then!"
> 
> 
