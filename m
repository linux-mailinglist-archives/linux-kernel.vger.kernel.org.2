Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C20C367A32
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 08:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbhDVGvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 02:51:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16488 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbhDVGvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:51:43 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FQp0r2Rqxzrdwb;
        Thu, 22 Apr 2021 14:48:44 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 22 Apr
 2021 14:51:04 +0800
Subject: Re: [PATCH] f2fs: compress: remove unneed check condition
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20210421083941.66371-1-yuchao0@huawei.com>
 <YID1sqemJVeBcdqD@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2c6f17e6-ef23-f313-5df2-6bd63d7df2b1@huawei.com>
Date:   Thu, 22 Apr 2021 14:51:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YID1sqemJVeBcdqD@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/22 12:04, Jaegeuk Kim wrote:
> On 04/21, Chao Yu wrote:
>> In only call path of __cluster_may_compress(), __f2fs_write_data_pages()
>> has checked SBI_POR_DOING condition, and also cluster_may_compress()
>> has checked CP_ERROR_FLAG condition, so remove redundant check condition
>> in __cluster_may_compress() for cleanup.
> 
> I think cp_error can get any time without synchronization. Is it safe to say
> it's redundant?

Yes,

But no matter how late we check cp_error, cp_error can happen after our
check points, it won't cause regression if we remove cp_error check there,
because for compress write, it uses OPU, it won't overwrite any existed data
in device.

Seems it will be more appropriate to check cp_error in
f2fs_write_compressed_pages() like we did in f2fs_write_single_data_page()
rather than in __cluster_may_compress().

BTW, shouldn't we rename __cluster_may_compress() to
cluster_beyond_filesize() for better readability?

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/compress.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index 3c9d797dbdd6..532c311e3a89 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -906,11 +906,6 @@ static bool __cluster_may_compress(struct compress_ctx *cc)
>>   
>>   		f2fs_bug_on(sbi, !page);
>>   
>> -		if (unlikely(f2fs_cp_error(sbi)))
>> -			return false;
>> -		if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>> -			return false;
>> -
>>   		/* beyond EOF */
>>   		if (page->index >= nr_pages)
>>   			return false;
>> -- 
>> 2.29.2
> .
> 
