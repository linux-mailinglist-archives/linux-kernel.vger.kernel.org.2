Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456A431ADBE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 20:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhBMTUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 14:20:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhBMTU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 14:20:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F330364DCF;
        Sat, 13 Feb 2021 19:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613243987;
        bh=pZBO4rvpEitfkDSjUhW3j10U+pt1UxIvnooDAWdRuzs=;
        h=From:To:Cc:Subject:Date:From;
        b=U2oBxlAwzHS/2pvENZ/dcSEcSpcu38NhLg5wiI2TIOg9q6BRGSaTSI97rTu0vs3DC
         z9AQSJuHpASYQbV5lUkVkf0l6U76ctrBCAZNWivEhOjktvOfTUpRPaOLuXSNOvoIwj
         Zn16sf/YN4C40MWslyvXzmxCf45A05v/+NDxH9SC9PyDu37PN2PQ+oe40PER0FUedC
         PfaKec2Xh564jwgqqgk0aczgGqWPft95F+o01Idk0kI39NcjU9fKbxyzraHVMrGNG5
         gHR1NzLIK0gpeUaw3E3vwnefOOcDpGU16qqvQT0S4KeTem2azUkAcHRpRSVuOLk4Kz
         b0ha58pYX8dNg==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brian Gerst <brgerst@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 0/2] Clean up x86_32 stackprotector
Date:   Sat, 13 Feb 2021 11:19:43 -0800
Message-Id: <cover.1613243844.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86_32 stackprotector is a maintenance nightmare.  Clean it up.  This
disables stackprotector on x86_32 on GCC 8.1 and on all clang
versions.  Some clang people are cc'd.

Changes from v1:
 - Changelog fixes.
 - Comment fixes (mostly from Sean).
 - Fix the !SMP case.

Andy Lutomirski (2):
  x86/stackprotector/32: Make the canary into a regular percpu variable
  x86/entry/32: Remove leftover macros after stackprotector cleanups

 arch/x86/Kconfig                          |  7 +-
 arch/x86/Makefile                         |  8 ++
 arch/x86/entry/entry_32.S                 | 95 +----------------------
 arch/x86/include/asm/processor.h          | 15 +---
 arch/x86/include/asm/ptrace.h             |  5 +-
 arch/x86/include/asm/segment.h            | 30 ++-----
 arch/x86/include/asm/stackprotector.h     | 79 ++++---------------
 arch/x86/include/asm/suspend_32.h         |  6 +-
 arch/x86/kernel/asm-offsets_32.c          |  5 --
 arch/x86/kernel/cpu/common.c              |  5 +-
 arch/x86/kernel/doublefault_32.c          |  4 +-
 arch/x86/kernel/head_32.S                 | 18 +----
 arch/x86/kernel/setup_percpu.c            |  1 -
 arch/x86/kernel/tls.c                     |  8 +-
 arch/x86/kvm/svm/svm.c                    | 10 +--
 arch/x86/lib/insn-eval.c                  |  4 -
 arch/x86/platform/pvh/head.S              | 14 ----
 arch/x86/power/cpu.c                      |  6 +-
 arch/x86/xen/enlighten_pv.c               |  1 -
 scripts/gcc-x86_32-has-stack-protector.sh |  6 +-
 20 files changed, 62 insertions(+), 265 deletions(-)

-- 
2.29.2

