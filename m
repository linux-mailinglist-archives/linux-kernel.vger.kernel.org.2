Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEBA373144
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhEDURK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:17:10 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:37414 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhEDURF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:17:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D50B2606BA24;
        Tue,  4 May 2021 22:16:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id eXkyKx33kwUy; Tue,  4 May 2021 22:16:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7E7A460A3580;
        Tue,  4 May 2021 22:16:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0aaXASAaCyeY; Tue,  4 May 2021 22:16:08 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 659F6616B581;
        Tue,  4 May 2021 22:16:08 +0200 (CEST)
Date:   Tue, 4 May 2021 22:16:08 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <1774500012.55581.1620159368372.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for 5.13
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: GMHW0go7JLrUncpTk0+XTclL3ZgoxA==
Thread-Topic: UML changes for 5.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit d434405aaab7d0ebc516b68a8fc4100922d7f5ef:

  Linux 5.12-rc7 (2021-04-11 15:16:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.13-rc1

for you to fetch changes up to ed102bf2afed226703eaf85a704755bdbea34583:

  um: Fix W=1 missing-include-dirs warnings (2021-04-15 23:10:57 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Disable CONFIG_GCOV when built with modules
- Many fixes for W=1 related warnings
- Code cleanup

Due to lack of time I was unable to prepare a bigger pull request.
PR for the next merge window will contain more interesting material, I promise. :-)

----------------------------------------------------------------
Johannes Berg (3):
      um: Fix tag order in stub_32.h
      um: Mark all kernel symbols as local
      um: Disable CONFIG_GCOV with MODULES

Randy Dunlap (4):
      um: Add 2 missing libs to fix various build errors
      um: pgtable.h: Fix W=1 warning for empty body in 'do' statement
      um: elf.h: Fix W=1 warning for empty body in 'do' statement
      um: Fix W=1 missing-include-dirs warnings

Yang Li (3):
      um: Remove unneeded variable 'ret'
      um: Replace if (cond) BUG() with BUG_ON()
      um: Remove unused including <linux/version.h>

 arch/um/Kconfig.debug               |  1 +
 arch/um/drivers/hostaudio_kern.c    |  4 +---
 arch/um/drivers/vector_kern.c       |  1 -
 arch/um/include/asm/pgtable.h       |  2 +-
 arch/um/include/uapi/asm/Kbuild     |  1 +
 arch/um/kernel/Makefile             |  1 -
 arch/um/kernel/dyn.lds.S            |  6 ++++++
 arch/um/kernel/gmon_syms.c          | 16 ----------------
 arch/um/kernel/mem.c                |  3 +--
 arch/um/kernel/uml.lds.S            |  6 ++++++
 arch/x86/um/Makefile                |  1 +
 arch/x86/um/asm/elf.h               |  2 +-
 arch/x86/um/shared/sysdep/stub_32.h |  2 +-
 13 files changed, 20 insertions(+), 26 deletions(-)
 create mode 100644 arch/um/include/uapi/asm/Kbuild
 delete mode 100644 arch/um/kernel/gmon_syms.c
