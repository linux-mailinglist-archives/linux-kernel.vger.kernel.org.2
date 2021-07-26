Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881CA3D59B8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhGZMFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbhGZMFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:05:07 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB2FC061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 05:45:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z7so10861745wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EdSEiQhPPfqlW+mNBlXL/6LkyvS46s9MWaLUDSXboLs=;
        b=cMAiwG60O3mJ/yFl82iRKWkX/2RsxNQFV+GdGrduhGDtDa2s1/iXKKFhmMPpVGXPLK
         fJa7sibt5Qn1sSJM14MEXSKYhHVIGjDRCz9X7aNrg6dOmwXXmwEQFDbWwzXzywuwj+VD
         xwc6C5GLLOEluhgH8wwnqHv/dEwyGGZ0xX8MMn40qeZre05Pcv5x9J8Ez3DbQM6BS2ks
         mGLPEPyxshCEpdnYQ3lZIzNETd8SIBde/3rhDmD0DG54cIbOK2eUcfRrJtwG/myAkFrz
         nQ3d6EkT5soST7X/ajaFq1FVf5YxMeCPk9mlcbPCYTVcru1CUnGpvdLskrzEKpqQ0k3x
         wpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EdSEiQhPPfqlW+mNBlXL/6LkyvS46s9MWaLUDSXboLs=;
        b=LlXS93apoCr7pH6mnXAl1FFnjlSnk3HKMxpCCr0VXwGMlR4EYOGZ9mwWsQ/Q+aG2W0
         qsrSQayRa5rnJEBgRr/hKNJU61Ijck+xhgxbWYIeeSnij9A4b3y2hgDpFlMx7BwQyOgu
         DPRVD0mWhr/f83zXrOg45mfsn42TmsHEqFLMmAU0g22gRcMHOKDLxcndHAk9TqEbTDvz
         LYb/AA/9u/RPf36cOl8HDBw+UXcFjZ4x22EXsU4P2cb27RRRHpFm92HwP6GJGG7hwEDT
         IwZw0q0TzV5ani5A9bp6c/ftfnrMk7U4VT8nKDmYdSFcaNclc79Q33rd2C6c9t91pW0G
         r2Sw==
X-Gm-Message-State: AOAM5307N3+zg/Etidz9NYNjjjm16dumTN45329xQ630hIOOO+RyQnSW
        oL31yRsd4K7ud/v6CO+BLw0pTdx/QmXhNyevY3ejJw==
X-Google-Smtp-Source: ABdhPJwkUJfUzY+D0ZUeN/xa+//W784LaiFLRerJU1kMI4d9SXUSL+tAmGatjZAFWSLpWKG5op/x6x/WbN6LfRBY86I=
X-Received: by 2002:a05:6000:2a1:: with SMTP id l1mr18569977wry.128.1627303534054;
 Mon, 26 Jul 2021 05:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210618123851.1344518-1-anup.patel@wdc.com>
In-Reply-To: <20210618123851.1344518-1-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 26 Jul 2021 18:15:20 +0530
Message-ID: <CAAhSdy3E56j9XBfNr93AdW62mEx40F9F4-SYbNEFdkKA2BWRqA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] Linux RISC-V ACLINT Support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

I have taken the approach of IPI domains (like you suggested) in this series.

What do you think ?

Regards,
Anup

