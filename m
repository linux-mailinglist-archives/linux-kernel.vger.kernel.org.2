Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF2840574B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357918AbhIINdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:33:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53256 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357117AbhIINIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:08:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 906B51FDEE;
        Thu,  9 Sep 2021 13:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631192865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8fvni01MBJWcxrLzPbIsAKIM37aJ2JiDCm9M8IpR/A=;
        b=hUdo2nR0EawMEn0tCZz+eb71l9bIv1JtCOFAj8A2+hXlZhAa4O+py+YtLLNnAk4TnGT9xI
        YwfNirztdFcoTpYCI19/BIn+OF+r95Qf8Jw4u4BGR3aczZ4wQgdvygzDe1vhAcjtaMPEjQ
        qDzDYz3a25yrSpOJMap6kcybalH5W0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631192865;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8fvni01MBJWcxrLzPbIsAKIM37aJ2JiDCm9M8IpR/A=;
        b=qFUIIgpaFwTDAOHvTpPWClu4gbEPsEJxT6SkoKJI/Y9FtFtvC6hOb8sPcS18GVhtwSvy8A
        9KL1z7kUf6GQteDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DA0B13B36;
        Thu,  9 Sep 2021 13:07:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wkMdGiEHOmEzDAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 09 Sep 2021 13:07:45 +0000
Message-ID: <0f55d19c-9c96-1251-58b5-4cd96a49bc6d@suse.cz>
Date:   Thu, 9 Sep 2021 15:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Content-Language: en-US
To:     Huangzhaoyang <huangzhaoyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        ke.wang@unisoc.com
References: <1631188824-25623-1-git-send-email-huangzhaoyang@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH] psi : calc psi memstall time more precisely
In-Reply-To: <1631188824-25623-1-git-send-email-huangzhaoyang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/21 14:00, Huangzhaoyang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> psi's memstall time is counted as simple as exit - entry so far, which ignore
> the task's off cpu time. Fix it by calc the percentage of off time via task and
> rq's util and runq load.

Wouldn't this also filter out IO wait time as that means sleeping, thus
again defeat the purpose of observing real stalls due to memory shortage?
If cpu starvation (due to overcommited system?) affects pci memstall
accuracy then that's suboptimal, but IMHO fixing it this way would do more
harm than good?

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  kernel/sched/psi.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index cc25a3c..6812c7e 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -182,6 +182,8 @@ struct psi_group psi_system = {
>  
>  static void psi_avgs_work(struct work_struct *work);
>  
> +static unsigned long psi_memtime_fixup(u32 growth);
> +
>  static void group_init(struct psi_group *group)
>  {
>  	int cpu;
> @@ -492,6 +494,23 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
>  	return growth;
>  }
>  
> +static unsigned long psi_memtime_fixup(u32 growth)
> +{
> +	struct rq *rq = task_rq(current);
> +	unsigned long growth_fixed = (unsigned long)growth;
> +
> +	if !(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH)
> +		return growth_fixed;
> +
> +	if ((current->in_memstall)
> +		&& (current->se.avg.util_avg <= rq->cfs.avg.util_avg)
> +		&& current->se.avg.util_avg != 0)
> +		growth_fixed = div64_ul((current->se.avg.util_avg + 1) * growth,
> +			rq->cfs.avg.util_avg + rq->avg_rt.util_avg + 1);
> +
> +	return growth_fixed;
> +}
> +
>  static void init_triggers(struct psi_group *group, u64 now)
>  {
>  	struct psi_trigger *t;
> @@ -658,6 +677,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
>  	}
>  
>  	if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
> +		delta = psi_memtime_fixup(delta);
>  		groupc->times[PSI_MEM_SOME] += delta;
>  		if (groupc->state_mask & (1 << PSI_MEM_FULL))
>  			groupc->times[PSI_MEM_FULL] += delta;
> @@ -928,8 +948,8 @@ void psi_memstall_leave(unsigned long *flags)
>  	 */
>  	rq = this_rq_lock_irq(&rf);
>  
> -	current->in_memstall = 0;
>  	psi_task_change(current, TSK_MEMSTALL, 0);
> +	current->in_memstall = 0;
>  
>  	rq_unlock_irq(rq, &rf);
>  }
> 

