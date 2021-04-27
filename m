Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB3C36CF8E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 01:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbhD0X3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 19:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbhD0X3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 19:29:49 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33C3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 16:29:05 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b21so3257878plz.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 16:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y7HxjP/Oou+y+oWelSFeYT4BTIle82wj6/68sSsfhm8=;
        b=F++1DsROrFO4sYCWRzYEt0iAAj/m+YXqYdzFguQ9nz6Q+6IRHSwVLMd2xfurWRlHSC
         99zH7zWCpCkB0F7zsnixZX0sqQCwvWGqEDg1Nrh0Jh/54ilnvqmMS/6xpy6Myi5JL5Z4
         PSg3j1guF/n2UhcdvlpQfS42P/U1uUkWwj0DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y7HxjP/Oou+y+oWelSFeYT4BTIle82wj6/68sSsfhm8=;
        b=PRQuAnbM/P1P0pBkiOe38Zm39Ku5fDfZco5otuthlqNgKxpgq/0Le3z3PHCIrOoOYr
         oe88OIWh9xRhp5a+EztbAfLY+nEB0K7WNaQoIHYcydw3GeNWyjMtYmQiyaNbJqGq7PSt
         qcUe1Zu3+3KkkYlNKU/lWXwxzTwcXtVQO4+VIZ1OomVqec9uAyPV7a5AD680o2SI/uaq
         olXT8Qy5hZV18BuwStsL7z8e8ybMVoeWXm/7I5gx8yeflvfN+syyjKAAKh/HEu5Wr2d9
         6bmc1DApvcF9ols1nyYD9IpIR2+41b/jBbloJX1Ksv85YS6yn05DY0iZ5NEByLm8/vP6
         nPaw==
X-Gm-Message-State: AOAM533Tj2M448CVAVZt/T4BonhxggMLiUWhwEtHoEt1U2Vow/TUbtjI
        /C0Ct5tJs6hD8PQsWXQGvui0TQ0q0IR8OA==
X-Google-Smtp-Source: ABdhPJygMxSQfKn7a9Ka9DhCIool7rEmYVOOl/Cc9hx8UcSW/TzqqC8EnS+pPEEQODdPZ3FnVTA5dQ==
X-Received: by 2002:a17:90a:6585:: with SMTP id k5mr29187452pjj.40.1619566145495;
        Tue, 27 Apr 2021 16:29:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b25sm3426904pfd.7.2021.04.27.16.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 16:29:04 -0700 (PDT)
Date:   Tue, 27 Apr 2021 16:29:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        oleg@redhat.com, Will Drewry <wad@chromium.org>
Subject: Re: pt_regs->ax == -ENOSYS
Message-ID: <202104271619.0DBE456@keescook>
References: <f0240e15-223a-7600-4494-7a0a75155bdb@zytor.com>
 <F9F5E9D4-C1EE-455A-A6B1-4DF9D349BBAA@amacapital.net>
 <06a5e088-b0e6-c65e-73e6-edc740aa4256@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06a5e088-b0e6-c65e-73e6-edc740aa4256@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 03:58:03PM -0700, H. Peter Anvin wrote:
> On 4/27/21 2:28 PM, Andy Lutomirski wrote:
> > 
> > > On Apr 27, 2021, at 2:15 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> > > 
> > > ﻿Trying to stomp out some possible cargo cult programming?
> > > 
> > > In the process of going through the various entry code paths, I have to admit to being a bit confused why pt_regs->ax is set to -ENOSYS very early in the system call path.
> > > 
> > 
> > It has to get set to _something_, and copying orig_ax seems perhaps silly.  There could also be code that relies on ptrace poking -1 into the nr resulting in -ENOSYS.
> > 
> 
> Yeah. I obviously ran into this working on the common entry-exit code for
> FRED; the frame has annoyingly different formats because of this, and I
> wanted to avoid slowing down the system call path.
> 
> > > What is perhaps even more confusing is:
> > > 
> > > __visible noinstr void do_syscall_64(struct pt_regs *regs, unsigned long nr)
> > > {
> > >         nr = syscall_enter_from_user_mode(regs, nr);
> > > 
> > >         instrumentation_begin();
> > >         if (likely(nr < NR_syscalls)) {
> > >                 nr = array_index_nospec(nr, NR_syscalls);
> > >                 regs->ax = sys_call_table[nr](regs);
> > > #ifdef CONFIG_X86_X32_ABI
> > >         } else if (likely((nr & __X32_SYSCALL_BIT) &&
> > >                           (nr & ~__X32_SYSCALL_BIT) < X32_NR_syscalls)) {
> > >                 nr = array_index_nospec(nr & ~__X32_SYSCALL_BIT,
> > >                                         X32_NR_syscalls);
> > >                 regs->ax = x32_sys_call_table[nr](regs);
> > > #endif
> > >         }
> > >         instrumentation_end();
> > >         syscall_exit_to_user_mode(regs);
> > > }
> > > #endif
> > > 
> > > Now, unless I'm completely out to sea, it seems to me that if syscall_enter_from_user_mode() changes the system call number to an invalid number and pt_regs->ax to !-ENOSYS then the system call will return a different value(!) depending on if it is out of range for the table (whatever was poked into pt_regs->ax) or if it corresponds to a hole in the table. This seems to me at least to be The Wrong Thing.
> > 
> > I think you’re right.
> > 
> > > 
> > > Calling regs->ax = sys_ni_syscall() in an else clause would arguably be the right thing here, except possibly in the case where nr (or (int)nr, see below) == -1 or < 0.
> > 
> > I think the check should be -1 for 64 bit but (u32)nr == (u32)-1 for the 32-bit path. Does that seem reasonable?

FWIW, there is some confusion with how syscall_trac_enter() signals the
"skip syscall" condition (-1L), vs actually calling "syscall -1". Right
now they're not really distinguished, and the early ENOSYS is there so that
"pretend it happened" can be implemented (by either ptrace or seccomp).
As in, "set return value to $whatever, and don't run a syscall".

> I'm thinking overall that depending on 64-bit %rax is once again a mistake;
> I realize that the assembly code that did that kept breaking because people
> messed with it, but we still have:
> 
> /*
>  * Only the low 32 bits of orig_ax are meaningful, so we return int.
>  * This importantly ignores the high bits on 64-bit, so comparisons
>  * sign-extend the low 32 bits.
>  */
> static inline int syscall_get_nr(struct task_struct *task, struct pt_regs
> *regs)
> {
>         return regs->orig_ax;
> }
> 
> "Different interpretation of the same data" is a notorious security trap.
> Zero-extending orig_ax would cause different behavior on 32 and 64 bits and
> differ from the above, so I'm thinking that just once and for all defining
> the system call number as a signed int for all the x86 ABIs would be the
> sanest.
> 
> It still doesn't really answer the question if "movq $-1,%rax; syscall" or
> "movl $-1,%eax; syscall" could somehow cause bad things to happen, though,
> which makes me a little bit nervous still.

I don't think this matters? What's the condition you're worried about
here? The syscall table lookup is going to be safe.

-- 
Kees Cook
