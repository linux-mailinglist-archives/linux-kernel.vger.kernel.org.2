Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD3B39E707
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhFGTDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:03:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37964 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhFGTDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:03:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 456B91FD2D;
        Mon,  7 Jun 2021 19:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623092486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8+oQUFe+s0sTQ/Yh3GnwEeSe6epzHODQN4kobR5NKoM=;
        b=PtSfcbLaJobgDU1tP/2wFu7YNxsk2YOzI/uOGup4JIzfb0R/ZjmlB/XkPFCwBpDpnsOvWt
        X3c2eMG7yAfkZzffHvUq9l2NzvUMRCrV2eL/ply7WiG59Xb8X1RqGPmbMSNRF9gO0xbG+G
        Ztz/mdbgL6RNJ44Pv3a+OMOooQ48Yig=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 12E86A3BBF;
        Mon,  7 Jun 2021 19:01:26 +0000 (UTC)
Date:   Mon, 7 Jun 2021 21:01:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        llong@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
Message-ID: <YL5tBQ3utMzUkHF3@dhcp22.suse.cz>
References: <20210607163103.632681-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607163103.632681-1-atomlin@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-06-21 17:31:03, Aaron Tomlin wrote:
> At the present time, in the context of memcg OOM, even when
> sysctl_oom_kill_allocating_task is enabled/or set, the "allocating"
> task cannot be selected, as a target for the OOM killer.
> 
> This patch removes the restriction entirely.

This is a global oom policy not a memcg specific one so a historical
behavior would change. So I do not think we can change that. The policy
can be implemented on the memcg level but this would require a much more
detailed explanation of the usecase and the semantic (e.g. wrt.
hierarchical behavior etc).
 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  mm/oom_kill.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index eefd3f5fde46..3bae33e2d9c2 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1089,9 +1089,9 @@ bool out_of_memory(struct oom_control *oc)
>  		oc->nodemask = NULL;
>  	check_panic_on_oom(oc);
>  
> -	if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
> -	    current->mm && !oom_unkillable_task(current) &&
> -	    oom_cpuset_eligible(current, oc) &&
> +	if (sysctl_oom_kill_allocating_task && current->mm &&
> +            !oom_unkillable_task(current) &&
> +            oom_cpuset_eligible(current, oc) &&
>  	    current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
>  		get_task_struct(current);
>  		oc->chosen = current;
> -- 
> 2.26.3

-- 
Michal Hocko
SUSE Labs
