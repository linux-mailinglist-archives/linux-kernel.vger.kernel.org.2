Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79024338602
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhCLGhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhCLGgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:36:40 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12096C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 22:36:40 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id a11so3045919qto.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 22:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YuBBCqZr1Px85yleK39mC93HGbGySY0fITwLtMOGyoA=;
        b=KQ5KAEoYHEZNwOyAP4oRAj1vPu7WsdZfiztwVv3Np1+bED+C6berPMOj/WyPeJuhFy
         Ie0a8uDfQ3YcG8JWKKC2Ba1drHTJknlDYvZ5P8CoXO1P7TYfKkllYmscByxE/oERYrnA
         7PiySIzZI2iM0ERBVwx7RTOQsDs7vAHb33gfVS5t33u5njOKc6gcZfQ0peaDnLIAXuY0
         9LtuE8K7Nw1HcWWycfaDVK0/+iUjIzJwZJoMRy9is20IVj7n5LQv8C+W4e1G+trMEEGF
         Yz+5ENl7bnDDhbRb2bcf/ExBQL5T0y/o1gvqXTaatPxiXhBzopJYka8bfTgfzMcuGXBX
         XSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YuBBCqZr1Px85yleK39mC93HGbGySY0fITwLtMOGyoA=;
        b=WYYC0Rj7ph5yxoGIx32vABJfql3dRSMw42IUMXjmfmYZ1i1U7svFi7nRLvWEPBTMLx
         cWnWIgBS4oV3ApCgGn5d0R1sVE4lSzg9M7CfOmdOG/U/btAwQ/wTFe1aLcplD9j1pzuw
         iry110wDgn4FejbkOlN9lPnlmKPkMaxUER4OukneUH9Y1YF6FqLVyy+oLQDD1jIGsJtE
         hxVFTuKEITX+qMgbaJjnftkEpQX+KwaH6GwLCp057IVDFuJU3+z1dgzkaoO2STuhVfic
         2MHSaapvhEEx9uHE4c1zeHkEGNy62G5lGhXri2gGtKoQfEO0hDfZXnw85J8dvGwlNoBw
         NQcA==
X-Gm-Message-State: AOAM530cwqqrnW9A9cybFBzcd1g4+zupeVPmsRIDq0IcmFBcqJn3OhUV
        wovkAVoQAeGWPb3xK9dywA8KTQaQk8MwJZ1gQcIZVw==
X-Google-Smtp-Source: ABdhPJyzKKrKccsmKmzC3iwT0eYiBXMeRUluIecoA3zBNiSG0mj0+LWF4mjLJf4qxlReCTafyqheCU6DgzE8PIlIDfk=
X-Received: by 2002:ac8:5212:: with SMTP id r18mr10402768qtn.290.1615530999035;
 Thu, 11 Mar 2021 22:36:39 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d356ca05bd4c1974@google.com> <CALCETrXUJOHj8PynvZVWgG7jBe6ZtqKpvjhbUM8perbbydRw5Q@mail.gmail.com>
In-Reply-To: <CALCETrXUJOHj8PynvZVWgG7jBe6ZtqKpvjhbUM8perbbydRw5Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Mar 2021 07:36:27 +0100
Message-ID: <CACT4Y+ZimBeG_g1842OqYpsjmm3x=tN-GYsTU-5yxnDd7gLTPw@mail.gmail.com>
Subject: Re: [syzbot] WARNING in handle_mm_fault
To:     Andy Lutomirski <luto@kernel.org>
Cc:     syzbot <syzbot+7d7013084f0a806f3786@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 3:30 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> Your warning is odd, but I see the bug.  It's in KVM.

Hi Andy,

By "your" you mean "kernel", right? ;)


