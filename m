Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0297B3393C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhCLQle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:41:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59291 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232217AbhCLQl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615567288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OeO9KUqOtDtdk47PC51v+iOlLQdCGKKGnQ1GOkBzCu0=;
        b=PS/uJty7zmZ0kh35EMgu9soXA6zpvgRyXVbmDd4IK79J/xyNDLD3rO/I99ASS15sprCwJC
        cyCB9W+CIjC1nbi7Lv81yPQDVs7YiFUTti7M2VTExSemTsNKI4+VVt5TBxoJYSADK9Rfrj
        zpR5nh+jxkNigSnZM3LndJZjMHbHprw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-r3UaRUcJMIaELwkLfrdHgA-1; Fri, 12 Mar 2021 11:41:24 -0500
X-MC-Unique: r3UaRUcJMIaELwkLfrdHgA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01E92107ACCD;
        Fri, 12 Mar 2021 16:41:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.14])
        by smtp.corp.redhat.com (Postfix) with SMTP id 77E8E18BAC;
        Fri, 12 Mar 2021 16:41:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 12 Mar 2021 17:41:22 +0100 (CET)
Date:   Fri, 12 Mar 2021 17:41:20 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jim Newsome <jnewsome@torproject.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
Message-ID: <20210312164119.GC27820@redhat.com>
References: <20210311233823.20325-1-jnewsome@torproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311233823.20325-1-jnewsome@torproject.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11, Jim Newsome wrote:
>
> +static bool is_effectively_child(struct wait_opts *wo, bool ptrace,
> +				 struct task_struct *target)
> +{
> +	struct task_struct *parent =
> +		!ptrace ? target->real_parent : target->parent;
> +
> +	return current == parent || (!(wo->wo_flags & __WNOTHREAD) &&
> +				     same_thread_group(current, parent));
> +}
> +
> +/*
> + * Optimization for waiting on PIDTYPE_PID. No need to iterate through child
> + * and tracee lists to find the target task.
> + */
> +static int do_wait_pid(struct wait_opts *wo)
> +{
> +	bool ptrace;
> +	struct task_struct *target;
> +	int retval;
> +
> +	ptrace = false;
> +
> +	/* A non-ptrace wait can only be performed on a thread group leader. */
> +	target = pid_task(wo->wo_pid, PIDTYPE_TGID);
> +
> +	if (target && is_effectively_child(wo, ptrace, target)) {
> +		retval = wait_consider_task(wo, ptrace, target);
> +		if (retval)
> +			return retval;
> +	}
> +
> +	ptrace = true;
> +
> +	/* A ptrace wait can be done on non-thread-group-leaders. */
> +	if (!target)
> +		target = pid_task(wo->wo_pid, PIDTYPE_PID);
> +
> +	if (target && is_effectively_child(wo, ptrace, target)) {
> +		retval = wait_consider_task(wo, ptrace, target);

No, this is not right... You need to check target->ptrace != 0.

I know that Eric suggests to not use thread_group_leader() and I won't argue
even if I don't really agree.

Up to you, but to me something like

	do_wait_pid()
	{
		target = pid_task(wo->wo_pid, PIDTYPE_PID);

		if (!target)
			return 0;

		if (thread_group_leader(target) &&
		    is_effectively_child(wo, 0, target) {
			...			
		}

		if (target->ptrace &&
		    is_effectively_child(wo, 1, target) {
			...
		}

		return 0;

	}

looks more simple/clean.

Oleg.

