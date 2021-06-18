Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36643AC082
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 03:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhFRBWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 21:22:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4961 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhFRBWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 21:22:46 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G5gyF1XH7z6yLJ;
        Fri, 18 Jun 2021 09:17:25 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 09:20:36 +0800
Received: from [127.0.0.1] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 09:20:35 +0800
Subject: Re: [PATCH 1/1] quota: remove unnecessary oom message
To:     Jan Kara <jack@suse.cz>
CC:     Jan Kara <jack@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210617091627.1653-1-thunder.leizhen@huawei.com>
 <20210617150116.GG32587@quack2.suse.cz>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e56de5db-9b76-6d24-68c9-0acb3776c9e8@huawei.com>
Date:   Fri, 18 Jun 2021 09:20:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210617150116.GG32587@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/17 23:01, Jan Kara wrote:
> On Thu 17-06-21 17:16:27, Zhen Lei wrote:
>> Fixes scripts/checkpatch.pl warning:
>> WARNING: Possible unnecessary 'out of memory' message
>>
>> Remove it can help us save a bit of memory.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> I agree the message is pointless. But when doing this, I guess we can just
> get rid of getdqbuf() altogether and instead call kmalloc() directly in all
> the places.

OK, I will get rid of it in v2.

> 
> 								Honza
> 
>> diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
>> index c5562c871c8b..b097d02bad94 100644
>> --- a/fs/quota/quota_tree.c
>> +++ b/fs/quota/quota_tree.c
>> @@ -49,11 +49,7 @@ static int qtree_dqstr_in_blk(struct qtree_mem_dqinfo *info)
>>  
>>  static char *getdqbuf(size_t size)
>>  {
>> -	char *buf = kmalloc(size, GFP_NOFS);
>> -	if (!buf)
>> -		printk(KERN_WARNING
>> -		       "VFS: Not enough memory for quota buffers.\n");
>> -	return buf;
>> +	return kmalloc(size, GFP_NOFS);
>>  }
>>  
>>  static ssize_t read_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
>> -- 
>> 2.25.1
>>
>>

