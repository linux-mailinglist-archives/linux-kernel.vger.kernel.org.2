Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A862B41386E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhIURhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhIURhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:37:42 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFB0C061756
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:36:13 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id n18so21412369pgm.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=APv0k4deLkX9okxYy1Z3tdltmcm0UEBl9IhNAVRm0bw=;
        b=UglN3A8BdOwvoGtIVWxKFD+lD5S45aZE5t2m6B5FPUerc8mG5YCxMKWTf0MHsEeKFn
         Mlq2RwjO5bmZuBYfOFzqBKndED2fEUfYdCmjQvqSeMJoY3w72WmcSpvT26tgn9rKZYhU
         i/mvQBczVTM0X+/Oa1X4yQuMoTjOMNVPsnkDL0o41Qjb2FeY8D1es/ahoVH4+T5EmjOA
         Y5ePDuFeFiStuUy8tM1k6LaKI9mC/WXfVBSB5KJuiDv6Y8hkMTuyXKofTzSP71rUpK8D
         jWfQQFaAkoMB2ip7tkTmS23JpBZp98Azua3v1+jtybx+Jfv7RRRacUDmTIwmDYkBUlVx
         PKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=APv0k4deLkX9okxYy1Z3tdltmcm0UEBl9IhNAVRm0bw=;
        b=m2XSHBSrjH2hOsBfkNX3wnVmtmh0iUFFFjWONfqY7dCbbVi+oGZCqa8qWFXA4P+xn5
         OMtDfsNzbQRx066usfKr0/voJq6JxsPQyODvIng+BzC7WNypvO2Q0dKhbq17murG0JeJ
         FWMpEyKgkimLS8SCZBbx74xetiyNGqYdjLjxKefi5nwDS2VSVGyOpJf2bn/GxqUS3l2o
         RQLl1hqF4e5bCgjmouSSgg2FmN6Rla5NRta/4t/04pBY4f6JDnKHdvUx0X1GfhsGADpy
         eurh0XxD4oC3x/d5y/l/NeKZdLle70AzFxhjk5IbE6T4gz6qt9mL1rdBRCosiEiRSuJN
         Mgww==
X-Gm-Message-State: AOAM532gUYw1JHLtYwu0QKt5JaBoPBarQLeps4TQaIwYc6R/585ccjMd
        j/mLWu8gQSZDzXuqJn9P+YohoA==
X-Google-Smtp-Source: ABdhPJxMV25r2jdWsEfC9zJPw2w3rkXKkPf8qqBpsd7B4f1UHzfBABHcCKH7VgP0MIKsn3JqaYOf4g==
X-Received: by 2002:a05:6a00:88b:b0:43d:e85f:e9ee with SMTP id q11-20020a056a00088b00b0043de85fe9eemr32367035pfj.46.1632245772197;
        Tue, 21 Sep 2021 10:36:12 -0700 (PDT)
Received: from google.com ([2620:15c:211:202:5f32:153:b2ea:296d])
        by smtp.gmail.com with ESMTPSA id e11sm17928496pfm.79.2021.09.21.10.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 10:36:11 -0700 (PDT)
Date:   Tue, 21 Sep 2021 10:35:58 -0700
From:   Nick Desaulniers <ndesaulniers@google.com>
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
        Andrew Cooper <andrew.cooper3@citrix.org>
Subject: Re: [patch V3 15/20] x86/fpu/signal: Change return type of
 copy_fpregs_to_sigframe() helpers to boolean
Message-ID: <YUoX/lVugPnd/ZiK@google.com>
References: <20210908130922.118265849@linutronix.de>
 <20210908132525.794334915@linutronix.de>
 <CADYN=9K1BdyupzcDAbyk2JTio1A98J9tsBS_LeOH4=GVG=7FqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9K1BdyupzcDAbyk2JTio1A98J9tsBS_LeOH4=GVG=7FqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 12:58:34PM +0200, Anders Roxell wrote:
