Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028F43D3017
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 01:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhGVWdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 18:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbhGVWd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 18:33:29 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C885C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 16:14:03 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a17-20020a17090abe11b0290173ce472b8aso6436194pjs.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 16:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SegNg7H7cBrrJSTIu9IxhK9gndrxnfwXCQId3QaK+t4=;
        b=pejoMsBXtkdB2ryuxXkEQ1dqQkG3twf1hTpmIjbAk970ydOc31x9Mv80KEK4ttynMk
         2qEHSuwTva/NY53x2NJTXyGp5KsHZ+M9vaxO5XlkcKSYwSlrl5BgKqPV6A3qV2TSa5qj
         ibNegrXaAd3faBJKNZ6MwBC0hOsWxPMUf75EQkqzFlp6cSa3zGE55W0FySt022VG8r9L
         R45bFQWXLeJ3T2oV0HoxrwRnRJZbCtpa+ql/i9vD0+Tcwu7l4weC4qxDC7O9CJjukIT4
         mB6mfjatTtP3Sr6n1mfxNDkmXyipdzZhFpqNkb9dHseejwuseJE9ROuj9wAVTPEI71H6
         CWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SegNg7H7cBrrJSTIu9IxhK9gndrxnfwXCQId3QaK+t4=;
        b=p2FfpIXA2whHddgVtiUvxLaG1tYOh/X/lPuXt7CaFJWKcYmM6z016EgUJGEKzg0Zv7
         1X6c37vKmdy3GR+PkwGMfe4Z3sbJWULCgP7QEMxLDZBooi16G0tUe3dB+jpOmftCdzUH
         b0gQpIYEaMwBpUts03BvAV/w5vVCZEEdY2NRmdgMEDk5w5W7V8S0BUVwyMGp0USN6jQz
         ox5pUe7m/KGz2yTOovgM9mZnfcbWZ4raK9/So3wuhRFZtIrOqwE6aYSN6jBnNk+dPjot
         b0Ya/bRbL0dhl9lq3nfhO6CTfESzGiYc3tbJG+mM7dwDoX2uLXNR/fVExx6qcxS1hIhb
         FS7w==
X-Gm-Message-State: AOAM530Cv6mqKloHG1w8+T70PTtq2GzkYYR49WS+3UVCH3+ZeLK931jC
        NcvGB/iEwcwXo09leWO41eOffInjwEg=
X-Google-Smtp-Source: ABdhPJyuNcQNX49/ZMge3MPp6VSqkojAVznHFT5gNfz9ZlqDeqjJm958BzqCifmLQypswYRjXJQE8g==
X-Received: by 2002:a17:90b:3b4c:: with SMTP id ot12mr1944328pjb.218.1626995642606;
        Thu, 22 Jul 2021 16:14:02 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:4610:babe:3aeb:2b63])
        by smtp.gmail.com with ESMTPSA id a35sm20934756pgm.66.2021.07.22.16.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 16:14:02 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: add sysfs node to control ra_pages for fadvise seq file
Date:   Thu, 22 Jul 2021 16:13:58 -0700
Message-Id: <20210722231358.611801-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

fadvise() allows the user to expand the readahead window to double with
POSIX_FADV_SEQUENTIAL, now. But, in some use cases, it is not that
sufficient and we need to meet the need in a restricted way. We can
control the multiplier value of bdi device readahead between 2 (default)
and 256 for POSIX_FADV_SEQUENTIAL advise option.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  6 +++++
 fs/f2fs/f2fs.h                          |  2 ++
 fs/f2fs/file.c                          | 32 +++++++++++++++++++++++++
 fs/f2fs/super.c                         |  1 +
 fs/f2fs/sysfs.c                         | 10 ++++++++
 5 files changed, 51 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 3d1f853c6681..60f1f176374e 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -507,3 +507,9 @@ Date:		July 2021
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	You can control for which gc mode the "gc_reclaimed_segments" node shows.
 		Refer to the description of the modes in "gc_reclaimed_segments".
+
+What:		/sys/fs/f2fs/<disk>/seq_file_ra_mul
+Date:		July 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	You can	control the multiplier value of	bdi device readahead window size
+		between 2 (default) and 256 for POSIX_FADV_SEQUENTIAL advise option.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 502e47936651..c59329dcb1f6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1733,6 +1733,8 @@ struct f2fs_sb_info {
 	unsigned int gc_segment_mode;		/* GC state for reclaimed segments */
 	unsigned int gc_reclaimed_segs[MAX_GC_MODE];	/* Reclaimed segs for each mode */
 
+	unsigned long seq_file_ra_mul;		/* multiplier for ra_pages of seq. files in fadvise */
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	struct kmem_cache *page_array_slab;	/* page array entry */
 	unsigned int page_array_slab_size;	/* default page array slab size */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6afd4562335f..f71c90236815 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -23,6 +23,7 @@
 #include <linux/nls.h>
 #include <linux/sched/signal.h>
 #include <linux/fileattr.h>
+#include <linux/fadvise.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -4332,6 +4333,36 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	return ret;
 }
 
+static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
+		int advice)
+{
+	int ret;
+	struct inode *inode;
+	struct address_space *mapping;
+	struct backing_dev_info *bdi;
+
+	if (advice == POSIX_FADV_SEQUENTIAL) {
+		inode = file_inode(filp);
+		if (S_ISFIFO(inode->i_mode))
+			return -ESPIPE;
+
+		mapping = filp->f_mapping;
+		if (!mapping || len < 0)
+			return -EINVAL;
+
+		bdi = inode_to_bdi(mapping->host);
+		filp->f_ra.ra_pages = bdi->ra_pages * F2FS_I_SB(inode)->seq_file_ra_mul;
+		spin_lock(&filp->f_lock);
+		filp->f_mode &= ~FMODE_RANDOM;
+		spin_unlock(&filp->f_lock);
+		return 0;
+	}
+
+	ret = generic_fadvise(filp, offset, len, advice);
+
+	return ret;
+}
+
 #ifdef CONFIG_COMPAT
 struct compat_f2fs_gc_range {
 	u32 sync;
@@ -4460,4 +4491,5 @@ const struct file_operations f2fs_file_operations = {
 #endif
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
+	.fadvise	= f2fs_file_fadvise,
 };
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9089303f7f8c..ccb745807fe1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3312,6 +3312,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
 	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
 	sbi->migration_granularity = sbi->segs_per_sec;
+	sbi->seq_file_ra_mul = 2;
 
 	sbi->dir_level = DEF_DIR_LEVEL;
 	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 15fe30d3aeb5..9a21be63436d 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -538,6 +538,14 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "seq_file_ra_mul")) {
+		if (t >= 2 && t <= 256)
+			sbi->seq_file_ra_mul = t;
+		else
+			return -EINVAL;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -763,6 +771,7 @@ F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_count, max_candidate_cou
 F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_weight, age_weight);
 F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_threshold, age_threshold);
 
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, seq_file_ra_mul, seq_file_ra_mul);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_segment_mode, gc_segment_mode);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_reclaimed_segments, gc_reclaimed_segs);
 
@@ -838,6 +847,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(atgc_candidate_count),
 	ATTR_LIST(atgc_age_weight),
 	ATTR_LIST(atgc_age_threshold),
+	ATTR_LIST(seq_file_ra_mul),
 	ATTR_LIST(gc_segment_mode),
 	ATTR_LIST(gc_reclaimed_segments),
 	NULL,
-- 
2.32.0.432.gabb21c7263-goog

