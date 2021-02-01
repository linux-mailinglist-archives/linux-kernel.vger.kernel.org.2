Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF594309FF8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 02:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhBABYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 20:24:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11221 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhBABXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 20:23:10 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DTVWQ38TDzlDTM;
        Mon,  1 Feb 2021 09:20:50 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Feb 2021 09:22:21 +0800
Subject: Re: [PATCH] hugetlbfs: show pagesize in unit of GB if possible
To:     David Rientjes <rientjes@google.com>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210130090339.4378-1-linmiaohe@huawei.com>
 <f5ac7d57-6653-aae-f119-b87d72acf192@google.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <24ab70d6-1d23-d118-f1e7-473f01615dcc@huawei.com>
Date:   Mon, 1 Feb 2021 09:22:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f5ac7d57-6653-aae-f119-b87d72acf192@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/1/31 6:07, David Rientjes wrote:
> On Sat, 30 Jan 2021, Miaohe Lin wrote:
> 
>> Hugepage size in unit of GB is supported. We could show pagesize in unit of
>> GB to make it more friendly to read. Also rework the calculation code of
>> page size unit to make it more readable.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  fs/hugetlbfs/inode.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index 3a08fbae3b53..40a9795f250a 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -1014,11 +1014,15 @@ static int hugetlbfs_show_options(struct seq_file *m, struct dentry *root)
>>  	if (sbinfo->max_inodes != -1)
>>  		seq_printf(m, ",nr_inodes=%lu", sbinfo->max_inodes);
>>  
>> -	hpage_size /= 1024;
>> -	mod = 'K';
>> -	if (hpage_size >= 1024) {
>> -		hpage_size /= 1024;
>> +	if (hpage_size >= SZ_1G) {
>> +		hpage_size /= SZ_1G;
>> +		mod = 'G';
>> +	} else if (hpage_size >= SZ_1M) {
>> +		hpage_size /= SZ_1M;
>>  		mod = 'M';
>> +	} else {
>> +		hpage_size /= SZ_1K;
>> +		mod = 'K';
>>  	}
>>  	seq_printf(m, ",pagesize=%lu%c", hpage_size, mod);
>>  	if (spool) {
> 
> NACK, this can break existing userspace parsing.
> .
> 

I see. I should take care of this. Many thanks.
