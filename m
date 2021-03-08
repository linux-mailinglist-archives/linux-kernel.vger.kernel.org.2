Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC08331B34
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhCIAAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhCHX7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 18:59:47 -0500
Received: from mail.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54899C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 15:59:47 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id CF8A04D243037;
        Mon,  8 Mar 2021 15:59:45 -0800 (PST)
Date:   Mon, 08 Mar 2021 15:46:19 -0800 (PST)
Message-Id: <20210308.154619.729170517586257571.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT] SPARC
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Mon, 08 Mar 2021 15:59:46 -0800 (PST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Just some more random bits from Al,  including a conversion over to generic exytables.

Please pull, thanks a lot!

The following changes since commit 062c84fccc4444805738d76a2699c4d3c95184ec:

  Merge tag 'rproc-v5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc (2021-02-24 11:30:13 -0800)

are available in the Git repository at:

  git://git.kernel.org:/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to cf64c2a905e0dabcc473ca70baf275fb3a61fac4:

  Merge branch 'work.sparc32' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2021-02-26 16:16:24 -0800)

----------------------------------------------------------------
Al Viro (10):
      sparc32: don't bother with lookup_fault() in __bzero()
      sparc32: kill lookup_fault()
      sparc32: switch __bzero() away from range exception table entries
      sparc32: get rid of range exception table entries in checksum_32.S
      sparc32: switch copy_user.S away from range exception table entries
      sparc32: switch to generic extables
      Merge remote-tracking branch 'sparc/master' into work.sparc32
      sparc64: get rid of fake_swapper_regs
      sparc32: get rid of fake_swapper_regs
      sparc32: take ->thread.flags out

David S. Miller (2):
      Merge branch 'work.sparc' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
      Merge branch 'work.sparc32' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs

 arch/sparc/include/asm/elf_64.h                    |   1 -
 arch/sparc/include/asm/{extable_64.h => extable.h} |   4 +-
 arch/sparc/include/asm/processor_32.h              |   6 +-
 arch/sparc/include/asm/thread_info_64.h            |   1 +
 arch/sparc/include/asm/uaccess.h                   |   3 +
 arch/sparc/include/asm/uaccess_32.h                |  38 ----------
 arch/sparc/include/asm/uaccess_64.h                |   1 -
 arch/sparc/kernel/head_32.S                        |   2 +-
 arch/sparc/kernel/head_64.S                        |   2 +-
 arch/sparc/kernel/process_32.c                     |  12 ----
 arch/sparc/kernel/setup_32.c                       |   3 -
 arch/sparc/kernel/setup_64.c                       |   4 --
 arch/sparc/kernel/unaligned_32.c                   | 106 ++-------------------------
 arch/sparc/lib/checksum_32.S                       |  64 +++++++----------
 arch/sparc/lib/copy_user.S                         | 315 +++++++++++++++++++++++++++++----------------------------------------------------
 arch/sparc/lib/memset.S                            |  87 +++++++++--------------
 arch/sparc/mm/Makefile                             |   2 +-
 arch/sparc/mm/extable.c                            | 107 ----------------------------
 arch/sparc/mm/fault_32.c                           |  80 +++------------------
 arch/sparc/mm/mm_32.h                              |   2 -
 lib/extable.c                                      |   5 --
 21 files changed, 198 insertions(+), 647 deletions(-)
 rename arch/sparc/include/asm/{extable_64.h => extable.h} (92%)
 delete mode 100644 arch/sparc/mm/extable.c
