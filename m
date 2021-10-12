Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAE342AC51
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbhJLSsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbhJLSss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:48:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630FFC061762
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:46:27 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y12so67435eda.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ZlTOS6cwW0YQw8cb3jx4k6dstuzxOfbAAnxoavlKaE=;
        b=b45g58tVEGcE0eIvcqBE27yzsC1YgR+4YO4qjfXkGdTmmS3EpN9JvwFsUN0SuTfRGr
         gSa5qR5DSeu7YLDNFb6U69gE00tXM1JSR0GtWWg212z3lHr1lVwUjSpm/dazi5Q6cbaQ
         WL2Ql0wnJIakshI1HqEwMPa94SXOZ2Tstjq50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZlTOS6cwW0YQw8cb3jx4k6dstuzxOfbAAnxoavlKaE=;
        b=RohMMeCSTvN4ZOwEzDdUmmZ6fG+ilVlcuFte8UBlWHs1xWCCRMBmCJaH05oF4UklZX
         elNFeGAC4At5HpLL70wb4TtQke6nC1lnZgV40590X1rTLzf9nG4iiTHyrSQ6SiZLx3lC
         E77ZBX62JSIK89gE+3GnmaAdqBnq2aq2f+MCy0ite/h6PdPDm86IZLnz6snqM8SuwBlK
         gnJaeSSVrnMsv74hi5wOqKU0FCJ/JVxslI/XrhxIAbo8pvaTd+A2C5ZMpAUmm0T8BGUx
         ye+jX5OCn7amJXwtSUEl2UK99bXkX+PFr30YsRDVbP9N765oLyCOnPyXMnj3zOp0+nZ0
         oYeA==
X-Gm-Message-State: AOAM530xGeyGJcIJP/TebS0+HixvGVvLlQjt5XAdKRilZdCORdGRDTIe
        dZLnSHiTeFVX+oALDPld2C42Eb7p8VT8hBLG
X-Google-Smtp-Source: ABdhPJzNmtCALDieo/G1NWrz2v4/7GTXdQqx6HiBJdf2VtN7LFS8sawEYVQLYGpZ1Xts75O7WgjSQQ==
X-Received: by 2002:a2e:b804:: with SMTP id u4mr30954812ljo.425.1634063675757;
        Tue, 12 Oct 2021 11:34:35 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id t7sm1187600lfg.60.2021.10.12.11.34.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 11:34:35 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id y26so749973lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:34:35 -0700 (PDT)
X-Received: by 2002:a2e:1510:: with SMTP id s16mr30124071ljd.56.1634063674845;
 Tue, 12 Oct 2021 11:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211012141131.3c9a2eb1@gandalf.local.home>
In-Reply-To: <20211012141131.3c9a2eb1@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Oct 2021 11:34:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2SbVnsO7yxgaD20HBaH=0rNM60nD92+BDSwQxofd9SQ@mail.gmail.com>
Message-ID: <CAHk-=wj2SbVnsO7yxgaD20HBaH=0rNM60nD92+BDSwQxofd9SQ@mail.gmail.com>
Subject: Re: [BUG] WARNING: CPU: 3 PID: 1 at mm/debug_vm_pgtable.c:493
To:     Steven Rostedt <rostedt@goodmis.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Gavin Shan <gshan@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding x86 people (VM in particular). The tests were written primarily
for ARM, but should work on x86 too.

That warning seems to be due to pud_set_huge() failing (the "line 438"
one I don't know what it is - there's no warning on that line in my
tree, so I worry a bit that Steven has other things in his tree).

On x86, that can fail due to mtrr differences, or if there's already
an entry there. Neither _should_ be an issue during the boot-time
tests, but who knows..

Or there's something wrong with the tests. The fact that it's not
repeatable despite being a boot-time thing is a bit odd.

             Linus

