Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70E93C3323
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 07:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhGJF4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 01:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhGJF4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 01:56:48 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E31DC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 22:54:04 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j9so5096719pfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 22:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lzHviVNvR5n7emS5jVnr0QdpnJPgvQFxs4HYngfgJ6k=;
        b=MiwshD6LXX9wwJxhyqr9fFHSeisZpFHFwXv5WnGAJIKB03U15wViUsuEEZ7T5JLeRV
         VgVRyMatSuSYnZS0KlkVVOBGozRusOHJAyb0gq1CZQshUSFrFXszl1Sj5T/m/ZxtsX1e
         fWgFS6CigmuPn/QI8FGeJUIJqAxWiJhBr46Obiw/HTjL6cSOePe7GTFASgMnuhresXvx
         jJiRm23WzSCZUtgW5FZiAKWWNPXjtoOJwsHLi9ZZFhwPviVdpt479b7LZhst4IByJnNm
         g4seX7S18xHiMVSrEUAp+xotqIYr4ua/qG5/00/31eT5xYMNhqAbusVvc5EoIqkAC/AT
         Jstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lzHviVNvR5n7emS5jVnr0QdpnJPgvQFxs4HYngfgJ6k=;
        b=UTQ3uaF54xqg4v4TI+WmGplyKNBMjDFOs+ksXH1YJ3avvoUhQLL7lgzexNx+4kASXo
         vbvmROwBm74AwyMvmW5ypbdtnqBiFhwGz9jrslR5dx8IBGiOrccZl08ITqGSyVmVc8q8
         fiuv6cTl7YU/1Ha4BVsL1ffTNxY2izgYf5u1QPynxBkdp2wGmzTvjhfwsFb5Y9oAl7RZ
         m+Ztb3fDTmoXd4v/mbGbpEQafKCpSaW3USBhkfziOjOazuPg5Cpd1Daq8X2Q1CzD1t16
         v6GIzb3cWBiD4/KTJ3rC85lD0F4s3zRHq3PTk1i4fYkyGxhDGStMok7sXjb2630pe2hq
         8jgA==
X-Gm-Message-State: AOAM531mx2pY2X1jcUiF3wBdWHO03egsxoOLtdE1xGsfLYjD7D626RcM
        wUA6Fp1TZpCCzdMRX2ntfwx9VFLqPbw=
X-Google-Smtp-Source: ABdhPJxkNnp65dXE7+Qb/f+xs6Qk2FT9LF5tyPV8WersknaAnkgz1a+9JGlGHSEZFFZ6qQkmmd07KQ==
X-Received: by 2002:a65:680b:: with SMTP id l11mr818733pgt.444.1625896443376;
        Fri, 09 Jul 2021 22:54:03 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:5944:1743:c40a:f492])
        by smtp.gmail.com with ESMTPSA id y7sm8695007pfy.153.2021.07.09.22.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 22:54:02 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3] f2fs: add sysfs nodes to get GC info for each GC mode
Date:   Fri,  9 Jul 2021 22:53:57 -0700
Message-Id: <20210710055357.1638111-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added gc_reclaimed_segments and gc_segment_mode sysfs nodes.
1) "gc_reclaimed_segments" shows how many segments have been
reclaimed by GC during a specific GC mode.
2) "gc_segment_mode" is used to control for which gc mode
the "gc_reclaimed_segments" node shows.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 14 +++++++++++++
 fs/f2fs/debug.c                         |  9 ++++++++
 fs/f2fs/f2fs.h                          |  5 +++++
 fs/f2fs/gc.c                            |  1 +
 fs/f2fs/sysfs.c                         | 28 +++++++++++++++++++++++++
 5 files changed, 57 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 95155e4ec7fe..3d1f853c6681 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -493,3 +493,17 @@ Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:	When ATGC is on, it controls age threshold to bypass GCing young
 		candidates whose age is not beyond the threshold, by default it was
 		initialized as 604800 seconds (equals to 7 days).
