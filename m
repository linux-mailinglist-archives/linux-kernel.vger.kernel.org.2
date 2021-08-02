Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8623DCEF9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 05:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhHBDtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 23:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhHBDtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 23:49:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3751DC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 20:49:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id e5so18164956pld.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 20:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=rHIx+Lzgiz2GLQikpyfJr7VGQZbn/plrpE6BfyoANFQ=;
        b=bo2Q2novGv6+egi0qRgwWl1hPx3EzIpdCUkjDFlGpielYLWkfwtothUKL2nrGLnDN2
         ienmbBt9H8Hjaxj5MN5ojmxuKlA2Y3rhj+wp9WpyExWYwX33An4QFpxV5YpXdUIpN6O3
         WDSWwDfTyFVtEYrktiquvRHeUUjpWtZmifAynGq5I25MnuDhVN1s6yx23MsfwXFx6QFh
         j9vjZfDfUYHqZ62EEG0v/diEsfby2RgVtnKDLJq3Y3AiXCb/EHxLdNJiQvjjopUTtev+
         N3oqbX/5vZyCHpIv7GA3tXYhxtmEZhFJTuxPgzhyIhJX/+BVn5+YBQNiCgVf4z7ij1MO
         rbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=rHIx+Lzgiz2GLQikpyfJr7VGQZbn/plrpE6BfyoANFQ=;
        b=NzeHl+8kdm2yeizKVlhWQLuO6leqT40DSubLRrXdH/f7Gh+8446R5FA7YcypmwMQui
         at6AZCU0dcI971Ca3QPpazeeYlb23MW5J+sclHxJ9WQmJOIGIXxwfHLZsHLSgu3CZSiX
         a4pSgMxw/sCejhsgXb3JjONYeXTM7n1Hc42cO2BAkzKQIH8sECEd74/IGzDsCAG8n7Lu
         P+qZDC/62eOxYEOl/WyJRq9/9R6+/4reu0DK/sJ9MgW2H6SafcFnIRBxSM60s+sOspgc
         WKZSYocpO1hpw5ZtBKp/U43yW3x44jOshlERet5NMNQySGea1pUxMa9oz9oR0FH84gxu
         wUUg==
X-Gm-Message-State: AOAM532PPa564LZqfAQPPIbAqnKxhG2p3OJeW1PfvWspIKq4DoYWByRn
        Kle/Sr0VeSGipznDLh20CUZdxA==
X-Google-Smtp-Source: ABdhPJzoNDt1S/Z4atDmNpr6PjpNaR/vFKfCvH9m8qOCDpXnj/+BTk+CgT/JRujlpyJ+Ar+73/pvXw==
X-Received: by 2002:a17:90b:1a86:: with SMTP id ng6mr11021807pjb.209.1627876144531;
        Sun, 01 Aug 2021 20:49:04 -0700 (PDT)
Received: from [2620:15c:17:3:f081:306b:20f6:7d15] ([2620:15c:17:3:f081:306b:20f6:7d15])
        by smtp.gmail.com with ESMTPSA id gz12sm6673758pjb.8.2021.08.01.20.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 20:49:03 -0700 (PDT)
Date:   Sun, 1 Aug 2021 20:49:02 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Aaron Tomlin <atomlin@redhat.com>
cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        penguin-kernel@i-love.sakura.ne.jp, llong@redhat.com,
        neelx@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/oom_kill: show oom eligibility when displaying
 the current memory state of all tasks
In-Reply-To: <20210730162002.279678-1-atomlin@redhat.com>
Message-ID: <fa6e3682-abae-f656-fec4-178a608face5@google.com>
References: <20210730162002.279678-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2021, Aaron Tomlin wrote:

>  Documentation/admin-guide/sysctl/vm.rst |  5 ++--
>  mm/oom_kill.c                           | 31 +++++++++++++++++++++----
>  2 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index 003d5cc3751b..4c79fa00ddb3 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -650,8 +650,9 @@ oom_dump_tasks
>  Enables a system-wide task dump (excluding kernel threads) to be produced
>  when the kernel performs an OOM-killing and includes such information as
>  pid, uid, tgid, vm size, rss, pgtables_bytes, swapents, oom_score_adj
> -score, and name.  This is helpful to determine why the OOM killer was
> -invoked, to identify the rogue task that caused it, and to determine why
> +score, oom eligibility status and name.  This is helpful to determine why
> +the OOM killer was invoked, to identify the rogue task that caused it, and
> +to determine why
>  the OOM killer chose the task it did to kill.
>  
>  If this is set to zero, this information is suppressed.  On very
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index c729a4c4a1ac..36daa6917b62 100644
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
> +static const char * const is_task_oom_eligible(struct task_struct *p)
> +{
> +	long adj;
> +
> +	adj = (long)p->signal->oom_score_adj;
> +	if (adj == OOM_SCORE_ADJ_MIN)
> +		return "M";

oom_score_adj is shown already in the tasklist dump, I'm not sure what 
value this adds.

> +	else if (test_bit(MMF_OOM_SKIP, &p->mm->flags)
> +		return "R";
> +	else if (in_vfork(p))
> +		return "V";

This is going to be racy, we can't show that a task that is emitted as 
part of the tasklist dump was did not have in_vfork() == true at the time 
oom_badness() was called.

Wouldn't it be better to simply print the output of oom_badness() to the 
tasklist dump instead so we get complete information?

We could simply special case a LONG_MIN return value as -1000 or "min".

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
> +	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %1s %s\n",
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
> +	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj oom_skipped name\n");
>  
>  	if (is_memcg_oom(oc))
>  		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
> -- 
> 2.31.1
> 
> 
