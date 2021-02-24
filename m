Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C2232387A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhBXIVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:21:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:35838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231830AbhBXIU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:20:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49C62AFB5;
        Wed, 24 Feb 2021 08:20:17 +0000 (UTC)
Date:   Wed, 24 Feb 2021 09:20:14 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: document the new location of page subpool
 pointer
Message-ID: <20210224082000.GA14793@linux>
References: <20210223180820.ee39f1544f2630d0eecf3a57@linux-foundation.org>
 <20210224040439.351882-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224040439.351882-1-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 08:04:39PM -0800, Mike Kravetz wrote:
> Expand comments, no functional change.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks

> ---
>  include/linux/hugetlb.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index cccd1aab69dd..c0467a7a1fe0 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -476,6 +476,9 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   * huegtlb page specific state flags.  These flags are located in page.private
>   * of the hugetlb head page.  Functions created via the below macros should be
>   * used to manipulate these flags.
> + * Note: The hugetlb page subpool pointer previously located at page.private
> + * was moved to page[1].private to make room for flags in the head page.  See
> + * hugetlb_page_subpool().
>   *
>   * HPG_restore_reserve - Set when a hugetlb page consumes a reservation at
>   *	allocation time.  Cleared when page is fully instantiated.  Free
> -- 
> 2.29.2
> 
> 

-- 
Oscar Salvador
SUSE L3