On Tue, Oct 12, 2021 at 11:11 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> My tests have been triggering on this every so often. My code is based on
> v5.15-rc3. Note, this is not fully reproducible.
>
> I also get errors an mm/debug_vm_pgtable.c:438
>
> And it also triggers the WARN_ON()s after that as well.
>
> Always happens at the debug_vm_pgtable() during boot up.
>
> Here's the last splat:
>
> ------------[ cut here ]------------
>  WARNING: CPU: 3 PID: 1 at mm/debug_vm_pgtable.c:492 debug_vm_pgtable+0x1312/0x1693
>  Modules linked in:
>  CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc3-test+ #24
>  Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
>  RIP: 0010:debug_vm_pgtable+0x1312/0x1693
>  Code: 38 ff ff ff 48 c7 00 00 00 00 00 48 8b 75 b8 48 8b 95 78 ff ff ff 48 8b bd 38 ff ff ff 48 c1 e6 0c e8 62 4e 62 fe 85 c0 75 02 <0f> 0b 48 8b bd 38 ff ff ff e8 e0 50 62 fe 85 c0 75 02 0f 0b 48 8b
>  RSP: 0000:ffffa1eac0033da8 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: bffffffffffffff7 RCX: 0000000000000000
>  RDX: ffffffffffe00000 RSI: ffffffff8bb477d0 RDI: 0000000000000007
>  RBP: ffffa1eac0033e98 R08: ffffa1eac0033d23 R09: 000000021ee00000
>  R10: 000000021effffff R11: 0000000000000000 R12: ffff8cf1436da538
>  R13: 00003e8b00000000 R14: 000fffffffe00000 R15: 0000000000000027
>  FS:  0000000000000000(0000) GS:ffff8cf256800000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 000000020f612001 CR4: 00000000001706e0
>  Call Trace:
>   ? destroy_args+0x281/0x281
>   do_one_initcall+0x68/0x2d0
>   ? rcu_read_lock_sched_held+0x46/0x80
>   kernel_init_freeable+0x1a5/0x1f4
>   ? rest_init+0x280/0x280
>   kernel_init+0x1a/0x120
>   ret_from_fork+0x22/0x30
>  irq event stamp: 880991
>  hardirqs last  enabled at (881001): [<ffffffff8a1096ef>] __up_console_sem+0x6f/0x80
>  hardirqs last disabled at (881016): [<ffffffff8a1096d4>] __up_console_sem+0x54/0x80
>  softirqs last  enabled at (881014): [<ffffffff8a097033>] irq_exit_rcu+0xa3/0xd0
>  softirqs last disabled at (881009): [<ffffffff8a097033>] irq_exit_rcu+0xa3/0xd0
>  ---[ end trace 731534acace262b5 ]---
>  ------------[ cut here ]------------
>  WARNING: CPU: 3 PID: 1 at mm/debug_vm_pgtable.c:493 debug_vm_pgtable+0x1324/0x1693
>  Modules linked in:
>  CPU: 3 PID: 1 Comm: swapper/0 Tainted: G        W         5.15.0-rc3-test+ #24
>  Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
>  RIP: 0010:debug_vm_pgtable+0x1324/0x1693
>  Code: 78 ff ff ff 48 8b bd 38 ff ff ff 48 c1 e6 0c e8 62 4e 62 fe 85 c0 75 02 0f 0b 48 8b bd 38 ff ff ff e8 e0 50 62 fe 85 c0 75 02 <0f> 0b 48 8b 85 38 ff ff ff 48 8b 00 48 a9 9f ff ff ff 74 02 0f 0b
>  RSP: 0000:ffffa1eac0033da8 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: bffffffffffffff7 RCX: 0000000000000000
>  RDX: ffffffffffe00000 RSI: ffffffff8bb477d0 RDI: ffff8cf1436db160
>  RBP: ffffa1eac0033e98 R08: 0000000000000000 R09: 000000021ee00000
>  R10: 000000021effffff R11: 0000000000000000 R12: ffff8cf1436da538
>  R13: 00003e8b00000000 R14: 000fffffffe00000 R15: 0000000000000027
>  FS:  0000000000000000(0000) GS:ffff8cf256800000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 000000020f612001 CR4: 00000000001706e0
>  Call Trace:
>   ? destroy_args+0x281/0x281
>   do_one_initcall+0x68/0x2d0
>   ? rcu_read_lock_sched_held+0x46/0x80
>   kernel_init_freeable+0x1a5/0x1f4
>   ? rest_init+0x280/0x280
>   kernel_init+0x1a/0x120
>   ret_from_fork+0x22/0x30
>  irq event stamp: 881327
>  hardirqs last  enabled at (881337): [<ffffffff8a1096ef>] __up_console_sem+0x6f/0x80
>  hardirqs last disabled at (881352): [<ffffffff8a1096d4>] __up_console_sem+0x54/0x80
>  softirqs last  enabled at (881350): [<ffffffff8a097033>] irq_exit_rcu+0xa3/0xd0
>  softirqs last disabled at (881345): [<ffffffff8a097033>] irq_exit_rcu+0xa3/0xd0
>  ---[ end trace 731534acace262b6 ]---
>
> Config attached (this is x86_64).
>
> -- Steve
