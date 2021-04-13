Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F06835D62D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344480AbhDMDxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241484AbhDMDxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:53:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1EDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:52:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r7so2955896wrm.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=toKmCz2nisSRdvrgW5rw5Wc/krsSKTFMT20yb/oxMiM=;
        b=lf4OkhjlcR1kToEmRa6nmkjI3wMVGCnZgqn23FXt1FDtTpqKXfidSPbzW1nyDSg2vt
         7m0DcGOH70QNXBI31oncfOL8gJ4BHbRv1OhvoOTdEANVdrdVOhY0MhzsJsv3tv4N5e5d
         m7sLLRaDyj5zgTZqR9FH7azQ5DdOWAaO2mUaOBjgp5UCBMQG0wvKaruPNGL3Uph6MscZ
         gAfYo3c7IC0EVkkhwu91zNMxj+B/27BNNbZIausax3qezuHGh1mPM8RagBEuZBY8w/3t
         C03dFV/BMJ1npPgcx1+WKZpM8VZfOCSq1L7gnAFA7AC+7xv1Cyv1ReMzzyazlhZRMOZh
         /YAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=toKmCz2nisSRdvrgW5rw5Wc/krsSKTFMT20yb/oxMiM=;
        b=R4/Ps3xUi28JXgB1G6ldF3q0dO0G8nIWNEjKgVC0FccQ0PtejxO/smlReZ4OAE+lyK
         D6yri37lWAfLDLidyL6VdYtrtxw/8htQlqk63OdNMT1OcksOB1R+k3pABt0ZfPetsI9Q
         ABNtQizTeYEIeDUNT2rgwDXpV/A+hiYfYrpxERtaoGG8mWFSMXwumzM+YhyVgvZl06Wh
         /gHqYQa8OMqMonGe3+x9F5qFoEknTvIJh77PklCzpjG6X1Bxn4fPIUGdx2Cz72nRggDh
         E8pRgMI7QBHXzVkJPflDXpG3UYjH60zW/vrMdaLVn0jHgWg1bj89Iuw6YKi0EIjqzyWg
         goBg==
X-Gm-Message-State: AOAM532RBtofJiEEA8ujP4m1rCd9HArC/3wBQTaTEQ+I4x7M3GvSeqff
        LCnQgGd5a0vPvNMRrbIv/ykToZDVhvrPOXmZ/rxPsQ==
X-Google-Smtp-Source: ABdhPJxF8Ap2B3rFfsdCGZvn0W8SVY/w9eSFkKaViSy95uQrDB0vuEVVn9X6euWV3lnDIIVQFrQPm4lROcZ9wzEP4qc=
X-Received: by 2002:a5d:4e01:: with SMTP id p1mr33895853wrt.128.1618285970840;
 Mon, 12 Apr 2021 20:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210413001110.7209bae6@xhacker>
In-Reply-To: <20210413001110.7209bae6@xhacker>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 13 Apr 2021 09:22:39 +0530
Message-ID: <CAAhSdy059rO99MmZ4ZYePjB9gnJzb+=14uK1-heV+vco-yKc-w@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] riscv: improve self-protection
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 9:46 PM Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
>
> From: Jisheng Zhang <jszhang@kernel.org>
>
> patch1 removes the non-necessary setup_zero_page()
> patch2 is a trivial improvement patch to move some functions to .init
> section
>
> Then following patches improve self-protection by:
>
> Marking some variables __ro_after_init
> Constifing some variables
> Enabling ARCH_HAS_STRICT_MODULE_RWX
>
> Hi Anup,
>
> I kept the __init modification to trap_init(), I will cook a trivial
> series to provide a __weak but NULL trap_init() implementation in
> init/main.c then remove all NULL implementation from all arch.

Yes, it makes sense to do this as a separate series.

Regards,
Anup

>
> Thanks
>
> Since v2:
>   - collect Reviewed-by tag
>   - add one patch to remove unnecessary setup_zero_page()
>
> Since v1:
>   - no need to move bpf_jit_alloc_exec() and bpf_jit_free_exec() to core
>     because RV32 uses the default module_alloc() for jit code which also
>     meets W^X after patch8
>   - fix a build error caused by local debug code clean up
>
>
> Jisheng Zhang (10):
>   riscv: mm: Remove setup_zero_page()
>   riscv: add __init section marker to some functions
>   riscv: Mark some global variables __ro_after_init
>   riscv: Constify sys_call_table
>   riscv: Constify sbi_ipi_ops
>   riscv: kprobes: Implement alloc_insn_page()
>   riscv: bpf: Write protect JIT code
>   riscv: bpf: Avoid breaking W^X on RV64
>   riscv: module: Create module allocations without exec permissions
>   riscv: Set ARCH_HAS_STRICT_MODULE_RWX if MMU
>
>  arch/riscv/Kconfig                 |  1 +
>  arch/riscv/include/asm/smp.h       |  4 ++--
>  arch/riscv/include/asm/syscall.h   |  2 +-
>  arch/riscv/kernel/cpufeature.c     |  2 +-
>  arch/riscv/kernel/module.c         | 10 ++++++++--
>  arch/riscv/kernel/probes/kprobes.c |  8 ++++++++
>  arch/riscv/kernel/sbi.c            | 10 +++++-----
>  arch/riscv/kernel/smp.c            |  6 +++---
>  arch/riscv/kernel/syscall_table.c  |  2 +-
>  arch/riscv/kernel/time.c           |  2 +-
>  arch/riscv/kernel/traps.c          |  2 +-
>  arch/riscv/kernel/vdso.c           |  4 ++--
>  arch/riscv/mm/init.c               | 16 +++++-----------
>  arch/riscv/mm/kasan_init.c         |  6 +++---
>  arch/riscv/mm/ptdump.c             |  2 +-
>  arch/riscv/net/bpf_jit_comp64.c    |  2 +-
>  arch/riscv/net/bpf_jit_core.c      |  1 +
>  17 files changed, 45 insertions(+), 35 deletions(-)
>
> --
> 2.31.0
>
>
