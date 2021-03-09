Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76F23329B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhCIPHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhCIPGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:06:37 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3C8C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 07:06:36 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id h26so6066246qtm.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 07:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RuVidFfGrxbRNJTTqDPajTcD/M7KgGy1YNO83vbVnDs=;
        b=Qr3lJxgex1KJ3QxckWln+1PcDhSEloI7TFLYIVff6X7j+prr1QMYujmD8zeJGap196
         XNYGryXGgFBCaMcqW6nSvIQd0IBROGQGOvtQFcPNCbU2dlhSm+LpVH9lhwEqgoqBwdAh
         GTzO8lBXZ+TETz25IJMcJn99c02QqnOgEweqSVl/eK257qpjiWtZiPMKI+jPbwLnu3e7
         adqgLUPgYHWGybWLqJIDb2cMDQ1Mj20upz/GW08E3UFFAGARCLYYDiqR/Lf/bEEfWyHR
         AltG8DtnXaCYG65M/uRmkNYmGaUYBZeR6TX0Qz/6VsLz/YjQYB5B3mdJON8R33EUm7wk
         661A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RuVidFfGrxbRNJTTqDPajTcD/M7KgGy1YNO83vbVnDs=;
        b=tlGGE+Ry1Z7UXaVpW9IoeVNQkMg7MY6Qnkd8Pm7+7WUrxEXELboseRuiV6x9dtP8Ax
         yfobGomjL+Yqq/5YDDboDGF+x3EAoc08EmFet6Amkz/01gOWExfXhmFdy6TcZ952vb4G
         nb+eZe1Z1fneUaA4jKTD8ommHOD1QG1YDQanRoTGrRQV1tZ6R38mevQmjZnDgCzUhnw5
         ZJ7ig/CG10CCkWg3UEwjNAVQmajQfZkFzPNe5JOtK7jIYkEN/iqvdkHaTRAgZplGSLKf
         gUAxvUlvIJtMtOFOUfTtrwlwopzSpLyGb70wjAIIbyyJBJvKBY8lRpIVR9DzAPd/JgP1
         Q+Eg==
X-Gm-Message-State: AOAM532Fj1lbWfQ3TKfw8WDrNsi6pZ8ufsOQ95nL30D1OhorbOUGqGgu
        6zHgWyJ7T4LULRhXfZGecfx7xSnVeiCdWsdVfhBAoQ==
X-Google-Smtp-Source: ABdhPJzOa1kpIzQxgbN4wZhxaMoGNj5+BJVMbMo8+ii2DodrJXa8DLvDDAS/BDZPDLnKby7R0TnYwKB0/1PodewBin4=
X-Received: by 2002:ac8:5212:: with SMTP id r18mr2811524qtn.290.1615302395752;
 Tue, 09 Mar 2021 07:06:35 -0800 (PST)
MIME-Version: 1.0
References: <CAGyP=7dpTbbj39uO37YrNMg9h4Nzmkszc3MoZg9n8ALir_A52g@mail.gmail.com>
 <YEZcVKbPzfMVK2aK@zeniv-ca.linux.org.uk> <CAGyP=7fHhyrTP-u0tqCy5ZHzZN0v_0dAoj6dCHnFuBbqtfnBmQ@mail.gmail.com>
 <YEeFYMcdPVNrKRJT@zeniv-ca.linux.org.uk>
In-Reply-To: <YEeFYMcdPVNrKRJT@zeniv-ca.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 9 Mar 2021 16:06:22 +0100
Message-ID: <CACT4Y+Z==NtH2K6pxN8w90cbczffF+wYbcTgTdbBczeBk5n1aw@mail.gmail.com>
Subject: Re: kernel panic: Attempted to kill init!
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Palash Oswal <oswalpalash@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 3:31 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > I observe the following result(notice the segfault in systemd):
> > root@sandbox:~# ./repro
> > [    9.457767] got to 221
> > [    9.457791] got to 183
> > [    9.459144] got to 201
> > [    9.459471] got to 208
> > [    9.459773] got to 210
> > [    9.462602] got to 270
> > [    9.488551] systemd[1]: segfault at 7ffe59fd7fb8 ip
> > 000055be8f20b466 sp 00007ffe59fd7fc0 error 6 in
> > systemd[55be8f15f000+ed000]
> > [    9.490723] Code: 00 00 00 00 41 57 41 56 41 55 41 54 55 53 89 fd
> > 48 81 ec 48 01 00 00 64 48 8b 04 25 28 00 00 00 48 89 84 24 38 01 00
> > 00 31 c0 <e8> f5 bf f7 ff 83 f8 01 0f 84 b7 00 00 00 48 8d 9c 240
> > [    9.492637] Kernel panic - not syncing: Attempted to kill init!
> > exitcode=0x0000000b
>
> Lovely.  So something in that sequence of syscalls manages to trigger
> segfault in unrelated process.  What happens if you put it to sleep
> right after open_by_handle_at() (e.g. by read(2) from fd 0, etc.)?

FWIW the code looks reasonable:

All code
========
   0: 00 00                add    %al,(%rax)
   2: 00 00                add    %al,(%rax)
   4: 41 57                push   %r15
   6: 41 56                push   %r14
   8: 41 55                push   %r13
   a: 41 54                push   %r12
   c: 55                    push   %rbp
   d: 53                    push   %rbx
   e: 89 fd                mov    %edi,%ebp
  10: 48 81 ec 48 01 00 00 sub    $0x148,%rsp
  17: 64 48 8b 04 25 28 00 mov    %fs:0x28,%rax
  1e: 00 00
  20: 48 89 84 24 38 01 00 mov    %rax,0x138(%rsp)
  27: 00
  28: 31 c0                xor    %eax,%eax
  2a:* e8 f5 bf f7 ff        callq  0xfffffffffff7c024 <-- trapping instruction
  2f: 83 f8 01              cmp    $0x1,%eax
  32: 0f 84 b7 00 00 00    je     0xef
  38: 48                    rex.W
  39: 8d                    .byte 0x8d
  3a: 9c                    pushfq
  3b: 40                    rex

This is a PC-relative call to a reasonable address, right?
I wonder if it always traps on this instruction or not. Maybe the
executable is corrupted and has a page missing in the image or
something similar. But also if we suspect a badly corrupted image, is
it worth pursuing it?...
