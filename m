Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99666379C24
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhEKBip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:38:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2762 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhEKBio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:38:44 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfL7F0tbgzmftL;
        Tue, 11 May 2021 09:34:17 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 11 May
 2021 09:37:35 +0800
Subject: Re: [PATCH 1/3] f2fs: compress: fix to call f2fs_put_dnode() paired
 with f2fs_get_block()
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20210510093032.35466-1-yuchao0@huawei.com>
 <YJlWaOSZNLkdGNnQ@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b45c381e-45e7-037d-c71c-77c73fdaae8a@huawei.com>
Date:   Tue, 11 May 2021 09:37:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YJlWaOSZNLkdGNnQ@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/10 23:51, Jaegeuk Kim wrote:
> On 05/10, Chao Yu wrote:
>> f2fs_get_block() and f2fs_put_dnode() should be called as a pair,
>> add missing f2fs_put_dnode() in prepare_compress_overwrite().
>>
>> Fixes: 4c8ff7095bef ("f2fs: support data compression")
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/compress.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index c208563eac28..d5cb0ba9a0e1 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -1088,6 +1088,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>>   
>>   		for (i = cc->cluster_size - 1; i > 0; i--) {
>>   			ret = f2fs_get_block(&dn, start_idx + i);
>> +			f2fs_put_dnode(&dn);
> 
> f2fs_reserve_block()
>   -> need_put = true;
>    -> f2fs_put_dnode();

Correct, it looks f2fs_vm_page_mkwrite() doesn't need to call
f2fs_put_dnode() as well.

Thanks,

> 
>>   			if (ret) {
>>   				i = cc->cluster_size;
>>   				break;
>> -- 
>> 2.29.2
> .
> 
