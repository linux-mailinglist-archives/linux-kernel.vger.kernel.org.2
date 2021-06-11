Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669B53A4806
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFKRoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhFKRow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623433373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tq2VBJnTIL88nOgXkv2qw+Gup4yecCG4S2LWVtxNUDY=;
        b=b+V//17w8r096DG/JkY7dGDw/dvlXHh8uqWGCPpEnVh52PSMvB5ZXpQ2Jqy1RRcScGZvKU
        4NJ/5GmFEVXroSACWlW+xh3By7rbXYyJSKl6cnI/gs6KlYfMnQrp8khv15XiwpUkhrIevk
        IOYNoG0IIsGRGanjYJjSB4b4YURLC8M=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-yo5cs26UNAuYWEUDdyFBXw-1; Fri, 11 Jun 2021 13:42:52 -0400
X-MC-Unique: yo5cs26UNAuYWEUDdyFBXw-1
Received: by mail-qt1-f200.google.com with SMTP id w1-20020ac87a610000b02902433332a0easo2408389qtt.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 10:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Tq2VBJnTIL88nOgXkv2qw+Gup4yecCG4S2LWVtxNUDY=;
        b=jdtlfk0zRcBGLfezIUqe8f/YJSJH7+VcK+yrgT/W0l5zwNNdz44T1C6X+BNWRoZFxT
         71UX3xV1+K1/Ydaf3lcaMxLE1a6C9Is8ijKDfYW40pizNXIaKlidos04aPCurPMEzLB0
         9zyG9T/Ca2yCo1cg7Ea2hMxAbPvCpjKTdGWyp9sCnQZU71YgPgWddFhtU9/AuulO9ZtI
         +3iMnqM415U7hNZ8ttXxX9ew9GyszJBfERBmNF+wHFYr33pT0v8FSJ8JVpmpO1jJ5cVA
         WB+nnzKX0x7g/AalMrxtsNGf0m32WuJpELi7r/gG67zQlyXnc2e48tSm+bH8mlCQGFFb
         juRw==
X-Gm-Message-State: AOAM530eEWZ0lACvJHUdu5+amkmmwk2zlhFTFpk1hD+s6UFpiMrnsfDb
        nf7KjgoskEj8rMf++nnQGUqfhRpGAEEBTwat9LHgk8byCyVD/2ZIVrqBJK9GvrdXMjhGilvQBCi
        cKIZbCmHly1zQzRUD05qNhzry6oCnPiUmqrQiJdI5AHxV/Kw4porUjWaPAN/mdp904DXY3TFJ
X-Received: by 2002:a05:6214:485:: with SMTP id ay5mr6025834qvb.6.1623433371872;
        Fri, 11 Jun 2021 10:42:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw79EIrxZh/eiep6ybHh0EA4qzUqCVzfw/jlsk5p45EmzeUqCeC8P5eD5hAcohWzas3AXoHGQ==
X-Received: by 2002:a05:6214:485:: with SMTP id ay5mr6025805qvb.6.1623433371505;
        Fri, 11 Jun 2021 10:42:51 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id f5sm4679772qkm.124.2021.06.11.10.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 10:42:50 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH] mm/oom_kill: show oom eligibility when displaying the
 current memory state of all tasks
To:     Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        penguin-kernel@i-love.sakura.ne.jp, llong@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210611171940.960887-1-atomlin@redhat.com>
Message-ID: <d233acb6-72ff-4914-88a3-75bf137e5286@redhat.com>
Date:   Fri, 11 Jun 2021 13:42:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210611171940.960887-1-atomlin@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 1:19 PM, Aaron Tomlin wrote:
> At the present time, when showing potential OOM victims, we do not
> exclude tasks which already have MMF_OOM_SKIP set; it is possible that
> the last OOM killable victim was already OOM killed, yet the OOM
> reaper failed to reclaim memory and set MMF_OOM_SKIP.
> This can be confusing/or perhaps even misleading, to the reader of the
> OOM report. Now, we already unconditionally display a task's
> oom_score_adj_min value that can be set to OOM_SCORE_ADJ_MIN which is
> indicative of an "unkillable" task i.e. is not eligible.
>
> This patch provides a clear indication with regard to the OOM
> eligibility of each displayed task.
>
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>   mm/oom_kill.c | 31 +++++++++++++++++++++++++++----
>   1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index eefd3f5fde46..70781d681a6e 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -160,6 +160,27 @@ static inline bool is_sysrq_oom(struct oom_control *oc)
>   	return oc->order == -1;
>   }
>   
> +/**
> + * is_task_eligible_oom - determine if and why a task cannot be OOM killed
> + * @tsk: task to check
> + *
> + * Needs to be called with task_lock().
> + */
> +static const char * is_task_oom_eligible(struct task_struct *p)
> +{
> +	long adj;
> +
> +	adj = (long)p->signal->oom_score_adj;
> +	if (adj == OOM_SCORE_ADJ_MIN)
> +		return "no: oom score";
> +	else if (test_bit(MMF_OOM_SKIP, &p->mm->flags)
> +		return "no: oom reaped";
> +	else if (in_vfork(p))
> +		return "no: in vfork";
> +	else
> +		return "yes";
> +}
> +
>   /* return true if the task is not adequate as candidate victim task. */
>   static bool oom_unkillable_task(struct task_struct *p)
>   {
> @@ -401,12 +422,13 @@ static int dump_task(struct task_struct *p, void *arg)
>   		return 0;
>   	}
>   
> -	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
> +	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %-15s %s\n",
>   		task->pid, from_kuid(&init_user_ns, task_uid(task)),
>   		task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
>   		mm_pgtables_bytes(task->mm),
>   		get_mm_counter(task->mm, MM_SWAPENTS),
> -		task->signal->oom_score_adj, task->comm);
> +		task->signal->oom_score_adj, is_task_oom_eligible(task),
> +		task->comm);
>   	task_unlock(task);
>   
>   	return 0;
> @@ -420,12 +442,13 @@ static int dump_task(struct task_struct *p, void *arg)
>    * memcg, not in the same cpuset, or bound to a disjoint set of mempolicy nodes
>    * are not shown.
>    * State information includes task's pid, uid, tgid, vm size, rss,
> - * pgtables_bytes, swapents, oom_score_adj value, and name.
> + * pgtables_bytes, swapents, oom_score_adj value, oom eligible status
> + * and name.
>    */
>   static void dump_tasks(struct oom_control *oc)
>   {
>   	pr_info("Tasks state (memory values in pages):\n");
> -	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
> +	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj oom eligible? name\n");

A minor nit:

"oom eligible?" has 13 characters. The field width is 15. Maybe you 
should pad 2 more spaces to make the proper alignment.

Cheers,
Longman

