Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6954B37F3FB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhEMIXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:23:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:60862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231655AbhEMIXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:23:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B0966AEBB;
        Thu, 13 May 2021 08:22:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 53E6B1E1501; Thu, 13 May 2021 10:22:36 +0200 (CEST)
Date:   Thu, 13 May 2021 10:22:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chi Wu <wuchi.zero@gmail.com>
Cc:     akpm@linux-foundation.org, axboe@fb.com, hcochran@kernelspring.com,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mszeredi@redhat.com, sedat.dilek@gmail.com, tj@kernel.org
Subject: Re: [PATCH] mm/page-writeback: Use __this_cpu_inc() in
 account_page_dirtied()
Message-ID: <20210513082236.GD2734@quack2.suse.cz>
References: <20210512144742.4764-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512144742.4764-1-wuchi.zero@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-05-21 22:47:42, Chi Wu wrote:
> As account_page_dirtied() was always protected by xa_lock_irqsave(),
> so using __this_cpu_inc() is better.
> 
> Signed-off-by: Chi Wu <wuchi.zero@gmail.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 0062d5c57d41..e3901d0d329e 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2436,7 +2436,7 @@ void account_page_dirtied(struct page *page, struct address_space *mapping)
>  		inc_wb_stat(wb, WB_DIRTIED);
>  		task_io_account_write(PAGE_SIZE);
>  		current->nr_dirtied++;
> -		this_cpu_inc(bdp_ratelimits);
> +		__this_cpu_inc(bdp_ratelimits);
>  
>  		mem_cgroup_track_foreign_dirty(page, wb);
>  	}
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
