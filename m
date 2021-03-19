Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487003418E3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhCSJzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhCSJzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:55:01 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AD0C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:55:01 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c3so2200759qkc.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jHeA6QTWcn7D3dgO+zTnrL0IC8nyerOMBAJ1Lhr8b7g=;
        b=Hrj/g+fsqKkMuu+C1kpTnTUeuwUkaNv9U4iLDk4IkvcOS7l6VQvHb+N0cdLUmOdLMk
         5W6ar9+gUyvXTVUT7GYxwVkEkjdxpDj/5T/+nIWZbIj+9lAOA9qhYNEWAQPF1Up4UlrA
         D8GzOtjv1qwnC8n2Bwk7c6nWfXhywj9dO6x3kTyVVL0IAGfkpgjXDDIaN16OFKjiMC/u
         b91nY++VoKySMLWOcVk3IdPC4Y0pLyrk29Kcco36V0VvMTEls+Wcou7O6QOg9w//+BCP
         m9TUH3/utyn/XfvGOk9vZje5K/DqhfcfCTTRxrR9+REO6VV6w1in1rXdQWfNy9S1Klw7
         j66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHeA6QTWcn7D3dgO+zTnrL0IC8nyerOMBAJ1Lhr8b7g=;
        b=ZyFayO/pIyBkBHrEtk1TuA3wat2CiaRTv/yjaBFRJgD/+AjeCiD8LqkzLFA+nrckZP
         PRXNA0sUU5XwTm8THBmAPTqgKBjlGfgDmlFfVlp++TRlN7GHjD+1sAo4l/NPeJu35suG
         R/7V+m/n9sWNu8HtbxTGMEvNeUFw9hngcC3bhiru7GyH4jlAzrKryDG7nszh8B6d0+jl
         vKfUDJ/E23LVU7xDwbPIajIAcHdqZkbagNKzwgrVF7nbkqPnoPeN936mpzl38tsxN43C
         5mN4GUwHleeFXobStjiQCpXFN45Ve7/Ben0le5nNWxNB7TG3l7gbRH1LuuagUieMNAOI
         VowQ==
X-Gm-Message-State: AOAM533WLZ1k+f2xs45nBAg0zz3ewatS6PMxoLOjwIf//N8o/vBcHPdn
        ylkvxqiA0FutNjTiBmAN0u3LEA8+akHt0sRZUbSuIQ==
X-Google-Smtp-Source: ABdhPJzwKLN5P2q2/qVy3FdobO1ML+WHP2ivraiBmoQqc1rKhBql0O2Lry8got3eyGC6p0brIwjpCcEpivwP2arHX9A=
X-Received: by 2002:a05:620a:2095:: with SMTP id e21mr8476293qka.265.1616147699834;
 Fri, 19 Mar 2021 02:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004f14c105bde08f75@google.com>
In-Reply-To: <0000000000004f14c105bde08f75@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 19 Mar 2021 10:54:48 +0100
Message-ID: <CACT4Y+bLkFSc8manYrCukj-_nzwVsV9y6xYWXmGyYFS-PoBRPQ@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: WARNING in __context_tracking_enter
To:     syzbot <syzbot+f09a12b2c77bfbbf51bd@syzkaller.appspotmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.On Fri, Mar 19, 2021 at 10:44 AM syzbot
<syzbot+f09a12b2c77bfbbf51bd@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    8b12a62a Merge tag 'drm-fixes-2021-03-19' of git://anongit..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17e815aed00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cfeed364fc353c32
> dashboard link: https://syzkaller.appspot.com/bug?extid=f09a12b2c77bfbbf51bd
> userspace arch: arm
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f09a12b2c77bfbbf51bd@syzkaller.appspotmail.com


+Mark, arm
It did not get far with CONFIG_CONTEXT_TRACKING_FORCE (kernel doesn't boot).


> Run /sbin/init as init process
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at include/linux/seqlock.h:271 __seqprop_assert include/linux/seqlock.h:271 [inline]
> WARNING: CPU: 0 PID: 1 at include/linux/seqlock.h:271 __seqprop_assert.constprop.0+0xf0/0x11c include/linux/seqlock.h:269
> Modules linked in:
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 1 Comm: init Not tainted 5.12.0-rc3-syzkaller #0
> Hardware name: ARM-Versatile Express
> Backtrace:
> [<81804310>] (dump_backtrace) from [<81804584>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:252)
>  r7:00000080 r6:60000193 r5:00000000 r4:82b58444
> [<8180456c>] (show_stack) from [<8180bc58>] (__dump_stack lib/dump_stack.c:79 [inline])
> [<8180456c>] (show_stack) from [<8180bc58>] (dump_stack+0xb8/0xe8 lib/dump_stack.c:120)
> [<8180bba0>] (dump_stack) from [<81805118>] (panic+0x130/0x378 kernel/panic.c:231)
>  r7:81f487d4 r6:82a390e4 r5:00000000 r4:82c6b0d8
> [<81804fe8>] (panic) from [<802447b4>] (__warn+0xb0/0x164 kernel/panic.c:605)
>  r3:82a2248c r2:00000000 r1:5b71e000 r0:81f487d4
>  r7:0000010f
> [<80244704>] (__warn) from [<818053c8>] (warn_slowpath_fmt+0x68/0xd4 kernel/panic.c:628)
>  r7:8028c4b4 r6:0000010f r5:81f40c30 r4:00000000
> [<81805364>] (warn_slowpath_fmt) from [<8028c4b4>] (__seqprop_assert include/linux/seqlock.h:271 [inline])
> [<81805364>] (warn_slowpath_fmt) from [<8028c4b4>] (__seqprop_assert.constprop.0+0xf0/0x11c include/linux/seqlock.h:269)
>  r8:00000000 r7:82a22498 r6:828ac940 r5:8181fbb0 r4:00000001
> [<8028c3c4>] (__seqprop_assert.constprop.0) from [<8028ea54>] (vtime_user_enter+0x1c/0x90 kernel/sched/cputime.c:709)
>  r5:8181fbb0 r4:834f0000
> [<8028ea38>] (vtime_user_enter) from [<8181fbb0>] (__context_tracking_enter+0x148/0x334 kernel/context_tracking.c:82)
>  r7:82a22498 r6:828ac940 r5:ffffe000 r4:00000001
> [<8181fa68>] (__context_tracking_enter) from [<80417170>] (context_tracking_enter kernel/context_tracking.c:122 [inline])
> [<8181fa68>] (__context_tracking_enter) from [<80417170>] (context_tracking_enter+0x54/0x84 kernel/context_tracking.c:106)
>  r7:00000000 r6:00000000 r5:60000193 r4:00000001
> [<8041711c>] (context_tracking_enter) from [<804171bc>] (user_enter include/linux/context_tracking.h:28 [inline])
> [<8041711c>] (context_tracking_enter) from [<804171bc>] (context_tracking_user_enter+0x1c/0x20 kernel/context_tracking.c:130)
>  r5:81820218 r4:00000000
> [<804171a0>] (context_tracking_user_enter) from [<802000d4>] (no_work_pending+0x8/0x38)
> Exception stack(0x834dffb0 to 0x834dfff8)
> ffa0:                                     00000000 00000000 00000000 00000000
> ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> ffe0: 00000000 7ec68ef0 00000000 76ee5a00 00000010 00000000
> Rebooting in 86400 seconds..
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000004f14c105bde08f75%40google.com.
