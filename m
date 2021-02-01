Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FB330A65E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhBALUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:20:33 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11994 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhBALUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:20:25 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DTlmv1FpLzjHQ8;
        Mon,  1 Feb 2021 19:18:23 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Feb 2021 19:19:39 +0800
Subject: Re: [PATCH] hugetlbfs: rework calculation code of Hugepage size in
 hugetlbfs_show_options()
To:     David Hildenbrand <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
References: <20210201082325.33875-1-linmiaohe@huawei.com>
 <2bb70cac-b8ef-cdbe-fa4e-db6229587e98@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <bf9d1db9-5f4e-4a1d-8389-c53ca63acfc1@huawei.com>
Date:   Mon, 1 Feb 2021 19:19:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2bb70cac-b8ef-cdbe-fa4e-db6229587e98@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/2/1 18:56, David Hildenbrand wrote:
> On 01.02.21 09:23, Miaohe Lin wrote:
>> Rework calculation code of the Hugepage size to make it more readable and
>> straightforward.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   fs/hugetlbfs/inode.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index 3a08fbae3b53..1be18de4b537 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -1014,11 +1014,12 @@ static int hugetlbfs_show_options(struct seq_file *m, struct dentry *root)
>>       if (sbinfo->max_inodes != -1)
>>           seq_printf(m, ",nr_inodes=%lu", sbinfo->max_inodes);
>>   -    hpage_size /= 1024;
>> -    mod = 'K';
>> -    if (hpage_size >= 1024) {
>> -        hpage_size /= 1024;
>> +    if (hpage_size >= SZ_1M) {
>> +        hpage_size /= SZ_1M;
>>           mod = 'M';
>> +    } else {
>> +        hpage_size /= SZ_1K;
>> +        mod = 'K';
>>       }
>>       seq_printf(m, ",pagesize=%lu%c", hpage_size, mod);
>>       if (spool) {
>>
> 
> Looks correct but I am not convinced the old code was that complicated to understand.
> 

The old code is not complicated but I think it may be better to use macro instead of well-known "magic number".
Many thanks for review.:)
