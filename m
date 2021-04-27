Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A632936CF8D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 01:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbhD0XYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 19:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbhD0XYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 19:24:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A92C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 16:23:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r12so91826792ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 16:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8OZ2oiVEvPGoOgQZ7Itt/LXNABjwOWwYKFkYAbzROXg=;
        b=IWOoAsJDfLqQQXreD3bPWHywiEF5t/ck/a3/JYp4ARxzOPwMyHpXkAKBuIsIPid3FW
         gKysa+pOmpVFQx+tMuC/UWQ98UmPWB4SI0iMqAJtWvaEY5lC/cG/5Co3c52TFZk4BkCj
         AiJvmz2YfFxGjm3PN9EUxr4xvsn1+hWy60R3LUYcgGaf0t3vOs5dN5jrHZpGUflPX3gs
         VbsAHLyCZl7NcW7Zkxc6lcXakoNUKRMrp4CXd2PSkCntTgJAyXO+9SjhBScPHRZpp8jv
         CaiEw6ByKai3dW1RKnHw9bNXx+Zl1FN/FSXXGNQgwHXqLDIOMjlv20U4zq1tGUaveXIz
         0DBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8OZ2oiVEvPGoOgQZ7Itt/LXNABjwOWwYKFkYAbzROXg=;
        b=V0mfyFLzx+0pc1MlHXdilQpvUmCY1ycoSIcI8dLMETxwILzzVIiPNzdb19+xdL1q+y
         gmt8DgFOD+qM+T/5sLRvWakvUUQXNPVD+q6VeyPTFceRE3cwte/zzP2dA8P00LFnFr26
         I7ieICt4F3GDN92VyalWpOuLZRvx6hMFV4ePiubGUjq8Bu0R5mB/EdP5b8b/PZiiLyXq
         agCkM6pRzCVBuBAYf9JMRmfoHhNrREWuOutTSbBGtz1619iVL523CFlUm7ZZfDZfZ0Fb
         kaEBDHKVpZYhx7pB8YT5NaFCxJCV5ioWFNYXFIoBnIRVUZIuMzpdbAtYn9KF55C9mB6P
         qelA==
X-Gm-Message-State: AOAM530McIkHGEr6io4k0bQcIYipPOup/KIt8cB1KPpIXlVz3066skM/
        F5yOnYbau0NCbISuZF4ZOfo1HCCdYjPbFhtYE+DvUA==
X-Google-Smtp-Source: ABdhPJz1qQ3lU4G6s8jUwb71gLA8x4WsaLEyuKIYw7H9g2cL/1+g6BPS7z/+iHmOwyoojrVjOdPrPPmfcMOv+FBsb6Q=
X-Received: by 2002:a17:906:f742:: with SMTP id jp2mr9076541ejb.199.1619565797504;
 Tue, 27 Apr 2021 16:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <f0240e15-223a-7600-4494-7a0a75155bdb@zytor.com>
 <F9F5E9D4-C1EE-455A-A6B1-4DF9D349BBAA@amacapital.net> <06a5e088-b0e6-c65e-73e6-edc740aa4256@zytor.com>
