Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D62370096
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 20:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhD3SfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 14:35:18 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:33399 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhD3SfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:35:17 -0400
Received: by mail-io1-f70.google.com with SMTP id z25-20020a6be2190000b02904095fa9518eso9556994ioc.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 11:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=za1NmX+Z+ChlarhNCaXhfZGYx5D/vXt1Y3UJ8u28MUg=;
        b=PqyUQURVl3HaM/cBwVFLzGld44jwYI+Mkr3Amfi+O4yp+aYRMiqOMHG606M/5fb9qj
         XnWbT1LifRmOUrrlo8Af3MpSIe5d+RgbM1oge+fwjnSdmWF3eA27gSPtFLzSby+1tKgK
         Sr12OepIlGNeJavInzvHEfwbAVwpw4xpm4SuxjVAVg6bDtRtWtzs6ipZLZTsOQybl2k4
         KLrqAHcZT1llpXqGp/2xOOUGol/ihGjZ2NLJyFllz1bkmPij1XXTB2H8nmE/2dAdwyCN
         9i7dykLAhNnS1m8xVh5i23JzDorBN0bDrBQ/C/pkwXV9fchvT1TuCYctq2CrgMzc70/X
         UJHA==
X-Gm-Message-State: AOAM532sTqSVubR3Ej8BQuL0wJBQa+6MDqqGxV5vOUFfQDlg7kWr4/c9
        rUnAR148lPBQ0dsZhWDlhiImjvi2gw/8LQ6mUyXF6r5AyfGo
X-Google-Smtp-Source: ABdhPJxxYj0KVcw2r+IB3kDa2IJLth21P/Fq7raY/a+aUN006hxo6zk5TX+n86rPAx/u7FfXPX1pHy+P6fC8yybXGAZ155uUJHaM
MIME-Version: 1.0
X-Received: by 2002:a92:a301:: with SMTP id a1mr5010723ili.41.1619807668369;
 Fri, 30 Apr 2021 11:34:28 -0700 (PDT)
Date:   Fri, 30 Apr 2021 11:34:28 -0700
In-Reply-To: <d350afac-eef2-c33f-e435-fe0ec7ffd1cf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad7f5805c134dc31@google.com>
Subject: Re: INFO: task hung in io_uring_cancel_sqpoll
From:   syzbot <syzbot+11bf59db879676f59e52@syzkaller.appspotmail.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, oswalpalash@gmail.com,
        syzkaller-upstream-moderation@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 4/30/21 4:02 PM, Palash Oswal wrote:
>> On Fri, Apr 30, 2021 at 8:03 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>
>>> On 4/30/21 3:21 PM, Palash Oswal wrote:
>>>> On Thursday, March 18, 2021 at 9:40:21 PM UTC+5:30 syzbot wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> syzbot found the following issue on:
>>>>>
>>>>> HEAD commit: 0d7588ab riscv: process: Fix no prototype for arch_dup_tas..
>>>>> git tree: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=12dde5aed00000
>>>>> kernel config: https://syzkaller.appspot.com/x/.config?x=81c0b708b31626cc
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=11bf59db879676f59e52
>>>>> userspace arch: riscv64
>>>>> CC: [asml.s...@gmail.com ax...@kernel.dk io-u...@vger.kernel.org linux-...@vger.kernel.org]
>>>>>
>>>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
>>> There was so many fixes in 5.12 after this revision, including sqpoll
>>> cancellation related... Can you try something more up-to-date? Like
>>> released 5.12 or for-next
>>>
>> 
>> The reproducer works for 5.12.
>> 
>> I tested against the HEAD b1ef997bec4d5cf251bfb5e47f7b04afa49bcdfe
>> commit on for-next tree
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/?h=for-next
>> and the reproducer fails.
>
> Can't reproduce. Does it hang as in the original's report dmesg?
> Can you paste logs?
>
> #syz test: git://git.kernel.dk/linux-block io_uring-5.13

This crash does not have a reproducer. I cannot test it.

>
> -- 
> Pavel Begunkov
