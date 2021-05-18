Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79774386E83
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 02:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbhERAxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 20:53:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4716 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbhERAxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 20:53:42 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fkcnf1R8QzmhFY;
        Tue, 18 May 2021 08:48:54 +0800 (CST)
Received: from dggemx753-chm.china.huawei.com (10.0.44.37) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 08:52:22 +0800
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 18 May 2021 08:52:21 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: add MODULE_SOFTDEP to ensure crc32c is
 included in the initramfs
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <jaegeuk@kernel.org>, marcosfrm <marcosfrm@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210517011557.21722-1-yuchao0@huawei.com>
 <YKKnkSag35cDXh0Z@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <be1af58d-fc5b-fab8-3be3-f90012c201f0@huawei.com>
Date:   Tue, 18 May 2021 08:51:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YKKnkSag35cDXh0Z@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggemx702-chm.china.huawei.com (10.1.199.49) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/18 1:27, Eric Biggers wrote:
> On Mon, May 17, 2021 at 09:15:57AM +0800, Chao Yu wrote:
>> As marcosfrm reported in bugzilla:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=213089
>>
>> Initramfs generators rely on "pre" softdeps (and "depends") to include
>> additional required modules.
>>
>> F2FS does not declare "pre: crc32" softdep. Then every generator (dracut,
>> mkinitcpio...) has to maintain a hardcoded list for this purpose.
>>
>> Hence let's use MODULE_SOFTDEP("pre: crc32") in f2fs code.
>>
>> Fixes: 43b6573bac95 ("f2fs: use cryptoapi crc32 functions")
>> Reported-by: marcosfrm <marcosfrm@gmail.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/super.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 3f8a7a6c250c..fa0ce6301c16 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -4431,4 +4431,5 @@ module_exit(exit_f2fs_fs)
>>   MODULE_AUTHOR("Samsung Electronics's Praesto Team");
>>   MODULE_DESCRIPTION("Flash Friendly File System");
>>   MODULE_LICENSE("GPL");
>> +MODULE_SOFTDEP("pre: crc32c");
> 
> Shouldn't it be crc32, not crc32c?

Thanks for the review, will fix.

Thanks,

> 
> - Eric
> .
> 
