Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C2334E967
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhC3Njy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232038AbhC3NjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:39:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52AB2619BD;
        Tue, 30 Mar 2021 13:39:18 +0000 (UTC)
Date:   Tue, 30 Mar 2021 09:39:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Modify parameter transfer type
Message-ID: <20210330093916.432697c7@gandalf.local.home>
In-Reply-To: <1617098546-41010-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1617098546-41010-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 18:02:26 +0800
Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Fix the following whitescan warning:
> 
> "order" is passed to a parameter that cannot be negative.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  kernel/trace/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index b7e29db..bd42e86 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6811,7 +6811,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
>  		if (!pg->index) {
>  			*last_pg = pg->next;
>  			order = get_count_order(pg->size / ENTRIES_PER_PAGE);
> -			free_pages((unsigned long)pg->records, order);
> +			free_pages((unsigned long)pg->records, (unsigned int)order);

NAK!

This "fix" actually makes the problem worse, and hides a possible bug.

-- Steve


>  			ftrace_number_of_pages -= 1 << order;
>  			ftrace_number_of_groups--;
>  			kfree(pg);