On Fri, Jun 18, 2021 at 6:09 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> Most of the existing RISC-V platforms use SiFive CLINT to provide M-level
> timer and IPI support whereas S-level uses SBI calls for timer and IPI
> support. Also, the SiFive CLINT device is a single device providing both
> timer and IPI functionality so RISC-V platforms can't partially implement
> SiFive CLINT device and provide alternate mechanism for timer and IPI.
>
> The RISC-V Advacned Core Local Interruptor (ACLINT) tries to address the
> limitations of SiFive CLINT by:
> 1) Taking modular approach and defining timer and IPI functionality as
>    separate devices so that RISC-V platforms can include only required
>    devices
> 2) Providing dedicated MMIO device for S-level IPIs so that SBI calls
>    can be avoided for IPIs in Linux RISC-V
> 3) Allowing multiple instances of timer and IPI devices for a
>    multi-socket (or multi-die) NUMA systems
> 4) Being backward compatible to SiFive CLINT so that existing RISC-V
>    platforms stay compliant with RISC-V ACLINT specification
>
> Latest RISC-V ACLINT specification (will be frozen in a month) can be
> found at:
> https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
>
> This series adds RISC-V ACLINT support and can be found in riscv_aclint_v2
> branch at:
> https://github.com/avpatel/linux
>
> To test this series, the RISC-V ACLINT support for QEMU and OpenSBI
> can be found in the riscv_aclint_v1 branch at:
> https://github.com/avpatel/qemu
> https://github.com/avpatel/opensbi
>
> Changes since v1:
>  - Added a new PATCH3 to treat IPIs as normal Linux IRQs for RISC-V kernel
>  - New SBI IPI call based irqchip driver in PATCH3 which is only initialized
>    by riscv_ipi_setup() when no Linux IRQ numbers are available for IPIs
>  - Moved DT bindings patches before corresponding driver patches
>  - Implemented ACLINT SWI driver as a irqchip driver in PATCH7
>  - Minor nit fixes pointed by Bin Meng
>
> Anup Patel (11):
>   RISC-V: Clear SIP bit only when using SBI IPI operations
>   RISC-V: Use common print prefix in smp.c
>   RISC-V: Treat IPIs as normal Linux IRQs
>   RISC-V: Allow marking IPIs as suitable for remote FENCEs
>   RISC-V: Use IPIs for remote TLB flush when possible
>   dt-bindings: interrupt-controller: Add ACLINT MSWI and SSWI bindings
>   irqchip: Add ACLINT software interrupt driver
>   RISC-V: Select ACLINT SWI driver for virt machine
>   dt-bindings: timer: Add ACLINT MTIMER bindings
>   clocksource: clint: Add support for ACLINT MTIMER device
>   MAINTAINERS: Add entry for RISC-V ACLINT drivers
>
>  .../riscv,aclint-swi.yaml                     |  82 ++++++
>  .../bindings/timer/riscv,aclint-mtimer.yaml   |  55 ++++
>  MAINTAINERS                                   |   9 +
>  arch/riscv/Kconfig                            |   1 +
>  arch/riscv/Kconfig.socs                       |   1 +
>  arch/riscv/include/asm/sbi.h                  |   2 +
>  arch/riscv/include/asm/smp.h                  |  48 +++-
>  arch/riscv/kernel/Makefile                    |   1 +
>  arch/riscv/kernel/cpu-hotplug.c               |   2 +
>  arch/riscv/kernel/irq.c                       |   1 +
>  arch/riscv/kernel/sbi-ipi.c                   | 223 ++++++++++++++
>  arch/riscv/kernel/sbi.c                       |  15 -
>  arch/riscv/kernel/smp.c                       | 171 +++++------
>  arch/riscv/kernel/smpboot.c                   |   4 +-
>  arch/riscv/mm/tlbflush.c                      |  62 +++-
>  drivers/clocksource/timer-clint.c             |  58 ++--
>  drivers/irqchip/Kconfig                       |  11 +
>  drivers/irqchip/Makefile                      |   1 +
>  drivers/irqchip/irq-aclint-swi.c              | 271 ++++++++++++++++++
>  drivers/irqchip/irq-riscv-intc.c              |  55 ++--
>  20 files changed, 879 insertions(+), 194 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
>  create mode 100644 Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
>  create mode 100644 arch/riscv/kernel/sbi-ipi.c
>  create mode 100644 drivers/irqchip/irq-aclint-swi.c
>
> --
> 2.25.1
>
