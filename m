Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F175630BB8A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhBBJ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:56:24 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12381 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhBBJzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:55:43 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DVKrk0ncgz7dgL;
        Tue,  2 Feb 2021 17:53:42 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 2 Feb 2021
 17:54:55 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: rename checkpoint=merge mount option
 to checkpoint_merge
To:     Daeho Jeong <daeho43@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <kernel-team@android.com>, Daeho Jeong <daehojeong@google.com>
References: <20210202092332.2562006-1-daeho43@gmail.com>
 <a7adaf99-0df1-cf4a-a60a-d47a104f51aa@huawei.com>
 <CACOAw_wmodtCvDRa_1hh2=u9AP3Qg6VBGG4K1by9QJNGweApVA@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <938ce080-d211-0834-64b4-fd4836a26d5a@huawei.com>
Date:   Tue, 2 Feb 2021 17:54:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_wmodtCvDRa_1hh2=u9AP3Qg6VBGG4K1by9QJNGweApVA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/2 17:44, Daeho Jeong wrote:
> When we remount it without the "checkpoint_merge" option, shouldn't we
> need to clear "MERGE_CHECKPOINT" again?
> This is actually what I intended, but I was wrong. Actually, I found this.
> 
> When we remount the filesystem, the previous mount option is passed
> through the "data" argument in the below.
> f2fs_remount(struct super_block *sb, int *flags, char *data)
> 
> If we don't provide the "nocheckpoint_merge" option, how can we turn
> off the "checkpoint_merge" option which is turned on in the previous
> mount?

We can use "mount -o remount /dev/xxx /mnt" to disable checkpoint_merge,
since that command won't pass old mount options to remount?

Quoted from man mount:

               mount -o remount,rw /dev/foo /dir

               After  this  call  all  old  mount options are replaced and arbitrary stuff from fstab (or mtab) is ignored, except the loop= option which is internally generated and maintained by the
               mount command.

               mount -o remount,rw  /dir

               After this call mount reads fstab and merges these options with the options from the command line (-o). If no mountpoint found in fstab than remount with unspecified source is allowed.

Thanks,

