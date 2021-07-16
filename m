Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF86F3CBEC8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 23:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbhGPWAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 18:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbhGPWAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 18:00:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B070C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 14:57:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g4-20020a17090ace84b029017554809f35so9552519pju.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 14:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c2JBcs4jRw3dV/Sn1RjrXaIM642g/ajOXjxCElidjgU=;
        b=eRdtnDXOj2F2cPOip1VDWppZdfZ9LoUYtOG1Y2GIkqkT2nxLCg5t0wYNaR3S7u5BrO
         F6IYcQOwe1ewi42K5NVNRNaq3i4CwlnuuKzSpPJZiFIYsVBqOnWeJqry6VIQtIO//l6X
         T6Gyeexg0cxA67jPUfrip92rqV9qjF10SBzUVC3A2d7oIM9TEw9ei5xEpLaDBSorF1Um
         zq4HTb91FYGRKXpBVF6PzZQazPxzTzA1xMoXS+v5GpQnF5/wUUr34kHnVRdMOGpuRbBy
         zAHdJhqOFeCGP3sZ5IE2QUa0YpolpTC/VU4IiqBo1jzwDzKc+akc5ledQ1oN3DSp4e7I
         tlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c2JBcs4jRw3dV/Sn1RjrXaIM642g/ajOXjxCElidjgU=;
        b=Cl1vhVppeCvHoVThul0EzchftYgQKLciLZZuBEWoN/9mfhbPZdBCcZcLN8eRuG8QkE
         doN7AeL3uO1VT++WP+N06ZnZK5vaC6SsnGltN4xaqyUdfgm0ka5eArvqTu0v51OS56im
         BEoBp6Ue84gM323sG8DHZ5rFcQVT1/A6RAvjurHux1K95dXcbV1/leIFEZDauB1kGVx7
         Z4wmexLWAaiNiMNZ7UvkG9nS64aG6cH4ArKjyauY5NDNpyMKcummyh/oJ/0ABOh8Py1R
         jo/F3go0TwAPf6PzFbH2c5q6r8x98Rdtu/ROZMXgh41GZO5F69fDRw8iGQCR1UDSZyH3
         hxtg==
X-Gm-Message-State: AOAM530W5ShRBEf1BzbUPPaJ24LtgGev9UX2iBwDHP69o0gV7Qu18fhw
        BEkihnhMgniqteUEb1g9LtNH7BZOwrg=
X-Google-Smtp-Source: ABdhPJwmb/zQFnRJCht+KSGegXorPeHDclify6EE3c6zesHGgLJONmsGp0mps/JFKTkF+9EA83O2Gg==
X-Received: by 2002:a17:90a:e2c5:: with SMTP id fr5mr12168529pjb.34.1626472629409;
        Fri, 16 Jul 2021 14:57:09 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:7cda:6a24:f8e4:c42f])
        by smtp.gmail.com with ESMTPSA id t10sm12095141pgv.52.2021.07.16.14.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 14:57:08 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: add periodic check in kernel version check
Date:   Fri, 16 Jul 2021 14:57:03 -0700
Message-Id: <20210716215703.1560325-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

In previous, we did a full scan right after kernel version is changed
and it triggered many unnecessary full scan whenever a newly built
kernel is downloaded. Plus, we are lack of a periodic health check of
on-disk filesystem images. So, I added a monthly periodic check after
a new vesion is updated.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/mount.c      | 50 +++++++++++++++++++++++++++++++++++------------
 include/f2fs_fs.h |  4 +++-
 lib/libf2fs.c     |  6 +++---
 3 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 1f2d7e0..7c4c681 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -13,6 +13,7 @@
 #include "xattr.h"
 #include <locale.h>
 #include <stdbool.h>
+#include <time.h>
 #ifdef HAVE_LINUX_POSIX_ACL_H
 #include <linux/posix_acl.h>
 #endif
@@ -424,7 +425,7 @@ printout:
 	DISP_u32(sb, meta_ino);
 	DISP_u32(sb, cp_payload);
 	DISP_u32(sb, crc);
-	DISP("%-.256s", sb, version);
+	DISP("%-.252s", sb, version);
 	printf("\n");
 }
 
@@ -939,6 +940,8 @@ int sanity_check_raw_super(struct f2fs_super_block *sb, enum SB_ADDR sb_addr)
 	return 0;
 }
 
