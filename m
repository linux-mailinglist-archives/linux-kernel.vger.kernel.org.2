Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292D3383C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 20:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhEQSiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhEQSiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 14:38:10 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66961C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 11:36:53 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id q10so6775579qkc.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 11:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xDXZeUPt5o63e3EAMlrrPUKhIs+5nbG9PoLpAGN3bQY=;
        b=jd1bmNkpPE7ZLUvzEQY1VM5qpnYhmODjrvBEhSADdrN37zdq+gZcxuVS1kOjhe1iRZ
         l7z9RMMz+2aP/oGTmB4kgjRxm5yJ9sltqK+WadRv4dcnJMFLs08BtKu4++uZWG3TZhJd
         H6xCj/zOcdA5m94vyKp3V9W3Tt1u5+KLmivr7FLDAYZ3+86bXWG0PJSYIQazZgMlN/LW
         0tSPdc/GICgCuDmSOcHh4IxUEYB5Wns09K6BzcB85NisvW0H/raUNUiijj9W3mX2GTh7
         t8r9ikIvfqbMWtV59CPkUFicTydhzERtOsjBqefQDEQxbCT019whmstmJmk3mPnyNxkX
         Zs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xDXZeUPt5o63e3EAMlrrPUKhIs+5nbG9PoLpAGN3bQY=;
        b=MBwHrc9Yt/CX6lw/onDC6xOE9f3cZx71gxoQKL/3fJFHsF4gkWNFG+ewI9d700TZdX
         yih4RsTr0qH+xh3QayDAlJuZidDrcazNjUKMLJNpQ+5ZXIrBd+byU2vbCCunT/7LqWYL
         NgOolS3sEsBJi2HshKKLQGFuKyJdaff/o82NVp7vZtKyyGiALMmC/dckcKJSVahg6hTe
         CayiISmrih+qiKPLC2Iqk+Azery5UpUbxOqpnkNupUCqYL/nl3t7QvnvKT6o7i1YyiyW
         HRtSf/A2lVNs+7k1w7ki/Yoz66zKtFG+ZsMj+yo8/Sc9Y98fTS8tVtB+tlIXwHZS6jCu
         3xQg==
X-Gm-Message-State: AOAM531iKiHLm8iZATdgV9e+uM2+lu1JsPqKnBvPP7Gvi1o/JRnTsB3n
        XPry36XOJDydmd+Du1HXBoUC7Q==
X-Google-Smtp-Source: ABdhPJxmJxfbXot8x9jqLb8m9kN9kDtpj8UeFDTbz81YB77VEsAqmcodHIPymeCiCHVKo/2lrpAxHQ==
X-Received: by 2002:ae9:e919:: with SMTP id x25mr1251594qkf.232.1621276612686;
        Mon, 17 May 2021 11:36:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8d28])
        by smtp.gmail.com with ESMTPSA id z11sm10986776qto.95.2021.05.17.11.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 11:36:52 -0700 (PDT)
Date:   Mon, 17 May 2021 14:36:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, Ke Wang <ke.wang@unisoc.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [[RFC]PATCH] psi: fix race between psi_trigger_create and psimon
Message-ID: <YKK3wgrhqzaiE7rQ@cmpxchg.org>
References: <1621242249-8314-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621242249-8314-1-git-send-email-huangzhaoyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Suren

On Mon, May 17, 2021 at 05:04:09PM +0800, Huangzhaoyang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Race detected between psimon_new and psimon_old as shown below, which
> cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
> and psi_system->poll_timer->entry->next. It is not necessary to reinit
> resource of psi_system when psi_trigger_create.
> 
> psi_trigger_create      psimon_new     psimon_old
>  init_waitqueue_head                    finish_wait
>                                           spin_lock(lock_old)
> 	spin_lock_init(lock_new)
>  wake_up_process(psimon_new)
> 
>                         finish_wait
>                           spin_lock(lock_new)
>                             list_del       list_del
> 
> Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
> Signed-off-by: ke.wang <ke.wang@unisoc.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  kernel/sched/psi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index cc25a3c..d00e585 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -182,6 +182,8 @@ struct psi_group psi_system = {
>  
>  static void psi_avgs_work(struct work_struct *work);
>  
> +static void poll_timer_fn(struct timer_list *t);
> +
>  static void group_init(struct psi_group *group)
>  {
>  	int cpu;
> @@ -201,6 +203,8 @@ static void group_init(struct psi_group *group)
>  	memset(group->polling_total, 0, sizeof(group->polling_total));
>  	group->polling_next_update = ULLONG_MAX;
>  	group->polling_until = 0;
> +	init_waitqueue_head(&group->poll_wait);
> +	timer_setup(&group->poll_timer, poll_timer_fn, 0);

This makes sense.

>  	rcu_assign_pointer(group->poll_task, NULL);
>  }
>  
> @@ -1157,7 +1161,6 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>  			return ERR_CAST(task);
>  		}
>  		atomic_set(&group->poll_wakeup, 0);
> -		init_waitqueue_head(&group->poll_wait);
>  		wake_up_process(task);
>  		timer_setup(&group->poll_timer, poll_timer_fn, 0);

This looks now unncessary?

>  		rcu_assign_pointer(group->poll_task, task);
> @@ -1233,7 +1236,6 @@ static void psi_trigger_destroy(struct kref *ref)
>  		 * But it might have been already scheduled before
>  		 * that - deschedule it cleanly before destroying it.
>  		 */
> -		del_timer_sync(&group->poll_timer);

And this looks wrong. Did you mean to delete the timer_setup() line
instead?