> 
> 2021년 2월 2일 (화) 오후 6:28, Chao Yu <yuchao0@huawei.com>님이 작성:
>>
>> On 2021/2/2 17:23, Daeho Jeong wrote:
>>> From: Daeho Jeong <daehojeong@google.com>
>>>
>>> As checkpoint=merge comes in, mount option setting related to checkpoint
>>> had been mixed up and it became hard to understand. So, I separated
>>> this option from "checkpoint=" and made another mount option
>>> "checkpoint_merge" for this.
>>>
>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>> ---
>>> v2: renamed "checkpoint=merge" to "checkpoint_merge"
>>> v3: removed "nocheckpoint_merge" option
>>> ---
>>>    Documentation/filesystems/f2fs.rst |  6 +++---
>>>    fs/f2fs/super.c                    | 21 +++++++++------------
>>>    2 files changed, 12 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
>>> index d0ead45dc706..475994ed8b15 100644
>>> --- a/Documentation/filesystems/f2fs.rst
>>> +++ b/Documentation/filesystems/f2fs.rst
>>> @@ -247,9 +247,9 @@ checkpoint=%s[:%u[%]]      Set to "disable" to turn off checkpointing. Set to "enabl
>>>                         hide up to all remaining free space. The actual space that
>>>                         would be unusable can be viewed at /sys/fs/f2fs/<disk>/unusable
>>>                         This space is reclaimed once checkpoint=enable.
>>> -                      Here is another option "merge", which creates a kernel daemon
>>> -                      and makes it to merge concurrent checkpoint requests as much
>>> -                      as possible to eliminate redundant checkpoint issues. Plus,
>>> +checkpoint_merge      When checkpoint is enabled, this can be used to create a kernel
>>> +                      daemon and make it to merge concurrent checkpoint requests as
>>> +                      much as possible to eliminate redundant checkpoint issues. Plus,
>>>                         we can eliminate the sluggish issue caused by slow checkpoint
>>>                         operation when the checkpoint is done in a process context in
>>>                         a cgroup having low i/o budget and cpu shares. To make this
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 56696f6cfa86..b60dcef7f9d0 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -215,7 +215,7 @@ static match_table_t f2fs_tokens = {
>>>        {Opt_checkpoint_disable_cap, "checkpoint=disable:%u"},
>>>        {Opt_checkpoint_disable_cap_perc, "checkpoint=disable:%u%%"},
>>>        {Opt_checkpoint_enable, "checkpoint=enable"},
>>> -     {Opt_checkpoint_merge, "checkpoint=merge"},
>>> +     {Opt_checkpoint_merge, "checkpoint_merge"},
>>>        {Opt_compress_algorithm, "compress_algorithm=%s"},
>>>        {Opt_compress_log_size, "compress_log_size=%u"},
>>>        {Opt_compress_extension, "compress_extension=%s"},
>>> @@ -1142,12 +1142,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>>                return -EINVAL;
>>>        }
>>>
>>> -     if (test_opt(sbi, DISABLE_CHECKPOINT) &&
>>> -                     test_opt(sbi, MERGE_CHECKPOINT)) {
>>> -             f2fs_err(sbi, "checkpoint=merge cannot be used with checkpoint=disable\n");
>>> -             return -EINVAL;
>>> -     }
>>> -
>>>        /* Not pass down write hints if the number of active logs is lesser
>>>         * than NR_CURSEG_PERSIST_TYPE.
>>>         */
>>> @@ -1782,7 +1776,7 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>>>                seq_printf(seq, ",checkpoint=disable:%u",
>>>                                F2FS_OPTION(sbi).unusable_cap);
>>>        if (test_opt(sbi, MERGE_CHECKPOINT))
>>> -             seq_puts(seq, ",checkpoint=merge");
>>> +             seq_puts(seq, ",checkpoint_merge");
>>>        if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_POSIX)
>>>                seq_printf(seq, ",fsync_mode=%s", "posix");
>>>        else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
>>> @@ -1827,6 +1821,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>>>        sbi->sb->s_flags |= SB_LAZYTIME;
>>>        set_opt(sbi, FLUSH_MERGE);
>>>        set_opt(sbi, DISCARD);
>>> +     clear_opt(sbi, MERGE_CHECKPOINT);
>>
>> It's not needed here?
>>
>> Thanks,
>>
>>>        if (f2fs_sb_has_blkzoned(sbi))
>>>                F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
>>>        else
>>> @@ -2066,9 +2061,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>                }
>>>        }
>>>
>>> -     if (!test_opt(sbi, MERGE_CHECKPOINT)) {
>>> -             f2fs_stop_ckpt_thread(sbi);
>>> -     } else {
>>> +     if (!test_opt(sbi, DISABLE_CHECKPOINT) &&
>>> +                     test_opt(sbi, MERGE_CHECKPOINT)) {
>>>                err = f2fs_start_ckpt_thread(sbi);
>>>                if (err) {
>>>                        f2fs_err(sbi,
>>> @@ -2076,6 +2070,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>                            err);
>>>                        goto restore_gc;
>>>                }
>>> +     } else {
>>> +             f2fs_stop_ckpt_thread(sbi);
>>>        }
>>>
>>>        /*
>>> @@ -3831,7 +3827,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>
>>>        /* setup checkpoint request control and start checkpoint issue thread */
>>>        f2fs_init_ckpt_req_control(sbi);
>>> -     if (test_opt(sbi, MERGE_CHECKPOINT)) {
>>> +     if (!test_opt(sbi, DISABLE_CHECKPOINT) &&
>>> +                     test_opt(sbi, MERGE_CHECKPOINT)) {
>>>                err = f2fs_start_ckpt_thread(sbi);
>>>                if (err) {
>>>                        f2fs_err(sbi,
>>>
> .
> 
