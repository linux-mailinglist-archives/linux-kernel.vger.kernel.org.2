Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F0A332166
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCII45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:56:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229641AbhCII4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615280208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k4YCi9TzxfvotEI0KHVk0DBixUOa/vI9Lyywwsk2fSU=;
        b=EigNbIaFFa+JrSQG3f0sR6c8fTgSR4BmzwIelh9Hsf9nj2WYDg9V2m8VOnwNxq4cMdiQIe
        HkRY6ou0ijvVRsHGFl5wDBUxSDnA1Z3SgUv9okcan5nZO2dhsL3O844I8CYfNsJMzpP21l
        Un/Zad7gg+tkazNyiyfN5ZKrB89Ckfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-NQtAbCGcPM68MSVIDpfRAg-1; Tue, 09 Mar 2021 03:56:46 -0500
X-MC-Unique: NQtAbCGcPM68MSVIDpfRAg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74CEB83DD22;
        Tue,  9 Mar 2021 08:56:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.174])
        by smtp.corp.redhat.com (Postfix) with SMTP id EC598196E3;
        Tue,  9 Mar 2021 08:56:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  9 Mar 2021 09:56:45 +0100 (CET)
Date:   Tue, 9 Mar 2021 09:56:42 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jim Newsome <jnewsome@torproject.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: patch: do_wait: make PIDTYPE_PID case O(1) instead of O(n)
Message-ID: <20210309085641.GB25222@redhat.com>
References: <b8591e67-1248-6c29-847e-d97e04b58210@torproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8591e67-1248-6c29-847e-d97e04b58210@torproject.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, and you forgot to CC lkml ;) let me resend my email.


Hi Jim,

Please do not use the attachments, just send the patch as plain text.
See Documentation/process/submitting-patches.rst

On 03/08, Jim Newsome wrote:
>
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1462,8 +1462,61 @@ static long do_wait(struct wait_opts *wo)
>  		goto notask;
>
>  	set_current_state(TASK_INTERRUPTIBLE);
> +
>  	read_lock(&tasklist_lock);
>  	tsk = current;
> +
> +	if (wo->wo_type == PIDTYPE_PID) {
> +		// Optimization for PIDTYPE_PID. No need to iterate through child and
> +		// tracee lists to find the target task.

I'd suggest to put this PIDTYPE_PID code into the new function.

> +
> +		struct task_struct *real_parent = NULL;
> +		struct task_struct *target = NULL;
> +		bool do_regular_wait, do_ptrace_wait;
> +
> +		// XXX: Do we need this? Or is the tasklist_lock sufficient?
> +		rcu_read_lock();

No, you don't need rcu lock, tasklist_lock is sufficient

> +		target = pid_task(wo->wo_pid, PIDTYPE_PID);
> +		if (!target) {
> +			rcu_read_unlock();
> +			goto notask;

This is wrong, you forgot to drop tasklist_lock.


> +		real_parent = !target->real_parent ? target->parent :
> +						     target->real_parent;

Hmm, I don't understand the line above... perhaps it connects to the
question below.

> +		if (!real_parent) {
> +			// XXX: Is it a kernel bug to get here? Or would this be
> +			// true of the init process?

Afaics, parent/real_parent can't be NULL if pid_task() succeeds.

> +		do_regular_wait = tsk == real_parent ||
> +				  (!(wo->wo_flags & __WNOTHREAD) &&
> +				   same_thread_group(tsk, real_parent));
> +		do_ptrace_wait = target->ptrace &&
> +				 (tsk == target->parent ||
> +				  (!(wo->wo_flags & __WNOTHREAD) &&
> +				   same_thread_group(tsk, target->parent)));
> +		rcu_read_unlock();
> +
> +		if (do_regular_wait) {
> +			retval =
> +				wait_consider_task(wo, /* ptrace= */ 0, target);
> +			if (retval) {
> +				goto end;
> +			}
> +		}
> +		if (do_ptrace_wait) {
> +			retval =
> +				wait_consider_task(wo, /* ptrace= */ 1, target);
> +			if (retval) {
> +				goto end;
> +			}
> +		}
> +		read_unlock(&tasklist_lock);
> +		goto notask;

This part looks correct at first glance...

Please redo and send V2 ;)

Oleg.

