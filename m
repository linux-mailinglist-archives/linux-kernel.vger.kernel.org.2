Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3776E41DD2B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245411AbhI3PTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:19:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52526 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245354AbhI3PTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:19:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 92ADC2003D;
        Thu, 30 Sep 2021 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633015045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r4dvjrVqa6lblFfeiOtqViO7KeVhWUcH3B50BD9jxkk=;
        b=G+2F5rD/5zurCYzw/cZ7qM3KxiogDqm/VdtHy04ZQVudY1Eyv5jlE4/naowqjHMMspO7+W
        b9WzveJ4ycc0FwHYiZ9Zgvmis/ySYlbZhyCSeV5J/0/ZzOc+rpek3KWgK1O/uwbpNreeAo
        cmXSGoVWwnIIWdo2k3Xa5yF3uP6zPdA=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 44E48A4007;
        Thu, 30 Sep 2021 15:17:25 +0000 (UTC)
Date:   Thu, 30 Sep 2021 17:17:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        valentin.schneider@arm.com, keescook@chromium.org,
        mathieu.desnoyers@efficios.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, viro@zeniv.linux.org.uk,
        christian@brauner.io, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] kernel/kthread: show a warning if kthread's comm is
 still trucated
Message-ID: <YVXVBXSZ1m4ScvbX@alley>
References: <20210929115036.4851-1-laoar.shao@gmail.com>
 <20210929115036.4851-6-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929115036.4851-6-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-09-29 11:50:36, Yafang Shao wrote:
> Show a warning if the ktrhead's comm is still trucated. Below is the
> result of my test case -
> 
> __kthread_create_on_node:410: comm of pid 14 is truncated from "I-am-a-kthread-with-long-name" to "I-am-a-kthread-with-lon"
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/kthread.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 6def951c605a..aa093f1f423a 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -404,7 +404,11 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
>  		 * task is already visible to other tasks, so updating
>  		 * COMM must be protected.
>  		 */
> -		vsnprintf(name, sizeof(name), namefmt, args);
> +		if (vsnprintf(name, KTHREAD_COMM_LEN, namefmt, args) >=
> +		    KTHREAD_COMM_LEN)
> +			pr_warn("%s:%d: comm of pid %d is truncated from \"%s\" to \"%s\"\n",
> +				__func__, __LINE__, task->pid, namefmt, name);

The warning makes sense. But the use of "namefmt" looks wrong. It is
format and not the name. Also __func__ and __LINE__ is overkill. It will
be always the same.

I would do something like:

		len = vsnprintf(name, sizeof(name), namefmt, args);
		if (len >= KTHREAD_COMM_LEN) {
			pr_warn("truncated kthread comm:%s, pid:%d by %d characters\n",
				name, task->pid, len - KTHREAD_COMM_LEN + 1);
		}

Best Regards,
Petr
