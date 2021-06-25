Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D803B45EC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhFYOm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFYOmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:42:22 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C46C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 07:40:01 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id w21so19221760qkb.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 07:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nD0kmHbZLR2o/dbFfrzrGrzfR5OtIwAqoz1ygGc2h+s=;
        b=nv/+OmObXOKpNySnuPU8XXYQ2sewmOTy/d8Mu+gtHbKjwkut9RVbv4YwA8mNuvofy6
         hxCoGmNhiVTc9Ly4Q/GYsUma8KKh/hVoA3HqUTLtOFuDuhGx/FMFkw2bjlnYxC8ddJS6
         xMx3LywCIwx93m7AUHOW92CZaS2+sL69nycap5WUnUVs3sbSqcgNrn0QgRSjghCz+nM5
         YFuBbjN9Il5WnWErhClRIeJ/pCyDd4UgsbHPhEDhhLy88Jm8b+XPG5U/mohkAw2oHtn9
         Zb/htY4rtv+mkpM3yC3l39mQGQlCSwbPIBPILNhZMA/AmWpxsMz0PU97fSdK21qtbl2t
         TKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nD0kmHbZLR2o/dbFfrzrGrzfR5OtIwAqoz1ygGc2h+s=;
        b=CovG1sudLc0z4mQB968ryLEluRavXXpN3rk9Gl6fLbkUhGzPzQRNIOJvB0OKuCpOvn
         VLIHjeayF3Hf+MPyp12AvmfJ+bJOOFaPJo8413ea527V3oZGANNQvZUl/Byk0nPqHr/I
         /w5V0QN2w/UrEYgJL9bnvz8gYuvTdkcWo9kSgZ0umlWIZ28q2+Ct7NwuuJvdB5qflXSf
         HlclozugWW6KaBDWi4Qus49mLsM/iOzwB5p05IcPPSHpdyUpY9NKJSPaGIWLIUDJ2NT7
         y85yaxN2wT45N3ZIrMGErdt34QFVwZd4tmdHNuyoJxHhhXm/1dal+hHkY4tNqk/szoxe
         YRLA==
X-Gm-Message-State: AOAM533U7qvsPdze4wNsW+GfT55yGWImbCpmlaPv+svkBQZvV5fmPMFH
        hfbgQPHKt3yF4qMn5wSwPlerkhiMgYAVEurelPIzFg==
X-Google-Smtp-Source: ABdhPJwIKdkG6REaQnMI3b4892OFPe5iz3O2v4BNAFDSWslZRy2rXcH2TIFHeZGdPJ5F3ITUzS06ala7PFSvCrNXAgk=
X-Received: by 2002:a37:9d93:: with SMTP id g141mr11934052qke.350.1624632000188;
 Fri, 25 Jun 2021 07:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ef5d1b05c57c2262@google.com> <87fsx7akyf.fsf@disp2133>
In-Reply-To: <87fsx7akyf.fsf@disp2133>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 25 Jun 2021 16:39:46 +0200
Message-ID: <CACT4Y+YM8wONCrOq75-TFwA86Sg5gRHDK81LQH_O_+yWsdTr=g@mail.gmail.com>
Subject: Re: [syzbot] KASAN: out-of-bounds Read in do_exit
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     syzbot <syzbot+b80bbdcca4c4dfaa189e@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, ast@kernel.org, christian@brauner.io,
        jnewsome@torproject.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, oleg@redhat.com,
        syzkaller-bugs@googlegroups.com, Ingo Molnar <mingo@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 7:31 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> syzbot <syzbot+b80bbdcca4c4dfaa189e@syzkaller.appspotmail.com> writes:
>
> > Hello,
> >
> > syzbot found the following issue on:
>
> This looks like dueling debug mechanism.  At a quick glance
> stack_no_used is deliberately looking for an uninitialized part of the
> stack.
>
> Perhaps the fix is to make KASAN and DEBUG_STACK_USAGE impossible to
> select at the same time in Kconfig?

+kasan-dev

Hi Eric,

Thanks for looking into this.

I see several strange things about this KASAN report:
1. KASAN is not supposed to leave unused stack memory as "poisoned".
Function entry poisons its own frame and function exit unpoisions it.
Longjmp-like things can leave unused stack poisoned. We have
kasan_unpoison_task_stack_below() for these, so maybe we are missing
this annotation somewhere.

2. This stand-alone shadow pattern "07 07 07 07 07 07 07 07" looks fishy.
It means there are 7 good bytes, then 1 poisoned byte, then 7 good
bytes and so on. I am not sure what can leave such a pattern. Both
heap and stack objects have larger redzones in between. I am not sure
about globals, but stack should not overlap with globals (and there
are no modules on syzbot).

So far this happened only once and no reproducer. If nobody sees
anything obvious, I would say we just wait for more info.



> > HEAD commit:    9ed13a17 Merge tag 'net-5.13-rc7' of git://git.kernel.org/..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=116c517bd00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=bf635d6d1c7ebabc
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b80bbdcca4c4dfaa189e
> > compiler:       Debian clang version 11.0.1-2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+b80bbdcca4c4dfaa189e@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: out-of-bounds in stack_not_used include/linux/sched/task_stack.h:101 [inline]
> > BUG: KASAN: out-of-bounds in check_stack_usage kernel/exit.c:711 [inline]
> > BUG: KASAN: out-of-bounds in do_exit+0x1c6b/0x23d0 kernel/exit.c:869
> > Read of size 8 at addr ffffc90017d60400 by task loop0/31717
> >
> > CPU: 0 PID: 31717 Comm: loop0 Not tainted 5.13.0-rc6-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:79 [inline]
> >  dump_stack+0x202/0x31e lib/dump_stack.c:120
> >  print_address_description+0x5f/0x3b0 mm/kasan/report.c:233
> >  __kasan_report mm/kasan/report.c:419 [inline]
> >  kasan_report+0x15c/0x200 mm/kasan/report.c:436
> >  stack_not_used include/linux/sched/task_stack.h:101 [inline]
> >  check_stack_usage kernel/exit.c:711 [inline]
> >  do_exit+0x1c6b/0x23d0 kernel/exit.c:869
> >  kthread+0x3b8/0x3c0 kernel/kthread.c:315
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> >
> >
> > Memory state around the buggy address:
> >  ffffc90017d60300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  ffffc90017d60380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>ffffc90017d60400: 07 07 07 07 07 07 07 07 00 00 00 00 00 00 00 00
> >                    ^
> >  ffffc90017d60480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >  ffffc90017d60500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ==================================================================
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/87fsx7akyf.fsf%40disp2133.
