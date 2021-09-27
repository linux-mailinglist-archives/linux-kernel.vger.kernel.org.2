Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61D8419618
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhI0OUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234692AbhI0OT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:19:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 606DF60EC0;
        Mon, 27 Sep 2021 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632752299;
        bh=i9UA8nXi2HqSCrUratcAGO/xQHmPOF8KqMc7/yV/Nx8=;
        h=From:To:Cc:Subject:Date:From;
        b=lWN3HznredrNPSogAcloFJ7fALhgrsrfvdpwQPrcfjP3LL7HV94IG4hnBe4G5onNY
         pxef/9s4A0ksQlGrAEZmSYaXktzR3KQVkfNtzotbI/SDVVX1ioTdoWjdtFqRPBicPI
         5MsUzK2V6VY5vjHb6BL9Kj+cC7z+fCq9skAYNHHArneYOg2S6+dfmUYvduMdUFVh1y
         pBGFHaT0HgG6K2REL1tlSz0oWLY4VC4vC9UqlYfz/jQZbb3TV3A0DYWUInFukB79iI
         9ShpZmeaCqCMOAJqfUl+Tbw255L+iIeCC932O+ErohqGLFKjIX5YCMyIm8crsC4nWl
         OY/rqJE9CNBiw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Anton Altaparmakov <anton@tuxera.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] ntfs: disable for 64KB because of stack overflow risk
Date:   Mon, 27 Sep 2021 16:18:03 +0200
Message-Id: <20210927141815.1711736-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

On ARM64 randconfig builds, we occasionally get warnings for NTFS:

fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
fs/ntfs/aops.c:1328:1: error: the frame size of 2224 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]

The problem here is that with 64KB pages, we get two arrays on the
stack that each have 128 pointers, for a total of 2KB. Before
the VLA change, this could already happen with 512-byte blocks,
however in practice NTFS should usually have 4KB blocks and not
be affected by this (see link).

Now the stack usage is always > 2KB on any architecture with 64KB
pages. Since both NTFS and 64KB page support are fairly rare,
we may get away with just marking the combination as disallowed
in Kconfig and see if anyone complains before we find a different
way to address it.

Fixes: ac4ecf968acb ("ntfs: aops: remove VLA usage")
Link: https://support.microsoft.com/en-us/help/140365/default-cluster-size-for-ntfs-fat-and-exfat
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ntfs/Kconfig | 1 +
 fs/ntfs/aops.c  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
index 1667a7e590d8..b770f0209b9c 100644
--- a/fs/ntfs/Kconfig
+++ b/fs/ntfs/Kconfig
@@ -2,6 +2,7 @@
 config NTFS_FS
 	tristate "NTFS file system support"
 	select NLS
+	depends on !PAGE_SIZE_64KB && !ARM64_64K_PAGES
 	help
 	  NTFS is the file system of Microsoft Windows NT, 2000, XP and 2003.
 
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index bb0a43860ad2..76d59bd4c1eb 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -914,6 +914,9 @@ static int ntfs_write_mst_block(struct page *page,
 	bool sync, is_mft, page_is_dirty, rec_is_dirty;
 	unsigned char bh_size_bits;
 
+	/* Two arrays of MAX_BUF_PER_PAGE on the stack risks an overrun with 64K pages */
+	BUILD_BUG_ON(PAGE_SIZE >= 65536);
+
 	if (WARN_ON(rec_size < NTFS_BLOCK_SIZE))
 		return -EINVAL;
 
-- 
2.29.2

