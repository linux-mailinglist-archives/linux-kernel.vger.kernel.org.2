Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA70349406
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhCYO2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhCYO1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:27:51 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959E9C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:27:49 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id f12so1761067qtq.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vub3FyDqXWgkhOmEu+as5HBA+YA2teT/pmWmTlyX8ek=;
        b=UR6nKQuknpUDYKw+9GL1TQ6V0aBcB5SLTyllLONu6EeBBmwETxPQsVtQ1RRXfECFiA
         5cI7K7y14iZRI8Rju+LuuUxtRn6VdBjLkjeboDB/msZx6iVNGbV7sLH5AH8MGe4w0BnE
         47HwSudw4G4pCB7/1NxFVfpl6uHHJZuLXnO5nlPGixzd/2p+dwbqPbYoJNzKrnzhOPxH
         1lPTqF7nprChmdtq55rS9TzYju4/jw1nknz+pBS1uO/rPqpcrxHUUVeTAyTKrUZugjqV
         P43w6uQjUR3JMgc7YengJzQsEQsFQ9eOdPV3A2AQsjdoYItt0CVa2YFc1BJrRdtluzCL
         ZOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vub3FyDqXWgkhOmEu+as5HBA+YA2teT/pmWmTlyX8ek=;
        b=sVH8SRPmd1iTPEF57yADYTadijSDMFulYUpoJM3FigzUoOZevPfkquustBP3eEMble
         7pzkq2h4+3QXDxVgeCdHmSaYlTwXKFI8jBXGS21E4FGRCPP6On1qhMAEw8M4FgAzQJue
         fS+lFexevpgRioIGkav9gHbqhs5EYSnbGNwL5E33fm+O1Xs5JTZIFj+7N8CsJ5mqtAUd
         Ey1q+bnhyzmry3alx8eE0Usp7hThgOtoigNSesFMpjCzRBHN+4ohsgCiL/KFKj2umIlu
         3mRTvSKqlHLqAOCDtn8a+s5DgYDh3uoKcDyA8tfS9FZJQ+qJdMs10w1tYEkjk3J/C3we
         Vuvg==
X-Gm-Message-State: AOAM5334ozXkQiXvAZAeBedA7aND7JYlzzpev/DmoDeUbFf0Ffp0+u7J
        kJ3luzH044w/dc/bhVe8cVBac64vSa2DZMXyPtVewQ==
X-Google-Smtp-Source: ABdhPJywjV7M8/CGhAWYPWA5Szy63A3yInmeCFIGj0oHtGEzjY4Wrm8myD2pm0Cb2c7ymlSwn1ejh5WMKFtuIYrulYY=
X-Received: by 2002:ac8:4558:: with SMTP id z24mr7815145qtn.66.1616682468592;
 Thu, 25 Mar 2021 07:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAOA8r4HeDfreXFFjxw53VPcDAB=BTwT_qEzuqPAq+0gBKU-nRA@mail.gmail.com>
 <000000000000d3eafe05bd2fbd51@google.com> <b0e69e38-f037-4823-a12b-82680c9494den@googlegroups.com>
In-Reply-To: <b0e69e38-f037-4823-a12b-82680c9494den@googlegroups.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 25 Mar 2021 15:27:36 +0100
Message-ID: <CACT4Y+afrr5xhSCSgwnzNXSOx9BwebXfwWzxqKj4qA6+55q-kg@mail.gmail.com>
Subject: Re: [syzbot] memory leak in drm_vma_node_allow
To:     Igor Torrente <igormtorrente@gmail.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 2:31 PM Igor Torrente <igormtorrente@gmail.com> wrote:
>
> Hello,
>
> Anyone can inform if there any special Qemu configuration or another thing necessary to reproduce this issue and drm_client_buffer_vunmap?
>
> I generated three different .c (-collide, - threaded and one without any special option) from the syz-reproducer but none of them reproduce this issue. In fact, not a single message in dmesg shows up for this particular issue + reproducer.
>
> Thanks,

+lkml

Hi Igor,

Both of these happened on GCE VMs, so there are no qemu flags per se.
If this depends on exact hardware and you want to recreate the
environment, you need to create a GCE VM with EnableDisplay property.



> On Wednesday, March 10, 2021 at 11:47:10 AM UTC-3 syzbot wrote:
>>
>> Hello,
>>
>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>> memory leak in drm_vma_node_allow
>>
>> 2021/03/10 14:46:00 executed programs: 132
>> BUG: memory leak
>> unreferenced object 0xffff8881256ee280 (size 64):
>> comm "syz-executor.7", pid 11116, jiffies 4294949693 (age 16.450s)
>> hex dump (first 32 bytes):
>> 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>> 00 00 00 00 00 00 00 00 00 0c 75 24 81 88 ff ff ..........u$....
>> backtrace:
>> [<000000001044f41c>] kmalloc include/linux/slab.h:554 [inline]
>> [<000000001044f41c>] drm_vma_node_allow+0x32/0x120 drivers/gpu/drm/drm_vma_manager.c:274
>> [<0000000039cdfb89>] drm_gem_handle_create_tail+0x107/0x250 drivers/gpu/drm/drm_gem.c:390
>> [<0000000069546020>] vgem_gem_create drivers/gpu/drm/vgem/vgem_drv.c:203 [inline]
>> [<0000000069546020>] vgem_gem_dumb_create+0x8d/0x240 drivers/gpu/drm/vgem/vgem_drv.c:223
>> [<000000005a419bcc>] drm_mode_create_dumb+0x121/0x150 drivers/gpu/drm/drm_dumb_buffers.c:96
>> [<00000000c7d2aa9d>] drm_ioctl_kernel+0xf0/0x160 drivers/gpu/drm/drm_ioctl.c:787
>> [<00000000e3de4c3c>] drm_ioctl+0x2c8/0x4c0 drivers/gpu/drm/drm_ioctl.c:887
>> [<00000000c6de34af>] vfs_ioctl fs/ioctl.c:48 [inline]
>> [<00000000c6de34af>] __do_sys_ioctl fs/ioctl.c:753 [inline]
>> [<00000000c6de34af>] __se_sys_ioctl fs/ioctl.c:739 [inline]
>> [<00000000c6de34af>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:739
>> [<0000000017fb1e54>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>> [<00000000267c1811>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>>
>>
>> Tested on:
>>
>> commit: 05a59d79 Merge git://git.kernel.org:/pub/scm/linux/kernel/..
>> git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ master
>> console output: https://syzkaller.appspot.com/x/log.txt?x=16a93152d00000
>> kernel config: https://syzkaller.appspot.com/x/.config?x=7f272e2e8f44941a
>> dashboard link: https://syzkaller.appspot.com/bug?extid=04639d98c75c52e41b8a
>> compiler:
>>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/b0e69e38-f037-4823-a12b-82680c9494den%40googlegroups.com.