+#define CHECK_PERIOD (3600 * 24 * 30)	// one month by default
+
 int validate_super_block(struct f2fs_sb_info *sbi, enum SB_ADDR sb_addr)
 {
 	char buf[F2FS_BLKSIZE];
@@ -956,31 +959,54 @@ int validate_super_block(struct f2fs_sb_info *sbi, enum SB_ADDR sb_addr)
 	if (!sanity_check_raw_super(sbi->raw_super, sb_addr)) {
 		/* get kernel version */
 		if (c.kd >= 0) {
-			dev_read_version(c.version, 0, VERSION_LEN);
+			dev_read_version(c.version, 0, VERSION_NAME_LEN);
 			get_kernel_version(c.version);
 		} else {
 			get_kernel_uname_version(c.version);
 		}
 
 		/* build sb version */
-		memcpy(c.sb_version, sbi->raw_super->version, VERSION_LEN);
+		memcpy(c.sb_version, sbi->raw_super->version, VERSION_NAME_LEN);
 		get_kernel_version(c.sb_version);
-		memcpy(c.init_version, sbi->raw_super->init_version, VERSION_LEN);
+		memcpy(c.init_version, sbi->raw_super->init_version,
+				VERSION_NAME_LEN);
 		get_kernel_version(c.init_version);
 
 		MSG(0, "Info: MKFS version\n  \"%s\"\n", c.init_version);
 		MSG(0, "Info: FSCK version\n  from \"%s\"\n    to \"%s\"\n",
 					c.sb_version, c.version);
-		if (!c.no_kernel_check &&
-				memcmp(c.sb_version, c.version, VERSION_LEN)) {
-			c.auto_fix = 0;
-			c.fix_on = 1;
-		}
-		if (c.fix_on) {
-			memcpy(sbi->raw_super->version,
-						c.version, VERSION_LEN);
+		if (!c.no_kernel_check) {
+			struct timespec t;
+			u32 prev_time, cur_time, time_diff;
+			__le32 *ver_ts_ptr = (__le32 *)(sbi->raw_super->version
+						+ VERSION_NAME_LEN);
+
+			t.tv_sec = t.tv_nsec = 0;
+			clock_gettime(CLOCK_REALTIME, &t);
+			cur_time = (u32)t.tv_sec;
+			prev_time = le32_to_cpu(*ver_ts_ptr);
+
+			MSG(0, "Info: version timestamp cur: %u, prev: %u\n",
+					cur_time, prev_time);
+			if (!memcmp(c.sb_version, c.version,
+						VERSION_NAME_LEN)) {
+				/* valid prev_time */
+				if (prev_time != 0 && cur_time > prev_time) {
+					time_diff = cur_time - prev_time;
+					if (time_diff < CHECK_PERIOD)
+						goto out;
+					c.auto_fix = 0;
+					c.fix_on = 1;
+				}
+			} else {
+				memcpy(sbi->raw_super->version,
+						c.version, VERSION_NAME_LEN);
+			}
+
+			*ver_ts_ptr = cpu_to_le32(cur_time);
 			update_superblock(sbi->raw_super, SB_MASK(sb_addr));
 		}
+out:
 		print_sb_state(sbi->raw_super);
 		return 0;
 	}
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 45f7257..3000d9d 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -350,7 +350,9 @@ static inline uint64_t bswap_64(uint64_t val)
 #define	DEFAULT_BLOCKS_PER_SEGMENT	512
 #define DEFAULT_SEGMENTS_PER_SECTION	1
 
-#define VERSION_LEN	256
+#define VERSION_LEN		256
+#define VERSION_TIMESTAMP_LEN	4
+#define VERSION_NAME_LEN	(VERSION_LEN - VERSION_TIMESTAMP_LEN)
 
 #define LPF "lost+found"
 
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 876c1dc..c6ab329 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -828,7 +828,7 @@ int f2fs_devs_are_umounted(void)
 void get_kernel_version(__u8 *version)
 {
 	int i;
-	for (i = 0; i < VERSION_LEN; i++) {
+	for (i = 0; i < VERSION_NAME_LEN; i++) {
 		if (version[i] == '\n')
 			break;
 	}
@@ -846,10 +846,10 @@ void get_kernel_uname_version(__u8 *version)
 
 #if defined(WITH_KERNEL_VERSION)
 	snprintf((char *)version,
-		VERSION_LEN, "%s %s", buf.release, buf.version);
+		VERSION_NAME_LEN, "%s %s", buf.release, buf.version);
 #else
 	snprintf((char *)version,
-		VERSION_LEN, "%s", buf.release);
+		VERSION_NAME_LEN, "%s", buf.release);
 #endif
 #else
 	memset(version, 0, VERSION_LEN);
-- 
2.32.0.402.g57bb445576-goog

