Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD973638E8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 02:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbhDSA4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 20:56:35 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:46686 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbhDSA4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 20:56:31 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 13J0u0FY011027
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 03:56:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1618793755; x=1621385755;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dnZDF3w6X7udDtiezD8XGYyfd4IjWkcxuZe8fuz0LRA=;
        b=dikSW43Z2/X2VJlkfW23IS53FUBEsNEf7RD5/fYcC7se8eJAiyjacQgiThWYKTd5
        jJr3R8MPw5aie6EdZ0yR4OA0GnRQz3IeYwY/ALEyAv5ldfS8czE/qi/6jJJUMAyN
        rXk1JWy/ScMAyzd1CAhYTakgPvrfPxAfEewWiaZUyCOjrymPcha5JE9tt15gm6r7
        peSF5zAJS6gRvRS5PJC7QHusRLHCsRwHuk5IRt4guA0JC2uXWFjkOe3t2KQi0iCb
        7GhgdOZyiU2gmdSoJJa3XHZsQv9EHK2kvM0MN38V2c7Y+qdk8XOvm7C9GuHZub0I
        HSSvyE62v+aZikW+4s3FLA==;
X-AuditID: 8b5b014d-a4c337000000209f-e2-607cd51ba308
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id F3.FF.08351.B15DC706; Mon, 19 Apr 2021 03:55:55 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick@ics.forth.gr at ics.forth.gr
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH v4 0/5] RISC-V: Add kexec/kdump support
Date:   Mon, 19 Apr 2021 03:55:34 +0300
Message-Id: <20210419005539.22729-1-mick@ics.forth.gr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPJMWRmVeSWpSXmKPExsXSHT1dWVf6ak2CwZrHchaXd81hs9j2uYXN
        ovndOXaLl5d7mC3aZvE7sHq8efmSxePhpktMHpuX1Htcar7O7vF5k1wAaxSXTUpqTmZZapG+
        XQJXxsKf51kK/vJV9J3YydrA+IC7i5GDQ0LAROLM9pIuRk4OIYGjjBJT37mC2BICbhK37+9k
        BbHZBDQl5l86yAJiiwiYSzTPfM0IYjMLZEgc3feLHcQWBopv6HwEFmcRUJV4uWglWC+vgJnE
        jJ0TWCBmyku0L9/OBhEXlDg58wkLxBx5ieats5knMPLMQpKahSS1gJFpFaNAYpmxXmZysV5a
        flFJhl560SZGcBgx+u5gvL35rd4hRiYOxkOMEhzMSiK892trEoR4UxIrq1KL8uOLSnNSiw8x
        SnOwKInz8upNiBcSSE8sSc1OTS1ILYLJMnFwSjUwaZ0Nr1GvD5Z9Keod9M7qS1/idf26kma1
        oIXL1WRtlr490DD9/Qn+aya6J2xeGYd8mWrDb2GRyedXx57ndzKpbNVxPS62cO6iFwaaDZKV
        efNWb5m1O2VVfHHFw2rZoDlHNJg2/L2VcPy8afnjZxvmv0uZtuV10wNb7Qd2Xga3+qrPdGy1
        +ffQUTun48bq2a2XGdkUulfoPzL4P8ft18F47ni/bvunzlbT/lmfcpA4xSt2aWf9QSUj+dSo
        dq0Lfl/Kl21P4956o9BWyuHYhryKkhmBC34p19iqPa6YuqH+N0OQtGpd2SXRfatfikbHd68L
        4vk9cXGKyd2++u/OJmeLJEMdIuNXGs0//OfBDnclluKMREMt5qLiRAByhGsakgIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds kexec/kdump and crash kernel
support on RISC-V. For testing the patches a patched
version of kexec-tools is needed (still a work in
progress) which can be found at:

https://riscv.ics.forth.gr/kexec-tools-patched.tar.xz

v4:
 * Rebase on top of "fixes" branch
 * Resolve Alex's comments

v3:
 * Rebase on newer kernel tree
 * Minor cleanups
 * Split UAPI changes to a separate patch
 * Improve / cleanup init_resources
 * Resolve Palmer's comments

v2:
 * Rebase on newer kernel tree
 * Minor cleanups
 * Properly populate the ioresources tre, so that it
   can be used later on for implementing strict /dev/mem
 * Use linux,usable-memory on /memory instead of a new binding
 * USe a reserved-memory node for ELF core header

Nick Kossifidis (5):
  RISC-V: Add EM_RISCV to kexec UAPI header
  RISC-V: Add kexec support
  RISC-V: Improve init_resources
  RISC-V: Add kdump support
  RISC-V: Add crash kernel support

 arch/riscv/Kconfig                  |  25 ++++
 arch/riscv/include/asm/elf.h        |   6 +
 arch/riscv/include/asm/kexec.h      |  56 +++++++
 arch/riscv/kernel/Makefile          |   6 +
 arch/riscv/kernel/crash_dump.c      |  46 ++++++
 arch/riscv/kernel/crash_save_regs.S |  56 +++++++
 arch/riscv/kernel/kexec_relocate.S  | 223 ++++++++++++++++++++++++++++
 arch/riscv/kernel/machine_kexec.c   | 193 ++++++++++++++++++++++++
 arch/riscv/kernel/setup.c           | 114 ++++++++------
 arch/riscv/mm/init.c                | 104 +++++++++++++
 include/uapi/linux/kexec.h          |   1 +
 11 files changed, 784 insertions(+), 46 deletions(-)
 create mode 100644 arch/riscv/include/asm/kexec.h
 create mode 100644 arch/riscv/kernel/crash_dump.c
 create mode 100644 arch/riscv/kernel/crash_save_regs.S
 create mode 100644 arch/riscv/kernel/kexec_relocate.S
 create mode 100644 arch/riscv/kernel/machine_kexec.c

-- 
2.26.2

