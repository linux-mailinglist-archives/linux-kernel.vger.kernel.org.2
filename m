Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90005381A18
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 19:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhEORPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 13:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhEOROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 13:14:53 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2DCC061573
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 10:13:39 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i22so2745427lfl.10
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+fYPo1kcqM7g4hExNdGaCFBoa0ZHAQe7z7aH++mkPI=;
        b=F6OVH6x40oYzidIeU/hvQjsVIxy5lZV1F9Vm70jjdYDj7j4fS0hCsKsuBbrVarUCx2
         Juc/+bLtba2GWTg35LAdHNhWyZoq9BOacR7Y9m77fUW2IggxeqzpoCp7EMtku3jguz9c
         5VBOmtHOT75wUWvA9B0BDzVCFGvwhcA9vLfnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+fYPo1kcqM7g4hExNdGaCFBoa0ZHAQe7z7aH++mkPI=;
        b=EEtCrSX1afvRBQZxmgnXow+RimKzV9ArjrbfRn0bcwL20CFuF/G6syAGAhKG2Q7chK
         8Y+nk/UEyoL7Q3+/7xMADBkkoxeMxdR01c6GmnYOCiZy/E6NAMaT/b+12HlY3j/bz2mA
         nS7tQA7N+grkIymax3qJAl3AkVgkMdCz3UKAtNGzYQmYu1ScbVSuzskc/EzQhynnkC2x
         19XMc16epLp+oW/1T6MKOTqVc9isFYA40nD2MUft2AkptdQhxJ88wzakwC3EnTX5TmGb
         koxNfVmAgJlC8BYRO1gD9w0W/Vd3csKmCGGpdoR5ms+Tbw878hjBFHs8AE1xwKtFpEvf
         GVsw==
X-Gm-Message-State: AOAM533584IcmobWZtKTvc713gi6JmuNZhGtCqzmdqUo33myhXCQtm2P
        31k93W9jiao+dcLV1AFiKYqCMyDR/fwopsdJslo=
X-Google-Smtp-Source: ABdhPJxh9RLRzS86wx4/0x/+4yFSpOAKine/QZND4z2Qi2+re7T/WLg1aqw92/WD6vyTyPTvhaEn3A==
X-Received: by 2002:a05:6512:3159:: with SMTP id s25mr34679064lfi.416.1621098817340;
        Sat, 15 May 2021 10:13:37 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id y19sm2122941ljj.125.2021.05.15.10.13.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 May 2021 10:13:36 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id w15so2160273ljo.10
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 10:13:36 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr41310022lji.465.1621098816301;
 Sat, 15 May 2021 10:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210515073453.GA78379@gmail.com>
In-Reply-To: <20210515073453.GA78379@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 15 May 2021 10:13:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpKm_bCDui-VcRwJWVPDPCFKY_oqRACpTff5zXNr8MjQ@mail.gmail.com>
Message-ID: <CAHk-=whpKm_bCDui-VcRwJWVPDPCFKY_oqRACpTff5zXNr8MjQ@mail.gmail.com>
Subject: Re: [GIT PULL] Stack randomization fix
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 12:35 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> --- a/include/linux/randomize_kstack.h
> +++ b/include/linux/randomize_kstack.h
> @@ -38,7 +38,7 @@ void *__builtin_alloca(size_t size);
>                 /* Keep allocation even after "ptr" loses scope. */     \
> -               asm volatile("" : "=o"(*ptr) :: "memory");              \
> +               asm volatile("" :: "r"(ptr) : "memory");                \
>         }                                                               \

Side note: at some point, a compiler will (correctly) decide that
regardless of the inline asm here, the scope of that allocation is
only that one block.

To be actually reliable, I suspect that add_random_kstack_offset()
should return that pointer as a cookie, and then users should have a

     end_random_kstack_offset(cookie);

at the end of the function that did the add_random_kstack_offset().

And that end_random_kstack_offset() should have *another* "asm
volatile" that uses the pointer.

Note that you need both of the asm volatile barriers: without the
first one, the compiler might decide to move the allocation down, and
without the second one, the compiler might decide the allocation is
out of scope and can be undone before the actual system call or
whatever is done.

Honestly, I don't personally much care (I think this is all stupid
overhead, and think clearing the stack is much better), and I suspect
that current compilers always end up cleaning up alloca at function
exit, so this probably all _works_ as-is. But it's technically fragile
and wrong.

          Linus
