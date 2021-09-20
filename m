Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790C3410FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 08:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhITG43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 02:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhITG41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 02:56:27 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A21C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 23:55:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c22so57208172edn.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 23:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VCi78mN2x2kHh1l5Km4KZVKR5L77ZE21c4hjNnlzASE=;
        b=czLC+Ngkh9GhtjcAnabJuWFebjDLfRI4M+rF3x6yxdDZ97gkMUCD7+kmL5o7Sw0MjA
         BlxSyWFW7kRDrCwOXWNU3t83vXCRCYy2iGz211SlEkBIjRq/zQTN6Y3qorISuiv4X5P9
         /fLzafYo4yc0n2ZdUin4HmgYLlomWABX0GyQWiJnCsnEyf99jeZ9qIPaRx5AGAd9cTE5
         Fijw8Ezp/DiMjvgJ8m26Z7SiA5scBcVX5YTNW0Jiuu2vjw3qDfi+saKv0lYXTWRDZft8
         y2+nvrHqIl6miK0MIWOZkpuq8Gs97VPmnzoyRRww9YfS1FrdhoCjX+fQ6pyK1wBQsaNf
         5r6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VCi78mN2x2kHh1l5Km4KZVKR5L77ZE21c4hjNnlzASE=;
        b=UZdjaYAgpFGpZDn5BA731OK5geCjwy/CA6WMiQA6CpCrXbEKPRijUqVxpsZGX7hZBg
         GD7DwQ0ibchsWlM5IsmJ1wB5pXGUunC96IRxnWhmRMqJcLZz8eUQfPt735O0hKVV8tiA
         lXtI6u6dqEDJhWxUfAFSHqPtjPv/NA7s1Kwu3nXnf9sV8VWUVlG5dObzoCym/guWTEWl
         MWSa2rORBWvAbRpwF5a9/ewK5wSZ6TPqUw/+pNr1n4GKegscQ7fZnTejycCOMnKunQLE
         VTnPUtTad+Aen35oJgwgEKWOubhIyYc2fDzEtbwM/EJIPEscApWfulK/Tlr48B/Oxy2v
         faqg==
X-Gm-Message-State: AOAM533utyMOkYaJ8Xsb5yB6xxDlqiNoV5n1h9kxjysm5YkYZdqyP/64
        t9PhOxL0wmqHrW9c/+v0crsRM3AqQirS/qhFHadKmw==
X-Google-Smtp-Source: ABdhPJwci1SBywa3LSGy8b+OOj/3yOi53811KIsJWRaFVLVD+hgE++znRxTu8J1NZxbBbVPQjcGeVbba2wOLklCLgAk=
X-Received: by 2002:aa7:d1d3:: with SMTP id g19mr26462988edp.103.1632120899694;
 Sun, 19 Sep 2021 23:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvoyDqbCnmcVMHCO3Zxn9=FGTjyTH9u=7FT7rCz-dh6JA@mail.gmail.com>
 <YUgDV31uzAQy5IcN@archlinux-ax161>
In-Reply-To: <YUgDV31uzAQy5IcN@archlinux-ax161>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 20 Sep 2021 12:24:48 +0530
Message-ID: <CA+G9fYv-EHy3-+ALV3Ev0k6J=e0_y7Xm2KgGFuE4XXFHp5EazA@mail.gmail.com>
Subject: Re: x86_64: clang-10: <instantiation>:2:2: error: unknown use of
 instruction mnemonic without a size suffix
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        llvm@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Mon, 20 Sept 2021 at 09:13, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Naresh,
>
> On Mon, Sep 20, 2021 at 08:55:46AM +0530, Naresh Kamboju wrote:
> > [Please ignore this email if it is already reported ]
> >
> > Following build warnings/ errors noticed while building linux mainline
> > master branch
> > with clang-10 for x86_64 architecture.
> > But clang-11, clang-12 and clang-13 build pass.
> >
> > <instantiation>:2:2: error: unknown use of instruction mnemonic
> > without a size suffix
> >  lsl %rax, %rax
> >  ^
> > <instantiation>:1:1: note: while in macro instantiation
> > LOAD_CPU_AND_NODE_SEG_LIMIT %rax
> > ^
> > <instantiation>:2:2: note: while in macro instantiation
> >  GET_PERCPU_BASE %rax
> >  ^
> > /builds/linux/arch/x86/entry/entry_64.S:887:2: note: while in macro
> > instantiation
> >  SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
> >  ^
> > make[3]: *** [/builds/linux/scripts/Makefile.build:379:

> Thanks for the report. This is another case where the implicit switch to
> the integrated assembler exposed a previously fixed issue in LLVM:
>
> https://github.com/ClangBuiltLinux/linux/issues/1079
>
> This cannot be fixed in the LLVM 10 branch as it is no longer updated so
> if you want to keep testing with clang-10 for x86_64 on mainline, please
> add 'LLVM_IAS=0' to your make command like we did in our own CI.

We will update our gitlab pipeline CI configs with 'LLVM_IAS=0'.

>
> As a quick aside, would you mind updating my email address in your
> system for reports to nathan@kernel.org? It will ensure it gets sent to
> the correct inbox so that I do not miss things, as I do not use my
> personal address for kernel development anymore.

Noted.

- Naresh
