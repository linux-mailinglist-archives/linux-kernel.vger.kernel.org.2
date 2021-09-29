Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB0D41CB8D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345759AbhI2SM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343518AbhI2SMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:12:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C885C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:11:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 145so2645018pfz.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=InCyEGJRepaMndZ1Cu28LiyH3Mn458LrfVZqSQJHIF4=;
        b=WEyGTc+vZ4OhLdsJ5Wolv2SBWxKb1HEvIL2Z19iZUEWkA1tAHUBgndB/1bEvSVHCSv
         zNlvDSEvIyhuHNBRIFlVU8NHL3WiR3zAZuYVlw+4e+Wlxsk9RgJYA9OYCBZ/43KyyApQ
         UrwQL0+HtMpE+4ea9FFErYdSUT/U7a+NC4FTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=InCyEGJRepaMndZ1Cu28LiyH3Mn458LrfVZqSQJHIF4=;
        b=YlAMFkBmWGIOXlLtak5e53k05rEs6rY7BmO5eh3AAP74hGeKDSY3lN/5SXXlUhyvOH
         Yejx4AhFE2UhmBgc9lZobFEpVXe7a3Owp8B8IOqQqAmrg+9W2XlIyCaqvbZ2iZeVnenb
         LwfdgWYqJcp2L2fKdu3tymUBk8QxJOjUkW6EF+AGh0jnGsFW+mx4ubN+I87dWu8EZnBs
         qAchbav2VGche5AOHrR8ZFuUSPwhfX6R+zxwIekjAUK3Z+coq3vBQRDCV4hXVacRUXDZ
         ZkTM06ZzfbLv2QMoteXO+WchyvxEj0lS8k2HPmaV8n/qybiGXHlrnf4LygoDEIZOYOPd
         a8ag==
X-Gm-Message-State: AOAM530ttnuC4seXlQaXjK7OXMKgljR8axq1OC99e6mH+wcdL/IodDFL
        1oIV7s0rPukZzapDpCP/gMzuMA==
X-Google-Smtp-Source: ABdhPJz/sRBdMqIeinvVX0EtmbbT7UuLVMdyjP4q8q2AiAOFLWkCmgwI+cIEhMxZMutU0r+qHD/7ng==
X-Received: by 2002:a63:7c5c:: with SMTP id l28mr1102609pgn.73.1632939069520;
        Wed, 29 Sep 2021 11:11:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h3sm338372pju.33.2021.09.29.11.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:11:08 -0700 (PDT)
Date:   Wed, 29 Sep 2021 11:11:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, pmladek@suse.com, peterz@infradead.org,
        valentin.schneider@arm.com, mathieu.desnoyers@efficios.com,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        viro@zeniv.linux.org.uk, christian@brauner.io,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] kernel/fork: allocate task->comm dynamicly
Message-ID: <202109291109.FAF3F47BA@keescook>
References: <20210929115036.4851-1-laoar.shao@gmail.com>
 <20210929115036.4851-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929115036.4851-3-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 11:50:33AM +0000, Yafang Shao wrote:
> task->comm is defined as an array embedded in struct task_struct before.
> This patch changes it to a char pointer. It will be allocated in the fork
> and freed when the task is freed.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/sched.h |  2 +-
>  kernel/fork.c         | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index e12b524426b0..b387b5943db4 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1051,7 +1051,7 @@ struct task_struct {
>  	 * - access it with [gs]et_task_comm()
>  	 * - lock it with task_lock()
>  	 */
> -	char				comm[TASK_COMM_LEN];
> +	char				*comm;

This, I think, is basically a non-starter. It adds another kmalloc to
the fork path without a well-justified reason. TASK_COMM_LEN is small,
yes, but why is growing it valuable enough to slow things down?

(Or, can you prove that this does NOT slow things down? It seems like
it would.)

-Kees

>  
>  	struct nameidata		*nameidata;
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 38681ad44c76..227aec240501 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -721,6 +721,20 @@ static void mmdrop_async(struct mm_struct *mm)
>  	}
>  }
>  
> +static int task_comm_alloc(struct task_struct *p)
> +{
> +	p->comm = kzalloc(TASK_COMM_LEN, GFP_KERNEL);
> +	if (!p->comm)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void task_comm_free(struct task_struct *p)
> +{
> +	kfree(p->comm);
> +}
> +
>  static inline void free_signal_struct(struct signal_struct *sig)
>  {
>  	taskstats_tgid_free(sig);
> @@ -753,6 +767,7 @@ void __put_task_struct(struct task_struct *tsk)
>  	bpf_task_storage_free(tsk);
>  	exit_creds(tsk);
>  	delayacct_tsk_free(tsk);
> +	task_comm_free(tsk);
>  	put_signal_struct(tsk->signal);
>  	sched_core_free(tsk);
>  
> @@ -2076,6 +2091,10 @@ static __latent_entropy struct task_struct *copy_process(
>  	if (data_race(nr_threads >= max_threads))
>  		goto bad_fork_cleanup_count;
>  
> +	retval = task_comm_alloc(p);
> +	if (retval)
> +		goto bad_fork_cleanup_count;
> +
>  	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
>  	p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_IDLE | PF_NO_SETAFFINITY);
>  	p->flags |= PF_FORKNOEXEC;
> -- 
> 2.17.1
> 

-- 
Kees Cook
