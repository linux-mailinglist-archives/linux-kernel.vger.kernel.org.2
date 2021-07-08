Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44E63C1AD8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 23:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhGHVMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 17:12:53 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:45306 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhGHVMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 17:12:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 53F6561BC7D4;
        Thu,  8 Jul 2021 23:10:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id N0AvF8LrfPmE; Thu,  8 Jul 2021 23:10:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 03FC4625DE15;
        Thu,  8 Jul 2021 23:10:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4FXJT9thVQqR; Thu,  8 Jul 2021 23:10:00 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id E40C261BC7D4;
        Thu,  8 Jul 2021 23:10:00 +0200 (CEST)
Date:   Thu, 8 Jul 2021 23:10:00 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <245242026.4934.1625778600867.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBIFS changes for 5.14
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: gccdygIs/rP4tTBt/0WbKQ2TL40HOw==
Thread-Topic: UBIFS changes for 5.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:

  Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.14-rc1

for you to fetch changes up to a801fcfeef96702fa3f9b22ad56c5eb1989d9221:

  ubifs: Set/Clear I_LINKABLE under i_lock for whiteout inode (2021-06-22 09:21:39 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UBIFS:

- Fix for a race xattr list and modification
- Various minor fixes (spelling, return codes, ...)

----------------------------------------------------------------
Dan Carpenter (1):
      ubifs: fix snprintf() checking

Zhen Lei (1):
      ubifs: journal: Fix error return code in ubifs_jnl_write_inode()

Zheng Yongjun (1):
      ubifs: Fix spelling mistakes

Zhihao Cheng (3):
      ubifs: Fix races between xattr_{set|get} and listxattr operations
      ubifs: Remove ui_mutex in ubifs_xattr_get and change_xattr
      ubifs: Set/Clear I_LINKABLE under i_lock for whiteout inode

 drivers/mtd/ubi/debug.c |  2 +-
 fs/ubifs/debug.c        |  2 +-
 fs/ubifs/dir.c          |  7 +++++++
 fs/ubifs/journal.c      |  3 ++-
 fs/ubifs/master.c       |  2 +-
 fs/ubifs/replay.c       |  2 +-
 fs/ubifs/super.c        |  3 ++-
 fs/ubifs/tnc_commit.c   |  2 +-
 fs/ubifs/ubifs.h        |  4 +++-
 fs/ubifs/xattr.c        | 48 +++++++++++++++++++++++++++++++++---------------
 10 files changed, 52 insertions(+), 23 deletions(-)
