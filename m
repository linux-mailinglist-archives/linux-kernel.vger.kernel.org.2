Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6BE414FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 20:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbhIVSYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 14:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbhIVSYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 14:24:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8F9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:23:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i25so15712268lfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 11:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGfIZI8WhvSFu5gKg6P7iX3egFZDenq/izFO/fb2gbc=;
        b=m60s3WJsGDXghsgkm8B1eoblT1PIJCcs65uylCEREykJ8thyuwT11Ppe5GhtejDxHy
         FRjqy7RgMJf5XlLdXFm6fX6N+/cnnYk9ueyhJnV71dhV/b+qDje78hTZ3ft2QBtiJOb3
         LRmzxKs7wxgYTxDsj38Sg2MZsTrwaPSP7hbud13kK/uRO7et1KnGA8lPxQm9i4mIav0i
         7xLi99Lbev9noZwo3i6s3nE+F9Vc2TaeEbX76EYORn72DVICZRpwCCfMKSo6judVPVBx
         BpSC8ePQ91txxFDAsBnNP5tAf7eVSgWVviO2lk0T6LBlcN3SczLQRFkkgmZWW09c8iDc
         n3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGfIZI8WhvSFu5gKg6P7iX3egFZDenq/izFO/fb2gbc=;
        b=VquynJDvTKu6O2ZH2OjrBEBITFrgH+bYvHrrCvZ+9XL8HGnJsyh3i29XFt/0Qnrbo2
         ThQSYR0RwrsfM71ko0eTs4CILB7t3ZUbZAxdFro8PVTlPrnB0KMvWlRJJLrv7r/27nkk
         3MkyjfGfYN0t0o8AnbTWXApsOUrFE7gAVFHRn0nOyJM6VedBC8rPZ2BbvM/TWHmWDnVj
         0HfrgmoAt0c23/RUlA2sOWigf0T0R6Dx4/xpOpcvHGdrG5MjZGJVJTU4UylW5Fh04ZqF
         7EN0LtApjnP/f/rXjBGYVwPE4Jd7G8Q7HNhpKfYfxLf/vA6Pp9Stwu5DrdZyAKb1/FBa
         Re1Q==
X-Gm-Message-State: AOAM532fyFZ+Ic0oWFZ9TsaYaweW0nVvfb+0KcvojTvsoBUVauWv5NTu
        sFIgNSJl4r2ymguLzRrMi4KakexormRADXqbZj19v7ASMDM=
X-Google-Smtp-Source: ABdhPJzwmkLhB1UyuuD+4i+kJD4hU3R7CHg3+DNiRTwGfmH05zDEOWp/QaW47rG6KodEKfdif5ZyTlYa5TM6PMTc8U0=
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr371646lfg.550.1632334992982;
 Wed, 22 Sep 2021 11:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210908130922.118265849@linutronix.de> <20210908132525.794334915@linutronix.de>
 <CADYN=9K1BdyupzcDAbyk2JTio1A98J9tsBS_LeOH4=GVG=7FqQ@mail.gmail.com> <YUoX/lVugPnd/ZiK@google.com>
In-Reply-To: <YUoX/lVugPnd/ZiK@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 22 Sep 2021 11:23:01 -0700
Message-ID: <CAKwvOd==W5BXp0-8kYJmd8LBvfOo5i9qvyJr43csQoxQd08row@mail.gmail.com>
Subject: Re: [patch V3 15/20] x86/fpu/signal: Change return type of
 copy_fpregs_to_sigframe() helpers to boolean
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Andrew (sorry, I messed up your address on the previous message)

