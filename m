Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A3034863F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 02:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbhCYBL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 21:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239552AbhCYBL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 21:11:26 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED523619EC;
        Thu, 25 Mar 2021 01:11:24 +0000 (UTC)
Date:   Wed, 24 Mar 2021 21:11:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     <mingo@redhat.com>, <jolsa@redhat.com>,
        <linux-kernel@vger.kernel.org>, <yangjihong1@huawei.com>,
        <xukuohai@huawei.com>, <zhangjinhao2@huawei.com>
Subject: Re: [PATCH 2/2] perf, ftrace: Fix use-after-free in
 __ftrace_ops_list_func()
Message-ID: <20210324211123.64d72c02@oasis.local.home>
In-Reply-To: <20210317102529.226734-3-lihuafei1@huawei.com>
References: <20210317102529.226734-1-lihuafei1@huawei.com>
        <20210317102529.226734-3-lihuafei1@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 18:25:29 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> We see the comment of ftrace_ops in include/linux/ftrace.h, which
> actually mentions that for dynamically allocated ftrace_ops, after
> unregistering it should be guaranteed that no user will reference that
> ftrace_ops again, but the current interface unregister_ftrace_function()
> does not seem to guarantee this.
> 
> We add the ftrace_function_unregister_sync() interface to give users
> like perf event a chance to synchronize. The reason we don't do
> synchronization directly in unregister_ftrace_function() is that for
> some users whose registered ftrace_ops is static, synchronization is not
> necessary for them and is performance intensive, so we add a separate
> interface.

You are papering over a real bug then.

Also, synchronize_rcu() is not strong enough. Callbacks can happen that
reference ftrace_ops that are not protected by standard RCU. You need
full synchronize_rcu_tasks_rude() which is much more disruptive that
normal synchronize_rcu().

The code has:

	if (ops->flags & FTRACE_OPS_FL_DYNAMIC) {
		/*
		 * We need to do a hard force of sched synchronization.
		 * This is because we use preempt_disable() to do RCU, but
		 * the function tracers can be called where RCU is not watching
		 * (like before user_exit()). We can not rely on the RCU
		 * infrastructure to do the synchronization, thus we must do it
		 * ourselves.
		 */
		synchronize_rcu_tasks_rude();

		/*
		 * When the kernel is preemptive, tasks can be preempted
		 * while on a ftrace trampoline. Just scheduling a task on
		 * a CPU is not good enough to flush them. Calling
		 * synchronize_rcu_tasks() will wait for those tasks to
		 * execute and either schedule voluntarily or enter user space.
		 */
		if (IS_ENABLED(CONFIG_PREEMPTION))
			synchronize_rcu_tasks();

 free_ops:
		ftrace_trampoline_free(ops);
	}

And what you are saying is that we are not getting there, where the
dynamically allocated perf ops is not set to be DYNAMIC?

That should be set as DYNAMIC if the ops was allocated, and can later
be freed. This code was written specifically to handle perf.

Thus, NACK on the patch. I want to know exactly what went wrong instead
of just saying "but the current interface unregister_ftrace_function()
does not seem to guarantee this", let's actually fix the bug and not just paper over it!
