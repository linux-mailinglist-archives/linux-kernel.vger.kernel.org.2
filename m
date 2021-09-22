Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95314414D37
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbhIVPjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:39:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:1118 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236400AbhIVPjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:39:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="284634130"
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; 
   d="scan'208";a="284634130"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 08:34:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; 
   d="scan'208";a="702297959"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga006.fm.intel.com with ESMTP; 22 Sep 2021 08:34:26 -0700
Date:   Wed, 22 Sep 2021 23:34:25 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mhocko@suse.com, rui.xiang@huawei.com
Subject: Re: [PATCH v2 1/1] mm: Fix the uninitialized use in
 overcommit_policy_handler
Message-ID: <20210922153425.GB68763@shbuild999.sh.intel.com>
References: <20210922014122.47219-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922014122.47219-1-chenjun102@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

On Wed, Sep 22, 2021 at 01:41:22AM +0000, Chen Jun wrote:
> An unexpected value of /proc/sys/vm/panic_on_oom we will get,
> after running the following program.
> 
> int main()
> {
>     int fd = open("/proc/sys/vm/panic_on_oom", O_RDWR)

should this be "/proc/sys/vm/overcommit_memory"

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
 
Other than the nit above, it looks good to me, thanks!

Reviewed-by: Feng Tang <feng.tang@intel.com>

> Fixes: 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to vm overcommit policy"
> Signed-off-by: Chen Jun <chenjun102@huawei.com>
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
> 
