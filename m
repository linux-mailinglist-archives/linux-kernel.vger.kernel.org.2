Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB44168A6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 02:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243613AbhIXAB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 20:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240701AbhIXABz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 20:01:55 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF210C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 17:00:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b15so32068386lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 17:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qi8HgtyrCEdGuJ+L8YfwlMZt/zmOidfROSszD9FUYeg=;
        b=oCI5rINrSal/Lq36k/v4ZEsMxbuOGSZK/avzUJJraL+tIzZ0qW1vzioaxmbZGMXLU0
         n2dMVHl0ADtcT7EdhRZO4O9EjCpeXtmT7B9E3SmOCUE85jsv8c6G6dXEwa/INU+jkHHc
         kmNcIC5AzLIU/JYsO7EJ/7IeUI1wkuyLGrjsHDxPGsLj1+VvWzjkSJglMJkKtdRN0ENU
         QMeAFqJ2BdhQfWDsEGenNHJXYtzWCxC8cnJJ6D2VI6aG1GmUo8QEkh73KV9rvomVUgZd
         j9k0MxVRP1Sxxla8jB8s5oaEtMsKWjvsI95mhA7Le/NPxKIoSGuFv72rjzpIu1C4XWyo
         TekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qi8HgtyrCEdGuJ+L8YfwlMZt/zmOidfROSszD9FUYeg=;
        b=ebB60wK5WXlG44bB6yHyLKiqrzCY7Wr2f0+YGcvzH/7CzGtYgxoU7wmmRTdV1wS8PG
         WLyDAJCYHiNkcXectqSAxxzo8TXHXxBI6xDvF2MEER+3ScxRsZr8/gZx8Ct+Nd67kRmO
         dmmIWNE6eK8yvdN5P3ue+/aFB6bMLXz8N5D3dpqPeY+qJBs5FBAnEOUe76NocIapCOLr
         ++quaSNrHuFG9Qn1/R+BIaBIrORYOzDvEEF9JRYzPOubPWmzsFy+Fxmf1NQR0HxTX8B7
         zKtOMGGmPn30QJtqkqL3xyPl39gFHE6zuSyq1BYYKa9dWFyy0NLJeQJvA+izBJ3TkhBD
         3HcA==
X-Gm-Message-State: AOAM5328RnBFkLF24lphOV2pJA0JDk4JKE7qwKH5QJAVo+mJNIar04Dq
        pg3WcWj1vKmWZjM3u3BXoYiGzlzYEoZimtTcX49xeQ==
X-Google-Smtp-Source: ABdhPJxTOQX9+vEPEexxUO4UHe1v6iUur1cN/HhZWac2PJo+Mcw32Q8XbkAkjMte7TZRcU+hyy/ME/mbDJUV5yaxvII=
X-Received: by 2002:a2e:5853:: with SMTP id x19mr7943180ljd.93.1632441620815;
 Thu, 23 Sep 2021 17:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210921193249.el476vlhg5k6lfcq@shells.gnugeneration.com>
 <20210922001537.4ktg3r2ky3b3r6yp@treble> <202109211931.E6E33500E8@keescook>
In-Reply-To: <202109211931.E6E33500E8@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 24 Sep 2021 01:59:54 +0200
Message-ID: <CAG48ez2zC=+PuNgezH53HBPZ8CXU5H=vkWx7nJs60G8RXt3w0Q@mail.gmail.com>
Subject: Re: CONFIG_ORC_UNWINDER=y breaks get_wchan()?
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>, peterz@infradead.org,
        luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 5:05 AM Kees Cook <keescook@chromium.org> wrote:
> On Tue, Sep 21, 2021 at 05:15:37PM -0700, Josh Poimboeuf wrote:
> > On Tue, Sep 21, 2021 at 12:32:49PM -0700, Vito Caputo wrote:
> > > Is this an oversight of the ORC_UNWINDER implementation?  It's
> > > arguably a regression to completely break wchans for tools like `ps -o
> > > wchan` and `top`, or my window manager and its separate monitoring
> > > utility.  Presumably there are other tools out there sampling wchans
> > > for monitoring as well, there's also an internal use of get_chan() in
> > > kernel/sched/fair.c for sleep profiling.
> > >
> > > I've occasionally seen when monitoring at a high sample rate (60hz) on
> > > something churny like a parallel kernel or systemd build, there's a
> > > spurious non-zero sample coming out of /proc/[pid]/wchan containing a
> > > hexadecimal address like 0xffffa9ebc181bcf8.  This all smells broken,
> > > is get_wchan() occasionally spitting out random junk here kallsyms
> > > can't resolve, because get_chan() is completely ignorant of
> > > ORC_UNWINDER's effects?
> >
> > Hi Vito,
> >
> > Thanks for reporting this.  Does this patch fix your issue?
> >
> >   https://lkml.kernel.org/r/20210831083625.59554-1-zhengqi.arch@bytedance.com
> >
> > Though, considering wchan has been silently broken for four years, I do
> > wonder what the impact would be if we were to just continue to show "0"
> > (and change frame pointers to do the same).
> >
> > The kernel is much more cautious than it used to be about exposing this
> > type of thing.  Can you elaborate on your use case?
> >
> > If we do keep it, we might want to require CAP_SYS_ADMIN anyway, for
> > similar reasons as
> >
> >   f8a00cef1720 ("proc: restrict kernel stack dumps to root")
>
> Normally wchan is protected by:
>
>         ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)
>
> I might argue that this check isn't right -- it needs to be using
> f_cred, but I'll let Jann answer more there.
>
> > ... since presumably proc_pid_wchan()'s use of '%ps' can result in an
> > actual address getting printed if the unwind gets confused, thanks to
> > __sprint_symbol()'s backup option if kallsyms_lookup_buildid() doesn't
> > find a name.
>
> Ew, yeah, __sprint_symbol() falls back to exposing addresses. :(
>
>         name = kallsyms_lookup_buildid(address, &size, &offset, &modname, &buildid,
>                                        buffer);
>         if (!name)
>                 return sprintf(buffer, "0x%lx", address - symbol_offset);

Whaaaat? That's not how wchan worked when I looked at this the last
time a few years ago...

... ah, commit 152c432b128cb ("proc/wchan: use printk format instead
of lookup_symbol_name()") is to blame for that.

> Thought I can't immediately think of what wouldn't be symbolized by
> kallsyms_lookup_buildid(), but given it fails open, I can totally
> believe there is. :)

One thing that makes /proc/$pid/wchan and /proc/$pid/stack so awful is
that they unwind a task's stack without ensuring that that stack isn't
actually running. That's why /proc/$pid/stack got restricted to root
years ago, see <https://bugs.chromium.org/p/project-zero/issues/detail?id=1657>
- I wrote an exploit back then that manages to read a pointer from an
arbitrary stack location via /proc/$pid/stack.

>         is_ksym_addr()
>         module_address_lookup()
>         bpf_address_lookup()
>         ftrace_mod_address_lookup()
>
> > Though, instead of requiring CAP_SYS_ADMIN, maybe we can just fix
> > __sprint_symbol() to not expose addresses?
> >
> > Or is there some other reason for needing CAP_SYS_ADMIN?  Jann?
>
> While it's not very high fidelity, I don't like having the kernel
> symbols exposed like this because userspace can basically sample the
> execution path of syscalls, etc. It's not a raw value, but it still
> creeps me out given that it can be probed.
>
> So, if it's been broken for 4 years under ORC, how about we just disable
> wchan permanently? (Untested...)

If that's possible, I would like it very much. I don't know whether
there are people on arm64 or so that rely on it though...
