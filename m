Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D34436825A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 16:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbhDVOVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 10:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbhDVOU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 10:20:59 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4960C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 07:20:20 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id l9so2206471ilh.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 07:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrJWKg8qXVKHqftlCgBjaSL6VbGyPelbV07Irtnhz3E=;
        b=PCWwmxGZfVK0z3Ug+FWfoNd2U+c4S+UYgxKsD0KK3dTdpSGJEGkbB+E9NbscwSjo/3
         2hzCpqnRXJDxpVWHipELFDknyxGNDrrf3V3fMhViaW8DreVLZYzhEiQJv2ODcj4xIcwk
         MPhdeBbrZWxbj1JgVMVbT0FwXKEovnTKZvtqfIgkytBE7HPXsmArPC+J7DAmcUrVyiUQ
         Y9MRkwVjGJKQ6PAq5FrRL0twGF521XkoMM2SxlGMuoYSLXRf5JNPcMu1ZIedj5szN7DB
         NfIAVANcU5q/VuiGla0es/kmuTzjggNf2ZIRUrwdOU9rPUxd+ftEYb0O/wNJbm7M2Z+S
         eBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrJWKg8qXVKHqftlCgBjaSL6VbGyPelbV07Irtnhz3E=;
        b=FvW8kBpWVhb1SRFR3waBIvOtezEwVaqEeyVhzlf5YsTf9Rd61GAaOjnougRsawcT/j
         +DL6Noc03roctp/MJcdIPJuqikoyG3d5Zim4vsQ0fXaNQHoEHON6qFY1NEXK7afh6njd
         0FYFoVk4qHcgUqDGYxzdyb/r+OmaXSpeMORpzjiIPJZjcgl/gSTyWroI5z30BvWNcbL+
         k12xj6SGOvLUZZzsBdKDTrTrCteB2FJRAuEng6T+icxze4aDRoE52pPU1ewup0WEBPdW
         xEOodEg/T/+53WtXHFe8mseckZa8ObvqYykeqe7uiuJxmBFqrHjLoj015iVicLc3k+aD
         IDUg==
X-Gm-Message-State: AOAM531HzeYfHFW58w06cX7QZSXXkYPkK6p+YAMOvgRef/lX0BS4ZwmC
        FSDjQMAVbnx5Fz09Q0g8dZAtuUbOtYPQZyix/N5s9w==
X-Google-Smtp-Source: ABdhPJxbJaGqsMcVkUPZlR5G96zrmkfSg98YCugoJp2SR7YhsYZ7p2eqSFr3YJtw/Va5rrk31Oyfo74tjvpiOuEwABs=
X-Received: by 2002:a92:d09:: with SMTP id 9mr2924207iln.229.1619101219892;
 Thu, 22 Apr 2021 07:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAKD1Yr2qeXseNLcQ9r4niob02jGOXdVeta6OwWF3Ta1dyp1V2Q@mail.gmail.com>
 <87v98fxjtm.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87v98fxjtm.ffs@nanos.tec.linutronix.de>
From:   Lorenzo Colitti <lorenzo@google.com>
Date:   Thu, 22 Apr 2021 23:20:07 +0900
Message-ID: <CAKD1Yr1u-UsP6s_4TX4HLTgHgYOrkqOajHr4vm6-rhhvFJsfyA@mail.gmail.com>
Subject: Re: [PATCH] hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 9:08 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> Just for comparison. In a VM I'm experimenting with right now the
> reprogramming time is ~500ns which is still a lot of cycles, but
> compared to 5us faster by an order of magnitude. And on the sane
> machine bare metal its way faster and therefore less noticeable.

FWIW, on this hardware, frtrace says that arming the arm64 architected
timer takes 0.7us. Definitely better than 2-3us, but still not free.
This is not a high-end desktop or server, but it's also not super
slow, low-power hardware.

>  * The transmit should only be run if no skb data has been sent for a
>  * certain duration.
>
> which is useless word salad.

You're the one who wrote that comment - see b1a31a5f5f27. You'll
forgive me for being amused. :-)

Thanks for the history/analysis/suggestions. I think it's a fact that
this is a regression in performance: this particular code has
performed well for a couple of years now. The fact that the good
performance only existed due to a correctness bug in the hrtimer code
definitely does make it harder to argue that the regression should be
reverted.

That said: if you have a fix for the double reprogram, then that fix
should probably be applied? 0.5us is not free, and even if hrtimers
aren't designed for frequent updates, touching the hardware twice as
often does seem like a bad idea, since, as you point out, there's a
*lot* of hardware that is slow.

Separately, we're also going to look at making ncm better. (In defense
of the original author, in 2014 I don't think anyone would even have
dreamed of USB being fast enough for this to be a problem.) The first
thing we're going to try to do is set the timer once per NTB instead
of once per packet (so, 10x less). My initial attempt to do that
causes the link to die after a while and I need to figure out why
before I can send a patch up. I'm suspicious of the threading, which
uses non-atomic variables (timer_force_tx, ncm->skb_tx_data) to
synchronize control flow between the timer and the transmit function,
which can presumably run on different CPUs. That seems wrong since
either core could observe stale variables. But perhaps there are
memory barriers that I'm not aware of.

The idea of getting rid of the timer by doing aggregation based on
transmit queue lengths seems like a much larger effort, but probably
one that is required to actually improve performance substantially
beyond what it is now.
