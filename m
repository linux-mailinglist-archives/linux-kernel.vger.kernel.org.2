Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF1E391121
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 09:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhEZHCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 03:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhEZHCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 03:02:19 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAAEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 00:00:48 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 82so45797qki.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 00:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLNi3dWeO+RuI5oF68OcZdUN7XM3z5lxWO0wGoaIJpg=;
        b=Ih8mhi++kT+ifmqSGnT7miS9ovRkYLoRPzWtntpeRsfv3UklBEgpKsVVQdGxsoIBdS
         eM7L8c3c/ONMb0P9TEs/drjbA192TFl3SNX2JadkLHgvqtCqReN4bI3xIl5Png6s4QC8
         I6oE3RHDVhpg9EFY7T7qf4Kh2deP+4kqgWUAZ986T0L3L0fLSyQWO2UlYEwQFDaXLD7q
         27WLakhyQx79aM63e/U/FuEffI0HUTObmYQPGLO0qjQfmTcUNxys6tKilEyOTZtkFVa+
         nGt7gwoeQ8NT7QvatcoAPtj44MKZF1KMV83XK0W1PD1uNH2jz8m2EZDB/h6etOG9hGPU
         HKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLNi3dWeO+RuI5oF68OcZdUN7XM3z5lxWO0wGoaIJpg=;
        b=fkwSUM/b3YswJPZ31c5wa4Md1Hu6iC+ECNrsj1R1N/CIgKnss8PMJs8f0yK/ObVLEI
         TukI+FSdE4PVmx8kq0vxEJbSlnzS6+Num0qR8KBsEwtZeM/Te6TOSsg4YUiG3rLddnFE
         hzj5fpUGaKAJaRz6dhR58Tna0/lnseZ3h5ZSaCskCyYqpbfLXrPwdYgZelyQvaiiMZyv
         14FO6QXU72YSAIS3Sp8oJZkhNmUJgdaU5jW2tv2yAylcXVbzuA4YXnFBPgnfqB5CbhAV
         9fHaNQn8uOL4Z4EqxDof/JmYEzC7+jP/GcQq4pQFzMqjp4+Drxw2V3tkBdIBEDL3HjLS
         yt9w==
X-Gm-Message-State: AOAM531Jy4IXride8K1U7KZA4U7SiDoI3sPRWxvFWJbM8rMCtFRJvGoC
        sQmBxNJSwZZsRtEsX9urgvTCTsUI3o1KWJqlqHwjqw==
X-Google-Smtp-Source: ABdhPJzAe6muTtNuLKVa3aUM3WYbKcFKMbQmeKs19fKraElQPO+th7VstpGYNEnKH9Lhf9MUCa7G6o9qdKGxiI+RjVM=
X-Received: by 2002:ae9:e014:: with SMTP id m20mr38488857qkk.424.1622012447095;
 Wed, 26 May 2021 00:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004c453905c30f8334@google.com> <fe20f360-7c6c-f1bf-c3a5-403ae979fae6@kernel.org>
In-Reply-To: <fe20f360-7c6c-f1bf-c3a5-403ae979fae6@kernel.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 26 May 2021 09:00:35 +0200
Message-ID: <CACT4Y+bpHL6hgY1h+7BM19-R4faOWgYsvTx3QSgpFN0JuxuWiQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in ex_handler_fprestore
To:     Andy Lutomirski <luto@kernel.org>
Cc:     syzbot <syzbot+2067e764dbcd10721e2e@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        fenghua.yu@intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, tony.luck@intel.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 2:33 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On 5/24/21 1:51 AM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    45af60e7 Merge tag 'for-5.13-rc2-tag' of git://git.kernel...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1591e9f7d00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=18fade5827eb74f7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=2067e764dbcd10721e2e
> > compiler:       Debian clang version 11.0.1-2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11be6bd1d00000
>
> Hi syz people and x86 people-
>
> I entirely believe that this bug is real and that syzbot bisected it
> correctly, but I'm puzzled by the reproducer.  It says:
>
> ptrace$setregs(0xd, r0, 0x0, &(0x7f0000000080))
>
> I would really, really expect this to result from PTRACE_SETREGSET or
> PTRACE_SETFPREGS, but this is PTRACE_SETREGS.
>
> Am I missing something really obvious here?

Hi Andy,

Sometimes syzkaller uses data format from one syscall variant, but
actually invokes another.
But here it does _not_ seem to be the case: 0xd is actually
PTRACE_SETREGS. And the other ptrace calls in the reproducer are
PTRACE_SEIZE and PTRACE_SINGLESTEP.
So I would assume somehow it happened with PTRACE_SETREGS.
Is there any indication from hardware as to what's wrong with fpregs?
