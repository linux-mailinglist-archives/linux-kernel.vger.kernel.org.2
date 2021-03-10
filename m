Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1EE336839
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 00:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhCJX4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 18:56:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35654 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhCJX4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 18:56:49 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615420607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ABfRZviwLycn3ApTe7ax5l7a+NQj46TdpQnTzrshqpE=;
        b=s+mQTO1emJRMuncmeqRtL93RPPe8Doa6Ki59jLfJkc8xezOxATvYgrN+SYcPV2dZFt9IUK
        5LdDzS/iCBkDpEogtHvZb5YNx2wckFaaTovjbrSUrMYJk+EGmj7zX1QDLeZQaJ8CRJDYHZ
        KJuG0d6tQsl6nGTeW7i3EjLyglkBqJR9XpePjg3oEHmhK2ZjUDZK843otHCIv3qyNDJMxm
        yxn1qwmOI2VvhT8Di2yVWMfTgXYwbVilGCZJpsR+E6B+jRxK898E963ROlQB29kt+6XC/U
        3w5JPbkh2V8TIiTJ/oss4+9mDOSCmMa0AoO0QyJ6o4HhkeEIIdno1FN91OHlzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615420607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ABfRZviwLycn3ApTe7ax5l7a+NQj46TdpQnTzrshqpE=;
        b=75vHLeX2igw4/jOCallwx/mCUEglVVhq8CTztmjNcZ5WPGUwfbuUO3G/L4KLLntIrlaN32
        bVGVtkVLuNN5joAQ==
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH] signal: Allow RT tasks to cache one sigqueue struct
In-Reply-To: <m1pn06oeno.fsf@fess.ebiederm.org>
References: <20210303142025.wbbt2nnr6dtgwjfi@linutronix.de> <m1zgzj7uv2.fsf@fess.ebiederm.org> <20210304081142.digtkddajkadwwq5@linutronix.de> <87tupr55ea.fsf@nanos.tec.linutronix.de> <m11rcu7nbr.fsf@fess.ebiederm.org> <87lfb263h2.fsf@nanos.tec.linutronix.de> <87sg524z6t.fsf@nanos.tec.linutronix.de> <m1pn06oeno.fsf@fess.ebiederm.org>
Date:   Thu, 11 Mar 2021 00:56:47 +0100
Message-ID: <87mtva4l6o.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10 2021 at 15:57, Eric W. Biederman wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> IMO, not bothering with an extra counter and rlimit plus the required
>> atomic operations is just fine and having this for all tasks
>> unconditionally looks like a clear win.
>>
>> I'll post an updated version of this soonish.
>
> That looks like a good analysis.
>
> I see that there is a sigqueue_cachep.  As I recall there are per cpu
> caches and all kinds of other good stuff when using kmem_cache_alloc.
>
> Are those goodies falling down?
>
> I am just a little unclear on why a slab allocation is sufficiently
> problematic that we want to avoid it.

In the normal case it's not problematic at all. i.e. when the per cpu
cache can directly fullfil the allocation in the fast path. Once that
fails you're off into latency land...

For the usual setup probably not an issue at all, but for real time
processing it matters.

Vs. the dedicated kmem cache for sigqueue. That's a red herring. By
default kmem caches are shared/merged as I learned today and if you want
dedicated ones you need to boot with 'slab_nomerge' on the command line.

So without that option (which is of course not backwards compatible
because the original behaviour was the other way around) your signal
kmem cache might end up in a shared/merged kmem cache. Just do:

  cat /proc/slabinfo | grep sig

and the default will find:

signal_cache        6440   6440   1152   28    8 : tunables    0    0    0 : slabdata    230    230      0
sighand_cache       3952   4035   2112   15    8 : tunables    0    0    0 : slabdata    269    269      0

But of course there is no way to figure out where your cache actually
landed and then with with 'slab_nomerge' you'll get:

sigqueue            3264   3264     80   51    1 : tunables    0    0    0 : slabdata     64     64      0
signal_cache        6440   6440   1152   28    8 : tunables    0    0    0 : slabdata    230    230      0
sighand_cache       3952   4035   2112   15    8 : tunables    0    0    0 : slabdata    269    269      0

Don't worry about the 'active objects' field. That's just bonkers
because SLUB has no proper accounting for active objects. That number is
useless ...

Not even CONFIG_SLUB_STATS=y will give you anything useful. I had to
hack my own statistics into the signal code to gather these numbers
!$@**!^?#!

But why I'm not surprised? This stuff is optimized for High Frequency
Trading which is useless by definition. Oh well...

Rant aside, there is no massive benefit of doing that caching in
general, but there is not much of a downside either and for particular
use cases it's useful even outside of PREEMPT_RT.

IMO, having it there unconditionally is better than yet another special
cased hackery.

Thanks,

        tglx
