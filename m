Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A18E325D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 07:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhBZGW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 01:22:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhBZGWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 01:22:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B902564E02;
        Fri, 26 Feb 2021 06:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614320503;
        bh=BX4ANU+deMF/gCnboQiDGoO4O8tphEU0zGUoRnCR8+g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qfHHydEIR/PrCEjFmvW05eOKcqgxnIKVRlNys0hmd4Jt6eF4++8eqlDkNDxD8fMb7
         z9uFv19hoTaovxU4em4pKiE/pnRtfkxl+Od1tBuqagziI9T7rTErCnaDEtPlyaiPLU
         SlXlvcZCqdeHj+zE5MfwcqLUwvG4NiEBiM3xrXnoQ59mPLoY3iFTRm+r4i0KULpw2V
         T4jamGddsxz0q0TNA60vkOYo/tJWe4AWQgCWoj/68JBPzCtlP0esZmvOZVuhaN51WO
         PRZyjsEEfQqRJAM1cTQmxTlGjW+L2V3MeCXFP4gYjw5wQ4h7NtLN7GBDdGF06i3+ie
         VZuhpgLH/pU2Q==
Received: by mail-lj1-f177.google.com with SMTP id a17so9367370ljq.2;
        Thu, 25 Feb 2021 22:21:42 -0800 (PST)
X-Gm-Message-State: AOAM531njM7/3G+CoNMyvivOhGJOYIQjXZ0gW2EMaNFQC2G2a2l9MYSY
        yOVzlex3ZjNRugfjkgxc4ejOjm2o8YiVjL7WnVw=
X-Google-Smtp-Source: ABdhPJz6GQ02m5yKncjhLrHyBdN+zIU3XRAYgog6pHcVmxWLyha3SvidqvgQS/WKsUsg1QE4UoT+9SSgSw5aoCdPnI4=
X-Received: by 2002:a2e:919a:: with SMTP id f26mr793595ljg.508.1614320500903;
 Thu, 25 Feb 2021 22:21:40 -0800 (PST)
MIME-Version: 1.0
References: <20210225142841.3385428-1-arnd@kernel.org> <20210225142841.3385428-2-arnd@kernel.org>
In-Reply-To: <20210225142841.3385428-2-arnd@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 26 Feb 2021 14:21:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQriSy2rLHkvJ+YwHtyBE3BwneZQ-FqwSUzLjSRc9gRcA@mail.gmail.com>
Message-ID: <CAJF2gTQriSy2rLHkvJ+YwHtyBE3BwneZQ-FqwSUzLjSRc9gRcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation: features: refresh feature list
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Youling Tang <tangyouling@loongson.cn>,
        Xingxing Su <suxingxing@loongson.cn>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Archer Yan <ayan@wavecomp.com>,
        Pekka Enberg <penberg@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        Zong Li <zong.li@sifive.com>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Arnd,

I'm very glad to see C-SKY & RISC-V features updated.

Signed-off-by: Guo Ren <guoren@kernel.org>

