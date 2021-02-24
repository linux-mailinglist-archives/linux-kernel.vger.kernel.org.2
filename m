Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36C324743
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 00:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhBXXAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 18:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbhBXXAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 18:00:43 -0500
Received: from zeniv-ca.linux.org.uk (unknown [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272BDC061574;
        Wed, 24 Feb 2021 15:00:03 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lF38E-000UEC-0d; Wed, 24 Feb 2021 22:59:46 +0000
Date:   Wed, 24 Feb 2021 22:59:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [git pull] work.sparc32
Message-ID: <YDbaYnzBVf604ns3@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Switching sparc32 to generic extables.  A bunch of magic goes away,
along with ARCH_HAS_SEARCH_EXTABLE.  Sat in -next for a couple of cycles
by now...

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.sparc32

for you to fetch changes up to 73686e787b495a85551e2e99c459adde6836eb31:

  Merge remote-tracking branch 'sparc/master' into work.sparc32 (2021-01-03 20:07:31 -0500)

----------------------------------------------------------------
Al Viro (7):
      sparc32: don't bother with lookup_fault() in __bzero()
      sparc32: kill lookup_fault()
      sparc32: switch __bzero() away from range exception table entries
      sparc32: get rid of range exception table entries in checksum_32.S
      sparc32: switch copy_user.S away from range exception table entries
      sparc32: switch to generic extables
      Merge remote-tracking branch 'sparc/master' into work.sparc32

 arch/sparc/Kconfig                                 |   2 +-
 arch/sparc/boot/piggyback.c                        |   4 +
 arch/sparc/include/asm/backoff.h                   |   2 +-
 arch/sparc/include/asm/elf_64.h                    |   1 -
 arch/sparc/include/asm/{extable_64.h => extable.h} |   4 +-
 arch/sparc/include/asm/pgtsrmmu.h                  |   2 +-
 arch/sparc/include/asm/uaccess.h                   |   3 +
 arch/sparc/include/asm/uaccess_32.h                |  38 ---
 arch/sparc/include/asm/uaccess_64.h                |   1 -
 arch/sparc/kernel/pci.c                            |   3 +-
 arch/sparc/kernel/unaligned_32.c                   |  10 +-
 arch/sparc/kernel/viohs.c                          |   6 +-
 arch/sparc/lib/checksum_32.S                       |  64 ++---
 arch/sparc/lib/copy_user.S                         | 315 ++++++++-------------
 arch/sparc/lib/memset.S                            |  86 +++---
 arch/sparc/mm/Makefile                             |   2 +-
 arch/sparc/mm/extable.c                            | 107 -------
 arch/sparc/mm/fault_32.c                           |  80 +-----
 arch/sparc/mm/mm_32.h                              |   2 -
 arch/sparc/mm/srmmu.c                              |  18 +-
 lib/extable.c                                      |   5 -
 21 files changed, 212 insertions(+), 543 deletions(-)
 rename arch/sparc/include/asm/{extable_64.h => extable.h} (92%)
 delete mode 100644 arch/sparc/mm/extable.c
