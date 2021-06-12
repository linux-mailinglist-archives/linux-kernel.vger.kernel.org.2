Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87D73A4C5A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFLDLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLDLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:11:08 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A13C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:08:55 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ei4so6701487pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=kpUTcvo6O2tGi/GNfmLN2Nx7EN/UMr+yD7v9046xIR8=;
        b=HgCHlQT+NjLsi/EXuC0ScHCl6kNZOg7lKSGqbaj2NLCzRycChsUNtX5N4T77o0McJA
         dOtPJMvkeSq7+ASt+umIGIk6N9RgXlCp1J2xNeFXasdJaRgKxKlb9xkJfrtbXuVx9sYY
         9WjB2xhXbNsZO+PsO83ggtD7whQwFPqlVhFNEZ0uKcSAryu3AA04minqQfq3LG13aWpz
         HJKhyIbnlcD8iS/iF3okFFS10JHihn1EuuqrH8C0JpWDEUazXP+tri2cFScNec79Fdye
         i5o+wDwTrq8J9EaBRyV5OK9jX/VulavimQqVl1ZZxbaOiKHlTU3qfLlsFppd1BeumF+L
         ArpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=kpUTcvo6O2tGi/GNfmLN2Nx7EN/UMr+yD7v9046xIR8=;
        b=FdG4pOp8tMMQHQ1kaQfii5MHUGMbVa1ajRl48sbqZ7AjVXfKRiggGSbn6ic1dlTh9L
         2oN2gVkmrWQK6Vklau/fbUFCeYbDKNcgwDO8F2ELqzQx7/EyoEx8ZerXCBC1lIn4bbzV
         +Dt46s90ulEemf+/+BT0ArBIJ8j7dDlIsMk3HL7FWpb5v7zX8Ft2yGXitGY7pq56cOqw
         1fFL6mqTX999kQMicT5dk+9bZ1zuzXEVi8MXYDo+v/lZC4iLcmReIOnpevoqJG4cY9mU
         rrQ0B43W2kED2nOBgMFoOzMuzenW7CYLVYU25sFpPqqC/MmjHd9mfSpQegqP3G2kKBNU
         FkZQ==
X-Gm-Message-State: AOAM531weiv9hZ6LifVTGLoUWsw89+Lsj851vUnUfECjeJPvBNntlfWn
        hMES7xtE/RDAIbIdXfJDdzpySqxifOk=
X-Google-Smtp-Source: ABdhPJwpBaGqcNIEYfky5Z6XAT9lCdE4ALMgr0PP+R/uUoNFCyASBGvueMnO6HF1zqyC30JPlNVCrg==
X-Received: by 2002:a17:902:b585:b029:f6:5cd5:f128 with SMTP id a5-20020a170902b585b02900f65cd5f128mr6634920pls.43.1623467334232;
        Fri, 11 Jun 2021 20:08:54 -0700 (PDT)
Received: from owniadeMacBook-Pro.local ([129.227.156.200])
        by smtp.gmail.com with ESMTPSA id z185sm6618080pgb.4.2021.06.11.20.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 20:08:53 -0700 (PDT)
Subject: Re: [RFC PATCH] mm/oom_kill: show oom eligibility when displaying the
 current memory state of all tasks
To:     Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        penguin-kernel@i-love.sakura.ne.jp, llong@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210611171940.960887-1-atomlin@redhat.com>
From:   ownia <ownia.linux@gmail.com>
Message-ID: <18a14e1a-df91-23b2-16d6-610e3c3c200e@gmail.com>
Date:   Sat, 12 Jun 2021 11:08:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210611171940.960887-1-atomlin@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/6/12 01:19, Aaron Tomlin wrote:
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
>  mm/oom_kill.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index eefd3f5fde46..70781d681a6e 100644
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
> +{
> +	long adj;
> +
> +	adj = (long)p->signal->oom_score_adj;
accoring to the origin type, adj this place maybe use *short* instead.
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
>  /* return true if the task is not adequate as candidate victim task. */
>  static bool oom_unkillable_task(struct task_struct *p)
>  {
> @@ -401,12 +422,13 @@ static int dump_task(struct task_struct *p, void *arg)
>  		return 0;
>  	}
>  
> -	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
> +	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %-15s %s\n",
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
> + * pgtables_bytes, swapents, oom_score_adj value, oom eligible status
> + * and name.
>   */
>  static void dump_tasks(struct oom_control *oc)
>  {
>  	pr_info("Tasks state (memory values in pages):\n");
> -	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
> +	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj oom eligible? name\n");
>  
>  	if (is_memcg_oom(oc))
>  		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