On Thu, Feb 25, 2021 at 10:29 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Run the update script to document the recent feature additions
> on riscv, mips and csky.
>
> Fixes: c109f42450ec ("csky: Add kmemleak support")
> Fixes: 8b3165e54566 ("MIPS: Enable GCOV")
> Fixes: 1ddc96bd42da ("MIPS: kernel: Support extracting off-line stack traces from user-space with perf")
> Fixes: 74784081aac8 ("riscv: Add uprobes supported")
> Fixes: 829adda597fe ("riscv: Add KPROBES_ON_FTRACE supported")
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Fixes: dcdc7a53a890 ("RISC-V: Implement ptrace regs and stack API")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  Documentation/features/debug/gcov-profile-all/arch-support.txt  | 2 +-
>  Documentation/features/debug/kmemleak/arch-support.txt          | 2 +-
>  Documentation/features/debug/kprobes-on-ftrace/arch-support.txt | 2 +-
>  Documentation/features/debug/kprobes/arch-support.txt           | 2 +-
>  Documentation/features/debug/kretprobes/arch-support.txt        | 2 +-
>  Documentation/features/debug/uprobes/arch-support.txt           | 2 +-
>  Documentation/features/perf/kprobes-event/arch-support.txt      | 2 +-
>  Documentation/features/perf/perf-regs/arch-support.txt          | 2 +-
>  Documentation/features/perf/perf-stackdump/arch-support.txt     | 2 +-
>  Documentation/features/sched/numa-balancing/arch-support.txt    | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
> index 416c70345946..b39c1a5de3f3 100644
> --- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
> +++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
> @@ -16,7 +16,7 @@
>      |        ia64: | TODO |
>      |        m68k: | TODO |
>      |  microblaze: |  ok  |
> -    |        mips: | TODO |
> +    |        mips: |  ok  |
>      |       nds32: | TODO |
>      |       nios2: | TODO |
>      |    openrisc: | TODO |
> diff --git a/Documentation/features/debug/kmemleak/arch-support.txt b/Documentation/features/debug/kmemleak/arch-support.txt
> index 915185634611..e9ac415f8aec 100644
> --- a/Documentation/features/debug/kmemleak/arch-support.txt
> +++ b/Documentation/features/debug/kmemleak/arch-support.txt
> @@ -10,7 +10,7 @@
>      |         arc: |  ok  |
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
> -    |        csky: | TODO |
> +    |        csky: |  ok  |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> index aade7816cb87..96156e8802a7 100644
> --- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> +++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> @@ -22,7 +22,7 @@
>      |    openrisc: | TODO |
>      |      parisc: |  ok  |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: |  ok  |
>      |          sh: | TODO |
>      |       sparc: | TODO |
> diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
> index 4b663c124d1c..ee95ed61909a 100644
> --- a/Documentation/features/debug/kprobes/arch-support.txt
> +++ b/Documentation/features/debug/kprobes/arch-support.txt
> @@ -22,7 +22,7 @@
>      |    openrisc: | TODO |
>      |      parisc: |  ok  |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: |  ok  |
>      |          sh: |  ok  |
>      |       sparc: |  ok  |
> diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
> index 5449bb808442..612cb97d47b8 100644
> --- a/Documentation/features/debug/kretprobes/arch-support.txt
> +++ b/Documentation/features/debug/kretprobes/arch-support.txt
> @@ -22,7 +22,7 @@
>      |    openrisc: | TODO |
>      |      parisc: |  ok  |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: |  ok  |
>      |          sh: |  ok  |
>      |       sparc: |  ok  |
> diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
> index 2820177787e1..8bd5548a4485 100644
> --- a/Documentation/features/debug/uprobes/arch-support.txt
> +++ b/Documentation/features/debug/uprobes/arch-support.txt
> @@ -22,7 +22,7 @@
>      |    openrisc: | TODO |
>      |      parisc: | TODO |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: |  ok  |
>      |          sh: | TODO |
>      |       sparc: |  ok  |
> diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
> index 75739a0007e0..78f3fe080f0e 100644
> --- a/Documentation/features/perf/kprobes-event/arch-support.txt
> +++ b/Documentation/features/perf/kprobes-event/arch-support.txt
> @@ -22,7 +22,7 @@
>      |    openrisc: | TODO |
>      |      parisc: |  ok  |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: |  ok  |
>      |          sh: |  ok  |
>      |       sparc: |  ok  |
> diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
> index ea8b6d96633a..5bf3b1854a1f 100644
> --- a/Documentation/features/perf/perf-regs/arch-support.txt
> +++ b/Documentation/features/perf/perf-regs/arch-support.txt
> @@ -16,7 +16,7 @@
>      |        ia64: | TODO |
>      |        m68k: | TODO |
>      |  microblaze: | TODO |
> -    |        mips: | TODO |
> +    |        mips: |  ok  |
>      |       nds32: | TODO |
>      |       nios2: | TODO |
>      |    openrisc: | TODO |
> diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
> index 87165861037e..d88659bb4fc1 100644
> --- a/Documentation/features/perf/perf-stackdump/arch-support.txt
> +++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
> @@ -16,7 +16,7 @@
>      |        ia64: | TODO |
>      |        m68k: | TODO |
>      |  microblaze: | TODO |
> -    |        mips: | TODO |
> +    |        mips: |  ok  |
>      |       nds32: | TODO |
>      |       nios2: | TODO |
>      |    openrisc: | TODO |
> diff --git a/Documentation/features/sched/numa-balancing/arch-support.txt b/Documentation/features/sched/numa-balancing/arch-support.txt
> index bfcfaff67a1b..9affb7c2c500 100644
> --- a/Documentation/features/sched/numa-balancing/arch-support.txt
> +++ b/Documentation/features/sched/numa-balancing/arch-support.txt
> @@ -22,7 +22,7 @@
>      |    openrisc: |  ..  |
>      |      parisc: |  ..  |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: |  ok  |
>      |          sh: |  ..  |
>      |       sparc: | TODO |
> --
> 2.29.2
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
