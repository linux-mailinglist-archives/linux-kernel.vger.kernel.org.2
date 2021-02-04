Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD8130EA11
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 03:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhBDCUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 21:20:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12119 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbhBDCUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 21:20:53 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DWMfy4s4bz162ZX;
        Thu,  4 Feb 2021 10:18:50 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 10:20:06 +0800
Subject: Re: [PATCH 2/4] hugetlg: Break earlier in add_reservation_in_range()
 when we can
To:     Peter Xu <peterx@redhat.com>
CC:     Wei Zhang <wzam@amazon.com>, Matthew Wilcox <willy@infradead.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Gal Pressman" <galpress@amazon.com>,
        Christoph Hellwig <hch@lst.de>,
        "Andrea Arcangeli" <aarcange@redhat.com>, Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        David Gibson <david@gibson.dropbear.id.au>,
        "Mike Rapoport" <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20210203210832.113685-1-peterx@redhat.com>
 <20210203210832.113685-3-peterx@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <22c64602-db2f-de36-ea54-5701f109368e@huawei.com>
Date:   Thu, 4 Feb 2021 10:20:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210203210832.113685-3-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/2/4 5:08, Peter Xu wrote:
> All the regions maintained in hugetlb reserved map is inclusive on "from" but
> exclusive on "to".  We can break earlier even if rg->from==t because it already
> means no possible intersection.
> 
> This does not need a Fixes in all cases because when it happens (rg->from==t)
> we'll not break out of the loop while we should, however the next thing we'd do
> is still add the last file_region we'd need and quit the loop in the next
> round.  So this change is not a bugfix (since the old code should still run
> okay iiuc), but we'd better still touch it up to make it logically sane.
> 

I think the difference is when we handle the rg->from == t case. Previous one is in the loop, now below the
loop. But the result should be same.
Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d2859c2aecc9..9e6ea96bf33b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -377,7 +377,7 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>  		/* When we find a region that starts beyond our range, we've
>  		 * finished.
>  		 */
> -		if (rg->from > t)
> +		if (rg->from >= t)
>  			break;
>  
>  		/* Add an entry for last_accounted_offset -> rg->from, and
> 

