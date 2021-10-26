Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29F143AC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 08:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhJZGrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 02:47:08 -0400
Received: from mail-ua1-f49.google.com ([209.85.222.49]:46958 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhJZGrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 02:47:07 -0400
Received: by mail-ua1-f49.google.com with SMTP id x3so7867884uar.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 23:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qVyQe2fJcvVu4rwWNArN64jmUQrjVOWtiM22QUfv30=;
        b=lCL0uQP4RkcnSLzYxRRiHl6wqeiB7e2MlUY5c13pnnCUZ3fyyu/P434OKHda9z3Tgq
         lQp0cykSinNfR7jDvUH3PD6Tp3UWoDI3IWaTTehI4NolxnVnz//wmlKU5pWc/3nFfJEP
         NqbKJkq6nrn7apxgIs5FGeX21iKhon5CzrwZ+FbXd0m4KnW4L9voDE9uIZAeGS09xmZv
         Nk8RRXy3B7w/3XJDY6tMxVs5+Ica38/W4RXSrBkB895BKXcPA5ynAgDKKuT6qHm7kZYR
         RCCV5DITR4ttGCS8U5a4sy63O5XQAJOtqEJ0aTS4B5ZjYX8Rl18a5gxeOQSJMolKei2Z
         HJNA==
X-Gm-Message-State: AOAM530MeYHl0AuWFvJzs5n4NZO0tYRfmYFiKwgEtAtXFjxUi7LWLBqN
        UU2SwMZDfw2Kx8YjCPhFqUGsQ65pcMbvZQ==
X-Google-Smtp-Source: ABdhPJyVaH5t6m6JT5YqETHlr/1CnjugZFjEkcg6m7W3+7EMDmr/Pb5Qbh2TNlywSxVcpLDgKldnvA==
X-Received: by 2002:ab0:344e:: with SMTP id a14mr20767729uaq.63.1635230683300;
        Mon, 25 Oct 2021 23:44:43 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id m186sm4177340vsm.11.2021.10.25.23.44.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 23:44:43 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id e5so20029263uam.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 23:44:42 -0700 (PDT)
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr21049182vsl.9.1635230682605;
 Mon, 25 Oct 2021 23:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUPWOjJfJohxLJefHOrJBtXZ0xfHQt4=hXpUXnasiN+AQ@mail.gmail.com>
 <830eda64-6e66-c61b-ceaa-57be87783b2c@w6rz.net>
In-Reply-To: <830eda64-6e66-c61b-ceaa-57be87783b2c@w6rz.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Oct 2021 08:44:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+jgNK8QCEysHnURkpUcazPOoepK32XzV8UGwVQdL5tw@mail.gmail.com>
Message-ID: <CAMuHMdU+jgNK8QCEysHnURkpUcazPOoepK32XzV8UGwVQdL5tw@mail.gmail.com>
Subject: Re: Out-of-bounds access when hartid >= NR_CPUS
To:     re@w6rz.net
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 2:37 AM Ron Economos <re@w6rz.net> wrote:
> On 10/25/21 8:54 AM, Geert Uytterhoeven wrote:
> > When booting a kernel with CONFIG_NR_CPUS=4 on Microchip PolarFire,
> > the 4th CPU either fails to come online, or the system crashes.
> >
> > This happens because PolarFire has 5 CPU cores: hart 0 is an e51,
> > and harts 1-4 are u54s, with the latter becoming CPUs 0-3 in Linux:
> >    - unused core has hartid 0 (sifive,e51),
> >    - processor 0 has hartid 1 (sifive,u74-mc),
> >    - processor 1 has hartid 2 (sifive,u74-mc),
> >    - processor 2 has hartid 3 (sifive,u74-mc),
> >    - processor 3 has hartid 4 (sifive,u74-mc).
> >
> > I assume the same issue is present on the SiFive fu540 and fu740
> > SoCs, but I don't have access to these.  The issue is not present
> > on StarFive JH7100, as processor 0 has hartid 1, and processor 1 has
> > hartid 0.
> >
> > arch/riscv/kernel/cpu_ops.c has:
> >
> >      void *__cpu_up_stack_pointer[NR_CPUS] __section(".data");
> >      void *__cpu_up_task_pointer[NR_CPUS] __section(".data");
> >
> >      void cpu_update_secondary_bootdata(unsigned int cpuid,
> >                                         struct task_struct *tidle)
> >      {
> >              int hartid = cpuid_to_hartid_map(cpuid);
> >
> >              /* Make sure tidle is updated */
> >              smp_mb();
> >              WRITE_ONCE(__cpu_up_stack_pointer[hartid],
> >                         task_stack_page(tidle) + THREAD_SIZE);
> >              WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
> >
> > The above two writes cause out-of-bound accesses beyond
> > __cpu_up_{stack,pointer}_pointer[] if hartid >= CONFIG_NR_CPUS.
> >
> >      }
> >
> > arch/riscv/kernel/smpboot.c:setup_smp(void) detects CPUs like this:
> >
> >      for_each_of_cpu_node(dn) {
> >              hart = riscv_of_processor_hartid(dn);
> >              if (hart < 0)
> >                      continue;
> >
> >              if (hart == cpuid_to_hartid_map(0)) {
> >                      BUG_ON(found_boot_cpu);
> >                      found_boot_cpu = 1;
> >                      early_map_cpu_to_node(0, of_node_to_nid(dn));
> >                      continue;
> >              }
> >              if (cpuid >= NR_CPUS) {
> >                      pr_warn("Invalid cpuid [%d] for hartid [%d]\n",
> >                              cpuid, hart);
> >                      break;
> >              }
> >
> >              cpuid_to_hartid_map(cpuid) = hart;
> >              early_map_cpu_to_node(cpuid, of_node_to_nid(dn));
> >              cpuid++;
> >      }
> >
> > So cpuid >= CONFIG_NR_CPUS (too many CPU cores) is already rejected.
> >
> > How to fix this?
> >
> > We could skip hartids >= NR_CPUS, but that feels strange to me, as
> > you need NR_CPUS to be larger (much larger if the first usable hartid
> > is a large number) than the number of CPUs used.
> The Ubuntu distro config for HiFive Unmatched set this to CONFIG_NR_CPUS=8.

I know. Same for most defconfigs in Linux.  But we do not tend to
work around buffer overflows by changing config values.  Besides,
those configs will still experience the issue when run on e.g. an
8+1 core processor where the cores used by Linux have hartids 1-8.

I noticed because I started with a starlight config with
CONFIG_NR_CPUS=2 (which gave me only one core), changed that to
CONFIG_NR_CPUS=4, and got a kernel that didn't boot at all (no output
without earlycon).I know. Same for most defconfigs in Linux.  But we
do not tend to
work around buffer overflows by changing config values.  Besides,
those configs will still experience the issue when run on e.g. an
8+1 core processor where the cores used by Linux have hartids 1-8.

> > We could store the minimum hartid, and always subtract that when
> > accessing __cpu_up_{stack,pointer}_pointer[] (also in
> > arch/riscv/kernel/head.S), but that means unused cores cannot be in the
> > middle of the hartid range.
> >
> > Are hartids guaranteed to be continuous? If not, we have no choice but
> > to index __cpu_up_{stack,pointer}_pointer[] by cpuid instead, which
> > needs a more expensive conversion in arch/riscv/kernel/head.S.

https://riscv.org/wp-content/uploads/2017/05/riscv-privileged-v1.10.pdf
says:

    Hart IDs might not necessarily be numbered contiguously in a
    multiprocessor system, but at least one hart must have a hart
    ID of zero.

Which means indexing arrays by hart ID is a no-go?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
