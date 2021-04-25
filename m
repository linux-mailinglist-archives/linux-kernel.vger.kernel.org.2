Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43E436A3EE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 03:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhDYB3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 21:29:13 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3407 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhDYB3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 21:29:10 -0400
Received: from dggemx753-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FSVhL3mf4z5tWv;
        Sun, 25 Apr 2021 09:25:22 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sun, 25 Apr 2021 09:28:26 +0800
Subject: Re: [PATCH] f2fs: compress: remove unneed check condition
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20210421083941.66371-1-yuchao0@huawei.com>
 <YID1sqemJVeBcdqD@google.com>
 <2c6f17e6-ef23-f313-5df2-6bd63d7df2b1@huawei.com>
 <YIS8KHf9VPxZl85b@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <5d7de7c7-5cc5-c342-3652-ab904b3e43b2@huawei.com>
Date:   Sun, 25 Apr 2021 09:28:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YIS8KHf9VPxZl85b@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/25 8:47, Jaegeuk Kim wrote:
> On 04/22, Chao Yu wrote:
>> On 2021/4/22 12:04, Jaegeuk Kim wrote:
>>> On 04/21, Chao Yu wrote:
>>>> In only call path of __cluster_may_compress(), __f2fs_write_data_pages()
>>>> has checked SBI_POR_DOING condition, and also cluster_may_compress()
>>>> has checked CP_ERROR_FLAG condition, so remove redundant check condition
>>>> in __cluster_may_compress() for cleanup.
>>>
>>> I think cp_error can get any time without synchronization. Is it safe to say
>>> it's redundant?
>>
>> Yes,
>>
>> But no matter how late we check cp_error, cp_error can happen after our
>> check points, it won't cause regression if we remove cp_error check there,
>> because for compress write, it uses OPU, it won't overwrite any existed data
>> in device.
>>
>> Seems it will be more appropriate to check cp_error in
>> f2fs_write_compressed_pages() like we did in f2fs_write_single_data_page()
>> rather than in __cluster_may_compress().
>>
>> BTW, shouldn't we rename __cluster_may_compress() to
>> cluster_beyond_filesize() for better readability?
> 
> f2fs_cluster_has_data()?

Maybe cluster_has_invalid_data()? which indicates there is invalid data
beyond filesize.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>    fs/f2fs/compress.c | 5 -----
>>>>    1 file changed, 5 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>>>> index 3c9d797dbdd6..532c311e3a89 100644
>>>> --- a/fs/f2fs/compress.c
>>>> +++ b/fs/f2fs/compress.c
>>>> @@ -906,11 +906,6 @@ static bool __cluster_may_compress(struct compress_ctx *cc)
>>>>    		f2fs_bug_on(sbi, !page);
>>>> -		if (unlikely(f2fs_cp_error(sbi)))
>>>> -			return false;
>>>> -		if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>>>> -			return false;
>>>> -
>>>>    		/* beyond EOF */
>>>>    		if (page->index >= nr_pages)
>>>>    			return false;
>>>> -- 
>>>> 2.29.2
>>> .
>>>
> .
> 
