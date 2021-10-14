Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4921D42DBBB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhJNOeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230010AbhJNOeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:34:10 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F0C560EB4;
        Thu, 14 Oct 2021 14:32:05 +0000 (UTC)
Date:   Thu, 14 Oct 2021 10:32:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: save cmdline only when task does not exist in
 savecmd for optimization
Message-ID: <20211014103201.685d3647@gandalf.local.home>
In-Reply-To: <20211011115018.88948-1-yangjihong1@huawei.com>
References: <20211011115018.88948-1-yangjihong1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 19:50:18 +0800
Yang Jihong <yangjihong1@huawei.com> wrote:

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 7896d30d90f7..a795610a3b37 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2427,8 +2427,11 @@ static int trace_save_cmdline(struct task_struct *tsk)
>  		savedcmd->cmdline_idx = idx;
>  	}
>  
> -	savedcmd->map_cmdline_to_pid[idx] = tsk->pid;
> -	set_cmdline(idx, tsk->comm);
> +	/* save cmdline only when task does not exist in savecmd */
> +	if (savedcmd->map_cmdline_to_pid[idx] != tsk->pid) {
> +		savedcmd->map_cmdline_to_pid[idx] = tsk->pid;
> +		set_cmdline(idx, tsk->comm);
> +	}
>  

I now remember why I never did it this way. This breaks saving the command
line when we do an exec.

That is, just because mapped_pid == tsk->pid does not mean that the comm is
the same.

-- Steve
