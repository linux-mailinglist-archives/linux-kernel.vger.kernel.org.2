Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811DC4143DE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 10:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhIVIgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 04:36:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43268 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbhIVIgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:36:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A6EDB22283;
        Wed, 22 Sep 2021 08:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632299712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CUIfUFXAE8nIx3z28JFV6Lwfo6OmUKmXPd+3c/HjPN8=;
        b=NL5Z9fZaT5y6wQ3jeGCoGamMV6OwX+DhRydn7ASV97N6GjB7TNGRXMD9jH9Q5fsEdMcpof
        oSceAibAOmaZfTHR7wOtl8tOTK78TJIv6/nsVfmas3Brm5J/kHnu9XfOw73TZxNCXE+Jg6
        k2Mcj2lMvudW3/GdrNnTih0Nj2roogM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 776EDA3B81;
        Wed, 22 Sep 2021 08:35:12 +0000 (UTC)
Date:   Wed, 22 Sep 2021 10:35:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, feng.tang@intel.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 1/1] mm: Fix the uninitialized use in
 overcommit_policy_handler
Message-ID: <YUrqwAiPkQCRQlr2@dhcp22.suse.cz>
References: <20210922014122.47219-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922014122.47219-1-chenjun102@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-09-21 01:41:22, Chen Jun wrote:
> An unexpected value of /proc/sys/vm/panic_on_oom we will get,
> after running the following program.
> 
> int main()
> {
>     int fd = open("/proc/sys/vm/panic_on_oom", O_RDWR)
>     write(fd, "1", 1);
>     write(fd, "2", 1);
>     close(fd);
> }
> 
> write(fd, "2", 1) will pass *ppos = 1 to proc_dointvec_minmax.
> proc_dointvec_minmax will return 0 without setting new_policy.
> 
> t.data = &new_policy;
> ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos)
>       -->do_proc_dointvec
>          -->__do_proc_dointvec
>               if (write) {
>                 if (proc_first_pos_non_zero_ignore(ppos, table))
>                   goto out;
> 
> sysctl_overcommit_memory = new_policy;
> 
> so sysctl_overcommit_memory will be set to an uninitialized value.
> 
> Check whether new_policy has been changed by proc_dointvec_minmax.
> 
> Fixes: 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to vm overcommit policy"
> Signed-off-by: Chen Jun <chenjun102@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Btw. you could also check for new_policy == sysctl_overcommit_memory so
that the sync of pcp counters is not fired without the policy change.
Something for a separate patch I guess.

> ---
> 
> v2:
>   * Check whether new_policy has been changed by proc_dointvec_minmax.
> 
>  mm/util.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 4ddb6e186dd5..d5be67771850 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -756,7 +756,7 @@ int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
>  		size_t *lenp, loff_t *ppos)
>  {
>  	struct ctl_table t;
> -	int new_policy;
> +	int new_policy = -1;
>  	int ret;
>  
>  	/*
> @@ -774,7 +774,7 @@ int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
>  		t = *table;
>  		t.data = &new_policy;
>  		ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
> -		if (ret)
> +		if (ret || new_policy == -1)
>  			return ret;
>  
>  		mm_compute_batch(new_policy);
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
