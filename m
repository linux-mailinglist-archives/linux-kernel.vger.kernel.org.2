Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48C0308257
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 01:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhA2AW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 19:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhA2AWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 19:22:48 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9140AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 16:22:07 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l18so5380349pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 16:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKL+JHPG3PhegsC2eNNTIj8bjTzjEUN9jv1phV2bHXI=;
        b=MK35RJy7wzotB7/sdEGFxgOsh/xT/A0vlz+PAvY/xdaHeFRC72OWd0qa9/+jgiI3Ky
         4yc/zYbWwVFhQpLknZUzJpyNYH6JUEQvl5++Vu8w3zXIOnleM+c6qfGgiTtgJ+eKulf4
         /6rhwwDWPLzSkP5inrtdSUBEQtvPooFFx4RqdTdOxnqgIDurwwvLGSiL393BDWmK0Kcs
         /dir550OvEk1d0lmB4AtC5IKSLeUQHvhgW0pwMMnBzhTV5lJKCmy15/9hcb3MfJ6GAw5
         2I9qvBRdK8kj6IzXpqILfECeO8oIOKFLptRqaLnaCkqUWW0xZ930Qn8U5nvoo4+8JmU5
         gSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKL+JHPG3PhegsC2eNNTIj8bjTzjEUN9jv1phV2bHXI=;
        b=CEf9Fu3hdEsSlcCpkF8Eb3BvywwRhX5HlcIY8B81mAUeEuZArjq1lfFFgSuXOkn0G+
         3WfvIMIFTKj2Y/mA2UtmMw3WtLm+zSnOTf1vPJ6wbjScOOH8j4BsDO6kRUrxYmt/9mow
         YkMGK7neFf3nXqam1oV+VfcyiaV1fcivvH3HbMw0BSBV2bChewRijTCIuVxe1b2SYAJx
         2LBM27pdEAQ3kBZZcAUt7oI1+uNKx172oLmyC+jQhfvEghJ3yGYWPJXPS4ROx9E1ovkT
         pybQVm3Qrnn3kJ1Pt6F99tHTT4MKOFBFJptPKQNya5lyQpT6QPoMpQuOgJP7+Wy38cFo
         FG3A==
X-Gm-Message-State: AOAM533Vnt0VCvbDu1+yFlflrwqnuJKbz3KmxY4cg1peMR6g1f3st0lS
        /k9s7i4+wjWOnXZwb0JzOCRen5OI3wBeRhWVcFTV+g==
X-Google-Smtp-Source: ABdhPJxLRcPBTJkwfQfzcdbMgZ5A33dd+rH+FULDmdc0vyRSNCIX/zXX9aRotXKUAdprfS4HFSGE7OyF8C0SOsY7hSQ=
X-Received: by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id
 97-20020a170902026ab02900daaf4777c7mr1917873plc.10.1611879726950; Thu, 28 Jan
 2021 16:22:06 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0MbxMC9iLe0NGR0ttLY7sZDjsrgKvfRZOXVJLjzDNKmA@mail.gmail.com>
 <20210128193422.241155-1-ndesaulniers@google.com> <CAMj1kXE5uw4+zV3JVpfA2drOD5TZVMs5a_E5wrrnzjEYc=E_fA@mail.gmail.com>
In-Reply-To: <CAMj1kXE5uw4+zV3JVpfA2drOD5TZVMs5a_E5wrrnzjEYc=E_fA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 28 Jan 2021 16:21:55 -0800
Message-ID: <CAKwvOdneTwx8LwKyAA+iMELEBWBxu2nkr9dVuQ=+hgsZROu-tw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: kprobes: rewrite test-[arm|thumb].c in UAL
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 28 Jan 2021 at 20:34, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > +       TEST_RX("tbh    [pc, r",7, (9f-(1f+4))>>1,", lsl #1]",
> >
> On Thu, Jan 28, 2021 at 1:03 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> Why is this change needed? Are the resulting opcodes equivalent? Does
> GAS infer the lsl #1 but Clang doesn't?

Yes; it seems if you serialize/deserialize this using GNU `as` and
objdump, that's the canonical form (GNU objdump seems to print in UAL
form, IIUC).  I didn't see anything specifically about `tbh` in
https://developer.arm.com/documentation/dui0473/c/writing-arm-assembly-language/assembly-language-changes-after-rvctv2-1?lang=en
but it's what GNU objdump produces and what clang's integrated
assembler accepts.

> >
> >  #define _DATA_PROCESSING32_DNM(op,s,val)                                       \
> > -       TEST_RR(op s".w r0,  r",1, VAL1,", r",2, val, "")                       \
> > +       TEST_RR(op s"   r0,  r",1, VAL1,", r",2, val, "")                       \
>
> What is wrong with these .w suffixes? Shouldn't the assembler accept
> these even on instructions that only exist in a wide encoding?

Yeah, I'm not sure these have anything to do with UAL.  Looking at
LLVM's sources and IIRC, LLVM has "InstAlias"es it uses for .w
suffixes. I think I need to fix those in LLVM for a couple
instructions, rather than modify these in kernel sources.  I'll split
off the arm-test.c and thumb-test.c into separate patches, fix LLVM,
and drop the .w suffix changes to thumb-test.c.

-- 
Thanks,
~Nick Desaulniers
