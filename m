Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB093EDDE8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhHPTb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhHPTb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:31:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6E5F601FA;
        Mon, 16 Aug 2021 19:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629142256;
        bh=MNpoNMPup3IDLG5hKn11lfoqTkvEgfR2Jw5Jdfr4Re4=;
        h=From:To:Cc:Subject:Date:From;
        b=UXl9WFuGS2/XPznNnst1mOdgqLJoqg9HFd3KFPed3A/ip+eusBli00yhwsv4uVI3/
         88m79cwaXI8IYPczeW/ccxT4rrEH2gFJdgyzdwlIxAkvRu7PeldZvBkSwCWabs9+1G
         7gYM4g20j2oS+ZR4FoT/h/czWO/Ja23/WVaa3jGWC88CbgWsFrT1AMTHAQChCQIFxN
         e/zKqbVkKOKFiIfAHDAUJF5BverLiVEzwfiCoRMz6JitLz1CTl1DKwcia5NxTUgPq0
         sXKUt4shQfVmrHYamUSs9VReFQLsBQJce5udfCWw821+Udq1nb/tIExDreRSZhwtIv
         O44mD+TbbPkkQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] fs/ntfs3: Remove unused variable cnt in ntfs_security_init()
Date:   Mon, 16 Aug 2021 12:30:41 -0700
Message-Id: <20210816193041.1164125-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

fs/ntfs3/fsntfs.c:1874:9: warning: variable 'cnt' set but not used
[-Wunused-but-set-variable]
        size_t cnt, off;
               ^
1 warning generated.

It is indeed unused so remove it.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/ntfs3/fsntfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 92140050fb6c..c6599c514acf 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1871,7 +1871,7 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
 	struct ATTRIB *attr;
 	struct ATTR_LIST_ENTRY *le;
 	u64 sds_size;
-	size_t cnt, off;
+	size_t off;
 	struct NTFS_DE *ne;
 	struct NTFS_DE_SII *sii_e;
 	struct ntfs_fnd *fnd_sii = NULL;
@@ -1946,7 +1946,6 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
 	sbi->security.next_off =
 		Quad2Align(sds_size - SecurityDescriptorsBlockSize);
 
-	cnt = 0;
 	off = 0;
 	ne = NULL;
 
@@ -1964,8 +1963,6 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
 		next_id = le32_to_cpu(sii_e->sec_id) + 1;
 		if (next_id >= sbi->security.next_id)
 			sbi->security.next_id = next_id;
-
-		cnt += 1;
 	}
 
 	sbi->security.ni = ni;

base-commit: 96b18047a7172037ff4206720f4e889670030b41
-- 
2.33.0.rc2