> On Thu, Mar 11, 2021 at 4:37 PM syzbot
> <syzbot+7d7013084f0a806f3786@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    05a59d79 Merge git://git.kernel.org:/pub/scm/linux/kernel/..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16f493ead00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=750735fdbc630971
> > dashboard link: https://syzkaller.appspot.com/bug?extid=7d7013084f0a806f3786
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+7d7013084f0a806f3786@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > raw_local_irq_restore() called with IRQs enabled
> > WARNING: CPU: 0 PID: 8412 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
> > Modules linked in:
> > CPU: 0 PID: 8412 Comm: syz-fuzzer Not tainted 5.12.0-rc2-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
>
> The above makes sense, but WTH is the below:
>
> > Code: be ff cc cc cc cc cc cc cc cc cc cc cc 80 3d 11 d1 ad 04 00 74 01 c3 48 c7 c7 20 79 6b 89 c6 05 00 d1 ad 04 01 e8 75 5b be ff <0f> 0b c3 48 39 77 10 0f 84 97 00 00 00 66 f7 47 22 f0 ff 74 4b 48
> > RSP: 0000:ffffc9000185fac8 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: ffff8880194268a0 RCX: 0000000000000000
> > RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000000
> > R13: ffffed1003284d14 R14: 0000000000000001 R15: ffff8880b9c36000
> > FS:  000000c00002ec90(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> > Call Trace:
> >  handle_mm_fault+0x1bc/0x7e0 mm/memory.c:4549
> > Code: 48 8d 05 97 25 3e 00 48 89 44 24 08 e8 6d 54 ea ff 90 e8 07 a1 ed ff eb a5 cc cc cc cc cc 8b 44 24 10 48 8b 4c 24 08 89 41 24 <c3> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 48 8b
> > RAX: 00000000000047f6 RBX: 00000000000047f6 RCX: 0000000000d60000
> > RDX: 0000000000004c00 RSI: 0000000000d60000 RDI: 000000000181cad0
> > RBP: 000000c000301890 R08: 00000000000047f5 R09: 000000000059c5a0
> > R10: 000000c0004e2000 R11: 0000000000000020 R12: 00000000000000fa
> > R13: 00aaaaaaaaaaaaaa R14: 000000000093f064 R15: 0000000000000038
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 0 PID: 8412 Comm: syz-fuzzer Not tainted 5.12.0-rc2-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
>
> Now we start reading here:
>
> >  __dump_stack lib/dump_stack.c:79 [inline]
> >  dump_stack+0x141/0x1d7 lib/dump_stack.c:120
> >  panic+0x306/0x73d kernel/panic.c:231
> >  __warn.cold+0x35/0x44 kernel/panic.c:605
> >  report_bug+0x1bd/0x210 lib/bug.c:195
> >  handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:239
> >  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:259
> >  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:575
> > RIP: 0010:warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
> > Code: be ff cc cc cc cc cc cc cc cc cc cc cc 80 3d 11 d1 ad 04 00 74 01 c3 48 c7 c7 20 79 6b 89 c6 05 00 d1 ad 04 01 e8 75 5b be ff <0f> 0b c3 48 39 77 10 0f 84 97 00 00 00 66 f7 47 22 f0 ff 74 4b 48
> > RSP: 0000:ffffc9000185fac8 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: ffff8880194268a0 RCX: 0000000000000000
> > RDX: ffff88802f7b2400 RSI: ffffffff815b4435 RDI: fffff5200030bf4b
> > RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000000
> > R10: ffffffff815ad19e R11: 0000000000000000 R12: 0000000000000003
> > R13: ffffed1003284d14 R14: 0000000000000001 R15: ffff8880b9c36000
> >  kvm_wait arch/x86/kernel/kvm.c:860 [inline]
>
> and there's the bug:
>
>         /*
>          * halt until it's our turn and kicked. Note that we do safe halt
>          * for irq enabled case to avoid hang when lock info is overwritten
>          * in irq spinlock slowpath and no spurious interrupt occur to save us.
>          */
>         if (arch_irqs_disabled_flags(flags))
>                 halt();
>         else
>                 safe_halt();
>
> out:
>         local_irq_restore(flags);
> }
>
> The safe_halt path is bogus.  It should just return instead of
> restoring the IRQ flags.

I think this should be fixed already by:
https://patchwork.kernel.org/project/kvm/patch/1614057902-23774-1-git-send-email-wanpengli@tencent.com/

#syz fix: x86/kvm: Fix broken irq restoration in kvm_wait