> On Wed, 8 Sept 2021 at 15:30, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Now that copy_fpregs_to_sigframe() returns boolean the individual return
> > codes in the related helper functions do not make sense anymore. Change
> > them to return boolean success/fail.
> >
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> When I build and boot (qemu_x86_64) a defconfig kernel on from todays
> next tag next-20210921 I see the following segmentation fault
> 
> 2021-09-21T10:11:45 <6>[    1.622922] mount (89) used greatest stack
> depth: 14384 bytes left
> 2021-09-21T10:11:45 <6>[    1.664760] EXT4-fs (sda): re-mounted. Opts:
> (null). Quota mode: none.
> 2021-09-21T10:11:45 <6>[    1.691041] mkdir (92) used greatest stack
> depth: 14312 bytes left
> 2021-09-21T10:11:45 <6>[    1.713201] mount (93) used greatest stack
> depth: 13720 bytes left
> 2021-09-21T10:11:46 Starting syslogd: /etc/init.d/rcS: line 12:   101
> Segmentation fault      $i start
> 
> 
> I did a bisection and found this as the faulty patch [1]. When I
> revert this patch I can't see the issue.
> 
> We noticed that function 'save_xstate_epilog()' changes the polarity
> of its return code for one of the return statements, and for its only
> caller. but not for the other return statement.
> 
> I tried this patch and I couldn't see the segmentation fault.
> 
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 445c57c9c539..61eeebc04427 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -104,7 +104,7 @@ static inline int save_xstate_epilog(void __user
> *buf, int ia32_frame)
>         err = __copy_to_user(&x->i387.sw_reserved, sw_bytes, sizeof(*sw_bytes));
> 
>         if (!use_xsave())
> -               return err;
> +               return !err;
> 
>         err |= __put_user(FP_XSTATE_MAGIC2,
>                           (__u32 __user *)(buf + fpu_user_xstate_size));

Thank for the report.  Our CI watching tip has also been super red over
the past day or so; all boot failures.

Andrew Cooper reported this diff to me on IRC; I tested out the above
and it fixes the boot failure for us.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1461

Our CI used -cpu Nehalem for qemu since KVM isn't exposed to the bots on
github actions, FWIW.
https://github.com/ClangBuiltLinux/boot-utils/blob/2edbca214f9a4cabd3f138ea029015d6cf52d110/boot-qemu.sh#L278-L288

> 
> 
> 
> Cheers,
> Anders
> [1] http://ix.io/3zxf
> 
> > ---
> >  arch/x86/kernel/fpu/signal.c |   17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >
> > --- a/arch/x86/kernel/fpu/signal.c
> > +++ b/arch/x86/kernel/fpu/signal.c
> > @@ -65,7 +65,7 @@ static inline int check_xstate_in_sigfra
> >  /*
> >   * Signal frame handlers.
> >   */
> > -static inline int save_fsave_header(struct task_struct *tsk, void __user *buf)
> > +static inline bool save_fsave_header(struct task_struct *tsk, void __user *buf)
> >  {
> >         if (use_fxsr()) {
> >                 struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
> > @@ -82,18 +82,19 @@ static inline int save_fsave_header(stru
> >                 if (__copy_to_user(buf, &env, sizeof(env)) ||
> >                     __put_user(xsave->i387.swd, &fp->status) ||
> >                     __put_user(X86_FXSR_MAGIC, &fp->magic))
> > -                       return -1;
> > +                       return false;
> >         } else {
> >                 struct fregs_state __user *fp = buf;
> >                 u32 swd;
> > +
> >                 if (__get_user(swd, &fp->swd) || __put_user(swd, &fp->status))
> > -                       return -1;
> > +                       return false;
> >         }
> >
> > -       return 0;
> > +       return true;
> >  }
> >
> > -static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
> > +static inline bool save_xstate_epilog(void __user *buf, int ia32_frame)
> >  {
> >         struct xregs_state __user *x = buf;
> >         struct _fpx_sw_bytes *sw_bytes;
> > @@ -131,7 +132,7 @@ static inline int save_xstate_epilog(voi
> >
> >         err |= __put_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
> >
> > -       return err;
> > +       return !err;
> >  }
> >
> >  static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
> > @@ -219,10 +220,10 @@ bool copy_fpstate_to_sigframe(void __use
> >         }
> >
> >         /* Save the fsave header for the 32-bit frames. */
> > -       if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
> > +       if ((ia32_fxstate || !use_fxsr()) && !save_fsave_header(tsk, buf))
> >                 return false;
> >
> > -       if (use_fxsr() && save_xstate_epilog(buf_fx, ia32_fxstate))
> > +       if (use_fxsr() && !save_xstate_epilog(buf_fx, ia32_fxstate))
> >                 return false;
> >
> >         return true;
> >