On Tue, Sep 21, 2021 at 10:36 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Sep 21, 2021 at 12:58:34PM +0200, Anders Roxell wrote:
> > On Wed, 8 Sept 2021 at 15:30, Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > Now that copy_fpregs_to_sigframe() returns boolean the individual return
> > > codes in the related helper functions do not make sense anymore. Change
> > > them to return boolean success/fail.
> > >
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >
> > When I build and boot (qemu_x86_64) a defconfig kernel on from todays
> > next tag next-20210921 I see the following segmentation fault
> >
> > 2021-09-21T10:11:45 <6>[    1.622922] mount (89) used greatest stack
> > depth: 14384 bytes left
> > 2021-09-21T10:11:45 <6>[    1.664760] EXT4-fs (sda): re-mounted. Opts:
> > (null). Quota mode: none.
> > 2021-09-21T10:11:45 <6>[    1.691041] mkdir (92) used greatest stack
> > depth: 14312 bytes left
> > 2021-09-21T10:11:45 <6>[    1.713201] mount (93) used greatest stack
> > depth: 13720 bytes left
> > 2021-09-21T10:11:46 Starting syslogd: /etc/init.d/rcS: line 12:   101
> > Segmentation fault      $i start
> >
> >
> > I did a bisection and found this as the faulty patch [1]. When I
> > revert this patch I can't see the issue.
> >
> > We noticed that function 'save_xstate_epilog()' changes the polarity
> > of its return code for one of the return statements, and for its only
> > caller. but not for the other return statement.
> >
> > I tried this patch and I couldn't see the segmentation fault.
> >
> > diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> > index 445c57c9c539..61eeebc04427 100644
> > --- a/arch/x86/kernel/fpu/signal.c
> > +++ b/arch/x86/kernel/fpu/signal.c
> > @@ -104,7 +104,7 @@ static inline int save_xstate_epilog(void __user
> > *buf, int ia32_frame)
> >         err = __copy_to_user(&x->i387.sw_reserved, sw_bytes, sizeof(*sw_bytes));
> >
> >         if (!use_xsave())
> > -               return err;
> > +               return !err;
> >
> >         err |= __put_user(FP_XSTATE_MAGIC2,
> >                           (__u32 __user *)(buf + fpu_user_xstate_size));
>
> Thank for the report.  Our CI watching tip has also been super red over
> the past day or so; all boot failures.
>
> Andrew Cooper reported this diff to me on IRC; I tested out the above
> and it fixes the boot failure for us.
>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1461
>
> Our CI used -cpu Nehalem for qemu since KVM isn't exposed to the bots on
> github actions, FWIW.
> https://github.com/ClangBuiltLinux/boot-utils/blob/2edbca214f9a4cabd3f138ea029015d6cf52d110/boot-qemu.sh#L278-L288
>
> >
> >
> >
> > Cheers,
> > Anders
> > [1] http://ix.io/3zxf
> >
> > > ---
> > >  arch/x86/kernel/fpu/signal.c |   17 +++++++++--------
> > >  1 file changed, 9 insertions(+), 8 deletions(-)
> > >
> > > --- a/arch/x86/kernel/fpu/signal.c
> > > +++ b/arch/x86/kernel/fpu/signal.c
> > > @@ -65,7 +65,7 @@ static inline int check_xstate_in_sigfra
> > >  /*
> > >   * Signal frame handlers.
> > >   */
> > > -static inline int save_fsave_header(struct task_struct *tsk, void __user *buf)
> > > +static inline bool save_fsave_header(struct task_struct *tsk, void __user *buf)
> > >  {
> > >         if (use_fxsr()) {
> > >                 struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
> > > @@ -82,18 +82,19 @@ static inline int save_fsave_header(stru
> > >                 if (__copy_to_user(buf, &env, sizeof(env)) ||
> > >                     __put_user(xsave->i387.swd, &fp->status) ||
> > >                     __put_user(X86_FXSR_MAGIC, &fp->magic))
> > > -                       return -1;
> > > +                       return false;
> > >         } else {
> > >                 struct fregs_state __user *fp = buf;
> > >                 u32 swd;
> > > +
> > >                 if (__get_user(swd, &fp->swd) || __put_user(swd, &fp->status))
> > > -                       return -1;
> > > +                       return false;
> > >         }
> > >
> > > -       return 0;
> > > +       return true;
> > >  }
> > >
> > > -static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
> > > +static inline bool save_xstate_epilog(void __user *buf, int ia32_frame)
> > >  {
> > >         struct xregs_state __user *x = buf;
> > >         struct _fpx_sw_bytes *sw_bytes;
> > > @@ -131,7 +132,7 @@ static inline int save_xstate_epilog(voi
> > >
> > >         err |= __put_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
> > >
> > > -       return err;
> > > +       return !err;
> > >  }
> > >
> > >  static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
> > > @@ -219,10 +220,10 @@ bool copy_fpstate_to_sigframe(void __use
> > >         }
> > >
> > >         /* Save the fsave header for the 32-bit frames. */
> > > -       if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
> > > +       if ((ia32_fxstate || !use_fxsr()) && !save_fsave_header(tsk, buf))
> > >                 return false;
> > >
> > > -       if (use_fxsr() && save_xstate_epilog(buf_fx, ia32_fxstate))
> > > +       if (use_fxsr() && !save_xstate_epilog(buf_fx, ia32_fxstate))
> > >                 return false;
> > >
> > >         return true;
> > >



-- 
Thanks,
~Nick Desaulniers
