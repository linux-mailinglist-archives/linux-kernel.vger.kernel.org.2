Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7999C3FBD75
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 22:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbhH3Udi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 16:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhH3Udh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 16:33:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFACC061575;
        Mon, 30 Aug 2021 13:32:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630355562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anwD3BTmBd6WQ25OCpAzllzeRhhNGOYOvouPH8galA8=;
        b=oUtPiSyi/R5wlxNanUXkkVnS+Cw1CqMVdSbfChdcsnPgTYZQop9KAGTvp4/FhRVK8tJ8df
        HKeUsYunTnq0eJDUPZe966WjornWv1qOMVBQN6MImOKANJqyXTHlTv28K5GMtXPZTaC1/V
        iTK5Q93FHd9JGz8cjqzy47TH4nJFEqbh9AFkAO44epoMQsiuFEVRk786AqztCXGv0ezfne
        TLtCprIvR6fOT6CxZrq4mchbjwLIILcllL2jI3McIxZQBACjyShhDysBym+zTDtznJjjTB
        dKHjAFCe5uNlkYAZsBMQBiCKrjHx2UiAV9AEIAerQhoiQPyXVwR2h+OFOr14fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630355562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=anwD3BTmBd6WQ25OCpAzllzeRhhNGOYOvouPH8galA8=;
        b=TMw54Yt1x8cB/bBj0qSVl4rOG1hHVIWlZP8nWDYP7gujzVj9wLCFGCHwsME7LJuifJbnIJ
        6kacEoKUL881SSDA==
To:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: Linux 5.14
In-Reply-To: <20210830201225.GA2671970@roeck-us.net>
References: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
 <20210830201225.GA2671970@roeck-us.net>
Date:   Mon, 30 Aug 2021 22:32:41 +0200
Message-ID: <87wno2fzbq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30 2021 at 13:12, Guenter Roeck wrote:
> On Sun, Aug 29, 2021 at 03:19:23PM -0700, Linus Torvalds wrote:
> So far so good, but there is a brand new runtime warning, seen when booting
> s390 images.
>
> [    3.218816] ------------[ cut here ]------------
> [    3.219010] WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:5779 sched_core_cpu_starting+0x172/0x180
> [    3.222992]  [<0000000000186e86>] sched_core_cpu_starting+0x176/0x180
> [    3.223114] ([<0000000000186dc4>] sched_core_cpu_starting+0xb4/0x180)
> [    3.223182]  [<00000000001963e4>] sched_cpu_starting+0x2c/0x68
> [    3.223243]  [<000000000014f288>] cpuhp_invoke_callback+0x318/0x970
> [    3.223304]  [<000000000014f970>] cpuhp_invoke_callback_range+0x90/0x108
> [    3.223364]  [<000000000015123c>] notify_cpu_starting+0x84/0xa8
> [    3.223426]  [<0000000000117bca>] smp_init_secondary+0x72/0xf0
> [    3.223492]  [<0000000000117846>] smp_start_secondary+0x86/0x90
>
> Commit 3c474b3239f12 ("sched: Fix Core-wide rq->lock for uninitialized
> CPUs") sems to be the culprit. Indeed, the warning is gone after reverting
> this commit.

The warning is gone, but the underlying S390 problem persists:

S390 invokes notify_cpu_starting() _before_ updating the topology masks.

Thanks,

        tglx
