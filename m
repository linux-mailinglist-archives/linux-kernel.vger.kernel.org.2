Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347F141DA64
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351207AbhI3NAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348795AbhI3NAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:00:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D12A613A7;
        Thu, 30 Sep 2021 12:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633006732;
        bh=XaLJOpJXyC0/AKRC/2WDJUbGWh++7znRLGEqxEgcGtU=;
        h=From:To:Cc:Subject:Date:From;
        b=pg6avzB8dmvoh6yqYuxdxQ8IIXXPyCZbEjB1q+8QwdqsdhHx2F444zyJpayMKuXuy
         nCuWJVvM+VywCxG4D0voRyTM+jLlY6gki14yu93KmBiOyJr7tpNFqQw+6ww/QgD+t1
         sfxdWtM6DbD37v+mwbJYsCcs8xKkR4RLJpXDBoI85enXGAmaSExYkjDZcG29AEwpu1
         ZUt2MWci2A3kBKUh9eAvkbv5iZxwx441R4DYcZT71Kv0U/ZggVnbqvFooD0Mr/ckc7
         VCdzWMdYOLTXOTvi1/6RA69rzxCLYdjbIJ+XRuLzT0MDTHHAuXjVW4JB4d7KU0CldB
         pJeNLUZ6FuUsw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH v2 0/7] Move task_struct::cpu back into thread_info
Date:   Thu, 30 Sep 2021 14:58:06 +0200
Message-Id: <20210930125813.197418-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c65eacbe290b ("sched/core: Allow putting thread_info into
task_struct") mentions that, along with moving thread_info into
task_struct, the cpu field is moved out of the former into the latter,
as at that point, it was the intention to ultimately get rid of
thread_info entirely, but this never happened.

While collaborating with Keith on adding THREAD_INFO_IN_TASK support to
ARM, we noticed that keeping CPU in task_struct is problematic for
architectures that define raw_smp_processor_id() in terms of this field,
as it requires linux/sched.h to be included, which causes a lot of pain
in terms of circular dependencies (or 'header soup', as the original
commit refers to it).

For examples of how existing architectures work around this, please
refer to patches #6 or #7. In the former case, it uses an awful
asm-offsets hack to index thread_info/current without using its type
definition. The latter approach simply keeps a copy of the task_struct
CPU field in thread_info, and keeps it in sync at context switch time.

We also discussed introducing yet another Kconfig symbol to indicate
that the arch has THREAD_INFO_IN_TASK enabled but still prefers to keep
its CPU field in thread_info, but simply keeping it in thread_info in
all cases seems to be the cleanest approach here, so that is what this
series implements.

Changes since v1/RFC:
- use macro for task_thread_info() to work around constness of
  task_cpu()'s task_struct argument
- add various acks
- drop patch #8 for ARM - it was preliminary in the RFC, and it can be
  taken as a fix in the ARM tree once THREAD_INFO_IN_TASK actually
  lands.

Code can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=move-task-cpu-to-ti-v2

Cc: Keith Packard <keithpac@amazon.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Heiko Carstens <hca@linux.ibm.com>

Ard Biesheuvel (7):
  arm64: add CPU field to struct thread_info
  x86: add CPU field to struct thread_info
  s390: add CPU field to struct thread_info
  powerpc: add CPU field to struct thread_info
  sched: move CPU field back into thread_info if THREAD_INFO_IN_TASK=y
  powerpc: smp: remove hack to obtain offset of task_struct::cpu
  riscv: rely on core code to keep thread_info::cpu updated

 arch/arm64/include/asm/thread_info.h   |  1 +
 arch/arm64/kernel/asm-offsets.c        |  2 +-
 arch/arm64/kernel/head.S               |  2 +-
 arch/powerpc/Makefile                  | 11 -----------
 arch/powerpc/include/asm/smp.h         | 17 +----------------
 arch/powerpc/include/asm/thread_info.h |  3 +++
 arch/powerpc/kernel/asm-offsets.c      |  4 +---
 arch/powerpc/kernel/smp.c              |  2 +-
 arch/riscv/kernel/asm-offsets.c        |  1 -
 arch/riscv/kernel/entry.S              |  5 -----
 arch/riscv/kernel/head.S               |  1 -
 arch/s390/include/asm/thread_info.h    |  1 +
 arch/x86/include/asm/thread_info.h     |  3 +++
 include/linux/sched.h                  | 13 +------------
 kernel/sched/sched.h                   |  4 ----
 15 files changed, 14 insertions(+), 56 deletions(-)

-- 
2.30.2

