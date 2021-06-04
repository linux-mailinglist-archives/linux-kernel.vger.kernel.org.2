Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4732639B0BC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 05:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFDDNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 23:13:50 -0400
Received: from m12-18.163.com ([220.181.12.18]:44072 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhFDDNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 23:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dlryy
        WVlvsjGjPmlZr4wasN+rfckYtap12Y9GmU8CGs=; b=PTR8z67k94NKz21p3dS3S
        N5FMo4TMqQ6ixiPpM7ZOpGDEFtfsFTjhniJXSRp1HCpNS3ULF4jQTTB3Gqb6iNVT
        Oy5ML1+TCauoMvUDAWhd3zkG12nW+QZPUucytlv67+ty2fNdzyz9X20tXYN2ev6b
        uRv8Hyc/zAfSnofc4sUV0A=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp14 (Coremail) with SMTP id EsCowABHSOABmrlgy+V3nQ--.55924S2;
        Fri, 04 Jun 2021 11:12:02 +0800 (CST)
From:   13145886936@163.com
To:     linux-kernel@vger.kernel.org
Cc:     gushengxian <gushengxian@yulong.com>
Subject: [PATCH] gen_init_cpio: Revised the use of space and tabs
Date:   Thu,  3 Jun 2021 20:11:59 -0700
Message-Id: <20210604031159.11234-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowABHSOABmrlgy+V3nQ--.55924S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxurWkurWfXF15GF1rAry3CFg_yoW5Gw4xpF
        Z0qr1jvr43Xay3CanxWr18Zrn8XryDKw13uFWvq348ZFsxX34rKw4UJw17Ka4Fkr13Za45
        Zay3KF4DKw4UJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b1CJQUUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/xtbBzgWng1QHMxhcugABsw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Revised the use of space and tabs.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 usr/gen_init_cpio.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 03b21189d58b..6c28a0938a5e 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -107,7 +107,7 @@ static int cpio_mkslink(const char *name, const char *target,
 
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
 	       "%08X%08X%08X%08X%08X%08X%08X",
 		"070701",		/* magic */
 		ino++,			/* ino */
@@ -156,7 +156,7 @@ static int cpio_mkgeneric(const char *name, unsigned int mode,
 
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
 	       "%08X%08X%08X%08X%08X%08X%08X",
 		"070701",		/* magic */
 		ino++,			/* ino */
@@ -250,7 +250,7 @@ static int cpio_mknod(const char *name, unsigned int mode,
 
 	if (name[0] == '/')
 		name++;
-	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
 	       "%08X%08X%08X%08X%08X%08X%08X",
 		"070701",		/* magic */
 		ino++,			/* ino */
@@ -335,12 +335,13 @@ static int cpio_mkfile(const char *name, const char *location,
 	size = 0;
 	for (i = 1; i <= nlinks; i++) {
 		/* data goes on last link */
-		if (i == nlinks) size = buf.st_size;
+		if (i == nlinks)
+			size = buf.st_size;
 
 		if (name[0] == '/')
 			name++;
 		namesize = strlen(name) + 1;
-		sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
+		sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
 		       "%08lX%08X%08X%08X%08X%08X%08X",
 			"070701",		/* magic */
 			ino,			/* ino */
@@ -373,10 +374,12 @@ static int cpio_mkfile(const char *name, const char *location,
 	}
 	ino++;
 	rc = 0;
-	
+
 error:
-	if (filebuf) free(filebuf);
-	if (file >= 0) close(file);
+	if (filebuf)
+		free(filebuf);
+	if (file >= 0)
+		close(file);
 	return rc;
 }
 
@@ -443,9 +446,10 @@ static int cpio_mkfile_line(const char *line)
 		dname = name;
 	}
 	rc = cpio_mkfile(dname, cpio_replace_env(location),
-	                 mode, uid, gid, nlinks);
+			mode, uid, gid, nlinks);
  fail:
-	if (dname_len) free(dname);
+	if (dname_len)
+		free(dname);
 	return rc;
 }
 
@@ -603,7 +607,7 @@ int main (int argc, char *argv[])
 
 		for (type_idx = 0; file_handler_table[type_idx].type; type_idx++) {
 			int rc;
-			if (! strcmp(line, file_handler_table[type_idx].type)) {
+			if (!strcmp(line, file_handler_table[type_idx].type)) {
 				if ((rc = file_handler_table[type_idx].handler(args))) {
 					ec = rc;
 					fprintf(stderr, " line %d\n", line_nr);
-- 
2.25.1


