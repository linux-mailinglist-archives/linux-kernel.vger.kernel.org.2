Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EBF4421D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 21:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhKAUri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 16:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhKAUrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:47:32 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DDCC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 13:44:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bu18so21522772lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4dtHoduNR/2xORhNqbNCHn1xtKRvr6GuXfcOktVL7Bo=;
        b=dqJf7ae/2MynopZB3QoE8WNMW+9Q8wobMYgadbrjVHr74FifxrLxJtNTcnEknk+txc
         wLPUUOjyxyvXkv5x593cQFzjhqMuBANU6eoLBSADxhJB07a7N2t8VmzZWSXLKUGRZ+4t
         RMTBwLTcOcz2t/z6PoXjHSlxSKI+WoICo7Efc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4dtHoduNR/2xORhNqbNCHn1xtKRvr6GuXfcOktVL7Bo=;
        b=nSrTLRLU7lGYpu0SEEY5Hroze6SkACnVXbHnxY3iruF/McaHZBLXyTXhFk9ITFRklv
         a7VOeKWc3alyeE2AHSoU0LBG3ySV6Tn6rWPys5xY9/Q6/R6jX9tCiVrJzeozglyYgtW2
         KYCxzY8ENg/4qXD/MFBFymDdLs1o8OaPrUjaVLdcsshPowwWpqewWV+2SniO3VMYRTpo
         Dx6VCRh7qJjAnlWVIi5rjrnpaNw2uOJ86qpkaSvvFxHaG3FAQ9IU6tT+wkcSjZkNoZNU
         TIxpKYfUhWFMPwRJF8pOCTt2jT6IwaRfssU0sI7Rbs2SR63oilSWfXc0ZdmrdYnBvZFi
         e9CQ==
X-Gm-Message-State: AOAM5332n829sKDDXOqCXFU7OlN2gSwEGqLvIgXBJCH27UBbn4Rcyogm
        X8IxbkthnQxx8jlDW5obJdsVElvRG9qEflgQ
X-Google-Smtp-Source: ABdhPJyZ0+ZBpBEunAqqxVJXFC+i3UbUg9hurkBzD73ozWnAr30+kTmFJB5Xj8UMBh9SNTnZTTr/bw==
X-Received: by 2002:a05:6512:b83:: with SMTP id b3mr29887851lfv.654.1635799496367;
        Mon, 01 Nov 2021 13:44:56 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id v14sm661872lfo.124.2021.11.01.13.44.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 13:44:55 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id x27so38699952lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 13:44:55 -0700 (PDT)
X-Received: by 2002:a05:6512:10c3:: with SMTP id k3mr30766094lfg.150.1635799495032;
 Mon, 01 Nov 2021 13:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <163572864256.3357115.931779940195622047.tglx@xen13> <163572864563.3357115.8793939214537874196.tglx@xen13>
In-Reply-To: <163572864563.3357115.8793939214537874196.tglx@xen13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 13:44:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNzL3AaVNruwLv=kcGXi1EbJN9CZC6GoRY66t6WFcfGg@mail.gmail.com>
Message-ID: <CAHk-=wgNzL3AaVNruwLv=kcGXi1EbJN9CZC6GoRY66t6WFcfGg@mail.gmail.com>
Subject: Re: [GIT pull] objtool/core for v5.16-rc1
To:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2021 at 6:16 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> please pull the latest objtool/core branch from:

Hmm. I've pulled this, but I'm not happy about the new warnings it
generates with an allmodconfig build:

  vmlinux.o: warning: objtool: __do_fast_syscall_32()+0xa: call to
stackleak_track_stack() leaves .noinstr.text section
   ..
    do_syscall_64()+0x9: call to stackleak_track_stack ...
    do_int80_syscall_32()+0x9: call to stackleak_track_stack ...
    exc_general_protection()+0x22: call to stackleak_track_stack ...
    fixup_bad_iret()+0x20: call to stackleak_track_stack ...
    mce_setup()+0x18: call to memset ...
    do_machine_check()+0x27: call to stackleak_track_stack ...
    rcu_dynticks_eqs_enter()+0x0: call to rcu_dynticks_task_trace_enter ...
    rcu_dynticks_eqs_exit()+0xe: call to rcu_dynticks_task_trace_exit ...
    rcu_nmi_enter()+0x36: call to __kasan_check_read ...
    .entry.text+0x10e6: call to stackleak_erase ...
    .entry.text+0x143: call to stackleak_erase ...
    .entry.text+0x17d9: call to stackleak_erase ...

most seem to be about the stackleak thing, but there's a memset in
there too, and rcu_dynticks_task_trace_enter/exit and
__kasan_check_read..

It may be compiler-dependent, this is with F34 and gcc 11.2.1 20210728.

With my actual normal config (and clang), I don't see any of these,
but that's not only a different compiler, it's a much smaller config
that has no kasan/stackleak etc.

                  Linus
