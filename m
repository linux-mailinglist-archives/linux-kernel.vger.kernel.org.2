Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D823A5B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 01:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhFMXvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 19:51:04 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:46677 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhFMXvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 19:51:03 -0400
Received: by mail-pl1-f181.google.com with SMTP id e1so5611459pld.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 16:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=4++lM/c5yuFezao0v/U58iKYZqak4/2YPsi6jthi/MU=;
        b=u8qk9ovErk+yiRsO1K7EN2usvRMWNFKFdUfVoGMl1WvFo6M7EsTp2V//cxltF69Via
         IQltky9u/ZvWFmfRgky/wUTBjPx3AWS036M8pvXCnmVNzgKX7KDNn18Z3MEGiXO374vj
         4L+MC1GFlhcqDTbCCzNn0HZmKfisGY/fBokJTP696RN244cMyn+tEspvbOf5DIboi1Hb
         nCmT1/dDqq5wRp3KIf4/wVvRzTW1mm3SODX1WxfYVrWwueDL/Hrz1nq5EsBeDRCJcsWr
         VFIrnUzBmjQ6KYukM19zW8HlkBVQMnBFFrzSS+luS/Y2ORVllbkjUD7+3CN6n7NhLgpd
         uiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=4++lM/c5yuFezao0v/U58iKYZqak4/2YPsi6jthi/MU=;
        b=s6ONGwVrsQ+yteuWsWTyTfDtPYjGWB2cg5megwoXCXy20oPfxpl7lbxDiNHy8UzvQK
         gfM4Yt3SkI1UFvdBSzFBLPa7sxuZcwXWlWmcAi7oMVbxp7dgH/OQPUeo654KwzuSdbzp
         kV1MV/h0OhGYriExULbY+YnqolmbVOijDGvN0qdcaKoTENOkmgWGFUQtyiYze3ZHzCan
         MIwQkmsBLXq6e89XoVISSWRcgTbZzLDUEWW/bypPU7MSrIwIml4UbsLnydRXvgxmfrp8
         oPnVVgK3lYquTtRTDVEf6NakxGilhu7f6tg6IfxD5MLbSzIGyaiKMG6yAIOY3KdwqD1o
         3oTQ==
X-Gm-Message-State: AOAM532mPicNrR7QJwjlX2XETejfXxVgN8CP4Td7ozpvujt55sjJB9DH
        Mu/QMc5Ufsm+q5WuyKAZ6ri+bQ==
X-Google-Smtp-Source: ABdhPJyL3rXVwtBroZkchCFGQh1DDDu76JX+VN/SjqFUHcThf3l8wb3D04Gb3OX6YXdk8pQf3m05Vw==
X-Received: by 2002:a17:90b:3696:: with SMTP id mj22mr21233255pjb.124.1623628070809;
        Sun, 13 Jun 2021 16:47:50 -0700 (PDT)
Received: from [2620:15c:17:3:da04:749c:4915:4eee] ([2620:15c:17:3:da04:749c:4915:4eee])
        by smtp.gmail.com with ESMTPSA id t14sm11208701pgm.9.2021.06.13.16.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 16:47:50 -0700 (PDT)
Date:   Sun, 13 Jun 2021 16:47:49 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Aaron Tomlin <atomlin@redhat.com>
cc:     linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, penguin-kernel@i-love.sakura.ne.jp,
        llong@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/oom_kill: show oom eligibility when displaying
 the current memory state of all tasks
In-Reply-To: <20210612204634.1102472-1-atomlin@redhat.com>
Message-ID: <6fc8beef-4dbb-b49a-4653-90fe564941a6@google.com>
References: <20210612204634.1102472-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021, Aaron Tomlin wrote:

> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index eefd3f5fde46..094b7b61d66f 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -160,6 +160,27 @@ static inline bool is_sysrq_oom(struct oom_control *oc)
>  	return oc->order == -1;
>  }
>  
> +/**
> + * is_task_eligible_oom - determine if and why a task cannot be OOM killed
> + * @tsk: task to check
> + *
> + * Needs to be called with task_lock().
> + */
> +static const char * is_task_oom_eligible(struct task_struct *p)

You should be able to just return a char.

> +{
> +	long adj;
> +
> +	adj = (long)p->signal->oom_score_adj;
> +	if (adj == OOM_SCORE_ADJ_MIN)
> +		return "S";

The value is already printed in the task dump, this doesn't look to add 
any information.

> +	else if (test_bit(MMF_OOM_SKIP, &p->mm->flags)
> +		return "R";

We should be doing the task dump only when we're killing a victim (unless 
we're panicking), so something else has been chosen.  Since we would have 
oom killed a process with MMF_OOM_SKIP already, can we simply choose to 
not print a line for this process?

> +	else if (in_vfork(p))
> +		return "V";

Is this a transition state that we can simply disregard from the output as 
well unless/until it becomes eligible?

> +	else
> +		return "";
> +}
> +
>  /* return true if the task is not adequate as candidate victim task. */
>  static bool oom_unkillable_task(struct task_struct *p)
>  {
> @@ -401,12 +422,13 @@ static int dump_task(struct task_struct *p, void *arg)
>  		return 0;
>  	}
>  
> -	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
> +	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %13s %s\n",

13 characters for one char output?

>  		task->pid, from_kuid(&init_user_ns, task_uid(task)),
>  		task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
>  		mm_pgtables_bytes(task->mm),
>  		get_mm_counter(task->mm, MM_SWAPENTS),
> -		task->signal->oom_score_adj, task->comm);
> +		task->signal->oom_score_adj, is_task_oom_eligible(task),
> +		task->comm);
>  	task_unlock(task);
>  
>  	return 0;
> @@ -420,12 +442,13 @@ static int dump_task(struct task_struct *p, void *arg)
>   * memcg, not in the same cpuset, or bound to a disjoint set of mempolicy nodes
>   * are not shown.
>   * State information includes task's pid, uid, tgid, vm size, rss,
> - * pgtables_bytes, swapents, oom_score_adj value, and name.
> + * pgtables_bytes, swapents, oom_score_adj value, oom eligibility status
> + * and name.
>   */
>  static void dump_tasks(struct oom_control *oc)
>  {
>  	pr_info("Tasks state (memory values in pages):\n");
> -	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
> +	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj oom eligible? name\n");

Field names are single words.

>  
>  	if (is_memcg_oom(oc))
>  		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
