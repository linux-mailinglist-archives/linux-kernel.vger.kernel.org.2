Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB643FE174
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhIARw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346725AbhIARwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:52:22 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA9CC0612A8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 10:51:19 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso792558otu.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMRUOCqOVIv4foBGm6C/Vv7PH/IIzLrp9kfxhKpHcIw=;
        b=jvKPcdqC0GlMbzK5toeSIUrMUWAbAc8Bx0ZbhT5SUpXJImrj7qGGaxgiMzLDQe8lHp
         N+3YMKrP7gwnmMBlb2PjUKz/GKXFuuq0rvJJzFsMkqXYjyDEfT5BOBTzgYNmocur7yg7
         QFWdr7YSYxJmZxrdlwFf65dcz7azzgc6/ZBlKprNBwBSDCE3O4dhMSsEi9S0sbSax3Cz
         RYi4EJPv1c/ipRVIcMUaENLTR3xl5bSqOm+Yqqek4Z2etCa3c0nTpp7qR3aHk4vuZsXF
         +kv5Mh3f4h9qlOPnQvXDEqCdwdCv348VH083aYAQo4hjDyPHLpMio+Mjz1dt5V4mQg+Q
         CZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMRUOCqOVIv4foBGm6C/Vv7PH/IIzLrp9kfxhKpHcIw=;
        b=Tg0GL0MJCW1i4ukXaMTxmkDPF0fqug+6MurweL9PtleDoHTp1r3lfYAnpmNIWQ0r3V
         6drJxGzWuepJDDMfmza1QxSsP0e6loBcciosJn3wrf+zvCDg8DdAr2QUo6GZVRuctcR+
         A2n96dvnFIK2/BXxDpaGFN7oAhal3rlcfw4bL+21m0vBatB8bf6uiNf5SGWMpvM24LHi
         1fEnY4PTUHSrE64JFF7diypi7mqrCR25Y3lKz+9khPUXszra78GE3Ve64/BFe8BpdZ4Y
         MRvagr15cxN/kFLcL9MoWnKGFZ3h6Vx3m5GboXUFXQxAXixSwRsPC/6mLpbtYoTfnhga
         kLNQ==
X-Gm-Message-State: AOAM532LPOR3VWdPG0BpL447/MR+uSk7iJJz1HTQvSnnFmCA9670cRD3
        lNNVDfMoHHllCEdRF4egPRQ8TBvDOYZtANbEn3VRXA==
X-Google-Smtp-Source: ABdhPJwA4LeX6YWvTfv/OV5qP4snN9Vrjl/4j4SDhVOMXuJBREbvZKw7o94RdZH1pJxLystNlCfwgU7MTJpMPOQepdQ=
X-Received: by 2002:a05:6830:88:: with SMTP id a8mr521010oto.233.1630518678382;
 Wed, 01 Sep 2021 10:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01630505035-ext-2999@work.hours> <patch.git-04dd26be3043.your-ad-here.call-01630504868-ext-6188@work.hours>
In-Reply-To: <patch.git-04dd26be3043.your-ad-here.call-01630504868-ext-6188@work.hours>
From:   Marco Elver <elver@google.com>
Date:   Wed, 1 Sep 2021 19:51:06 +0200
Message-ID: <CANpmjNOJN4yG8g+Qz0icppRK6coVdN5yKMhyTCQeBRFq7_YpfA@mail.gmail.com>
Subject: Re: [PATCH] s390/unwind: use current_frame_address() to unwind
 current task
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, qemu-s390x <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sept 2021 at 16:06, Vasily Gorbik <gor@linux.ibm.com> wrote:
> current_stack_pointer() simply returns current value of %r15. If
> current_stack_pointer() caller allocates stack (which is the case in
> unwind code) %r15 points to a stack frame allocated for callees, meaning
> current_stack_pointer() caller (e.g. stack_trace_save) will end up in
> the stacktrace. This is not expected by stack_trace_save*() callers and
> causes problems.
>
> current_frame_address() on the other hand returns function stack frame
> address, which matches %r15 upon function invocation. Using it in
> get_stack_pointer() makes it more aligned with x86 implementation
> (according to BACKTRACE_SELF_TEST output) and meets stack_trace_save*()
> caller's expectations, notably KCSAN.
>
> Also make sure unwind_start is always inlined.
>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Tested-by: Marco Elver <elver@google.com>

Thanks!

> ---
>  arch/s390/include/asm/stacktrace.h | 20 ++++++++++----------
>  arch/s390/include/asm/unwind.h     |  8 ++++----
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
> index 3d8a4b94c620..22c41d7fd95c 100644
> --- a/arch/s390/include/asm/stacktrace.h
> +++ b/arch/s390/include/asm/stacktrace.h
> @@ -34,16 +34,6 @@ static inline bool on_stack(struct stack_info *info,
>         return addr >= info->begin && addr + len <= info->end;
>  }
>
> -static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
> -                                                      struct pt_regs *regs)
> -{
> -       if (regs)
> -               return (unsigned long) kernel_stack_pointer(regs);
> -       if (task == current)
> -               return current_stack_pointer();
> -       return (unsigned long) task->thread.ksp;
> -}
> -
>  /*
>   * Stack layout of a C stack frame.
>   */
> @@ -74,6 +64,16 @@ struct stack_frame {
>         ((unsigned long)__builtin_frame_address(0) -                    \
>          offsetof(struct stack_frame, back_chain))
>
> +static __always_inline unsigned long get_stack_pointer(struct task_struct *task,
> +                                                      struct pt_regs *regs)
> +{
> +       if (regs)
> +               return (unsigned long) kernel_stack_pointer(regs);
> +       if (task == current)
> +               return current_frame_address();
> +       return (unsigned long) task->thread.ksp;
> +}
> +
>  /*
>   * To keep this simple mark register 2-6 as being changed (volatile)
>   * by the called function, even though register 6 is saved/nonvolatile.
> diff --git a/arch/s390/include/asm/unwind.h b/arch/s390/include/asm/unwind.h
> index de9006b0cfeb..5ebf534ef753 100644
> --- a/arch/s390/include/asm/unwind.h
> +++ b/arch/s390/include/asm/unwind.h
> @@ -55,10 +55,10 @@ static inline bool unwind_error(struct unwind_state *state)
>         return state->error;
>  }
>
> -static inline void unwind_start(struct unwind_state *state,
> -                               struct task_struct *task,
> -                               struct pt_regs *regs,
> -                               unsigned long first_frame)
> +static __always_inline void unwind_start(struct unwind_state *state,
> +                                        struct task_struct *task,
> +                                        struct pt_regs *regs,
> +                                        unsigned long first_frame)
>  {
>         task = task ?: current;
>         first_frame = first_frame ?: get_stack_pointer(task, regs);
> --
> 2.25.4
