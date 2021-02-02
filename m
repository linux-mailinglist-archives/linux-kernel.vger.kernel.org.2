Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A2B30B4B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhBBB3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:29:51 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11999 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhBBB3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:29:50 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DV6cz40snzjHj1;
        Tue,  2 Feb 2021 09:27:47 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 2 Feb 2021
 09:28:59 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix checkpoint mount option wrong
 combination
To:     Daeho Jeong <daeho43@gmail.com>, Chao Yu <chao@kernel.org>
CC:     Daeho Jeong <daehojeong@google.com>, <kernel-team@android.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210201000606.2206740-1-daeho43@gmail.com>
 <7e2f440e-6500-04c8-1115-880754a18efa@kernel.org>
 <CACOAw_zW+xnN7pBmTknuJ1=CGiAvVq0sQhe7D6X8sOjgjF_qeg@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a98a7866-3e57-e480-9405-4002de0ec4ad@huawei.com>
Date:   Tue, 2 Feb 2021 09:28:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_zW+xnN7pBmTknuJ1=CGiAvVq0sQhe7D6X8sOjgjF_qeg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/1 21:11, Daeho Jeong wrote:
> Actually, I think we need to select one among them, disable, enable
> and merge. I realized my previous understanding about that was wrong.

Actually,
1. chekcpoint=enable/disable decide whether we will allow checkpoint
2. checkpoint=merge or not decide how we issue checkpoint

They are different, we should not only select only one of them, the
combination of them is allowed.

Thanks,

> In that case of "checkpoint=merge,checkpoint=enable", the last option
> will override the ones before that.
> This is how the other mount options like fsync_mode, whint_mode and etc.
> So, the answer will be "checkpoint=enable". What do you think?
> 
> 
> 
> 2021년 2월 1일 (월) 오후 9:40, Chao Yu <chao@kernel.org>님이 작성:
>>
>> On 2021/2/1 8:06, Daeho Jeong wrote:
>>> From: Daeho Jeong <daehojeong@google.com>
>>>
>>> As checkpoint=merge comes in, mount option setting related to
>>> checkpoint had been mixed up. Fixed it.
>>>
>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>> ---
>>>    fs/f2fs/super.c | 11 +++++------
>>>    1 file changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 56696f6cfa86..8231c888c772 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -930,20 +930,25 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>>                                return -EINVAL;
>>>                        F2FS_OPTION(sbi).unusable_cap_perc = arg;
>>>                        set_opt(sbi, DISABLE_CHECKPOINT);
>>> +                     clear_opt(sbi, MERGE_CHECKPOINT);
>>>                        break;
>>>                case Opt_checkpoint_disable_cap:
>>>                        if (args->from && match_int(args, &arg))
>>>                                return -EINVAL;
>>>                        F2FS_OPTION(sbi).unusable_cap = arg;
>>>                        set_opt(sbi, DISABLE_CHECKPOINT);
>>> +                     clear_opt(sbi, MERGE_CHECKPOINT);
>>>                        break;
>>>                case Opt_checkpoint_disable:
>>>                        set_opt(sbi, DISABLE_CHECKPOINT);
>>> +                     clear_opt(sbi, MERGE_CHECKPOINT);
>>>                        break;
>>>                case Opt_checkpoint_enable:
>>>                        clear_opt(sbi, DISABLE_CHECKPOINT);
>>> +                     clear_opt(sbi, MERGE_CHECKPOINT);
>>
>> What if: -o checkpoint=merge,checkpoint=enable
>>
>> Can you please explain the rule of merge/disable/enable combination and their
>> result? e.g.
>> checkpoint=merge,checkpoint=enable
>> checkpoint=enable,checkpoint=merge
>> checkpoint=merge,checkpoint=disable
>> checkpoint=disable,checkpoint=merge
>>
>> If the rule/result is clear, it should be documented.
>>
>> Thanks,
>>
>>
>>>                        break;
>>>                case Opt_checkpoint_merge:
>>> +                     clear_opt(sbi, DISABLE_CHECKPOINT);
>>>                        set_opt(sbi, MERGE_CHECKPOINT);
>>>                        break;
>>>    #ifdef CONFIG_F2FS_FS_COMPRESSION
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
>>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
