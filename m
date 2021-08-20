Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0EB3F2F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbhHTPhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 11:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbhHTPg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 11:36:58 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF66C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:36:20 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id x4so9530708pgh.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVaM21zboKi9bHEQ0ttFpVnASIsPfjTlp97ppLGTj1U=;
        b=Sojg/FHkKWx5wUVjCacavd+y6ZfzcktO5t3SV5aDArCmtppXNu/zhRNw43x79Vb/dL
         BAxy4fkdbNL1WJcQ+PN+/md+CQbQJh3QC9TuCKFtG0SAZN+pVKuzBIV4ZID/TfpCL9co
         +DulgMA2PlokWE3+Q2VOE8jbQ+3nazlsB7+HlPuGRSkc0cjdtrTYlubveGVGvlS54zmR
         QdFrCukummdFJN0jWJM/t/GvJ70rJh0iNCaCzIkWXLfwMnEHPVD9MFtyKfXsOnpy7I5/
         K0OOmTufWPY+OfWKjLbPBOVMUvm0Mk66HfL4sAhCKLIyfAAUJgvQ4kZWdS0nFH3tLzYS
         59ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVaM21zboKi9bHEQ0ttFpVnASIsPfjTlp97ppLGTj1U=;
        b=m1l5dz5jj8+Pd83LD5kcBE42dLzIzO4Fk4UN1qpT0gjvg/bKpTBMOv/Uq8NWVQemu1
         3Jp5RQtqvyTRu1OVEgZZGHDx9dpopmRzRGpj4L1zC3vG94joyjwp/oRayl0bDkS+7X+X
         +v9e858LXDvsK8fIF9Iv6BFWFVRMc8Xva1LIpBoC+7WKb46huU9NalWhtJp5GXl6v2tl
         KCWLu8lpxLarppa8kJLxaJYVHsEKrz6TDFAfDrL3Vs5SLuO+KXq60O8Vv1sO3F6HucY/
         VeKPilBarvEiLx3tCTFU/CcgNcP2Frl7gki2BYtC7kydUp+TgkMs0vsD6brxdGNOY6k6
         TcWw==
X-Gm-Message-State: AOAM530KCKHxUROzyeNMPdgWRZ2EXfbTeVexlFpVHEktnKgMxtK4Dibc
        GDtrVup0+wq+gxyhuNwEudVVm5iYXt8=
X-Google-Smtp-Source: ABdhPJwcdA24G6Cd01HsD0eemjnvTy4qFsaRW6JSBJ3Zhbi7SEB0630kvaIfGiynoPsRWd5pIP9biw==
X-Received: by 2002:a63:5f88:: with SMTP id t130mr19367782pgb.6.1629473779239;
        Fri, 20 Aug 2021 08:36:19 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:ab38:89b9:1824:6a27])
        by smtp.gmail.com with ESMTPSA id h24sm6684821pjv.3.2021.08.20.08.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 08:36:18 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs-tools: change fiemap print out format
Date:   Fri, 20 Aug 2021 08:36:14 -0700
Message-Id: <20210820153615.275030-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
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
v2: merged two separate memset into one
---
 tools/f2fs_io/f2fs_io.c | 52 ++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 42dbd60..ae4d405 100644
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
@@ -743,26 +743,40 @@ static void do_fiemap(int argc, char **argv, const struct cmd_desc *cmd)
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
+	memset(fm, 0, sizeof(struct fiemap) + extents_mem_size);
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
2.33.0.rc2.250.ged5fa647cd-goog

