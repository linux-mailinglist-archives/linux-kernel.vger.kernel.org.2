Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8477C320D5C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 21:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhBUUC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 15:02:58 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:48490 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhBUUC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 15:02:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DECBB60A3582;
        Sun, 21 Feb 2021 21:02:14 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CxQ-5D8vKsRy; Sun, 21 Feb 2021 21:02:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9B40660A3587;
        Sun, 21 Feb 2021 21:02:14 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jVmISwEKIoao; Sun, 21 Feb 2021 21:02:14 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8270B60A3582;
        Sun, 21 Feb 2021 21:02:14 +0100 (CET)
Date:   Sun, 21 Feb 2021 21:02:14 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2079847149.14899.1613937734472.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] JFFS2/UBIFS and UBI changes for 5.12
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: TrGKkieyaZn28el165n92fOXdblJ5w==
Thread-Topic: JFFS2/UBIFS and UBI changes for 5.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

  Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.12-rc1

for you to fetch changes up to 42119dbe571eb419dae99b81dd20fa42f47464e1:

  ubifs: Fix error return code in alloc_wbufs() (2021-02-13 22:58:44 +0100)

----------------------------------------------------------------
This pull request contains changes (actually just fixes) for UBIFS

JFFS2:
- Fix for use-after-free in jffs2_sum_write_data()
- Fix for out-of-bounds access in jffs2_zlib_compress()

UBI:
- Remove dead/useless code

UBIFS:
- Fix for a memory leak in ubifs_init_authentication()
- Fix for high stack usage
- Fix for a off-by-one error in xattrs code

----------------------------------------------------------------
Arnd Bergmann (1):
      ubifs: replay: Fix high stack usage, again

Dinghao Liu (1):
      ubifs: Fix memleak in ubifs_init_authentication

Jubin Zhong (1):
      ubi: remove dead code in validate_vid_hdr()

Sascha Hauer (1):
      ubifs: Fix off-by-one error

Tom Rix (1):
      jffs2: fix use after free in jffs2_sum_write_data()

Wang ShaoBo (1):
      ubifs: Fix error return code in alloc_wbufs()

Yang Yang (1):
      jffs2: check the validity of dstlen in jffs2_zlib_compress()

Zheng Yongjun (1):
      ubi: eba: Delete useless kfree code

 drivers/mtd/ubi/eba.c  | 1 -
 drivers/mtd/ubi/io.c   | 7 +------
 fs/jffs2/compr_rtime.c | 3 +++
 fs/jffs2/summary.c     | 3 +++
 fs/ubifs/auth.c        | 2 +-
 fs/ubifs/journal.c     | 2 +-
 fs/ubifs/replay.c      | 4 +++-
 fs/ubifs/super.c       | 4 +++-
 fs/ubifs/xattr.c       | 2 +-
 9 files changed, 16 insertions(+), 12 deletions(-)
