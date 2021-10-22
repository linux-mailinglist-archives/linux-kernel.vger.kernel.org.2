Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D7C4379F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhJVPel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232384AbhJVPeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:34:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DCEC6054E;
        Fri, 22 Oct 2021 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634916740;
        bh=dsX++Uq9HxwTDlQDY7ato4NKF0kNAEUBDapYaqRA0mI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lQWW/kv4bYwG2eiGsk3PVYg9jXIMXMKfD1qt40pxIisJzhuO9iPyELNTcPrDIMU//
         ECQ8d9i3TlKupqDUH+GCtLlcdYYrJcWNhBfitlIYYJBJ0roxybxflXr43fn+G2i7pf
         jfqsWwqGSzJTco7W/4iE4hQ+VOp97sdF9Ww+kWi91vm3wjzGQxZxZ2KHmfujNLKQvy
         1Ns3wrxF5xFusbkj8TBUOzXWxc+Gaeq5Gy10uLTThbfYTY100ke9UKU1GnUj4Yv3Z5
         1jXHMi96uF3jATU7SHVhhs3zNKBkHktLInR0tgccjaxATjTSJAE2+KQ35nBtAM4MKk
         gBaue/wr7AXcw==
Message-ID: <3ddb4013-8d63-7c00-6fdd-1f21752bd60c@kernel.org>
Date:   Fri, 22 Oct 2021 23:32:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove circular locking between
 sb_internal and fs_reclaim
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
References: <20211014190503.717830-1-daeho43@gmail.com>
 <e8b106fb-2878-2fa9-788f-965eef179a85@kernel.org>
 <CACOAw_yupuz+Xx-z9V0UaExuARHd8H9rruWCa2yj5-mgkeuUtQ@mail.gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_yupuz+Xx-z9V0UaExuARHd8H9rruWCa2yj5-mgkeuUtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/10/22 0:44, Daeho Jeong wrote:
> There is a deadlock between sb_internal lock (sb_start_intwrite()) and
> dquot related lock.
> It's because we call f2fs_truncate(), which eventually calls
> dquot_initialize(), while holding sb_internal lock.
> So, I called dquot_initialize() in advance to make the 2nd calling of
> it in f2fs_truncate() ineffective.
> This is similar with the thing in f2fs_evict_inode() in inode.c

Well, if dquot_initialize() fails in f2fs_drop_inode(), will we still run
into deadlock?

Thanks,

> 
> Thanks,
> 
> On Thu, Oct 21, 2021 at 5:11 AM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2021/10/15 3:05, Daeho Jeong wrote:
>>> From: Daeho Jeong <daehojeong@google.com>
>>>
>>> We detected the below circular locking dependency between sb_internal
>>> and fs_reclaim. So, removed it by calling dquot_initialize() before
>>> sb_start_intwrite().
>>>
>>>    ======================================================
>>>    WARNING: possible circular locking dependency detected
>>>    ------------------------------------------------------
>>>    kswapd0/133 is trying to acquire lock:
>>> ffffff80d5fb9680 (sb_internal#2){.+.+}-{0:0}, at: evict+0xd4/0x2f8
>>>
>>> but task is already holding lock:
>>> ffffffda597c93a8 (fs_reclaim){+.+.}-{0:0}, at:
>>> __fs_reclaim_acquire+0x4/0x50
>>>
>>> which lock already depends on the new lock.
>>> ...
>>> other info that might help us debug this:
>>>
>>>    Chain exists of:
>>>
>>> sb_internal#2 --> &s->s_dquot.dqio_sem --> fs_reclaim
>>>
>>>     Possible unsafe locking scenario:
>>>
>>>           CPU0                    CPU1
>>>           ----                    ----
>>>      lock(fs_reclaim);
>>>                                   lock(&s->s_dquot.dqio_sem);
>>>                                   lock(fs_reclaim);
>>>      lock(sb_internal#2);
>>
>> Sorry, I still didn't get the root cause of this deadlock issue, could
>> you please explain more about this?
>>
>> And why calling dquot_initialize() in drop_inode() could break the
>> circular locking dependency?
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>> ---
>>>    fs/f2fs/super.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 86eeb019cc52..a133932333c5 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -1370,6 +1370,8 @@ static int f2fs_drop_inode(struct inode *inode)
>>>                        /* should remain fi->extent_tree for writepage */
>>>                        f2fs_destroy_extent_node(inode);
>>>
>>> +                     dquot_initialize(inode);
>>> +
>>>                        sb_start_intwrite(inode->i_sb);
>>>                        f2fs_i_size_write(inode, 0);
>>>
>>>
