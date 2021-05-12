Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD4537BE43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhELNdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:33:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhELNdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:33:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B46E9613CF;
        Wed, 12 May 2021 13:32:04 +0000 (UTC)
Date:   Wed, 12 May 2021 09:32:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: Correct calling tracepoints
Message-ID: <20210512093202.5fca1259@gandalf.local.home>
In-Reply-To: <YJvL+IvlTtoNv2c7@hirez.programming.kicks-ass.net>
References: <20210512120937.90211-1-leo.yan@linaro.org>
        <YJvL+IvlTtoNv2c7@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2021 14:37:12 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, May 12, 2021 at 08:09:37PM +0800, Leo Yan wrote:
> > The commit eb1f00237aca ("lockdep,trace: Expose tracepoints") reverses
> > tracepoints for lock_contended() and lock_acquired(), thus the ftrace
> > log shows the wrong locking sequence that "acquired" event is prior to
> > "contended" event:
> > 
> >   <idle>-0       [001] d.s3 20803.501685: lock_acquire: 0000000008b91ab4 &sg_policy->update_lock
> >   <idle>-0       [001] d.s3 20803.501686: lock_acquired: 0000000008b91ab4 &sg_policy->update_lock
> >   <idle>-0       [001] d.s3 20803.501689: lock_contended: 0000000008b91ab4 &sg_policy->update_lock
> >   <idle>-0       [001] d.s3 20803.501690: lock_release: 0000000008b91ab4 &sg_policy->update_lock
> > 
> > This patch fixes calling tracepoints for lock_contended() and
> > lock_acquired().
> > 
> > Fixes: eb1f00237aca ("lockdep,trace: Expose tracepoints")
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>  
> 
> No idea how that happened, curious. Thanks for fixing though!

    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
    Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
    Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Tested-by: Marco Elver <elver@google.com>

That's embarrassing :-p

-- Steve
