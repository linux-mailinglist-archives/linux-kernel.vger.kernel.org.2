Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAB5439ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhJYP4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:56:45 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:40454 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhJYP4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:56:44 -0400
Received: by mail-ua1-f51.google.com with SMTP id e2so23074424uax.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 08:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AGNNgOmVg+yVUKzMcQpO1dKw5Tftq7yu9PfveBqIu/M=;
        b=QBdNoiO1rMs9hXad29WSs1HRAEDTY0URDOZCzmKW39Xbv8MTTXON/gPBbeGuqw8Vcu
         FllL1iKGcQLN1Y3yRrvgRpG18dh5Usdp+qhnTofQgfxWB0ZivpWJyKHWkl/opSOQ4AhJ
         kpT/RhTAcxD8FLShzs48kdfYxA9+lCfwvFpLM6sgLiFHM01uETfFX3im6nRwnAoNjASv
         4IzWy3fIjS3B01POyQ5QWTOSvYiTXhmHSWfvObykVObIaaXlvS96YYg90v+Rlx/3J2vb
         x9Dhc08YiZ7Ao3kT3I4rjXPEIH0Ccz7nrm27/KH8Y2xRO8QaZGGKSbYkauvotWn8IiSW
         mKww==
X-Gm-Message-State: AOAM532ku6Vn2ksz+dEocAKby+G3dn8g0l/TOh+xolY0/tjTTzainJvk
        K16xqnoM43Bz5ZX181EW+GuY0gtVLBrSbw==
X-Google-Smtp-Source: ABdhPJyOuKbzKJiCT/mXRgDxW3FibLE7pN2D4UHZzoneiqvD1BgxBH7yQ+rFL7hxr/md2tkIj8Yqyg==
X-Received: by 2002:a67:f3c2:: with SMTP id j2mr4855785vsn.44.1635177261708;
        Mon, 25 Oct 2021 08:54:21 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id t5sm9856314vsk.24.2021.10.25.08.54.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 08:54:21 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id o26so9197525uab.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 08:54:21 -0700 (PDT)
X-Received: by 2002:a67:f84d:: with SMTP id b13mr12058620vsp.41.1635177260921;
 Mon, 25 Oct 2021 08:54:20 -0700 (PDT)
MIME-Version: 1.0
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Oct 2021 17:54:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUPWOjJfJohxLJefHOrJBtXZ0xfHQt4=hXpUXnasiN+AQ@mail.gmail.com>
Message-ID: <CAMuHMdUPWOjJfJohxLJefHOrJBtXZ0xfHQt4=hXpUXnasiN+AQ@mail.gmail.com>
Subject: Out-of-bounds access when hartid >= NR_CPUS
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When booting a kernel with CONFIG_NR_CPUS=4 on Microchip PolarFire,
the 4th CPU either fails to come online, or the system crashes.

This happens because PolarFire has 5 CPU cores: hart 0 is an e51,
and harts 1-4 are u54s, with the latter becoming CPUs 0-3 in Linux:
  - unused core has hartid 0 (sifive,e51),
  - processor 0 has hartid 1 (sifive,u74-mc),
  - processor 1 has hartid 2 (sifive,u74-mc),
  - processor 2 has hartid 3 (sifive,u74-mc),
  - processor 3 has hartid 4 (sifive,u74-mc).

I assume the same issue is present on the SiFive fu540 and fu740
SoCs, but I don't have access to these.  The issue is not present
on StarFive JH7100, as processor 0 has hartid 1, and processor 1 has
hartid 0.

arch/riscv/kernel/cpu_ops.c has:

    void *__cpu_up_stack_pointer[NR_CPUS] __section(".data");
    void *__cpu_up_task_pointer[NR_CPUS] __section(".data");

    void cpu_update_secondary_bootdata(unsigned int cpuid,
                                       struct task_struct *tidle)
    {
            int hartid = cpuid_to_hartid_map(cpuid);

            /* Make sure tidle is updated */
            smp_mb();
            WRITE_ONCE(__cpu_up_stack_pointer[hartid],
                       task_stack_page(tidle) + THREAD_SIZE);
            WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);

The above two writes cause out-of-bound accesses beyond
__cpu_up_{stack,pointer}_pointer[] if hartid >= CONFIG_NR_CPUS.

    }

arch/riscv/kernel/smpboot.c:setup_smp(void) detects CPUs like this:

    for_each_of_cpu_node(dn) {
            hart = riscv_of_processor_hartid(dn);
            if (hart < 0)
                    continue;

            if (hart == cpuid_to_hartid_map(0)) {
                    BUG_ON(found_boot_cpu);
                    found_boot_cpu = 1;
                    early_map_cpu_to_node(0, of_node_to_nid(dn));
                    continue;
            }
            if (cpuid >= NR_CPUS) {
                    pr_warn("Invalid cpuid [%d] for hartid [%d]\n",
                            cpuid, hart);
                    break;
            }

            cpuid_to_hartid_map(cpuid) = hart;
            early_map_cpu_to_node(cpuid, of_node_to_nid(dn));
            cpuid++;
    }

So cpuid >= CONFIG_NR_CPUS (too many CPU cores) is already rejected.

How to fix this?

We could skip hartids >= NR_CPUS, but that feels strange to me, as
you need NR_CPUS to be larger (much larger if the first usable hartid
is a large number) than the number of CPUs used.

We could store the minimum hartid, and always subtract that when
accessing __cpu_up_{stack,pointer}_pointer[] (also in
arch/riscv/kernel/head.S), but that means unused cores cannot be in the
middle of the hartid range.

Are hartids guaranteed to be continuous? If not, we have no choice but
to index __cpu_up_{stack,pointer}_pointer[] by cpuid instead, which
needs a more expensive conversion in arch/riscv/kernel/head.S.

Thanks for your comments!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
