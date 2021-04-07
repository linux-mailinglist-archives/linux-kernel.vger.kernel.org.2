Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1980835652B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349419AbhDGHYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:24:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15154 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346608AbhDGHYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:24:52 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FFbS42fqxzpVVd;
        Wed,  7 Apr 2021 15:21:56 +0800 (CST)
Received: from [10.174.179.9] (10.174.179.9) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 15:24:39 +0800
Subject: Re: [PATCH 3/4] mm/hugeltb: fix potential wrong gbl_reserve value for
 hugetlb_acct_memory()
To:     Mike Kravetz <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <n-horiguchi@ah.jp.nec.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210402093249.25137-1-linmiaohe@huawei.com>
 <20210402093249.25137-4-linmiaohe@huawei.com>
 <20afccd5-2bc4-9db9-695e-dd6175b0b42b@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1311fcfe-bc5f-e878-3912-ca9a9e0eed90@huawei.com>
Date:   Wed, 7 Apr 2021 15:24:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20afccd5-2bc4-9db9-695e-dd6175b0b42b@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/4/7 10:49, Mike Kravetz wrote:
> On 4/2/21 2:32 AM, Miaohe Lin wrote:
>> The resv_map could be NULL since this routine can be called in the evict
>> inode path for all hugetlbfs inodes. So we could have chg = 0 and this
>> would result in a negative value when chg - freed. This is unexpected for
>> hugepage_subpool_put_pages() and hugetlb_acct_memory().
> 
> I am not sure if this is possible.
> 
> It is true that resv_map could be NULL.  However, I believe resv map
> can only be NULL for inodes that are not regular or link inodes.  This
> is the inode creation code in hugetlbfs_get_inode().
> 
>        /*
>          * Reserve maps are only needed for inodes that can have associated
>          * page allocations.
>          */
>         if (S_ISREG(mode) || S_ISLNK(mode)) {
>                 resv_map = resv_map_alloc();
>                 if (!resv_map)
>                         return NULL;
>         }
> 

Agree.

> If resv_map is NULL, then no hugetlb pages can be allocated/associated
> with the file.  As a result, remove_inode_hugepages will never find any
> huge pages associated with the inode and the passed value 'freed' will
> always be zero.
> 

But I am confused now. AFAICS, remove_inode_hugepages() searches the address_space of
the inode to remove the hugepages while does not care if inode has associated resv_map.
How does it prevent hugetlb pages from being allocated/associated with the file if
resv_map is NULL? Could you please explain this more?

Many thanks.

> Does that sound correct?
>
