Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A8F3C6EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 12:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhGMKzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 06:55:49 -0400
Received: from foss.arm.com ([217.140.110.172]:40724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235484AbhGMKzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 06:55:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47B991FB;
        Tue, 13 Jul 2021 03:52:58 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC4C83F7D8;
        Tue, 13 Jul 2021 03:52:57 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/5] locking/atomic: generic arch__atomic_long_*() and arch_ bitops
Date:   Tue, 13 Jul 2021 11:52:48 +0100
Message-Id: <20210713105253.7615-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches (based on v5.14-rc1) add arch_*() forms of the atomic_long_*()
operations for all architectures, and build atop this to have the generic
bitops provide arch_*() forms, allowing for safe usage in `noinstr` code. For
example, I'd like to be able to use these in arm64's entry code.

The first three patches cleanup the current code, simplifiying this by removing
some ARCH_ATOMIC remnants and centralizing the generated headers under
include/linux/atomic/ for consistency.

Patch four adds arch_atomic_long_*(). This is almost entirely scripted (adding
~600 lines), with the only manual change being to the order of includes in
include/linux/atomic.h, as we must now include atomic-long.h before
atomic-instrumented.h.

Patch five updates the generic bitop implementaton to provide arch_* forms.
Since the non-atomic ops can be implicitly instrumented, some logic is added to
omit the redundant checks.

I've pushed the patches to my atomics/arch-atomic-bitops branch [1,2].

I've given this some light build and boot testing so far.

Thanks,
Mark.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=atomics/arch-atomic-bitops
[2] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git atomics/arch-atomic-bitops

Mark Rutland (5):
  locking/atomic: simplify ifdef generation
  locking/atomic: remove ARCH_ATOMIC remanants
  locking/atomic: centralize generated headers
  locking/atomic: add arch_atomic_long*()
  locking/atomic: add generic arch_*() bitops

 include/asm-generic/atomic-long.h                  | 1014 --------------------
 include/asm-generic/bitops/atomic.h                |   32 +-
 .../asm-generic/bitops/instrumented-non-atomic.h   |   21 +-
 include/asm-generic/bitops/lock.h                  |   39 +-
 include/asm-generic/bitops/non-atomic.h            |   41 +-
 include/linux/atomic.h                             |    7 +-
 include/linux/{ => atomic}/atomic-arch-fallback.h  |    0
 .../atomic}/atomic-instrumented.h                  |  586 ++++++++++-
 include/linux/atomic/atomic-long.h                 | 1014 ++++++++++++++++++++
 scripts/atomic/check-atomics.sh                    |    6 +-
 scripts/atomic/fallbacks/acquire                   |    4 +-
 scripts/atomic/fallbacks/add_negative              |    6 +-
 scripts/atomic/fallbacks/add_unless                |    6 +-
 scripts/atomic/fallbacks/andnot                    |    4 +-
 scripts/atomic/fallbacks/dec                       |    4 +-
 scripts/atomic/fallbacks/dec_and_test              |    6 +-
 scripts/atomic/fallbacks/dec_if_positive           |    6 +-
 scripts/atomic/fallbacks/dec_unless_positive       |    6 +-
 scripts/atomic/fallbacks/fence                     |    4 +-
 scripts/atomic/fallbacks/fetch_add_unless          |    8 +-
 scripts/atomic/fallbacks/inc                       |    4 +-
 scripts/atomic/fallbacks/inc_and_test              |    6 +-
 scripts/atomic/fallbacks/inc_not_zero              |    6 +-
 scripts/atomic/fallbacks/inc_unless_negative       |    6 +-
 scripts/atomic/fallbacks/read_acquire              |    2 +-
 scripts/atomic/fallbacks/release                   |    4 +-
 scripts/atomic/fallbacks/set_release               |    2 +-
 scripts/atomic/fallbacks/sub_and_test              |    6 +-
 scripts/atomic/fallbacks/try_cmpxchg               |    4 +-
 scripts/atomic/gen-atomic-fallback.sh              |   68 +-
 scripts/atomic/gen-atomic-instrumented.sh          |   11 +-
 scripts/atomic/gen-atomic-long.sh                  |   10 +-
 scripts/atomic/gen-atomics.sh                      |    6 +-
 33 files changed, 1772 insertions(+), 1177 deletions(-)
 delete mode 100644 include/asm-generic/atomic-long.h
 rename include/linux/{ => atomic}/atomic-arch-fallback.h (100%)
 rename include/{asm-generic => linux/atomic}/atomic-instrumented.h (68%)
 create mode 100644 include/linux/atomic/atomic-long.h

-- 
2.11.0

