Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D853332D0B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhCIRQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:16:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbhCIRPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615310148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d6Atk3r60by6TY7OYkWgG8UO+5JPZv2/zHXdvP4ImTo=;
        b=RkcMg/zPXmzuJQKtlrfo8Eacd+prYyYbAMKVUX62AaO05ARCGuS/h2WfRLgOh3oz7vwoo1
        YmMp0NYjsC027BVKwmICvZgihtLmBSxNqpV9ltc+GB7VRWZbMFbcs4FBKGcqJaFxj2pELr
        QTvNtvfXSJlJ/ITQRMq8W2BBMuQh7+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-FbYuOk6WPiez2b0qQL3zKQ-1; Tue, 09 Mar 2021 12:15:44 -0500
X-MC-Unique: FbYuOk6WPiez2b0qQL3zKQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA75A800D62;
        Tue,  9 Mar 2021 17:15:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.181])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3159D1037E83;
        Tue,  9 Mar 2021 17:15:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  9 Mar 2021 18:15:42 +0100 (CET)
Date:   Tue, 9 Mar 2021 18:15:39 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jim Newsome <jnewsome@torproject.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
Message-ID: <20210309171539.GA32475@redhat.com>
References: <20210309161548.18786-1-jnewsome@torproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309161548.18786-1-jnewsome@torproject.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim,

Thanks, the patch looks good to me. Yet I think you need to send V3 even
if I personally do not care ;) Please consider ./scripts/checkpatch.pl,
it reports all the coding-style problems I was going to mention.

I too have a couple of cosmetic nits, but feel free to ignore, this is
subjective.

On 03/09, Jim Newsome wrote:
>
> do_wait is an internal function used to implement waitpid, waitid,
> wait4, etc. To handle the general case, it does an O(n) linear scan of
> the thread group's children and tracees.
> 
> This patch adds a special-case when waiting on a pid to skip these scans
> and instead do an O(1) lookup. This improves performance when waiting on
> a pid from a thread group with many children and/or tracees.
> 
> Signed-off-by: James Newsome
> ---
>  kernel/exit.c | 54 ++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 45 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 04029e35e69a..312c4dfc9555 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1439,6 +1439,33 @@ void __wake_up_parent(struct task_struct *p, struct task_struct *parent)
>  			   TASK_INTERRUPTIBLE, p);
>  }
>  
> +// Optimization for waiting on PIDTYPE_PID. No need to iterate through child
> +// and tracee lists to find the target task.
> +static int do_wait_pid(struct wait_opts *wo, struct task_struct *tsk)
> +{
> +	struct task_struct *target = pid_task(wo->wo_pid, PIDTYPE_PID);
> +	if (!target) {
> +		return 0;
> +	}
> +	if (tsk == target->real_parent ||
> +	    (!(wo->wo_flags & __WNOTHREAD) &&
> +	     same_thread_group(tsk, target->real_parent))) {
> +		int retval = wait_consider_task(wo, /* ptrace= */ 0, target);
> +		if (retval) {
> +			return retval;
> +		}
> +	}
> +	if (target->ptrace && (tsk == target->parent ||
> +			       (!(wo->wo_flags & __WNOTHREAD) &&
> +				same_thread_group(tsk, target->parent)))) {
> +		int retval = wait_consider_task(wo, /* ptrace= */ 1, target);
> +		if (retval) {
> +			return retval;
> +		}
> +	}

Both if's use "int retval", to me it would be better to declare this variable
at the start of do_wait_pid(). But again, I won't insist this is up to you.

I am wondering if something like

	static inline bool is_parent(struct task_struct *tsk, struct task_struct *p, int flags)
	{
		return	tsk == p || !(flags & __WNOTHREAD)) && same_thread_group(tsk, p);
	}

makes any sense to make do_wait_pid() more clear... probably not.

Oleg.

