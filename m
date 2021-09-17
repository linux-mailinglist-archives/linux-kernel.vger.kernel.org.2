Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48023410136
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 00:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244721AbhIQWZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 18:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhIQWY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:24:59 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356C7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 15:23:36 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id m11so14057731ioo.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 15:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVonwcgT3P/AR3qomjxOAA0wy7W8W2TTzNju3rynBUU=;
        b=AgQWA99UqF2qEUd78ncVB2B9RKQ1elJYxaXsOP4lQ4rns2l/1ROkqqw5NdXVX6ewpQ
         cZHdw6Vv63O/TGhsr1n0LfYIC0xn6KablX4W6ExjDb9PJNNCIB6CC7qc8eMo1HWcKGRU
         E/6JXg5dpvQ/unwMAQVstiy+TGPIkE0UUBIQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVonwcgT3P/AR3qomjxOAA0wy7W8W2TTzNju3rynBUU=;
        b=NNNpGMw9/TBQJV6Uz/KGo/jmTno/BaRtQl2X4jTRqPmQn/W6h+L7OUl66LlYG275P8
         bJY5O3cmlC8/Q49im96aCRBSSmcLqMJexzoScsVS7zJSlc4rcas79VSQ7jTgSW/lKHQ1
         CxClBaM3aL5b4o7+CXUrsAcsD+ws8+Z/3TnddWpfcZ71R2EgqQ9KS5gcECw0mVoiEYfp
         Y62BC6YVsA7aoSk5n+l79tFYOTJyursHL8aLm9NqJu2bjtAMEz46gTV+BfLX1P7Nikg4
         5vpDpnWBaGryUBeBhNJUK8oReo2gEMhvkRtTOLnn9by/g/WCCuypRDFyU3AoLTlecqCd
         /rgg==
X-Gm-Message-State: AOAM533yW5tiLudSgLgaNCVXzgjbQKbmtEtqS3GvN7bwP++pCDmqyjoX
        6xIlTEPYaszVpzcasM1ZceWITmVcicNnbUkv3BA=
X-Google-Smtp-Source: ABdhPJzohWnn7VWlS25asJt9FxcRnc9snTX2m1ZDeukUiimksCd/SASpbkcAGUxLJPHD+e+wWsWJWA==
X-Received: by 2002:a05:6638:3813:: with SMTP id i19mr10721567jav.16.1631917415511;
        Fri, 17 Sep 2021 15:23:35 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com. [209.85.166.171])
        by smtp.gmail.com with ESMTPSA id r16sm4484869ilj.77.2021.09.17.15.23.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 15:23:35 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id b8so11820055ilh.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 15:23:35 -0700 (PDT)
X-Received: by 2002:a05:6e02:1ba9:: with SMTP id n9mr4013308ili.204.1631917414788;
 Fri, 17 Sep 2021 15:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <202109151423.43604.linux@zary.sk> <202109162227.17415.linux@zary.sk>
 <20210916210509.GG4323@worktop.programming.kicks-ass.net> <202109171011.31916.linux@zary.sk>
 <YURdxNpH8YNQZQT7@hirez.programming.kicks-ass.net>
In-Reply-To: <YURdxNpH8YNQZQT7@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Sep 2021 15:23:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_-bRjcJdXubdUUsTph+DH-5f77FmkbNCfFVYg=Td2zw@mail.gmail.com>
Message-ID: <CAHk-=wj_-bRjcJdXubdUUsTph+DH-5f77FmkbNCfFVYg=Td2zw@mail.gmail.com>
Subject: Re: [PATCH] x86/iopl: Fake iopl(3) CLI/STI usage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ondrej Zary <linux@zary.sk>, Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 2:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> +       nr_copied = insn_fetch_from_user(regs, buf);

Ugh. This is the code that does the magic "add CS base" stuff.

Do we really want to do that instead of just doing

        unsigned char byte = get_user((char __user *)regs->ip);

when later on the debug code does:

> +               pr_err("%s[%d] attempts to use CLI/STI, pretending it's a NOP, ip:%lx",
> +                      current->comm, task_pid_nr(current), regs->ip);
> +               print_vma_addr(KERN_CONT " in ", regs->ip);
> +               pr_cont("\n");

and prints out the wrong IP address?

IOW, I'd argue that you should get it right in both places, or not try
to get it right in one but not the other.

I think the proper thing to do is perhaps something like

        unsigned long cs_base = 0;
        unsigned long address;
        unsigned char byte;

        if (!user_64bit_mode(regs)) {
                cs_base = insn_get_seg_base(regs, INAT_SEG_REG_CS);
                if (cs_base = -1ul)
                        return false;
        }

        // We could check the limit too, but nobody cares
        address = regs->ip + cs_base;
        if (get_user(byte, (const char __user *)address))
                return false;

        // cli/sti?
        if (byte != 0xfa && byte ! 0xfb)
                return false;

and now you have the actual linear address in 'address' and can at
least print it out correctly.

Hmm? Because it's just sad to get it right in one place, and wrong in
another. And we don't actually _want_ any of the instruction
fetch/decode stuff.

           Linus
