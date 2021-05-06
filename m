Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19752374D57
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 04:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhEFCQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 22:16:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:18356 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhEFCQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 22:16:51 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FbHF5303Pzlby9;
        Thu,  6 May 2021 10:13:45 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 6 May 2021
 10:15:50 +0800
Subject: Re: [PATCH v2] f2fs: compress: remove unneed check condition
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20210427030730.90331-1-yuchao0@huawei.com>
 <YJFdUEmYFba8sEKJ@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e6ac0f5d-61ba-3525-10b9-db2db9549464@huawei.com>
Date:   Thu, 6 May 2021 10:15:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YJFdUEmYFba8sEKJ@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/4 22:42, Jaegeuk Kim wrote:
> Hi Chao,
> 
> I split this into two patches along with upstreamed change.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev-test

Jaegeuk, it's better, thanks, :)

Thanks,

> 
> Thanks,
> 
> On 04/27, Chao Yu wrote:
>> This patch changes as below:
>> - remove unneeded check condition in __cluster_may_compress()
>> - rename __cluster_may_compress() to cluster_has_invalid_data() for
>> better readability
>> - add cp_error check in f2fs_write_compressed_pages() like we did
>> in f2fs_write_single_data_page()
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v2:
>> - rename function for better readability
>> - add cp_error check in f2fs_write_compressed_pages()
>>   fs/f2fs/compress.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index 6e46a00c1930..53f78befed8f 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -888,9 +888,8 @@ bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index)
>>   	return is_page_in_cluster(cc, index);
>>   }
>>   
>> -static bool __cluster_may_compress(struct compress_ctx *cc)
>> +static bool cluster_has_invalid_data(struct compress_ctx *cc)
>>   {
>> -	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
>>   	loff_t i_size = i_size_read(cc->inode);
>>   	unsigned nr_pages = DIV_ROUND_UP(i_size, PAGE_SIZE);
>>   	int i;
>> @@ -898,18 +897,13 @@ static bool __cluster_may_compress(struct compress_ctx *cc)
>>   	for (i = 0; i < cc->cluster_size; i++) {
>>   		struct page *page = cc->rpages[i];
>>   
>> -		f2fs_bug_on(sbi, !page);
>> -
>> -		if (unlikely(f2fs_cp_error(sbi)))
>> -			return false;
>> -		if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>> -			return false;
>> +		f2fs_bug_on(F2FS_I_SB(cc->inode), !page);
>>   
>>   		/* beyond EOF */
>>   		if (page->index >= nr_pages)
>> -			return false;
>> +			return true;
>>   	}
>> -	return true;
>> +	return false;
>>   }
>>   
>>   static int __f2fs_cluster_blocks(struct compress_ctx *cc, bool compr)
>> @@ -985,7 +979,7 @@ static bool cluster_may_compress(struct compress_ctx *cc)
>>   		return false;
>>   	if (unlikely(f2fs_cp_error(F2FS_I_SB(cc->inode))))
>>   		return false;
>> -	return __cluster_may_compress(cc);
>> +	return !cluster_has_invalid_data(cc);
>>   }
>>   
>>   static void set_cluster_writeback(struct compress_ctx *cc)
>> @@ -1232,6 +1226,12 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>>   	loff_t psize;
>>   	int i, err;
>>   
>> +	/* we should bypass data pages to proceed the kworkder jobs */
>> +	if (unlikely(f2fs_cp_error(sbi))) {
>> +		mapping_set_error(cc->rpages[0]->mapping, -EIO);
>> +		goto out_free;
>> +	}
>> +
>>   	if (IS_NOQUOTA(inode)) {
>>   		/*
>>   		 * We need to wait for node_write to avoid block allocation during
>> -- 
>> 2.29.2
> .
> 
