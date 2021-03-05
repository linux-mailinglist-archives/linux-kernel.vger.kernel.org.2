Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EBE32DEAE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 01:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhCEAzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 19:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhCEAzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 19:55:12 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E80C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 16:55:12 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id v14so427662ilj.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 16:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVX3R3qcYp4p1roAQ+X2+GwYoESAwIIzmcb1WvB7M0Y=;
        b=GyM5DuIgSfPnQF4PsXY5NU+FZhPl+aijbYRewp0qsfXboP7OdPh4qNxiwPeHILlXoG
         xJg01zBvtg40iS0ntz8aPcSEz9wTrCTwlw4pD4Nodvk+A5nmPFTqP/avck6Owss7WOK2
         uVdloHmRw65OpRFpaRTtGTWtqeRB15b3ILrEMCa9LtKb1EF5ZzQ0RWDUd310z/dSu4Hk
         kGliY97EXktRosaGC+3TWROMSc+L04eKA1iayJyT9g2E+jFLDZtzUU3OBVbLl5OhyEtA
         EoKL3gQzCaQlg5yoKAYcXwHBUq2e9T2CIkJFaPFj2na5b035aM9V8i6I5JWSnGjkQ/dy
         genw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVX3R3qcYp4p1roAQ+X2+GwYoESAwIIzmcb1WvB7M0Y=;
        b=apO0oR5JBJkl7W3+XSgKCIp90AyKH6EU7btA58Ljji5a2utDXX68I4HjG+UKwq5TpV
         aSx3r2Tlwt7POmNnEEM1jS/NA7M5fKMQaQRROKUIgLa2F537hbiu0QRUiCeCis9+8G13
         oYOCiKLgB6rNL72ezRw3bpJHOrAXEakBzNdwDslJC/BpC4sAd4RPrItEjAQL1taDQqyP
         IfxawjhGzNIH7L+GjpEB0AwRowYFbnjUH3qyvxBjBlDvO0+mRVnJ61QyEVq/VUQbAP95
         ZJLMfe83AeEDAoLxNEzqnIoAZ2V8oUk7Kz4GgMCMuO4ACpbtlvmmfG4vgjb51o45O4dY
         4anA==
X-Gm-Message-State: AOAM5305xC1KQpBPkIKui5pUexdDT37sekpiKH//G+V+V08wSSi0/yIA
        BA8lokup8KQR2L2i8M0vUw/gQ7igxrCcoctfUMEx4pw=
X-Google-Smtp-Source: ABdhPJw0qYDQCQTsOAUZHRZkcTPe+6ITY38yLW08YTIJ4okefJIk7NsTQoFHb0AgEEfPQHW8xWJF660/nDv4SzDTSrE=
X-Received: by 2002:a92:d2c6:: with SMTP id w6mr6293681ilg.273.1614905711947;
 Thu, 04 Mar 2021 16:55:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614884673.git.luto@kernel.org> <2b774fe982f6125909bc3ba26cef3cac0036b096.1614884673.git.luto@kernel.org>
In-Reply-To: <2b774fe982f6125909bc3ba26cef3cac0036b096.1614884673.git.luto@kernel.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 4 Mar 2021 19:55:00 -0500
Message-ID: <CAMzpN2jw-1qWaz3yPSW0fyig7b1j0UGeKboPvpVrpPE+5eTxGg@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] x86/entry: Convert ret_from_fork to C
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 2:16 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> ret_from_fork is written in asm, slightly differently, for x86_32 and
> x86_64.  Convert it to C.
>
> This is a straight conversion without any particular cleverness.  As a
> further cleanup, the code that sets up the ret_from_fork argument registers
> could be adjusted to put the arguments in the correct registers.

An alternative would be to stash the function pointer and argument in
the pt_regs of the new kthread task, and test for PF_KTHREAD instead.
That would eliminate the need to pass those two values to the C
version of ret_from_fork().

> This will cause the ORC unwinder to find pt_regs even for kernel threads on
> x86_64.  This seems harmless.
>
> The 32-bit comment above the now-deleted schedule_tail_wrapper was
> obsolete: the encode_frame_pointer mechanism (see copy_thread()) solves the
> same problem more cleanly.
>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/entry/common.c          | 23 ++++++++++++++
>  arch/x86/entry/entry_32.S        | 51 +++++---------------------------
>  arch/x86/entry/entry_64.S        | 33 +++++----------------
>  arch/x86/include/asm/switch_to.h |  2 +-
>  arch/x86/kernel/process.c        |  2 +-
>  arch/x86/kernel/process_32.c     |  2 +-
>  arch/x86/kernel/unwind_orc.c     |  2 +-
>  7 files changed, 43 insertions(+), 72 deletions(-)
>
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 95776f16c1cb..ef1c65938a6b 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -214,6 +214,29 @@ SYSCALL_DEFINE0(ni_syscall)
>         return -ENOSYS;
>  }
>
> +void ret_from_fork(struct task_struct *prev,
> +                  int (*kernel_thread_fn)(void *),
> +                  void *kernel_thread_arg,
> +                  struct pt_regs *user_regs);
> +
> +__visible void noinstr ret_from_fork(struct task_struct *prev,
> +                                    int (*kernel_thread_fn)(void *),
> +                                    void *kernel_thread_arg,
> +                                    struct pt_regs *user_regs)
> +{
> +       instrumentation_begin();
> +
> +       schedule_tail(prev);
> +
> +       if (kernel_thread_fn) {

This should have an unlikely(), as kernel threads should be the rare case.

--
Brian Gerst
