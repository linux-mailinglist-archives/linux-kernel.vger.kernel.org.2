Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA1B444FC2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 08:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhKDHpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 03:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhKDHpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 03:45:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB7B760E9C;
        Thu,  4 Nov 2021 07:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636011752;
        bh=f9b2147ZcHEg3YBYAtLQt1FHe0MReor1ntRmgB/y1F4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XSZ56pUy8PqqHGHqO8nGyi6AscjF07tkYejwXc8sVnsLVrz/9kjiC/rOWXm0awIku
         lADyOnpsRB8GgjiXws7hmBNqEWhCTKMQ/a8ReUHG5e3mbB705vGTsLyfok6/vunxNY
         1ePDfK7BcDFTd8eClnSC42i3wS23v2yMfciwYelW4xkrwBdIiKUnpuC8Q2+zZ1dWnS
         90g74D8reJQ5Vtmg4RiWg/XI0OphPMGiveJzZgPsranRlzmA5/zKyyjm+Ry2XanwMu
         qpy5hhTmEhy8S+hGdd+HWb4fWtbpuJhGUCyRkaG0s8uh0kTT+Z8MVEqhgEWjVLuTUY
         dLTXMCKVfEzQA==
Message-ID: <e2870f1b-14dd-bd8a-b997-0ab1e7110ef8@kernel.org>
Date:   Thu, 4 Nov 2021 15:42:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] fs: f2fs: fix UAF in f2fs_available_free_memory
Content-Language: en-US
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211103142228.1235864-1-mudongliangabcd@gmail.com>
 <bff77e5c-7e14-32c5-6ffe-78e35271532b@kernel.org>
 <CAD-N9QVq4Lc3gEe8yZw3bBWo3Yzf=K_+KXDratJp=oyXhS_gPg@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <CAD-N9QVq4Lc3gEe8yZw3bBWo3Yzf=K_+KXDratJp=oyXhS_gPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/11/4 15:35, Dongliang Mu wrote:
> On Thu, Nov 4, 2021 at 3:16 PM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2021/11/3 22:22, Dongliang Mu wrote:
>>> f2fs_fill_super
>>> -> f2fs_build_segment_manager
>>>      -> create_discard_cmd_control
>>>         -> f2fs_start_discard_thread
>>>
>>> It invokes kthread_run to create a thread and run issue_discard_thread.
>>>
>>> However, if f2fs_build_node_manager fails, the control flow goes to
>>> free_nm and calls f2fs_destroy_node_manager. This function will free
>>> sbi->nm_info. However, if issue_discard_thread accesses sbi->nm_info
>>> after the deallocation, but before the f2fs_stop_discard_thread, it will
>>> cause UAF(Use-after-free).
>>>
>>> -> f2fs_destroy_segment_manager
>>>      -> destroy_discard_cmd_control
>>>         -> f2fs_stop_discard_thread
>>>
>>> Fix this by switching the order of f2fs_build_segment_manager
>>> and f2fs_build_node_manager.
>>>
>>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
>>> ---
>>>    fs/f2fs/super.c | 16 ++++++++--------
>>>    1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 78ebc306ee2b..1a23b64cfb74 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -4135,18 +4135,18 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>        }
>>>
>>>        /* setup f2fs internal modules */
>>> -     err = f2fs_build_segment_manager(sbi);
>>> -     if (err) {
>>> -             f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)",
>>> -                      err);
>>> -             goto free_sm;
>>> -     }
>>>        err = f2fs_build_node_manager(sbi);
>>>        if (err) {
>>>                f2fs_err(sbi, "Failed to initialize F2FS node manager (%d)",
>>>                         err);
>>>                goto free_nm;
>>>        }
>>> +     err = f2fs_build_segment_manager(sbi);
>>> +     if (err) {
>>> +             f2fs_err(sbi, "Failed to initialize F2FS segment manager (%d)",
>>> +                      err);
>>> +             goto free_sm;
>>> +     }
>>>
>>>        /* For write statistics */
>>>        sbi->sectors_written_start = f2fs_get_sectors_written(sbi);
>>> @@ -4351,10 +4351,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>        sbi->node_inode = NULL;
>>>    free_stats:
>>>        f2fs_destroy_stats(sbi);
>>> -free_nm:
>>> -     f2fs_destroy_node_manager(sbi);
>>>    free_sm:
>>>        f2fs_destroy_segment_manager(sbi);
>>> +free_nm:
>>> +     f2fs_destroy_node_manager(sbi);
>>
>> IIRC, above two functions shouldn't not be called reversely due to some
>> resource dependency, Jaegeuk, please help to confirm this.
>>
>> So I suggest to call destroy_discard_cmd_control() before
>> f2fs_destroy_node_manager(), is it fine to you?
> 
> Maybe f2fs_stop_discard_thread is better than
> destroy_discard_cmd_control. It only stops the kthread, leading to
> fewer side effects.

Fine to me. :)

Thanks,

> 
> How do you think?
> 
>>
>> Thanks,
>>
>>>        f2fs_destroy_post_read_wq(sbi);
>>>    stop_ckpt_thread:
>>>        f2fs_stop_ckpt_thread(sbi);
>>>
