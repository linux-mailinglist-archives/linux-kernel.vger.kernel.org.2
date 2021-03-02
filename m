Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097B232A075
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381098AbhCBEUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbhCBAGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 19:06:04 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A01C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 16:04:03 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id k191so4031422vke.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 16:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1XIh7gShiN//tKrunNkN4L88i2M+YGwifuTELwFc6LE=;
        b=RlEPeQvM7w3v3jo/GZf62qKNSqZjAqW8q/W60ZiLmdY7BqXdXk8y6j2Gjb195dJWTU
         kvRFSqOHrabfVq0LNCErRyl3i2tg9kzH/gx3RbyQKvwbO1uEY2SeorKqOzp2qtblfL+u
         Zaraz6NSI9aKQtn1gKYyJO8h6oH3fveRi2EXfOgWfdkj0ECa2V20Vwk4CpGjft022BBY
         xY2aAlwwjwpOyTjkA14JU2hVBUvG6Yn+5sLL6YIKHr1w4wq16LpAc4gzVM0eRXRBgTb1
         Jc7em+a22T08rKQVVoS8qsJdaT2MwJff34Wl9LKvyehISEfDOngVxnlzqfGmO4zS5vLo
         D/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XIh7gShiN//tKrunNkN4L88i2M+YGwifuTELwFc6LE=;
        b=SHfdVjpbOmw56KunSvXICw/si5wZhe7RDxjcXKhw7cyyOd8PNyTGIrC/UXLnuyx5MR
         +kg/yrPmlmsaaJZNE7MCyuVaKTFK81572xCw0I2Qk/iOluNIliHrVsF49keoy5Hb/yS5
         +XyCaOCIsKUH4cm61O5TpszBYuDMEb9FnLPoTEJmFyhjsEtInX2A9Rap2Rz9X5Jch0oE
         lfEd6bLuR0Fto7KCuAbCLQ8IQu6LDJi8SgYfKncpXptSkumZydrRxGqzcPQHlpZDdeK4
         IpTnyhIjcwqMGW98wAd2VCIRrGW48ehgmkExFejEebYU06cbqnIZGpivbqjiWib2GyDL
         A/ww==
X-Gm-Message-State: AOAM533P+uBoIqBjUVoLfnPWBty2deH98V1rBObPLhZJIEuC9HfER/ow
        1+lLBoV1sXuQiREYDr89W0l68MgERQl3nnraLo7blw==
X-Google-Smtp-Source: ABdhPJxs4Dm8IV02FQpD6xaKHVoTVlyR3Rk97EFV3wxndnjWBCnYE8bxp+cmHy+nmGVvN19ShFtbl2MS1XYboW8jrZY=
X-Received: by 2002:a1f:a9c9:: with SMTP id s192mr972306vke.22.1614643442327;
 Mon, 01 Mar 2021 16:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20210301074027.GD12822@xsang-OptiPlex-9020> <CABCJKuc8H83b_8_Ccp+Cb7O9x5oEu6sPNq63sjGcAJcgiwy0bw@mail.gmail.com>
 <20210301184524.7aa05ac1@gandalf.local.home>
In-Reply-To: <20210301184524.7aa05ac1@gandalf.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 1 Mar 2021 16:03:51 -0800
Message-ID: <CABCJKudQme=bcNJtNCORUpBnVA_Pkr2Zk_3Nu2EsfnuoE7LJ3g@mail.gmail.com>
Subject: Re: [x86, build] 6dafca9780: WARNING:at_arch/x86/kernel/ftrace.c:#ftrace_verify_code
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 3:45 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 1 Mar 2021 14:14:51 -0800
> Sami Tolvanen <samitolvanen@google.com> wrote:
>
> > Basically, the problem is that ftrace_replace_code() expects to find
> > ideal_nops[NOP_ATOMIC5] here, which in this case is 66:66:66:66:90,
> > while objtool has replaced the __fentry__ call with 0f:1f:44:00:00.
> >
> > As ideal_nops changes depending on kernel config and hardware, when
> > CC_USING_NOP_MCOUNT is defined we could either change
> > ftrace_nop_replace() to always use P6_NOP5, or skip
> > ftrace_verify_code() in ftrace_replace_code() for
> > FTRACE_UPDATE_MAKE_CALL.
>
> So I hacked up the code to get -mnop-record to work on x86, and checked the
> vmlinux and it gives me:
>
> ffffffff81bc6120 <schedule>:
> ffffffff81bc6120:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> ffffffff81bc6125:       55                      push   %rbp
> ffffffff81bc6126:       65 48 8b 2c 25 c0 7d 01 00      mov    %gs:0x17dc0,%rbp ffffffff81bc612b: R_X86_64_32S  current_task
> ffffffff81bc612f:       53                      push   %rbx
> ffffffff81bc6130:       48 8b 45 18             mov    0x18(%rbp),%rax
>
>
> Which is the 0f:1f:44:00:00, and it works fine for me.
>
> Now, that could be because the ideal_nops[NOP_ATOMIC5] is the same, which
> would explain this.
>
> No, we should *not* change ftrace_nop_replace() to always use any P6_NOP5,
> as there was a reason we did this. Because not all nops are the same, and
> this gets called for *every* function that is traced.
>
> No, we should not skip ftrace_verify_code() *ever*. (/me was just
> referencing on twitter the scenario where ftrace bricked e1000e cards).
>
> This is probably why I never was much for the compiler conversion into nops,
> because it may chose the wrong one for the architecture.

Sure, makes sense. Should we just skip the conversion in objtool then
and let the kernel deal with it?

> What we could do, is if the nop chosen by the compiler is not the ideal
> nop, to go back and modify all the nops added by the compiler to the ideal
> one, which would keep it using the most efficient one.
>
> Or, add something like this:
>

[...]

>                 ret = ftrace_verify_code(rec->ip, old);
> +
> +               if (__is_defined(CC_USING_NOP_MCOUNT) && ret && old_nop) {
> +                       /* Compiler could have put in P6_NOP5 */
> +                       old = P6_NOP5;
> +                       ret = ftrace_verify_code(rec->ip, old);
> +               }
> +

Wouldn't that still hit WARN(1) in the initial ftrace_verify_code()
call if ideal_nops doesn't match?

Sami
