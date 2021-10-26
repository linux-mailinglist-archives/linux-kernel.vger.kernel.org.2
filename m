Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB92D43BE1B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 01:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbhJZXuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 19:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237057AbhJZXug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 19:50:36 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98078C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 16:48:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v20so687620plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 16:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=njkqslFi81CJdgjpKZ7lE+Q4NAM4QezMjn79c9rwW5I=;
        b=yFhDg/St14S+JDyXq1zwYeKBE7rKhdYF5Zw3ZgGu4s1uaqfuZ0/bYQX1NECpjNzGq4
         wAM2ynstuBaRQAZx5AXhAWAKiSpv5XwruTRmn0f6EDokEdhN1eeLaYi7lJs7mDbopAaz
         7sCQUnYsUbUJ5YFDwl1acbZCre3GkfxoIzyZBoJ2YDbnxCbe9j6X+eFDAjWcZI/Po8Do
         EykTs0QggjLE4JX+GkQ6825B038xMW+JIUUeBtpKTyevs0tgoDRRWRi/vHX8g2B34AyJ
         GZTz43gHVYLExc9thO9e6wAs1nLbTFz1Xvs2R6LkqhyTk4Id1tTnoJC5bOz/lNb0aCGu
         KmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=njkqslFi81CJdgjpKZ7lE+Q4NAM4QezMjn79c9rwW5I=;
        b=YZQPKpy8lxp52mRqU0nbnTf4a2LsEqgHG/QvDWX7E/EOsTqBpvYueiXYvWaZRX6iHM
         I3wOSOFJNtnG72KzodkSE+sg3OTbNzqpWNvpx3Z6Ku6FmY6nFvLSVL+aK1Gmbj93HaKh
         gi901B1STZdq5XLwlfzs8/mJ38WeyTjuOtdF5ggZ/EPXf0bdYnBdQOc2RuSd3nPlr6eX
         7sAwbEWMZgTTCj4O0sA6noYVmw7D3Os7H4hbd/1oviHhqdrXJ/9svLlis5r26ZY6Ov7e
         ZqmE/SJb5CxeP1FWD1OOsAguRsCuy2m/MTloUMLJMABWeYoVm9DfU0IPg/kZ/n7PsAcu
         WUyA==
X-Gm-Message-State: AOAM531sgbEY4nJA4pqdSlBUwvc29eQ9XERnclLfTWrKaYr+jh/ce2Np
        mJNE7iZ8amPKLhBSileGhyGO4Q==
X-Google-Smtp-Source: ABdhPJyuv44a0itknKhOqmu4SkSph1yjSLOlDm2TgYU9DxwigHNlYFAslzREtZoefsT/F90ImhvUvQ==
X-Received: by 2002:a17:90a:4b85:: with SMTP id i5mr2110945pjh.25.1635292091032;
        Tue, 26 Oct 2021 16:48:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:5e10:676c:ab93:f48d:23ae])
        by smtp.gmail.com with ESMTPSA id i5sm20437959pgo.36.2021.10.26.16.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:48:10 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:48:10 -0700 (PDT)
X-Google-Original-Date: Tue, 26 Oct 2021 16:24:16 PDT (-0700)
Subject:     Re: [PATCH 0/2] ftrace: make sure preemption disabled on recursion testing
In-Reply-To: <8c7de46d-9869-aa5e-2bb9-5dbc2eda395e@linux.alibaba.com>
CC:     guoren@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, tglx@linutronix.de, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, jpoimboe@redhat.com,
        jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
        joe.lawrence@redhat.com, colin.king@canonical.com,
        mhiramat@kernel.org, peterz@infradead.org, npiggin@gmail.com,
        jszhang@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        live-patching@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     yun.wang@linux.alibaba.com
Message-ID: <mhng-95994d12-e1d9-43b3-bef0-c5c844ffcf86@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2021 22:39:16 PDT (-0700), yun.wang@linux.alibaba.com wrote:
> The testing show that perf_ftrace_function_call() are using
> smp_processor_id() with preemption enabled, all the checking
> on CPU could be wrong after preemption, PATCH 1/2 will fix
> that.
>
> Besides, as Peter point out, the testing of recursion within
> the section between ftrace_test_recursion_trylock()/_unlock()
> pair also need the preemption disabled as the documentation
> explained, PATCH 2/2 will make sure on that.
>
> Michael Wang (2):
>   ftrace: disable preemption on the testing of recursion
>   ftrace: prevent preemption in perf_ftrace_function_call()
>
>  arch/csky/kernel/probes/ftrace.c     |  2 --
>  arch/parisc/kernel/ftrace.c          |  2 --
>  arch/powerpc/kernel/kprobes-ftrace.c |  2 --
>  arch/riscv/kernel/probes/ftrace.c    |  2 --
>  arch/x86/kernel/kprobes/ftrace.c     |  2 --
>  include/linux/trace_recursion.h      | 10 +++++++++-
>  kernel/livepatch/patch.c             |  6 ------
>  kernel/trace/trace_event_perf.c      | 17 +++++++++++++----
>  kernel/trace/trace_functions.c       |  5 -----
>  9 files changed, 22 insertions(+), 26 deletions(-)

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com> # RISC-V
