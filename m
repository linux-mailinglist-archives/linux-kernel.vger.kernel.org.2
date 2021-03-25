Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA36034997C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhCYS2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229533AbhCYS1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616696866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2VMhsAZwrflDKUGyUEkwUGTMaYhk4RiBpO9SY7d/GvA=;
        b=CJqOGt2OLW24Dcr4fIdYSQiVxUH7WaqilE2ba95Jtzy/5s3HI0cs2kuaHdWAhSMCr90YiE
        +prRRoPfXw/XDKO72GEFtRxOIKkHVRmZO4IDnW2S5K98ntMKeji/Cjvi+2hlXaYQCKSOpy
        PSlTnL31+clXvE85jTSla68xnCH+OGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-hZL5rhMhOXOZJtL5r9omZQ-1; Thu, 25 Mar 2021 14:27:42 -0400
X-MC-Unique: hZL5rhMhOXOZJtL5r9omZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73AAA87A82A;
        Thu, 25 Mar 2021 18:27:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.41])
        by smtp.corp.redhat.com (Postfix) with SMTP id 18E4260CCF;
        Thu, 25 Mar 2021 18:27:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 25 Mar 2021 19:27:39 +0100 (CET)
Date:   Thu, 25 Mar 2021 19:27:35 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] task_struct::state frobbing
Message-ID: <20210325182735.GA28349@redhat.com>
References: <YFzSWR6mAGitxMqA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFzSWR6mAGitxMqA@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25, Peter Zijlstra wrote:
>
>  static void ptrace_unfreeze_traced(struct task_struct *task)
>  {
> -	if (task->state != __TASK_TRACED)
> +	if (READ_ONCE(task->__state) != __TASK_TRACED)
>  		return;

this change is correct,

> @@ -201,11 +201,11 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
>  	 * Recheck state under the lock to close this race.
>  	 */
>  	spin_lock_irq(&task->sighand->siglock);
> -	if (task->state == __TASK_TRACED) {
> +	if (READ_ONCE(task->__state) == __TASK_TRACED) {

this too,

> @@ -240,7 +240,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>  	 */
>  	read_lock(&tasklist_lock);
>  	if (child->ptrace && child->parent == current) {
> -		WARN_ON(child->state == __TASK_TRACED);
> +		WARN_ON(task_is_traced(child));
>  		/*
>  		 * child->sighand can't be NULL, release_task()
>  		 * does ptrace_unlink() before __exit_signal().
> @@ -257,7 +257,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>  			 * ptrace_stop() changes ->state back to TASK_RUNNING,
>  			 * so we should not worry about leaking __TASK_TRACED.
>  			 */
> -			WARN_ON(child->state == __TASK_TRACED);
> +			WARN_ON(task_is_traced(child));


the two above are not.

"state == __TASK_TRACED" and task_is_traced() is not the same thing.

"state == __TASK_TRACED" means that debugger changed the state from TASK_TRACED
to __TASK_TRACED (iow, removed TASK_WAKEKILL) to ensure the tracee can not run,
this doesn't affect task_is_traced().

Oleg.

