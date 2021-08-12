Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D233EA325
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhHLKyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:54:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57768 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbhHLKyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:54:15 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628765629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hfoGD6Vp85UKZqBQKRVucx1rZSJDFax4wk2DU97QUSw=;
        b=BWEMmFeElQSnWEL40aAz3dzH0xkdb/BjE6EQyDaE9AddkkVOs3hFv0T9wzK4gl8IcIDbdB
        Y1AW2mDj8FPBDINfgrjRXuWlG8/R2pTJUloD3nO9PNc/iB742BZj20zVcqU0HvnRmkrYl1
        And+FfXIYBqXgx1f6wYNunnJeaOP20/qL9vaN4shxnDUgw+eyxBptB8hSjA9BwVCeAKxfX
        5Q5ylqFE2akq5q5nelwVtBF16ftZP/cBQbcbqmYeej2VZ1CnViR81kPNTV7L+SHOcuhw65
        UTH51esAcKmdCqtasmqY1YcSvO0X3qeYg5wq1dFUpWD8Xi3wVt94n6vzewhOvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628765629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hfoGD6Vp85UKZqBQKRVucx1rZSJDFax4wk2DU97QUSw=;
        b=+YYA1+D/NMmVRUdHe5999cHWAe9igzH/TP6zxu35SjyCoRDf9jBt6qqnKJtJm+G4xsAIMY
        uqorbw0aZmZeFFAw==
To:     brookxu <brookxu.cn@gmail.com>, john.stultz@linaro.org,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] clocksource: skip check while watchdog hung up or
 unstable
In-Reply-To: <acbc5aaa-0d19-3144-5299-a66a49b20542@gmail.com>
References: <63064a758eb087febce3eff5b2c736a5449b3dd2.1628675461.git.brookxu@tencent.com>
 <877dgsp2vp.ffs@tglx> <2614d5ac-3392-20d1-d772-7a18bec40fa2@gmail.com>
 <87wnoshyhi.ffs@tglx> <acbc5aaa-0d19-3144-5299-a66a49b20542@gmail.com>
Date:   Thu, 12 Aug 2021 12:53:48 +0200
Message-ID: <87fsvfhr2b.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11 2021 at 23:26, brookxu wrote:
> Thomas Gleixner wrote on 2021/8/11 22:01:
>>> To be precise, we are processing interrupts in handle_edge_irq() for a long
>>> time. Since the interrupts of multiple hardware queues are mapped to a single
>>> CPU, multiple cores are continuously issuing IO, and then a single core is
>>> processing IO. Perhaps the test case can be optimized, but shouldn't this lead
>>> to switching clocks in principle?
>> 
>> The clocksource watchdog failure is only _ONE_ consequence. Processing
>> hard interrupts for 155 seconds straight will trigger lockup detectors
>> of all sorts if you have them enabled.
>> 
>> So just papering over the clocksource watchdog does not solve anything,
>> really. Next week you have to add similar hacks to the lockup detectors,
>> RCU and whatever.
>
> Yeah, we have observed soft lockup and RCU stall, but these behaviors are
> expected because the current CPU scheduling is disabled. However, marking
> TSC unstable is inconsistent with the actual situation. The worst problem
> is that after the clocksource switched to hpet, the abnormal time will be
> greatly prolonged due to the degradation of performance. We have not found
> that soft lockup and RCU stall will affect the machine for a long time in
> this test. Aside from these, as the watchdog is scheduled periodically, when
> wd_nsec is 0, it means that something maybe abnormal, do we readlly still
> need to continue to verify TSC? and how to ensure the correctness of the
> results?

Sorry no. While softlockups and RCU stalls might have no long term
effect in the first place, this argumentation vs. the clocksource
watchdog is just a strawman. You're abusing the system in a way which
causes it to malfunction so you have to live with the consequences.

Aside of that this 'workaround' is just duct taping a particular part of
the problem. What guarantees that after the interrupt storm subsided the
clocksource delta of the watchdog becomes 0 (negative)?

Absolutely nothing. The delta can be positive, but then the watchdog and
the TSC are not in sync anymore which will disable the TSC as well.

A 24MHz HPET has a wraparound time of ~178s which means during:

  89s < tdelta < 178s

your hack papers over the problem. Any interrupt storm time outside of
that window results in fail.

Now run the same test on a machine with a 14MHz HPET and you get

 153s < tdelta < 306s

so your 155s interrupt storm barely fits. And what are you doing with
your next test which runs only 80 seconds?

Not to talk about the fact that you wreckage detection of a watchdog
clocksource going stale.

So no, we are not adding hacks to support abuse.

What we really want to do is to add detection for interrupt storms of
this sort and shut those interrupts down for good.

Thanks,

        tglx
---
Patient: "Doctor, it hurts when I hammer on my toe."
Doctor:  "Don't do that then!"


