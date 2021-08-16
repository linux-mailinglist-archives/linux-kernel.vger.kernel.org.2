Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD0B3ECFB9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhHPHxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233182AbhHPHxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:53:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EA8A61AE3;
        Mon, 16 Aug 2021 07:53:05 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 00/10] irqchip: Add LoongArch-related irqchip drivers
Date:   Mon, 16 Aug 2021 15:52:42 +0800
Message-Id: <20210816075252.4003406-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
boot protocol LoongArch-specific interrupt controllers (similar to APIC)
are already added in the next revision of ACPI Specification (current
revision is 6.4).

This patchset adds some irqchip drivers for LoongArch, it is preparing
to add LoongArch support in mainline kernel, we can see a snapshot here:
https://github.com/loongson/linux/tree/loongarch-next

Cross-compile tool chain to build kernel:
https://github.com/loongson/build-tools/releases

Loongson and LoongArch documentations:
https://github.com/loongson/LoongArch-Documentation

LoongArch-specific interrupt controllers:
https://mantis.uefi.org/mantis/view.php?id=2203

V1 -> V2:
1, Remove queued patches;
2, Move common logic of DT/ACPI probing to common functions;
3, Split .suspend()/.resume() functions to separate patches.

Huacai Chen:
 irqchip: Adjust Kconfig for Loongson.
 irqchip/loongson-pch-pic: Add ACPI init support.
 irqchip/loongson-pch-pic: Add suspend/resume support.
 irqchip/loongson-pch-msi: Add ACPI init support.
 irqchip/loongson-htvec: Add ACPI init support.
 irqchip/loongson-htvec: Add suspend/resume support.
 irqchip/loongson-liointc: Add ACPI init support. 
 irqchip: Add LoongArch CPU interrupt controller support.
 irqchip: Add Loongson Extended I/O interrupt controller.
 irqchip: Add Loongson PCH LPC controller support.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/Kconfig                |  37 +++-
 drivers/irqchip/Makefile               |   3 +
 drivers/irqchip/irq-loongarch-cpu.c    |  76 ++++++++
 drivers/irqchip/irq-loongson-eiointc.c | 326 +++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-loongson-htvec.c   | 147 +++++++++++----
 drivers/irqchip/irq-loongson-liointc.c | 197 ++++++++++++--------
 drivers/irqchip/irq-loongson-pch-lpc.c | 205 +++++++++++++++++++++
 drivers/irqchip/irq-loongson-pch-msi.c | 126 ++++++++-----
 drivers/irqchip/irq-loongson-pch-pic.c | 157 +++++++++++++---
 include/linux/cpuhotplug.h             |   1 +
 10 files changed, 1087 insertions(+), 188 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
 create mode 100644 drivers/irqchip/irq-loongson-eiointc.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c
--
2.27.0

