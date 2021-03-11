Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80210337555
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhCKOUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhCKOUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:20:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515C1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:20:02 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615472401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pgXSNT8FWFYRIt/2JMg9uAfJskUhwCfntKUAqs0mAGg=;
        b=pp8my18z0AmauzI6PtPqBVw/SxUkCIwTR+KwM3iWBpaPDCxNVVNIZ6Chb4L+zNTvGFltD5
        Z4IgJ1+d2Y/j66APCw4a1+PFxwoR1tzi5NUID2K6GnhEDDWGaV5/0SdKYjesG/2BTuJk+S
        jgQyR2DBc2F8x49soDdPBOWuv/niSsp9PoZ9Yf25nhamWm9Fu/eZzq7y5gLH5vzLdIMNtc
        ToajwdCDrW9r2VgLWhi+kjXHc5LA2byZSxc6uv2vZBB1ksofEHkmD2koox0iE1kPofuJLE
        ZOWIgvjshHA+EuEm4n908zl9T3NLmtPBVk2xCFBPIX+0gUpHu/ueubHQASgnJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615472401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pgXSNT8FWFYRIt/2JMg9uAfJskUhwCfntKUAqs0mAGg=;
        b=56eSYq3pevIOtKAsrYiEP9tTP4K7UoDYazXEmzDL+OyJDRd5kxf4+oEbVdhASjAZgi97Na
        1U2q0ZOdPCn8bJBA==
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
In-Reply-To: <87a6r95067.fsf@nanos.tec.linutronix.de>
References: <20210303142025.wbbt2nnr6dtgwjfi@linutronix.de> <m1zgzj7uv2.fsf@fess.ebiederm.org> <20210304081142.digtkddajkadwwq5@linutronix.de> <87tupr55ea.fsf@nanos.tec.linutronix.de> <m11rcu7nbr.fsf@fess.ebiederm.org> <87lfb263h2.fsf@nanos.tec.linutronix.de> <87sg524z6t.fsf@nanos.tec.linutronix.de> <m1pn06oeno.fsf@fess.ebiederm.org> <87mtva4l6o.fsf@nanos.tec.linutronix.de> <87a6r95067.fsf@nanos.tec.linutronix.de>
Date:   Thu, 11 Mar 2021 15:20:00 +0100
Message-ID: <877dmd4vsf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11 2021 at 13:45, Thomas Gleixner wrote:

> On Thu, Mar 11 2021 at 00:56, Thomas Gleixner wrote:
>> Rant aside, there is no massive benefit of doing that caching in
>> general, but there is not much of a downside either and for particular
>> use cases it's useful even outside of PREEMPT_RT.
>>
>> IMO, having it there unconditionally is better than yet another special
>> cased hackery.
>
> Just did some micro instrumentation to measure the time spent in
> __sigqueue_alloc/free() with and without the caching.
>
> Unsurprisingly that results in a time reduction of ~67% saving about 3us
> per alloc/free pair. Not hugely relevant for a kernel build but for
> anything which is signal heavy it'll make an difference.

That's all fastpath allocations and nothing which hit the slow path,
which would be way worse.

Thanks,

        tglx
