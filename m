Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C06378116
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhEJKSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:18:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:32874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhEJKSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:18:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620641836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3cweDVHmJDxzRO4VtKIboZgqH2LOMiawxyK36GGbPmY=;
        b=o/bmQD9GUo7ODfdUF3UID6DnGaat3qXTIm88SkPjMHt5uVFvIlKajxhNWo77eysUmbOGdH
        4Uirwfp48bc7+hqhwCq/VFMLZ0tfwdKxgjKFbPteGMwRDh/wCd1ZpiEzp+d9vR2xK2HZHr
        vSHo6gGnv8os6NQfGkCH70/GLeDRgSw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5DFDADDB;
        Mon, 10 May 2021 10:17:15 +0000 (UTC)
Date:   Mon, 10 May 2021 12:17:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Luo Jiaxing <luojiaxing@huawei.com>, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        bobo.shaobowang@huawei.com
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
Message-ID: <YJkIK9cyHr46UAFP@alley>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley>
 <YJP4F1UIt/eRZ96s@google.com>
 <YJP5MnkJ8pJevXM6@google.com>
 <YJVsgPc66lhaAUN0@alley>
 <YJjuRV57eO3Pp/bp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJjuRV57eO3Pp/bp@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-05-10 17:26:45, Sergey Senozhatsky wrote:
> On (21/05/07 18:36), Petr Mladek wrote:
> Well, the alternative patch set just gives everyone an API that selectively
> downgrades printk() to pre-console_sem_owner age: when console_unlock()
> would never handover the printing duty. It'll take no time until this
> function will pop up somewhere where we don't want it to be used.
> 
> E.g.
> 
> 	rcu_read_lock();
> 	...
> 	console_unlock_preemptible();
> 	...
> 	rcu_read_unlock();
> 
> lockdep_assert_preemption_enabled() is not entirely reliable - it
> depends on __lockdep_enabled, provided that system in question has
> CONFIG_PROVE_LOCKING set.

I understand the concern. I think that I would be able to sleep with
this. I believe that such problems would be discovered soon.

Also I doubt that it would spread that quickly. It is the same as
with printk_deferred(). It is just a workaround for a problem
that only few people are aware of.

If it is still a concern, we could make it static and block
any patches that would make it public.

But it does not make sense to fight over this now.
I am not sure that console_unlock_preemptible() is worth it after all.
Luo has to prove that it might fix a real life problem.


> It queues the work IF we have pending messages AND there are NO active
> console_sem waiters spinning on consolse_sem waiting for us to handover
> the printing duty. And IRQ shall write to consoles only N messages out
> of possibly M pending messages (M > N). N, obviously, should be small,
> e.g. 42 lines: if after 42 printed lines we didn't handover printing
> to another context then - queue another IRQ work and iret. But it keeps
> the console_owner mechanism enabled.

I am sorry but I am not going to continue in this discussion. Many
printk() designs have been discussed in the past and this is just
repeating the same again and again.

The current plan is to move console work to kthreads (separate
preemptive context). Using IRQ is a complete opposite way.

There is always the fight between getting the messages out as soon
as possible and the risk of breaking the system (softlockups,
deadlocks).

The kthread approach reduces the risk of system breakage to a bare
minimum. The price is that some messages might never reach console.
There is finally a consensus to give it a try. If it fails, we might
start looking for alternatives again.

Best Regards,
Petr
