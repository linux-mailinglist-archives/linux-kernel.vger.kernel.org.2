Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B579E3BC4FB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 05:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhGFDLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 23:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhGFDLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 23:11:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0D646197E;
        Tue,  6 Jul 2021 03:08:43 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Chen Zhu <zhuchen@loongson.cn>
Subject: [PATCH 0/9] irqchip: Add LoongArch-related irqchip drivers
Date:   Tue,  6 Jul 2021 11:08:55 +0800
Message-Id: <20210706030904.1411775-1-chenhuacai@loongson.cn>
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

Huacai Chen and Chen Zhu(9):
 irqchip: Adjust Kconfig for Loongson.
 irqchip/loongson-pch-pic: Improve edge triggered interrupt support.
 irqchip/loongson-pch-pic: Add ACPI init support.
 irqchip/loongson-pch-msi: Add ACPI init support.
 irqchip/loongson-htvec: Add ACPI init support.
 irqchip/loongson-liointc: Add ACPI init support. 
 irqchip: Add LoongArch CPU interrupt controller support.
 irqchip: Add Loongson Extended I/O interrupt controller.
 irqchip: Add Loongson PCH LPC controller support.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Chen Zhu <zhuchen@loongson.cn> 
---
 drivers/irqchip/Kconfig                |  37 +++-
 drivers/irqchip/Makefile               |   3 +
 drivers/irqchip/irq-loongarch-cpu.c    |  87 ++++++++++
 drivers/irqchip/irq-loongson-eiointc.c | 308 +++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-loongson-htvec.c   | 102 ++++++++++-
 drivers/irqchip/irq-loongson-liointc.c | 140 ++++++++++++++-
 drivers/irqchip/irq-loongson-pch-lpc.c | 204 ++++++++++++++++++++++
 drivers/irqchip/irq-loongson-pch-msi.c |  69 +++++++-
 drivers/irqchip/irq-loongson-pch-pic.c | 139 ++++++++++++++-
 include/linux/cpuhotplug.h             |   1 +
 10 files changed, 1069 insertions(+), 21 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
 create mode 100644 drivers/irqchip/irq-loongson-eiointc.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c
--
2.27.0

