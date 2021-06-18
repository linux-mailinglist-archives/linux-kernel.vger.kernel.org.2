Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110B13AD352
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhFRUGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:06:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58728 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhFRUGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:06:19 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624046648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=spgBxNY8WxX/83KFnI0Ha+vRsF2Z9M+7groG436lah8=;
        b=FTWd92+cvMDXWnc2qdtmQRNmynLAUJF4CfcJR+/fRu5Pfl62RN3UgVVsUPSByQSajE6OYg
        2ef6uZbRuHiSIV8AdxxvBXI5R6NJIkAVTez3J5HwKbcR6BqaVoQXLOaGXPTIsNrcnWbY/Q
        8qL3HeI0I1Zrl7TzWyZLbx1by7y6RX1aqpmwe6w7O1bxhKi2RE2tw2xp+gMXHJ+6S9ZL0P
        6eUQGnY3UdWKC6enQiZ0eR2IyPgrE3B+o62Y3rXAWPN5uoC0OI4ZJeQ1kT3N8QSSQWKICT
        rAdXEGltjnISuCQkzqxKCRVk8kipxeUN3I2fsJeeTeZ80vHMXrY1aemk7QHMZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624046648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=spgBxNY8WxX/83KFnI0Ha+vRsF2Z9M+7groG436lah8=;
        b=GODC8RqU3yfwJo8JiR3pC8SyE5vP7FD4xjQWhqkIaqnrEEA+Zje7Mj+HWvJB/unFgAH+nO
        VPgREWt+oWmTA8BQ==
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Song Hui <hui.song_1@nxp.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-rt-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "Steven Rostedt \(VMware\)" <rostedt@goodmis.org>,
        Esben Haabendal <esben@geanix.com>
Subject: Re: commit 3d5bfbd97163 versus -rt
In-Reply-To: <5afbc89e-dbc4-3f47-4e61-63a77165aaec@prevas.dk>
References: <5afbc89e-dbc4-3f47-4e61-63a77165aaec@prevas.dk>
Date:   Fri, 18 Jun 2021 22:04:07 +0200
Message-ID: <871r8zey88.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15 2021 at 14:35, Rasmus Villemoes wrote:
>  [<8016fb80>] (generic_handle_irq) from [<8043e98c>]
> (mpc8xxx_gpio_irq_cascade+0xac/0xd0)
>  [<8043e8e0>] (mpc8xxx_gpio_irq_cascade) from [<80171c80>]
> (irq_forced_thread_fn+0x38/0x8c)
>   r5:80e282c0 r4:80deda00
>  [<80171c48>] (irq_forced_thread_fn) from [<80171eb4>]
> (irq_thread+0x11c/0x238)
.
> Reverting commit 3d5bfbd9716318b1ca5c38488aa69f64d38a9aa5 (gpio:
> mpc8xxx: change the gpio interrupt flags.) makes it go away, as does
> disabling CONFIG_PREEMPT_RT or simply booting a vanilla v5.10.42 (where
> that option exists but cannot be selected).
>
> This seems to be the kind of thing where an -rt expert can immediately
> see what's wrong and how to fix it. Ideas anyone?

Let me explain. The force threaded interrupt code in mainline made the
wrong assumption that disabling softirqs is sufficient to provide the
semantics of non-threaded handler invocation. This turned out to be
wrong and caused people to do fancy workarounds.

See 81e2073c175b ("genirq: Disable interrupts for force threaded
handlers") for details.

So people started to remove IRQF_NO_THREAD or local_irq_save/restore
pairs in drivers.

But 3d5bfbd97163 ("gpio: mpc8xxx: change the gpio interrupt flags.") has
nothing to do with that:

    "Delete the interrupt IRQF_NO_THREAD flags in order to gpio interrupts
     can be threaded to allow high-priority processes to preempt."

This changelog is blatantly wrong. In mainline forced irq threads have
always been invoked with softirqs disabled, which obviously makes them
non-preemptible. And on RT this would have exploded exactly in the way
you observed.

The commit predates 81e2073c175b and therefore was obviously never
tested neither on mainline nor on RT.

Bartosz, please revert this ASAP.

I'll add a lockdep assert into generic_handle_irq() to make it obvious
where the problem is. That won't help with completely untested garbage
of course.

81e2073c175b is obviously a problem for demultiplexing drivers which
make weird assumptions when RT comes into play and I'm not surprised
that there is some fallout which we need to look at. Especially when
people start to zap IRQF_NO_THREAD or irq_save/restore pairs blindly.

Thanks,

        tglx