In-Reply-To: <06a5e088-b0e6-c65e-73e6-edc740aa4256@zytor.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 27 Apr 2021 16:23:06 -0700
Message-ID: <CALCETrW7Vu5ZU-Lv4RRG5DSGxMBJmDMqpvP7kqO16DwajproBQ@mail.gmail.com>
Subject: Re: pt_regs->ax == -ENOSYS
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 3:58 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 4/27/21 2:28 PM, Andy Lutomirski wrote:
> >
> >> On Apr 27, 2021, at 2:15 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> >>
> >> =EF=BB=BFTrying to stomp out some possible cargo cult programming?
> >>
> >> In the process of going through the various entry code paths, I have t=
o admit to being a bit confused why pt_regs->ax is set to -ENOSYS very earl=
y in the system call path.
> >>
> >
> > It has to get set to _something_, and copying orig_ax seems perhaps sil=
ly.  There could also be code that relies on ptrace poking -1 into the nr r=
esulting in -ENOSYS.
> >
>
> Yeah. I obviously ran into this working on the common entry-exit code
> for FRED; the frame has annoyingly different formats because of this,
> and I wanted to avoid slowing down the system call path.
>
> >> What is perhaps even more confusing is:
> >>
> >> __visible noinstr void do_syscall_64(struct pt_regs *regs, unsigned lo=
ng nr)
> >> {
> >>         nr =3D syscall_enter_from_user_mode(regs, nr);
> >>
> >>         instrumentation_begin();
> >>         if (likely(nr < NR_syscalls)) {
> >>                 nr =3D array_index_nospec(nr, NR_syscalls);
> >>                 regs->ax =3D sys_call_table[nr](regs);
> >> #ifdef CONFIG_X86_X32_ABI
> >>         } else if (likely((nr & __X32_SYSCALL_BIT) &&
> >>                           (nr & ~__X32_SYSCALL_BIT) < X32_NR_syscalls)=
) {
> >>                 nr =3D array_index_nospec(nr & ~__X32_SYSCALL_BIT,
> >>                                         X32_NR_syscalls);
> >>                 regs->ax =3D x32_sys_call_table[nr](regs);
> >> #endif
> >>         }
> >>         instrumentation_end();
> >>         syscall_exit_to_user_mode(regs);
> >> }
> >> #endif
> >>
> >> Now, unless I'm completely out to sea, it seems to me that if syscall_=
enter_from_user_mode() changes the system call number to an invalid number =
and pt_regs->ax to !-ENOSYS then the system call will return a different va=
lue(!) depending on if it is out of range for the table (whatever was poked=
 into pt_regs->ax) or if it corresponds to a hole in the table. This seems =
to me at least to be The Wrong Thing.
> >
> > I think you=E2=80=99re right.
> >
> >>
> >> Calling regs->ax =3D sys_ni_syscall() in an else clause would arguably=
 be the right thing here, except possibly in the case where nr (or (int)nr,=
 see below) =3D=3D -1 or < 0.
> >
> > I think the check should be -1 for 64 bit but (u32)nr =3D=3D (u32)-1 fo=
r the 32-bit path. Does that seem reasonable?
>
> I'm thinking overall that depending on 64-bit %rax is once again a
> mistake; I realize that the assembly code that did that kept breaking
> because people messed with it, but we still have:
>
> /*
>   * Only the low 32 bits of orig_ax are meaningful, so we return int.
>   * This importantly ignores the high bits on 64-bit, so comparisons
>   * sign-extend the low 32 bits.
>   */
> static inline int syscall_get_nr(struct task_struct *task, struct
> pt_regs *regs)
> {
>          return regs->orig_ax;
> }
>
> "Different interpretation of the same data" is a notorious security
> trap. Zero-extending orig_ax would cause different behavior on 32 and 64
> bits and differ from the above, so I'm thinking that just once and for
> all defining the system call number as a signed int for all the x86 ABIs
> would be the sanest.
>
> It still doesn't really answer the question if "movq $-1,%rax; syscall"
> or "movl $-1,%eax; syscall" could somehow cause bad things to happen,
> though, which makes me a little bit nervous still.
>

I much prefer the model of saying that the bits that make sense for
the syscall type (all 64 for 64-bit SYSCALL and the low 32 for
everything else) are all valid.  This way there are no weird reserved
bits, no weird ptrace() interactions, etc.  I'm a tiny bit concerned
that this would result in a backwards compatibility issue, but not
very.  This would involve changing syscall_get_nr(), but that doesn't
seem so bad.  The biggest problem is that seccomp hardcoded syscall
nrs to 32 bit.

An alternative would be to declare that we always truncate to 32 bits,
except that 64-bit SYSCALL with high bits set is an error and results
in ENOSYS. The ptrace interaction there is potentially nasty.

Basically, all choices here kind of suck, and I haven't done a real
analysis of all the issues...

--Andy
