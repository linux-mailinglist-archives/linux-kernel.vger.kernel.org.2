Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66493332C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 02:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhCJBbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 20:31:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13898 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhCJBbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 20:31:04 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DwDyR1PCfzkWSn;
        Wed, 10 Mar 2021 09:29:35 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 10 Mar
 2021 09:31:01 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add sysfs nodes to get accumulated
 compression info
To:     Daeho Jeong <daeho43@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <kernel-team@android.com>, Daeho Jeong <daehojeong@google.com>
References: <20210305022402.2721974-1-daeho43@gmail.com>
 <2f2abc41-24d5-6795-44fe-b770ed8514df@huawei.com>
 <CACOAw_woQGgTy_hTfdcFufA7VG3cBVSN9vSD5bubvTeo+3wxsg@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <203c1945-9d48-098e-fa8f-1c86b1086ae3@huawei.com>
Date:   Wed, 10 Mar 2021 09:31:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_woQGgTy_hTfdcFufA7VG3cBVSN9vSD5bubvTeo+3wxsg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/9 21:00, Daeho Jeong wrote:
> 2021년 3월 9일 (화) 오후 6:22, Chao Yu <yuchao0@huawei.com>님이 작성:
>>
>> On 2021/3/5 10:24, Daeho Jeong wrote:
>>> From: Daeho Jeong <daehojeong@google.com>
>>>
>>> Added acc_compr_inodes to show accumulated compressed inode count and
>>> acc_compr_blocks to show accumulated secured block count with
>>
>> I noticed that these stat numbers are recorded in extra reserved area in
>> hot node curseg journal, the journal will be persisted only for umount
>> or fastboot checkpoint, so the numbers are not so accurate... does this
>> satisfy your requirement?
>>
> 
> Yes, we are satisfied with just getting rough number of them. But, it

Alright,

> would be better if you suggest more accurate way. :)

I think this is the cheapest way to store rough number, otherwise it needs to change
f2fs_checkpoint structure layout or add a new inner inode to persist these stat
numbers if we want more accurate one.

> 
>>> compression in sysfs. These can be re-initialized to "0" by writing "0"
>>> value in one of both.
>>
>> Why do we allow reset the stat numbers?
>>
> 
> Actually, I want to have a way to clear any stale number of them, but
> I agree we don't need this.
> 
>> Why not covering all code with macro CONFIG_F2FS_FS_COMPRESSION, since these
>> numbers are only be updated when we enable compression.
>>
> 
> I wanted to keep the info even in the kernel with doesn't support
> per-file compression if those had been written once. What do you
> think?

Sure, if so it's fine to me. :)

Thanks,

> 
>> Thanks,
> .
> 
