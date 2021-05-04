Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96D2373143
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhEDURD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:17:03 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:37384 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhEDURB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:17:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E636E616B584;
        Tue,  4 May 2021 22:16:02 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nF_cEsHtKrhB; Tue,  4 May 2021 22:16:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7E19F616B581;
        Tue,  4 May 2021 22:16:02 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id h1XM32xtwEee; Tue,  4 May 2021 22:16:02 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 486B7608A38A;
        Tue,  4 May 2021 22:16:02 +0200 (CEST)
Date:   Tue, 4 May 2021 22:16:02 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <1258125270.55580.1620159361990.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] JFFS2, UBI and UBIFS changes for 5.13
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: e8eii+QRwXewm5Jz3riefse6I71Cfg==
Thread-Topic: JFFS2, UBI and UBIFS changes for 5.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit d434405aaab7d0ebc516b68a8fc4100922d7f5ef:

  Linux 5.12-rc7 (2021-04-11 15:16:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.13-rc1

for you to fetch changes up to 9a29f7f020e06f14eb126bcb84a7f0d166415824:

  ubi: Remove unnecessary struct declaration (2021-04-15 22:01:25 +0200)

----------------------------------------------------------------
This pull request contains changes for JFFS2, UBI and UBIFS

JFFS2:
- Use splice_write()
- Fix for a slab-out-of-bounds bug

UBI:
- Fix for clang related warnings
- Code cleanup

UBIFS:
- Fix for inode rebirth at replay
- Set s_uuid
- Use zstd for default filesystem

----------------------------------------------------------------
Arnd Bergmann (1):
      jffs2: avoid Wempty-body warnings

Guochun Mao (1):
      ubifs: Only check replay with inode type to judge if inode linked

Gustavo A. R. Silva (1):
      ubi: Fix fall-through warnings for Clang

Joel Stanley (1):
      jffs2: Hook up splice_write callback

Martin Devera (1):
      ubifs: Report max LEB count at mount time

Rui Salvaterra (1):
      ubifs: Default to zstd compression

Steffen Trumtrar (1):
      ubifs: Set s_uuid in super block to support ima/evm uuid options

Wan Jiabing (1):
      ubi: Remove unnecessary struct declaration

lizhe (1):
      jffs2: Fix kasan slab-out-of-bounds problem

 drivers/mtd/ubi/build.c |  1 +
 drivers/mtd/ubi/ubi.h   |  2 --
 fs/jffs2/file.c         |  1 +
 fs/jffs2/scan.c         |  2 +-
 fs/jffs2/summary.h      | 16 ++++++++--------
 fs/ubifs/replay.c       |  3 ++-
 fs/ubifs/sb.c           |  3 +++
 fs/ubifs/super.c        |  6 ++++--
 8 files changed, 20 insertions(+), 14 deletions(-)
