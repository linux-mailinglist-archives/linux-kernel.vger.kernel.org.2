Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0248C368368
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbhDVPfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbhDVPft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:35:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B137DC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 08:35:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619105713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tdYgOjuDcXp+D8oued9UmtxqKDBab3b/DzqMtt7gcB8=;
        b=WDtegM7V4szTFJdXyCOuw0laWC2MlcRocc4QReIuT1r72eIspp6JdJA03ZruqiBkPIqUhf
        R2oIhvc0hHvaMTJgq3+nkd0Gnz46yfWAH0ixjuzGDKYNHN8zQ1QCpmGlk1YEQu2ARmdsFC
        l/k/L4Kq9NTNz/ouVhn5EhAG8Ucetgc6x90TqRuNOACdDD3imeDZptAYsvGfqi2jzUt3k1
        RH5U28wvJpy33FhCHpyY+dOBT5MTdk3GehTTIqElyJ6GLVMSEqfgmsSRgXk3GHTzCLlG92
        xyQFFe9y8qrMdadyvUZRNB+rBo68qqRVRE8tWK9o9/thf8vSGwWdsOZXbWFzbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619105713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tdYgOjuDcXp+D8oued9UmtxqKDBab3b/DzqMtt7gcB8=;
        b=PeiVHxyXC6MUVD89MelzcsqMeyl9GvQp3a86YZyboGlvoRoyS5/z3d2nakgTwgmkJPBfg4
        7QeIDfnYM4vfd9Aw==
To:     Lorenzo Colitti <lorenzo@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Maciej =?utf-8?Q?=C5=BBenczykows?= =?utf-8?Q?ki?= 
        <zenczykowski@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()
In-Reply-To: <CAKD1Yr1u-UsP6s_4TX4HLTgHgYOrkqOajHr4vm6-rhhvFJsfyA@mail.gmail.com>
References: <CAKD1Yr2qeXseNLcQ9r4niob02jGOXdVeta6OwWF3Ta1dyp1V2Q@mail.gmail.com> <87v98fxjtm.ffs@nanos.tec.linutronix.de> <CAKD1Yr1u-UsP6s_4TX4HLTgHgYOrkqOajHr4vm6-rhhvFJsfyA@mail.gmail.com>
Date:   Thu, 22 Apr 2021 17:35:12 +0200
Message-ID: <87h7jyxrgv.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22 2021 at 23:20, Lorenzo Colitti wrote:

> On Thu, Apr 22, 2021 at 9:08 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Just for comparison. In a VM I'm experimenting with right now the
>> reprogramming time is ~500ns which is still a lot of cycles, but
>> compared to 5us faster by an order of magnitude. And on the sane
>> machine bare metal its way faster and therefore less noticeable.
>
> FWIW, on this hardware, frtrace says that arming the arm64 architected
> timer takes 0.7us. Definitely better than 2-3us, but still not free.
> This is not a high-end desktop or server, but it's also not super
> slow, low-power hardware.
>
>>  * The transmit should only be run if no skb data has been sent for a
>>  * certain duration.
>>
>> which is useless word salad.
>
> You're the one who wrote that comment - see b1a31a5f5f27. You'll
> forgive me for being amused. :-)

Rightfully so! I still call it word salat :)

> Thanks for the history/analysis/suggestions. I think it's a fact that
> this is a regression in performance: this particular code has
> performed well for a couple of years now. The fact that the good
> performance only existed due to a correctness bug in the hrtimer code
> definitely does make it harder to argue that the regression should be
> reverted.

We tend to disagree about the naming conventions here, but we seem at
least to agree that reverting a fix for a correctness bug (which has way
worse implications than slowing down a gruesome driver) is not going to
happen.

> That said: if you have a fix for the double reprogram, then that fix
> should probably be applied? 0.5us is not free, and even if hrtimers
> aren't designed for frequent updates, touching the hardware twice as
> often does seem like a bad idea, since, as you point out, there's a
> *lot* of hardware that is slow.

That's an obvious improvement, but not a fix. And I checked quite some
hrtimer users and there are only a few which ever rearm an queued timer
and that happens infrequently.

> Separately, we're also going to look at making ncm better. (In defense
> of the original author, in 2014 I don't think anyone would even have
> dreamed of USB being fast enough for this to be a problem.) The first
> thing we're going to try to do is set the timer once per NTB instead
> of once per packet (so, 10x less). My initial attempt to do that
> causes the link to die after a while and I need to figure out why
> before I can send a patch up. I'm suspicious of the threading, which
> uses non-atomic variables (timer_force_tx, ncm->skb_tx_data) to
> synchronize control flow between the timer and the transmit function,
> which can presumably run on different CPUs. That seems wrong since
> either core could observe stale variables. But perhaps there are
> memory barriers that I'm not aware of.

Not that I see any.

> The idea of getting rid of the timer by doing aggregation based on
> transmit queue lengths seems like a much larger effort, but probably
> one that is required to actually improve performance substantially
> beyond what it is now.

I don't think it's a huge effort. netdev_xmit_more() should tell you
what you need to know.

Thanks,

        tglx
