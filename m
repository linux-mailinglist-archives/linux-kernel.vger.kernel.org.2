Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9472B309F15
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 22:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhAaV2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 16:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhAaVWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 16:22:39 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDE3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 13:21:59 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id s18so17145533ljg.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 13:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OF5ZNCFNSO0oBueNH/k4qhgh/MmAm+w5aisyR1YieHk=;
        b=Az0Ri32e+Bv2bmVVEHpVP7PhohzbJjNx4jX0KfJZPcHqGl2I9EnTxyrOFBDsGczTpf
         Vtc735c6kxrIogFVQosZuzhzZf12ag+7CRNKZ9yFqCxxolVzGSHPGeq/r9IonrKPgM2Y
         9mvb/AmDkCR9SgW7yAkq7PitZVffRTLaFFgVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OF5ZNCFNSO0oBueNH/k4qhgh/MmAm+w5aisyR1YieHk=;
        b=nV26FEOVZohnZbo4Ap7UlheV1bXY52IaetBg6HUiXmVnz1XUpqu7wOfPqjO14PcJe+
         NlBapj76qqud7Lzciu6VQxycGgfmWM1HgcBjbskKIgS310dKmoNPfGirP97ZW/b1hfF0
         Basgyp+qhphC3sxNQwAdlxaLyXj0Wl8Zilk0Tt/sGMHMfKyJm8jYzG725r0/Pb2OqQ+w
         wle/jVo8qOm7tKD0K9PLP3n+DomADv/HflxQmVcXrRqLYlUR0fHWTf1E7jEnHe/PwbMY
         Q6cDV2Scr3wHKvUpYpyeOsYQsLyA+JWlT+nh9FSD4n/fmIbvC0N3i07Gis7jY4ySvx6y
         CuPQ==
X-Gm-Message-State: AOAM533cpayZj0kntybhDkFkmz1+6lapeBe0o4OFzf+RaSujAfXUMPG0
        Xruh4gzQzgHIvuxEViM+ZvjwEIN0EDwKww==
X-Google-Smtp-Source: ABdhPJxTajSd2DL5dFuMAcD6J5CW7kzr8SoVbLmP95lytdcFLkfukqJ+rrsiVADw4CsgKZiOlbWRvw==
X-Received: by 2002:a2e:9610:: with SMTP id v16mr8208565ljh.374.1612128117247;
        Sun, 31 Jan 2021 13:21:57 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id y29sm2748233lfj.198.2021.01.31.13.21.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 13:21:56 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id h12so20047647lfp.9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 13:21:55 -0800 (PST)
X-Received: by 2002:ac2:4436:: with SMTP id w22mr6721301lfl.41.1612128115390;
 Sun, 31 Jan 2021 13:21:55 -0800 (PST)
MIME-Version: 1.0
References: <CAP045ApxLJ7vXOVp5Cwx7WEyDr6v01D9YD3xGFDv3WAp6czaMQ@mail.gmail.com>
 <87v9bdc4yc.fsf@m5Zedd9JOGzJrf0> <CAHk-=wixO7LJKwtD+CQJTQHgJFQjr=sSi_pQEGqcYdczTphncg@mail.gmail.com>
 <87mtwozwn3.fsf@collabora.com>
In-Reply-To: <87mtwozwn3.fsf@collabora.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 13:21:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=whfC5Rj+UCepiNaeMFTugpkUjfn7O57NLANFA6FoLA6Vw@mail.gmail.com>
Message-ID: <CAHk-=whfC5Rj+UCepiNaeMFTugpkUjfn7O57NLANFA6FoLA6Vw@mail.gmail.com>
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Yuxuan Shui <yshuiv7@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        Kyle Huey <me@kylehuey.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 12:20 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
>
> I think we should migrate TIF_SINGLESTEP to a SYSCALL_WORK flag as that
> is just a simple refactor.

That makes no sense at all to me.

A single-step has absolutely nothing to do with system calls, and it's
also not what any other architecture is doing.

So honestly, something is wrong if TIF_SINGLESTEP should be moved to
the SYSCALL_WORK_SYSCALL_xyz flags. That's not what single-stepping is
at all about.

It looks like commit 299155244770 ("entry: Drop usage of TIF flags in
the generic syscall code") is simply wrong. The whole premise for it
was wrong because it didn't notice that TIF_SINGLESTEP isn't a syscall
flag - and shouldn't be one.

The problem seems to be that TIF_SINGLESTEP has two different
meanings: the usual "enable single stepping", *and* then a special
magic hack to also do it at system call exit. You only seem to have
looked at the magic hack, not the actual REAL meaning of
TIF_SINGLESTEP, which causes TF to be set and the debug fault.

This whole code is very confusing. What is that
"arch_syscall_exit_tracehook()" thing in the first place? I see an
arch wrapper, but I don't see any architecture that actually defines
it, so it seems to always become just tracehook_report_syscall_exit().

It then does (on x86) the generic version, which does

        if (step)
                user_single_step_report(regs);
        else
                ptrace_report_syscall(regs, PTRACE_EVENTMSG_SYSCALL_EXIT);

where that user_single_step_report() is a nonsensical special case
that just does what a debug fault does for all the *usual* single step
events in exc_debug_user() (which does not use that pointless
"user_single_step_report()" function, but just does

                send_sigtrap(regs, 0, get_si_code(dr6));

so please, let's take a step back here, and look at the basics:

 - the *main* user of TIF_SINGLESTEP is regular debugging that causes
a #DB after each user space instruction, and causes that
send_sigtrap() in exc_debug_user()

 - there is one very odd and weird special case that is about having
system call tracing enabled, which seems to have unclear semantics and
this is the case that got broken.

What's the fix here? Because no, single-stepping isn't about system
calls, and we should not try to change the code to be about system
calls, because no other architecture does that EITHER.

Now, it's possible that eventually

 (a) the normal TF flag setting doesn't actually need TIF_SINGESTEP at all

 (b) the TIF_SINGLESTEP bit really only needs to be about the odd
special case for system calls.

but as things are now, (a) is *NOT* true. We have very magical
behavior wrt TIF_SINGLESTEP, see enable_single_step(), and the comment
about

        /*
         * If TF was already set, check whether it was us who set it.
         * If not, we should never attempt a block step.
         */

which actually ends up depending very subtly on whether TIF_SINGLESTEP
was already set *before* we did that enable_single_step(), and/or
whether TF was already set on the stack (because users can set it
themselves without ptrace).

Again, the special system call case is the special case, NOT the
normal case. Don't try to make TIF_SINGLESTEP be about the special
case.

              Linus

             Linus
