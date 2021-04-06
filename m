Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2DD3553D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbhDFM1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241745AbhDFM1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:27:36 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55BB76121E;
        Tue,  6 Apr 2021 12:27:28 +0000 (UTC)
Date:   Tue, 6 Apr 2021 08:27:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Check if pages were allocated before calling
 free_pages()
Message-ID: <20210406082726.3b25a2f6@gandalf.local.home>
In-Reply-To: <1617691905-8016-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1617691905-8016-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Apr 2021 14:51:45 +0800
Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> It is possible that on error pg->size can be zero when getting its
> order,which would return a -1 value. It is dangerous to pass in an
> order of -1 to free_pages(). Check if order is greater than or equal
> to zero before calling free_pages().
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  kernel/trace/ftrace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index b7e29db..74efc33 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6811,7 +6811,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
>  		if (!pg->index) {
>  			*last_pg = pg->next;
>  			order = get_count_order(pg->size / ENTRIES_PER_PAGE);
> -			free_pages((unsigned long)pg->records, order);
> +			if (order >= 0)
> +				free_pages((unsigned long)pg->records, order);

This has already been fixed upstream.

-- Steve

>  			ftrace_number_of_pages -= 1 << order;
>  			ftrace_number_of_groups--;
>  			kfree(pg);

