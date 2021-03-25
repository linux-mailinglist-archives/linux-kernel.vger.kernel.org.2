Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A3D348661
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 02:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbhCYBWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 21:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239566AbhCYBVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 21:21:13 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4596E61A14;
        Thu, 25 Mar 2021 01:20:19 +0000 (UTC)
Date:   Wed, 24 Mar 2021 21:20:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     <mingo@redhat.com>, <jolsa@redhat.com>,
        <linux-kernel@vger.kernel.org>, <yangjihong1@huawei.com>,
        <xukuohai@huawei.com>, <zhangjinhao2@huawei.com>
Subject: Re: [PATCH 1/2] ftrace: Update ftrace_ops->next pointer with
 rcu_assign_pointer()
Message-ID: <20210324212017.0cd11e7e@oasis.local.home>
In-Reply-To: <20210317102529.226734-2-lihuafei1@huawei.com>
References: <20210317102529.226734-1-lihuafei1@huawei.com>
        <20210317102529.226734-2-lihuafei1@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 18:25:28 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> The unregistered ftrace_ops may be freed by the caller, so we should use
> rcu_assign_pointer() in remove_ftrace_ops() to remove the ftrace_ops,
> which ensures that no more users will reference the ftrace_ops after
> synchronize_rcu() is called.

The patch is fine, but we don't use synchronize_rcu() to protect the
list. We use synchronize_rcu_tasks().

-- Steve


> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  kernel/trace/ftrace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 4d8e35575549..2e315a145d20 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -282,7 +282,7 @@ static int remove_ftrace_ops(struct ftrace_ops __rcu **list,
>  			lockdep_is_held(&ftrace_lock)) == ops &&
>  	    rcu_dereference_protected(ops->next,
>  			lockdep_is_held(&ftrace_lock)) == &ftrace_list_end) {
> -		*list = &ftrace_list_end;
> +		rcu_assign_pointer(*list, &ftrace_list_end);
>  		return 0;
>  	}
>  
> @@ -293,7 +293,7 @@ static int remove_ftrace_ops(struct ftrace_ops __rcu **list,
>  	if (*p != ops)
>  		return -1;
>  
> -	*p = (*p)->next;
> +	rcu_assign_pointer(*p, (*p)->next);
>  	return 0;
>  }
>  

