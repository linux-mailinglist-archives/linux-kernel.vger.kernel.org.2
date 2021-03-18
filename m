Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36348340856
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhCRPAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhCRPAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:00:17 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760ABC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:00:17 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id n79so2264442qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bxU4B+nPTRvM9ZSZ6AoL1FQH5EKqbaO4AUDdmZHY4sI=;
        b=FMYfnfClh0ZpsMe4rUISHYHqBUlQwe6DJICKpxwL7H0T1o3CzbN5M/Jgvd0k+NOBpm
         w8+4HqRhiluSxzDLaBfeliemodCDBEwlJrQ/RISc4M2h4NsBcPGj01Aukw1ib5pj2rSl
         hmrAvXtu1mO4gOdmUq7eiiuiZQwpYfwVheRXV0ten5GJXKNXzAc6cHPaf9Tqrf6EHrtn
         XKTq4eIpgZ0jxm1zoGvckPQARMbgGzod7NBp3I/4Huzt1gMVqt0n29GcNV5XtiwtRb0g
         R0rHhye3RrVwOqWjk/dNCUkgJXLEmTL+c2faNd7ADnPcBhs798dTqDuPmZLcLTHVjtGg
         J61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxU4B+nPTRvM9ZSZ6AoL1FQH5EKqbaO4AUDdmZHY4sI=;
        b=E5zzQzP/9BGc8y0UE7EVrWSXGpau/xlTNBxNSdvwYZeK221wsiomlLwlSx+KQgY+wx
         mI3zlArerbFyDS0VQcT5N10GbDF3QXJZ6m+r3+oOBn2A40zUZRFi6jfk/gGlHJeLtjdV
         H1bNibMxKMCLtioqhVntRGrS8pFWpuxdebTMKMe+xHObkTpLM3EbliNXLR7jXiuoppy4
         GgSn9uteG3bE1fFmtnTx1Iy8/g0g+ucXz5fWhqi+F+XkaoIG5PzYuI/Qb6EoWz+Xlb5J
         WVfVSlKB+VuJpv7waO7u9p8z+JRczgzIunIxtE7gUJUYzbSKvDkiFzxHvPfUz4aqm0wU
         NY5A==
X-Gm-Message-State: AOAM530bgGy8dUuxdzI1+qizx8WQWZLdAsbbmxz/N+bO3ZPjxbHqSj9w
        ksX3rFhQRJSBwo8dfWzd6hcWulmLLEoaWRs2dzbaBQdGmAM=
X-Google-Smtp-Source: ABdhPJxg+3qTjY8O8SPZ8KLwB8cFot7os7lZv/k4zkQYpQppPM/BeTeLp/gSMbo4mtKoDI69/7hzy3AethVE9rBuD5s=
X-Received: by 2002:a37:a7cb:: with SMTP id q194mr4759869qke.350.1616079616393;
 Thu, 18 Mar 2021 08:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000056b18b05bd7c6511@google.com> <CACT4Y+brvecfGUk7H7-mcJ82NxbEuETv+js0nRxpV7zc1AZH5w@mail.gmail.com>
 <c82390e5-33f6-75f6-6b93-c618537413e5@huawei.com> <CACT4Y+ZpfAiQKagp5xr0HY85SRr2h6pe10emm4_B5RLfVraN9A@mail.gmail.com>
 <093ff4d1-3977-1085-404f-ec46a3b1d8f0@huawei.com>
In-Reply-To: <093ff4d1-3977-1085-404f-ec46a3b1d8f0@huawei.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 18 Mar 2021 16:00:05 +0100
Message-ID: <CACT4Y+ai3qVzcBcTBoD4KkVTQzKm5nhEskhTjhNDmwuyBWSy-A@mail.gmail.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in riscv_intc_irq
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     syzbot <syzbot+005654dd9b8f26bd4c07@syzkaller.appspotmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 3:50 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >> On 2021/3/14 18:47, Dmitry Vyukov wrote:
> >>> On Sun, Mar 14, 2021 at 11:14 AM syzbot
> >>> <syzbot+005654dd9b8f26bd4c07@syzkaller.appspotmail.com> wrote:
> >>>> Hello,
> >>>>
> >>>> syzbot found the following issue on:
> >>>>
> >>>> HEAD commit:    0d7588ab riscv: process: Fix no prototype for arch_dup_tas..
> >>>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> >>>> console output: https://syzkaller.appspot.com/x/log.txt?x=15a35756d00000
> >>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=81c0b708b31626cc
> >>>> dashboard link: https://syzkaller.appspot.com/bug?extid=005654dd9b8f26bd4c07
> >>>> userspace arch: riscv64
> >>>>
> >>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>
> >>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>>> Reported-by: syzbot+005654dd9b8f26bd4c07@syzkaller.appspotmail.com
> >>>>
> >>>> ==================================================================
> >>>> BUG: KASAN: slab-out-of-bounds in riscv_intc_irq+0x24/0xcc drivers/irqchip/irq-riscv-intc.c:24
> >>>> Read of size 8 at addr ffffffe00c963bd0 by task kworker/1:1/4388
> >>>>
> >>>> CPU: 1 PID: 4388 Comm: kworker/1:1 Not tainted 5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
> >>>> Hardware name: riscv-virtio,qemu (DT)
> >>>> Workqueue: events nsim_dev_trap_report_work
> >>>> Call Trace:
> >>>> [<ffffffe0000096c0>] walk_stackframe+0x0/0x23c arch/riscv/kernel/traps.c:201
> >>>>
> >>>> Allocated by task 76347056:
> >>>> (stack is not available)
> >>>>
> >>>> Last potentially related work creation:
> >>> There seems to be some issue with riscv stack unwinder.
> >>> This does not have stacks.
> >> Hi, could you test with the following  patch about the no stack
> >> issue(from v5.11-rc4), I made a mistake when do some cleanup...
> >>
> >> https://lore.kernel.org/linux-riscv/ce5b3533-b75d-c31c-4319-9d29769bbbd5@huawei.com/T/#t
> > Hi Kefeng,
> >
> > Please see:
> > http://bit.do/syzbot#no-custom-patches
> >
> > Is a unit-test for this possible? Fuzzing is not a replacement for unit testing.
>
> ok, I mean that the issue about stack unwinder which may cause by my
> previous patch,
>
> if some one want the stack back, it could try the bugfix.

Everybody wants the stack back!
Good, let's wait when it's merged and we will see stacks in all kernel
testing systems.





> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/093ff4d1-3977-1085-404f-ec46a3b1d8f0%40huawei.com.
