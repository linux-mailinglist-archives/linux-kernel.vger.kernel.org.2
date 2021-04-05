Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6686D353D08
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 10:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhDEI6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 04:58:00 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:56901 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbhDEI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 04:57:40 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 1358vWaV079891
        for <linux-kernel@vger.kernel.org>; Mon, 5 Apr 2021 11:57:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1617613047; x=1620205047;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EfKmC1JuJT8Zu2DDNgq2xg0tTemOVFs2FYglazg4zNM=;
        b=LD8mGRYATXub8N7uRNlngMhpde9Wv65ySPWbYJjSpTaoRfRatLFPabOycpTq8yoc
        Yvg5gfQ6w7bs5A1nRXY97iDJhC3M3pOews9QJqvzU46nixj+nWs1eGo2HoSOfgNO
        C87ai6HyNiO0uOhupSXyEpL1ETubOnAjmeQRytwYUhXEiEGuDlQOxm4jGeewCZqy
        zpRjvJLzyfn4QmrRIDDWoJoYvL62ei2gtlGOKRBVrYetWMTcYLbq6ts9zmyteN6Q
        OGn2Q4dkqce8J3Mer2gKssqJDE2kny/ewtkhMtcpf21QJ4/UUZjoR7kNEnbFNL+Q
        /oo5xHIZSm2wm1QghREYiA==;
X-AuditID: 8b5b014d-a70347000000209f-d7-606ad0f75597
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 77.77.08351.7F0DA606; Mon,  5 Apr 2021 11:57:27 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick@ics.forth.gr at ics.forth.gr
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     linux-riscv@lists.infradead.org, palmer@dabbelt.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH v3 0/5] RISC-V: Add kexec/kdump support
Date:   Mon,  5 Apr 2021 11:57:07 +0300
Message-Id: <20210405085712.1953848-1-mick@ics.forth.gr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42Lpjp6urPv9QlaCwYd5khaXd81hs9j2uYXN
        ovndOXaLl5d7mC3aZvE7sHq8efmSxePhpktMHpuX1Htcar7O7vF5k1wAaxSXTUpqTmZZapG+
        XQJXRuPm20wF2/kqnp9Rb2Bcy93FyMkhIWAi0d33gbGLkYtDSOAoo8SDCWvYIBJuErfv72QF
        sdkENCXmXzrIAmKLCJhLNM98zQhiMwtkSBzd94sdxBYGiq+e/44ZxGYRUJU48uo2WA2vgIXE
        /50LWCFmyku0L9/OBhEXlDg58wkLxBx5ieats5knMPLMQpKahSS1gJFpFaNAYpmxXmZysV5a
        flFJhl560SZGcCAx+u5gvL35rd4hRiYOxkOMEhzMSiK8DxuyEoR4UxIrq1KL8uOLSnNSiw8x
        SnOwKInz8upNiBcSSE8sSc1OTS1ILYLJMnFwSjUwOW9hCXKIsGKuPzo37mG4kbmnSnr4HsP0
        11uWZp0IVZq7K8he9OU0GZMAxusLYnwez2E+1Bx5wdPtx0w+y8Bybf/+WwLRezLfZVuzLuid
        Zsy1t6hl+9H+Hpk0uadX79yXUWHMmi24smT/49uxFdP3Pav7vf8Wd8SrPzJLO6f3bHJWybV8
        q3XKfUrj+5hXZ6af29um3Neyeao9+4NWI8dZkyMyFr5wbeBgij0zlfurVUTLP/nzm5ZVb7Nc
        NfV2TI3b8Yqw7uUd5uv/zqu/sVTmsKF8XYuxwRkbpV1lBpqZ01YZSj7h5chsN7jPoFT0vU29
        dFdGpHam/86XSjnXOkr3VOzxuCG09EqIlv7vKAslluKMREMt5qLiRAA1iB7CkwIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds kexec/kdump and crash kernel
support on RISC-V. For testing the patches a patched
version of kexec-tools is needed (still a work in
progress) which can be found at:

https://riscv.ics.forth.gr/kexec-tools-patched.tar.xz

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
 arch/riscv/include/asm/kexec.h      |  54 +++++++
 arch/riscv/kernel/Makefile          |   6 +
 arch/riscv/kernel/crash_dump.c      |  46 ++++++
 arch/riscv/kernel/crash_save_regs.S |  56 +++++++
 arch/riscv/kernel/kexec_relocate.S  | 222 ++++++++++++++++++++++++++++
 arch/riscv/kernel/machine_kexec.c   | 193 ++++++++++++++++++++++++
 arch/riscv/kernel/setup.c           | 113 ++++++++------
 arch/riscv/mm/init.c                | 110 ++++++++++++++
 include/uapi/linux/kexec.h          |   1 +
 11 files changed, 787 insertions(+), 45 deletions(-)
 create mode 100644 arch/riscv/include/asm/kexec.h
 create mode 100644 arch/riscv/kernel/crash_dump.c
 create mode 100644 arch/riscv/kernel/crash_save_regs.S
 create mode 100644 arch/riscv/kernel/kexec_relocate.S
 create mode 100644 arch/riscv/kernel/machine_kexec.c

-- 
2.26.2

