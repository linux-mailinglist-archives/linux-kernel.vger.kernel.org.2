Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FC93591B1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 03:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhDIBwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 21:52:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16055 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbhDIBwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:52:44 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGgzp6QGszPpL3;
        Fri,  9 Apr 2021 09:49:42 +0800 (CST)
Received: from [10.67.109.150] (10.67.109.150) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 09:52:20 +0800
Subject: Re: [PATCH -next] nilfs2: Fix typos in comments
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
CC:     James Morris <jamorris@linux.microsoft.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Xiang Yang <xiangyang3@huawei.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Cui GaoSheng <cuigaosheng1@huawei.com>,
        Gong Ruiqi <gongruiqi1@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>
References: <20210408140824.62010-1-lujialin4@huawei.com>
 <CAKFNMo=T_Key8jLqW_Q5mp4u7q7jymW=rqey9uDheFyaxMg1Tg@mail.gmail.com>
From:   "lujialin (A)" <lujialin4@huawei.com>
Message-ID: <ce9287d3-d2e6-4633-5c64-8480abe41ac4@huawei.com>
Date:   Fri, 9 Apr 2021 09:52:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAKFNMo=T_Key8jLqW_Q5mp4u7q7jymW=rqey9uDheFyaxMg1Tg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.150]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing, I will exclude it in v2 patch and send out later.

在 2021/4/8 23:35, Ryusuke Konishi 写道:
> Hi,
>
> This patch partially overlaps the following fix that I previously sent to
> Andrew:
>
>    https://lkml.org/lkml/2021/4/8/114
>
> Can you exclude two typo fixes of "retured -> returned" from yours ?
>
> Thanks,
> Ryusuke Konishi
>
> On Thu, Apr 8, 2021 at 11:08 PM Lu Jialin <lujialin4@huawei.com> wrote:
>> numer -> number in fs/nilfs2/cpfile.c and fs/nilfs2/segment.c
>> retured -> returned and Decription -> Description in fs/nilfs2/ioctl.c
>> isntance -> instance in fs/nilfs2/the_nilfs.c
>> No functionality changed.
>>
>> Signed-off-by: Lu Jialin <lujialin4@huawei.com>
>> ---
>>   fs/nilfs2/cpfile.c    | 2 +-
>>   fs/nilfs2/ioctl.c     | 6 +++---
>>   fs/nilfs2/segment.c   | 4 ++--
>>   fs/nilfs2/the_nilfs.c | 2 +-
>>   4 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
>> index 025fb082575a..ce144776b4ef 100644
>> --- a/fs/nilfs2/cpfile.c
>> +++ b/fs/nilfs2/cpfile.c
>> @@ -293,7 +293,7 @@ void nilfs_cpfile_put_checkpoint(struct inode *cpfile, __u64 cno,
>>    * nilfs_cpfile_delete_checkpoints - delete checkpoints
>>    * @cpfile: inode of checkpoint file
>>    * @start: start checkpoint number
>> - * @end: end checkpoint numer
>> + * @end: end checkpoint number
>>    *
>>    * Description: nilfs_cpfile_delete_checkpoints() deletes the checkpoints in
>>    * the period from @start to @end, excluding @end itself. The checkpoints
>> diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
>> index b053b40315bf..cbb59a6c4b81 100644
>> --- a/fs/nilfs2/ioctl.c
>> +++ b/fs/nilfs2/ioctl.c
>> @@ -979,7 +979,7 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
>>    * and metadata are written out to the device when it successfully
>>    * returned.
>>    *
>> - * Return Value: On success, 0 is retured. On errors, one of the following
>> + * Return Value: On success, 0 is returned. On errors, one of the following
>>    * negative error code is returned.
>>    *
>>    * %-EROFS - Read only filesystem.
>> @@ -1058,7 +1058,7 @@ static int nilfs_ioctl_resize(struct inode *inode, struct file *filp,
>>    * @inode: inode object
>>    * @argp: pointer on argument from userspace
>>    *
>> - * Decription: nilfs_ioctl_trim_fs is the FITRIM ioctl handle function. It
>> + * Description: nilfs_ioctl_trim_fs is the FITRIM ioctl handle function. It
>>    * checks the arguments from userspace and calls nilfs_sufile_trim_fs, which
>>    * performs the actual trim operation.
>>    *
>> @@ -1100,7 +1100,7 @@ static int nilfs_ioctl_trim_fs(struct inode *inode, void __user *argp)
>>    * @inode: inode object
>>    * @argp: pointer on argument from userspace
>>    *
>> - * Decription: nilfs_ioctl_set_alloc_range() function defines lower limit
>> + * Description: nilfs_ioctl_set_alloc_range() function defines lower limit
>>    * of segments in bytes and upper limit of segments in bytes.
>>    * The NILFS_IOCTL_SET_ALLOC_RANGE is used by nilfs_resize utility.
>>    *
>> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
>> index cd4da9535aed..686c8ee7b29c 100644
>> --- a/fs/nilfs2/segment.c
>> +++ b/fs/nilfs2/segment.c
>> @@ -2214,7 +2214,7 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
>>    * nilfs_construct_segment - construct a logical segment
>>    * @sb: super block
>>    *
>> - * Return Value: On success, 0 is retured. On errors, one of the following
>> + * Return Value: On success, 0 is returned. On errors, one of the following
>>    * negative error code is returned.
>>    *
>>    * %-EROFS - Read only filesystem.
>> @@ -2251,7 +2251,7 @@ int nilfs_construct_segment(struct super_block *sb)
>>    * @start: start byte offset
>>    * @end: end byte offset (inclusive)
>>    *
>> - * Return Value: On success, 0 is retured. On errors, one of the following
>> + * Return Value: On success, 0 is returned. On errors, one of the following
>>    * negative error code is returned.
>>    *
>>    * %-EROFS - Read only filesystem.
>> diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
>> index 221a1cc597f0..8b7b01a380ce 100644
>> --- a/fs/nilfs2/the_nilfs.c
>> +++ b/fs/nilfs2/the_nilfs.c
>> @@ -195,7 +195,7 @@ static int nilfs_store_log_cursor(struct the_nilfs *nilfs,
>>   /**
>>    * load_nilfs - load and recover the nilfs
>>    * @nilfs: the_nilfs structure to be released
>> - * @sb: super block isntance used to recover past segment
>> + * @sb: super block instance used to recover past segment
>>    *
>>    * load_nilfs() searches and load the latest super root,
>>    * attaches the last segment, and does recovery if needed.
>> --
>> 2.17.1
>>
> .
