Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960B333AD46
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhCOIWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:22:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:52450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhCOIWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:22:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615796528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TVXDS4PNaIbYmQB548Zv6jzVSO7USa2Bb9Hywj+/n68=;
        b=FmdPycGOFiDVovjmElF/zwLetRYgcpx4VNpb32W2+8eZS5yqu/opRu5k65sr0jKSqvyteh
        /CYv5nUrVI2XtWdps9Djxtqx2ZC0ygLjeTODrlQZcqpfLQ3VhekszctaQM0V3/HX2/nwwa
        EIsWY3gW5jjJDyxWOFDdv4fIUa/Ykzo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7896ACA8;
        Mon, 15 Mar 2021 08:22:08 +0000 (UTC)
Date:   Mon, 15 Mar 2021 09:22:07 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jiang Biao <benbjiang@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, robinlai@tencent.com,
        benbjiang@tencent.com
Subject: Re: [PATCH] mm/oom_kill: fix wild pointer in out_of_memory
Message-ID: <YE8ZL8VTllD5RLOf@dhcp22.suse.cz>
References: <20210313042300.3833-1-benbjiang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313042300.3833-1-benbjiang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 13-03-21 12:23:00, Jiang Biao wrote:
> From: Bin Lai <robinlai@tencent.com>
> 
> From: Bin Lai <robinlai@tencent.com>
> 
> The oc->chosen is used by oom implementation, and the caller does
> not initialize this variable. If the tasks of memcg are all unkillable,
> oom_evaluate_task cann't choose any task, and the oc->chosen will be
> a wild pointer. So we should initialize oc->chosen before calling
> oom_evaluate_task.

All callers do initialize oom_control on the stack and even partial
structure initialization on stack will result in the zeroying of all
other structure's element. So I do not think there is any problem.

> 
> Signed-off-by: Bin Lai <robinlai@tencent.com>
> Reviewed-by: Jiang Biao <benbjiang@tencent.com>
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 9efaf43..0658a30 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -366,6 +366,7 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>  static void select_bad_process(struct oom_control *oc)
>  {
>  	oc->chosen_points = LONG_MIN;
> +	oc->chosen = NULL;
>  
>  	if (is_memcg_oom(oc))
>  		mem_cgroup_scan_tasks(oc->memcg, oom_evaluate_task, oc);
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
