Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F21530B9EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhBBIax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:30:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12100 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhBBIav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:30:51 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DVHyn4Kycz162v0;
        Tue,  2 Feb 2021 16:28:49 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 2 Feb 2021
 16:30:03 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: rename checkpoint=merge mount option
 to checkpoint_merge
To:     Daeho Jeong <daeho43@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <kernel-team@android.com>, Daeho Jeong <daehojeong@google.com>
References: <20210202051829.2127214-1-daeho43@gmail.com>
 <ef27f0cc-87b6-cea1-31a6-f2837d6a673c@huawei.com>
 <CACOAw_wGY1CNXZ9QoLB1t0800Wyjv1_P9iuqk4SOKjT-oUQamw@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <6f1e4639-3715-d855-951d-7c0a67fa9913@huawei.com>
Date:   Tue, 2 Feb 2021 16:30:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_wGY1CNXZ9QoLB1t0800Wyjv1_P9iuqk4SOKjT-oUQamw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/2 16:02, Daeho Jeong wrote:
> I chose the same step with "flush_merge", because it doesn't have
> "noflush_merge".

Oh, "noxxx" option was added only when we set the option by default in
default_options(), when user want to disable the default option, it
needs to use "noxxx" option, and then we will show this "noxxx" option
string to user via show_options() to indicate that "noxxx" option is
working now.

Anyway I think we should fix to show "noflush_merge" option because we
have set flush_merge by default.

> Do you think we need that for both, "noflush_merge" and "nocheckpoint_merge"?

For "nocheckpoint_merge", we can introduce this option only when we want
to set "checkpoint_merge" by default.

Here is the example from noinline_data:

Commit 75342797988 ("f2fs: enable inline data by default")

Thanks,

> 
> I thought we needed to give some time to make this be turned on by
> default. It might be a little radical. :)
> 
> What do you think?
> 
> 2021년 2월 2일 (화) 오후 4:40, Chao Yu <yuchao0@huawei.com>님이 작성:
>>
>> On 2021/2/2 13:18, Daeho Jeong wrote:
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
>>> ---
>>>    Documentation/filesystems/f2fs.rst |  6 +++---
>>>    fs/f2fs/super.c                    | 26 ++++++++++++++------------
>>>    2 files changed, 17 insertions(+), 15 deletions(-)
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
>>> index 56696f6cfa86..d8603e6c4916 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -145,6 +145,7 @@ enum {
>>>        Opt_checkpoint_disable_cap_perc,
>>>        Opt_checkpoint_enable,
>>>        Opt_checkpoint_merge,
>>> +     Opt_nocheckpoint_merge,
>>>        Opt_compress_algorithm,
>>>        Opt_compress_log_size,
>>>        Opt_compress_extension,
>>> @@ -215,7 +216,8 @@ static match_table_t f2fs_tokens = {
>>>        {Opt_checkpoint_disable_cap, "checkpoint=disable:%u"},
>>>        {Opt_checkpoint_disable_cap_perc, "checkpoint=disable:%u%%"},
>>>        {Opt_checkpoint_enable, "checkpoint=enable"},
>>> -     {Opt_checkpoint_merge, "checkpoint=merge"},
>>> +     {Opt_checkpoint_merge, "checkpoint_merge"},
>>> +     {Opt_nocheckpoint_merge, "nocheckpoint_merge"},
>>>        {Opt_compress_algorithm, "compress_algorithm=%s"},
>>>        {Opt_compress_log_size, "compress_log_size=%u"},
>>>        {Opt_compress_extension, "compress_extension=%s"},
>>> @@ -946,6 +948,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>>                case Opt_checkpoint_merge:
>>>                        set_opt(sbi, MERGE_CHECKPOINT);
>>>                        break;
>>> +             case Opt_nocheckpoint_merge:
>>> +                     clear_opt(sbi, MERGE_CHECKPOINT);
>>> +                     break;
>>>    #ifdef CONFIG_F2FS_FS_COMPRESSION
>>>                case Opt_compress_algorithm:
>>>                        if (!f2fs_sb_has_compression(sbi)) {
>>> @@ -1142,12 +1147,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
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
>>> @@ -1782,7 +1781,7 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>>>                seq_printf(seq, ",checkpoint=disable:%u",
>>>                                F2FS_OPTION(sbi).unusable_cap);
>>>        if (test_opt(sbi, MERGE_CHECKPOINT))
>>> -             seq_puts(seq, ",checkpoint=merge");
>>> +             seq_puts(seq, ",checkpoint_merge");
>>
>> Other noxxx options will be shown in show_options(), how about following them?
>>
>>>        if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_POSIX)
>>>                seq_printf(seq, ",fsync_mode=%s", "posix");
>>>        else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
>>> @@ -1827,6 +1826,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>>>        sbi->sb->s_flags |= SB_LAZYTIME;
>>>        set_opt(sbi, FLUSH_MERGE);
>>>        set_opt(sbi, DISCARD);
>>> +     clear_opt(sbi, MERGE_CHECKPOINT);
>>
>> Why should we clear checkpoint_merge option in default_options()?
>>
>> Thanks,
>>
>>>        if (f2fs_sb_has_blkzoned(sbi))
>>>                F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
>>>        else
>>> @@ -2066,9 +2066,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
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
>>> @@ -2076,6 +2075,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>                            err);
>>>                        goto restore_gc;
>>>                }
>>> +     } else {
>>> +             f2fs_stop_ckpt_thread(sbi);
>>>        }
>>>
>>>        /*
>>> @@ -3831,7 +3832,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
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
