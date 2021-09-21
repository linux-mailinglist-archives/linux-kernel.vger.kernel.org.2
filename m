Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D0B413208
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhIULAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 07:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhIULAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:00:15 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A1DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:58:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id bx4so28268738edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RP1t6F1ow/8OQN+izm78Y9bJ9MVZd+yMFKLR4PsDpvY=;
        b=dNYC1TlF4OiaopZt2R6nRivqbgyYgnbN3v8OhCvwyorE/5RGAWb3kO/pkQcgonl00r
         7qxUhIpiCupJEMDxoHJ+2HWYa0RsC3IT48AS2KoAbTL94FU+1QgfYdn3TFzbx4H7mLvX
         ekbq9mhGySKGUIGlpnehR7dUtQU9k5dptnTdRUyVANV/scuPe1gPMfxVG5Arf8wVXKtk
         eJ0vWVF2xj8rXf0Oqxv0+D95r7T6er6unkKDae+JRW6qN8OUIZ2/iNXVnaOLyQyGmJhL
         17AulVxZ/MR95Ra/i1lF6Ti6EhwqIVgNj6XcSC6f5K+RcBifB5PynzD3UUo9bZFU954e
         ERkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RP1t6F1ow/8OQN+izm78Y9bJ9MVZd+yMFKLR4PsDpvY=;
        b=xXawgNe3h3OY/kfxeOmBWrdagjHXTvYRxPqb+dDKkuC7mSmV3lgcmyCh/224bAeR/k
         /ry9tgbiVstlFKVUm48prVWrh1nReriq5zQZ61kERIOyhL0ZZc1lH4/z45HWsg2HIZAg
         HG+BmhFi9wNc26Kli8skBctVg/2/emydAp4cnVBrqOna7xNPKUFLnBCBF6jY5Ycocxl7
         4bUMI83FAjUdijkLqkXZ7OelMH1oFo5avY3lTBISYye491gIY+JEeh1GK9Zv3aoyilVB
         g+mhmsbvD+0sk1lBbvzI0RZvzo9ZXEkR+xzi2XW6Xmkg7w6P78wIc+Lsn+DIE6cEcOYm
         o4OA==
X-Gm-Message-State: AOAM531MPLMMdJs+Ho7o8F1GqXej6wR9m+DfoiIU+DuuRtZzq9v5NIrg
        KzPnK/Wmw7TNl6yOFH/J2LB+TSV9R6pJ3zyUBr1kvA==
X-Google-Smtp-Source: ABdhPJyuF5p756lFHQ9knf9JJSVQj6VYBSdcR/CvJQbKvyiwGLh4557EpxMR/12vC/dPOYLSz5LtAt03kjsbubN3s2I=
X-Received: by 2002:aa7:c988:: with SMTP id c8mr34846134edt.105.1632221925394;
 Tue, 21 Sep 2021 03:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210908130922.118265849@linutronix.de> <20210908132525.794334915@linutronix.de>
In-Reply-To: <20210908132525.794334915@linutronix.de>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 21 Sep 2021 12:58:34 +0200
Message-ID: <CADYN=9K1BdyupzcDAbyk2JTio1A98J9tsBS_LeOH4=GVG=7FqQ@mail.gmail.com>
Subject: Re: [patch V3 15/20] x86/fpu/signal: Change return type of
 copy_fpregs_to_sigframe() helpers to boolean
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sept 2021 at 15:30, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Now that copy_fpregs_to_sigframe() returns boolean the individual return
> codes in the related helper functions do not make sense anymore. Change
> them to return boolean success/fail.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

When I build and boot (qemu_x86_64) a defconfig kernel on from todays
next tag next-20210921 I see the following segmentation fault

2021-09-21T10:11:45 <6>[    1.622922] mount (89) used greatest stack
depth: 14384 bytes left
2021-09-21T10:11:45 <6>[    1.664760] EXT4-fs (sda): re-mounted. Opts:
(null). Quota mode: none.
2021-09-21T10:11:45 <6>[    1.691041] mkdir (92) used greatest stack
depth: 14312 bytes left
2021-09-21T10:11:45 <6>[    1.713201] mount (93) used greatest stack
depth: 13720 bytes left
2021-09-21T10:11:46 Starting syslogd: /etc/init.d/rcS: line 12:   101
Segmentation fault      $i start


I did a bisection and found this as the faulty patch [1]. When I
revert this patch I can't see the issue.

We noticed that function 'save_xstate_epilog()' changes the polarity
of its return code for one of the return statements, and for its only
caller. but not for the other return statement.

I tried this patch and I couldn't see the segmentation fault.

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 445c57c9c539..61eeebc04427 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -104,7 +104,7 @@ static inline int save_xstate_epilog(void __user
*buf, int ia32_frame)
        err = __copy_to_user(&x->i387.sw_reserved, sw_bytes, sizeof(*sw_bytes));

        if (!use_xsave())
-               return err;
+               return !err;

        err |= __put_user(FP_XSTATE_MAGIC2,
                          (__u32 __user *)(buf + fpu_user_xstate_size));



Cheers,
Anders
[1] http://ix.io/3zxf

> ---
>  arch/x86/kernel/fpu/signal.c |   17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -65,7 +65,7 @@ static inline int check_xstate_in_sigfra
>  /*
>   * Signal frame handlers.
>   */
> -static inline int save_fsave_header(struct task_struct *tsk, void __user *buf)
> +static inline bool save_fsave_header(struct task_struct *tsk, void __user *buf)
>  {
>         if (use_fxsr()) {
>                 struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
> @@ -82,18 +82,19 @@ static inline int save_fsave_header(stru
>                 if (__copy_to_user(buf, &env, sizeof(env)) ||
>                     __put_user(xsave->i387.swd, &fp->status) ||
>                     __put_user(X86_FXSR_MAGIC, &fp->magic))
> -                       return -1;
> +                       return false;
>         } else {
>                 struct fregs_state __user *fp = buf;
>                 u32 swd;
> +
>                 if (__get_user(swd, &fp->swd) || __put_user(swd, &fp->status))
> -                       return -1;
> +                       return false;
>         }
>
> -       return 0;
> +       return true;
>  }
>
> -static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
> +static inline bool save_xstate_epilog(void __user *buf, int ia32_frame)
>  {
>         struct xregs_state __user *x = buf;
>         struct _fpx_sw_bytes *sw_bytes;
> @@ -131,7 +132,7 @@ static inline int save_xstate_epilog(voi
>
>         err |= __put_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
>
> -       return err;
> +       return !err;
>  }
>
>  static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
> @@ -219,10 +220,10 @@ bool copy_fpstate_to_sigframe(void __use
>         }
>
>         /* Save the fsave header for the 32-bit frames. */
> -       if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
> +       if ((ia32_fxstate || !use_fxsr()) && !save_fsave_header(tsk, buf))
>                 return false;
>
> -       if (use_fxsr() && save_xstate_epilog(buf_fx, ia32_fxstate))
> +       if (use_fxsr() && !save_xstate_epilog(buf_fx, ia32_fxstate))
>                 return false;
>
>         return true;
>
