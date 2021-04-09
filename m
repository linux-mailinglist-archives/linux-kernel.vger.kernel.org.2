Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4E359260
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhDIDBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:01:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16058 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhDIDBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:01:47 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGjWT681rzPpHV;
        Fri,  9 Apr 2021 10:58:45 +0800 (CST)
Received: from [10.174.179.9] (10.174.179.9) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 11:01:28 +0800
Subject: Re: [PATCH 3/4] mm/hugeltb: fix potential wrong gbl_reserve value for
 hugetlb_acct_memory()
To:     Mike Kravetz <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <n-horiguchi@ah.jp.nec.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20210402093249.25137-1-linmiaohe@huawei.com>
 <20210402093249.25137-4-linmiaohe@huawei.com>
 <20afccd5-2bc4-9db9-695e-dd6175b0b42b@oracle.com>
 <1311fcfe-bc5f-e878-3912-ca9a9e0eed90@huawei.com>
 <ecd3e4c9-1add-c304-5f26-7e34e5e6494c@oracle.com>
 <ddec1fba-25ea-ebb3-fb87-41671db5cb92@huawei.com>
 <0ebaa062-80e8-b380-c02e-7eb72e67f973@huawei.com>
 <90188b1a-a206-5586-2da9-683f7537f960@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8dfe32a3-1789-6a40-b650-304c2cfb6531@huawei.com>
Date:   Fri, 9 Apr 2021 11:01:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <90188b1a-a206-5586-2da9-683f7537f960@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/9 6:53, Mike Kravetz wrote:
> On 4/7/21 8:26 PM, Miaohe Lin wrote:
>> On 2021/4/8 11:24, Miaohe Lin wrote:
>>> On 2021/4/8 4:53, Mike Kravetz wrote:
>>>> On 4/7/21 12:24 AM, Miaohe Lin wrote:
>>>>> Hi:
>>>>> On 2021/4/7 10:49, Mike Kravetz wrote:
>>>>>> On 4/2/21 2:32 AM, Miaohe Lin wrote:
>>>>>>> The resv_map could be NULL since this routine can be called in the evict
>>>>>>> inode path for all hugetlbfs inodes. So we could have chg = 0 and this
>>>>>>> would result in a negative value when chg - freed. This is unexpected for
>>>>>>> hugepage_subpool_put_pages() and hugetlb_acct_memory().
>>>>>>
>>>>>> I am not sure if this is possible.
>>>>>>
>>>>>> It is true that resv_map could be NULL.  However, I believe resv map
>>>>>> can only be NULL for inodes that are not regular or link inodes.  This
>>>>>> is the inode creation code in hugetlbfs_get_inode().
>>>>>>
>>>>>>        /*
>>>>>>          * Reserve maps are only needed for inodes that can have associated
>>>>>>          * page allocations.
>>>>>>          */
>>>>>>         if (S_ISREG(mode) || S_ISLNK(mode)) {
>>>>>>                 resv_map = resv_map_alloc();
>>>>>>                 if (!resv_map)
>>>>>>                         return NULL;
>>>>>>         }
>>>>>>
>>>>>
>>>>> Agree.
>>>>>
>>>>>> If resv_map is NULL, then no hugetlb pages can be allocated/associated
>>>>>> with the file.  As a result, remove_inode_hugepages will never find any
>>>>>> huge pages associated with the inode and the passed value 'freed' will
>>>>>> always be zero.
>>>>>>
>>>>>
>>>>> But I am confused now. AFAICS, remove_inode_hugepages() searches the address_space of
>>>>> the inode to remove the hugepages while does not care if inode has associated resv_map.
>>>>> How does it prevent hugetlb pages from being allocated/associated with the file if
>>>>> resv_map is NULL? Could you please explain this more?
>>>>>
>>>>
>>>> Recall that there are only two ways to get huge pages associated with
>>>> a hugetlbfs file: fallocate and mmap/write fault.  Directly writing to
>>>> hugetlbfs files is not supported.
>>>>
>>>> If you take a closer look at hugetlbfs_get_inode, it has that code to
>>>> allocate the resv map mentioned above as well as the following:
>>>>
>>>> 		switch (mode & S_IFMT) {
>>>> 		default:
>>>> 			init_special_inode(inode, mode, dev);
>>>> 			break;
>>>> 		case S_IFREG:
>>>> 			inode->i_op = &hugetlbfs_inode_operations;
>>>> 			inode->i_fop = &hugetlbfs_file_operations;
>>>> 			break;
>>>> 		case S_IFDIR:
>>>> 			inode->i_op = &hugetlbfs_dir_inode_operations;
>>>> 			inode->i_fop = &simple_dir_operations;
>>>>
>>>> 			/* directory inodes start off with i_nlink == 2 (for "." entry) */
>>>> 			inc_nlink(inode);
>>>> 			break;
>>>> 		case S_IFLNK:
>>>> 			inode->i_op = &page_symlink_inode_operations;
>>>> 			inode_nohighmem(inode);
>>>> 			break;
>>>> 		}
>>>>
>>>> Notice that only S_IFREG inodes will have i_fop == &hugetlbfs_file_operations.
>>>> hugetlbfs_file_operations contain the hugetlbfs specific mmap and fallocate
>>>> routines.  Hence, only files with S_IFREG inodes can potentially have
>>>> associated huge pages.  S_IFLNK inodes can as well via file linking.
>>>>
>>>> If an inode is not S_ISREG(mode) || S_ISLNK(mode), then it will not have
>>>> a resv_map.  In addition, it will not have hugetlbfs_file_operations and
>>>> can not have associated huge pages.
>>>>
>>>
>>> Many many thanks for detailed and patient explanation! :) I think I have got the idea!
>>>
>>>> I looked at this closely when adding commits
>>>> 58b6e5e8f1ad hugetlbfs: fix memory leak for resv_map
>>>> f27a5136f70a hugetlbfs: always use address space in inode for resv_map pointer
>>>>
>>>> I may not be remembering all of the details correctly.  Commit f27a5136f70a
>>>> added the comment that resv_map could be NULL to hugetlb_unreserve_pages.
>>>>
>>>
>>> Since we must have freed == 0 while chg == 0. Should we make this assumption explict
>>> by something like below?
>>>
>>> WARN_ON(chg < freed);
>>>
>>
>> Or just a comment to avoid confusion ?
>>
> 
> Yes, add a comment to hugetlb_unreserve_pages saying that !resv_map
> implies freed == 0.
> 

Sounds good!

> It would also be helpful to check for (chg - freed) == 0 and skip the
> calls to hugepage_subpool_put_pages() and hugetlb_acct_memory().  Both
> of those routines may perform an unnecessary lock/unlock cycle in this
> case.
> 
> A simple
> 	if (chg == free)
> 		return 0;
> before the call to hugepage_subpool_put_pages would work.

This may not be really helpful because hugepage_subpool_put_pages() and hugetlb_acct_memory()
both would handle delta == 0 case without unnecessary lock/unlock cycle.
Does this make sense for you? If so, I will prepare v2 with the changes to add a comment
to hugetlb_unreserve_pages() __without__ the check for (chg - freed) == 0.

Many thanks!