+
+What:		/sys/fs/f2fs/<disk>/gc_reclaimed_segments
+Date:		July 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show how many segments have been reclaimed by GC during a specific
+		GC mode (0: GC normal, 1: GC idle CB, 2: GC idle greedy,
+		3: GC idle AT, 4: GC urgent high, 5: GC urgent low)
+		You can re-initialize this value to "0".
+
+What:		/sys/fs/f2fs/<disk>/gc_segment_mode
+Date:		July 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	You can control for which gc mode the "gc_reclaimed_segments" node shows.
+		Refer to the description of the modes in "gc_reclaimed_segments".
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 833325038ef3..53ed1e9191f0 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -450,6 +450,15 @@ static int stat_show(struct seq_file *s, void *v)
 				si->data_segs, si->bg_data_segs);
 		seq_printf(s, "  - node segments : %d (%d)\n",
 				si->node_segs, si->bg_node_segs);
+		seq_printf(s, "  - Reclaimed segs : Normal (%d), Idle CB (%d), "
+				"Idle Greedy (%d), Idle AT (%d), "
+				"Urgent High (%d), Urgent Low (%d)\n",
+				si->sbi->gc_reclaimed_segs[GC_NORMAL],
+				si->sbi->gc_reclaimed_segs[GC_IDLE_CB],
+				si->sbi->gc_reclaimed_segs[GC_IDLE_GREEDY],
+				si->sbi->gc_reclaimed_segs[GC_IDLE_AT],
+				si->sbi->gc_reclaimed_segs[GC_URGENT_HIGH],
+				si->sbi->gc_reclaimed_segs[GC_URGENT_LOW]);
 		seq_printf(s, "Try to move %d blocks (BG: %d)\n", si->tot_blks,
 				si->bg_data_blks + si->bg_node_blks);
 		seq_printf(s, "  - data blocks : %d (%d)\n", si->data_blks,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 16ce1ade9fa6..502e47936651 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1251,6 +1251,7 @@ enum {
 	GC_IDLE_AT,
 	GC_URGENT_HIGH,
 	GC_URGENT_LOW,
+	MAX_GC_MODE,
 };
 
 enum {
@@ -1728,6 +1729,10 @@ struct f2fs_sb_info {
 	struct kmem_cache *inline_xattr_slab;	/* inline xattr entry */
 	unsigned int inline_xattr_slab_size;	/* default inline xattr slab size */
 
+	/* For reclaimed segs statistics per each GC mode */
+	unsigned int gc_segment_mode;		/* GC state for reclaimed segments */
+	unsigned int gc_reclaimed_segs[MAX_GC_MODE];	/* Reclaimed segs for each mode */
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	struct kmem_cache *page_array_slab;	/* page array entry */
 	unsigned int page_array_slab_size;	/* default page array slab size */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index da5947b30142..85f83ee38e24 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1648,6 +1648,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 							force_migrate);
 
 		stat_inc_seg_count(sbi, type, gc_type);
+		sbi->gc_reclaimed_segs[sbi->gc_mode]++;
 		migrated++;
 
 freed:
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 6642246206bd..15fe30d3aeb5 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -307,6 +307,14 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		return sysfs_emit(buf, "%u\n", sbi->compr_new_inode);
 #endif
 
+	if (!strcmp(a->attr.name, "gc_segment_mode"))
+		return sysfs_emit(buf, "%u\n", sbi->gc_segment_mode);
+
+	if (!strcmp(a->attr.name, "gc_reclaimed_segments")) {
+		return sysfs_emit(buf, "%u\n",
+			sbi->gc_reclaimed_segs[sbi->gc_segment_mode]);
+	}
+
 	ui = (unsigned int *)(ptr + a->offset);
 
 	return sprintf(buf, "%u\n", *ui);
@@ -515,6 +523,21 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_segment_mode")) {
+		if (t < MAX_GC_MODE)
+			sbi->gc_segment_mode = t;
+		else
+			return -EINVAL;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "gc_reclaimed_segments")) {
+		if (t != 0)
+			return -EINVAL;
+		sbi->gc_reclaimed_segs[sbi->gc_segment_mode] = 0;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -740,6 +763,9 @@ F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_count, max_candidate_cou
 F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_weight, age_weight);
 F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_threshold, age_threshold);
 
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_segment_mode, gc_segment_mode);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_reclaimed_segments, gc_reclaimed_segs);
+
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_urgent_sleep_time),
@@ -812,6 +838,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(atgc_candidate_count),
 	ATTR_LIST(atgc_age_weight),
 	ATTR_LIST(atgc_age_threshold),
+	ATTR_LIST(gc_segment_mode),
+	ATTR_LIST(gc_reclaimed_segments),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.32.0.93.g670b81a890-goog

