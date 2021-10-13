Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91AC42C2C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbhJMOVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:21:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhJMOVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:21:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A57E760ED4;
        Wed, 13 Oct 2021 14:19:24 +0000 (UTC)
Date:   Wed, 13 Oct 2021 10:19:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     keescook@chromium.org, peterz@infradead.org, pmladek@suse.com,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        valentin.schneider@arm.com, mathieu.desnoyers@efficios.com,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, dietmar.eggemann@arm.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Zapolskiy <vzapolskiy@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v4 2/5] connector: use __get_task_comm in
 proc_comm_connector
Message-ID: <20211013101921.0843aaf0@gandalf.local.home>
In-Reply-To: <20211013102346.179642-3-laoar.shao@gmail.com>
References: <20211013102346.179642-1-laoar.shao@gmail.com>
        <20211013102346.179642-3-laoar.shao@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 10:23:43 +0000
Yafang Shao <laoar.shao@gmail.com> wrote:

> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -230,7 +230,10 @@ void proc_comm_connector(struct task_struct *task)
>  	ev->what = PROC_EVENT_COMM;
>  	ev->event_data.comm.process_pid  = task->pid;
>  	ev->event_data.comm.process_tgid = task->tgid;
> -	get_task_comm(ev->event_data.comm.comm, task);
> +
> +	/* This may get truncated. */
> +	__get_task_comm(ev->event_data.comm.comm,
> +			sizeof(ev->event_data.comm.comm), task);
>  
>  	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
>  	msg->ack = 0; /* not used */

__get_task_comm() uses strncpy() which my understanding is, does not add
the nul terminating byte when truncating. Which changes the functionality
here. As all task comms have a terminating byte, the old method would copy
that and include it. This won't add the terminating byte if the buffer is
smaller than the comm, and that might cause issues.

-- Steve
