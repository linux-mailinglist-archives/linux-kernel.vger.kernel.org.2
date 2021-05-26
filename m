Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B06391484
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhEZKLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:11:52 -0400
Received: from foss.arm.com ([217.140.110.172]:42482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233758AbhEZKLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:11:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED71E1516;
        Wed, 26 May 2021 03:10:18 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3B833F73B;
        Wed, 26 May 2021 03:10:17 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Yejune Deng <yejune.deng@gmail.com>
Subject: Re: [PATCH] sched: Fix PF_NO_SETAFFINITY blind inheritance
In-Reply-To: <20210525235849.441842-1-frederic@kernel.org>
References: <20210525235849.441842-1-frederic@kernel.org>
Date:   Wed, 26 May 2021 11:10:07 +0100
Message-ID: <87a6ohhklc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Frederic,

Sorry about that one; thanks for having dug into it.

On 26/05/21 01:58, Frederic Weisbecker wrote:
> One way to solve the PF_NO_SETAFFINITY issue is to not inherit this flag
> on copy_process() at all. The cases where it matters are:
>
> * fork_idle(): explicitly set the flag already.
> * fork() syscalls: userspace tasks that shouldn't be concerned by that.
> * create_io_thread(): the callers explicitly attribute the flag to the
>                       newly created tasks.
> * kernel_thread():
>       _ Fix the issues on init/1 and kthreadd
>       _ Fix the issues on kthreadd children.
>       _ Usermode helper created by an unbound workqueue. This shouldn't
>         matter. In the worst case it gives more control to userspace
>         on setting affinity to these short living tasks although this can
>         be tuned with inherited unbound workqueues affinity already.
>

(I just saw it got shoved into tip already, but in any case:)

That makes sense to me. Regarding the UMH point, I don't believe there are
others like it creeping around; otherwise we might've had to go with e.g.

  p->flags &= ~(... | (PF_NO_SETAFFINITY * !!(p->flags & PF_IDLE)))

but per the above that doesn't seem necessary.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
