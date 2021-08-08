Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4AD3E3CEE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 00:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhHHVxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 17:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhHHVw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 17:52:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D5BC061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 14:52:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a8so24866079pjk.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 14:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBisvwrIQ7iEb0ZHHGpaTqr2PuP/8UAbapg7LIgk4LI=;
        b=ZYrBruw90MxhenNP5nSUlZ7lVFgEVfBoBAGLjXQcW3Xln3BInDaDrA/ThNjX/Arw38
         NvaL4QhoMEhEISmhK+7011NbHShaXVTRTV81c02eYSVTqaVJSaOPVuOhxWyxCZVHK26/
         QXLbuvQv4Rb4UQlRwV9zTcbf11Rh8pYgDL1YfwDl3BWdt6CkZFkhfVB70PoVubBitWmP
         iR/u5IARvpJRadGXg/2NHpDSYUB/IYuA4EKggm9aIS0ATV7SER8MXfPCY0z7jEOlxCFJ
         nNQMgbBVXCsyOk0ZH+r3PRox4SHpTLstaTszVtyBYlJRM/vbcYAg4rDxjHBsAKW5C1DI
         b04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBisvwrIQ7iEb0ZHHGpaTqr2PuP/8UAbapg7LIgk4LI=;
        b=uPWbIT+Z0K74jIJ2jl/O3R/Cmq+kBDoUiPTr8ctATBkUYiaB5wK16fJmmJUK6N0Ws5
         AoFUzXnQAVbLK1f5NasvCDyaxO1gHmBGca/OH+WgmlOttG6mX50bmqxC6NVGqDsN74Y/
         WWTOSyQ89IuZKSRpheMuKzsqOr217WJXDQBLaSjeP5Cwaswq1/2gcKetKRCvx6GcZL7z
         vCNUOuzrGkXv4RbA7oLDRVuKczyu4R1pQLQNpeMdYt33miiI183Vz6d3IH3TQTLQaTlF
         78XZoa+/Ax3MxLyRIBBEZZ+DMmHZw+JcAzjH7oVtRJh/rus626R56HnXxuXOJbDvLQ3a
         0WQA==
X-Gm-Message-State: AOAM531dq6UlshTijCI4Is9/DkcYLyTieHRl0UeLjG2IIN9OHR5XZv0t
        rt67mKHyXVVSlMUXb38btQ7Gr0OZ5sg=
X-Google-Smtp-Source: ABdhPJwSR4vBkyzWqC2fCEK7SqwJ5+3XQFoc+BgyNBy1Eu9dvKa+2s9azqsRBVxmCLw6PjUKzob0OQ==
X-Received: by 2002:a62:d404:0:b029:3a1:8a54:728 with SMTP id a4-20020a62d4040000b02903a18a540728mr15210415pfh.37.1628459557831;
        Sun, 08 Aug 2021 14:52:37 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:82f:f0c4:8925:ebc2])
        by smtp.gmail.com with ESMTPSA id r13sm20265080pgi.78.2021.08.08.14.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 14:52:37 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: change fiemap print out format
Date:   Sun,  8 Aug 2021 14:52:33 -0700
Message-Id: <20210808215234.1939266-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Given fiemap way to print out extents in the kernel, we can correctly
print the layout of each file in a unit of extent, not block. So, I
changed fiemap print out way like below.

Fiemap: offset = 0 len = 60
	logical addr.    physical addr.   length           flags
0	0000000000000000 00000020032df000 0000000000004000 00001008
1	0000000000004000 00000020032e0000 0000000000004000 00001008
2	0000000000008000 00000020032e1000 0000000000004000 00001008
3	000000000000c000 00000020032e2000 0000000000004000 00001008

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 tools/f2fs_io/f2fs_io.c | 53 ++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 42dbd60..0d2948e 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -731,11 +731,11 @@ static void do_randread(int argc, char **argv, const struct cmd_desc *cmd)
 #if defined(HAVE_LINUX_FIEMAP_H) && defined(HAVE_LINUX_FS_H)
 static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
 {
-	unsigned count, i;
-	int fd;
-	__u64 phy_addr;
-	struct fiemap *fm = xmalloc(sizeof(struct fiemap) +
-			sizeof(struct fiemap_extent));
+	unsigned int i;
+	int fd, extents_mem_size;
+	u64 start, length;
+	u32 mapped_extents;
+	struct fiemap *fm = xmalloc(sizeof(struct fiemap));
 
 	if (argc != 4) {
 		fputs("Excess arguments\n\n", stderr);
@@ -743,26 +743,41 @@ static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
 		exit(1);
 	}
 
-	fm->fm_start = atoi(argv[1]) * F2FS_BLKSIZE;
-	fm->fm_length = F2FS_BLKSIZE;
-	fm->fm_extent_count = 1;
-	count = atoi(argv[2]);
+	memset(fm, 0, sizeof(struct fiemap));
+	start = atoi(argv[1]) * F2FS_BLKSIZE;
+	length = atoi(argv[2]) * F2FS_BLKSIZE;
+	fm->fm_start = start;
+	fm->fm_length = length;
 
 	fd = xopen(argv[3], O_RDONLY | O_LARGEFILE, 0);
 
-	printf("Fiemap: offset = %08"PRIx64" len = %d\n",
-				(u64)fm->fm_start / F2FS_BLKSIZE, count);
-	for (i = 0; i < count; i++) {
-		if (ioctl(fd, FS_IOC_FIEMAP, fm) < 0)
-			die_errno("FIEMAP failed");
+	printf("Fiemap: offset = %"PRIu64" len = %"PRIu64"\n",
+				start / F2FS_BLKSIZE, length / F2FS_BLKSIZE);
+	if (ioctl(fd, FS_IOC_FIEMAP, fm) < 0)
+		die_errno("FIEMAP failed");
+
+	mapped_extents = fm->fm_mapped_extents;
+	extents_mem_size = sizeof(struct fiemap_extent) * mapped_extents;
+	free(fm);
+	fm = xmalloc(sizeof(struct fiemap) + extents_mem_size);
 
-		phy_addr = fm->fm_extents[0].fe_physical / F2FS_BLKSIZE;
-		printf("%llu: %llu\n", fm->fm_start / F2FS_BLKSIZE, phy_addr);
+	memset(fm, 0, sizeof(struct fiemap));
+	memset(fm->fm_extents, 0, extents_mem_size);
+	fm->fm_start = start;
+	fm->fm_length = length;
+	fm->fm_extent_count = mapped_extents;
 
-		if (fm->fm_extents[0].fe_flags & FIEMAP_EXTENT_LAST)
-			break;
+	if (ioctl(fd, FS_IOC_FIEMAP, fm) < 0)
+		die_errno("FIEMAP failed");
 
-		fm->fm_start += F2FS_BLKSIZE;
+	printf("\t%-17s%-17s%-17s%s\n", "logical addr.", "physical addr.", "length", "flags");
+	for (i = 0; i < fm->fm_mapped_extents; i++) {
+		printf("%d\t%.16llx %.16llx %.16llx %.8x\n", i,
+		    fm->fm_extents[i].fe_logical, fm->fm_extents[i].fe_physical,
+		    fm->fm_extents[i].fe_length, fm->fm_extents[i].fe_flags);
+
+		if (fm->fm_extents[i].fe_flags & FIEMAP_EXTENT_LAST)
+			break;
 	}
 	printf("\n");
 	free(fm);
-- 
2.32.0.605.g8dce9f2422-goog

