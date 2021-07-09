Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21E43C2A81
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 22:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGIUr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 16:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGIUrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 16:47:25 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE7BC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 13:44:41 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so8927702pjs.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 13:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iFKfOHPWNRehyMMb6EVJKVOyGtUORa52In1SCytQALI=;
        b=uJDwiNUd2i0a89wFt/pd7XuecL3FcaCbSKHCJDZB1hxI4eWv3J9R4dqiZO+mNnPp/c
         vIfUF82BRiDmT/BQXvuFhdCm1+iZzUzQp3+EatJkGSt3zZbm0ej+zxgk70/luqpiK/9L
         xzMn6suJoVo2e2rtnnpXLdIW/NoKQir8a8qzFs4AGbwaUaigfGivrgGxRRzObFIqNtJo
         HrM1SdK6FcwoXlXanmsss8OrOC0a6mfV1ih0MYi70/eWzdo3uB01Iu7OJfadqb4DsdMf
         FFbEkC4OjqFljvjS8GC93QGbJo6IxSbgzD7nvr9mIQ0u3g8pZMbIXHkHQ5giOnH8NjS3
         SmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iFKfOHPWNRehyMMb6EVJKVOyGtUORa52In1SCytQALI=;
        b=DFZB90js1hSRVWKjmZF7yy/DacFRHLhzmGsjnEdvX+boLQVIe0qRU+XVHek7ssrSah
         iLbqUQLQDA47/KkCerUkWMe0+yvW0Htd/Luq/3A3bk8vsMS+2VWaSSrLOtZzdN+C+NTk
         JrPgcajDcnL7YTHh5EjsT+Jf6Un0nszz9PTb+2WcAKiaWL783MTLkTy2L+gaKo2k+vMq
         QIIfLfoZy0YPHwS83DWLjDH7is/HRihhLARpxiPs9Aty/K8mL9d73gR2JOMj+NXPcmYz
         rQYdNAifAgvTVvXyYKOZM8HMVWvS+QAmW5tuBnm6dJpmk++Uh81GpYxFjzWSj8B1mFu0
         0nSw==
X-Gm-Message-State: AOAM5332MXBH8mQYIuy1FQ9L4H4Zzr1lRCu/xfKJnjwYILC4SrjJpiwP
        JZefSMnV6x/VIHDWiRoeDSfEizivA4c=
X-Google-Smtp-Source: ABdhPJwMQwUzGbPRiIc7MfVoy0lWZEJjJIPB0j7PNm51b1CRVAeeyG+dyOzkUl6ugHFlOPS+8M41JA==
X-Received: by 2002:a17:90a:d590:: with SMTP id v16mr39175533pju.205.1625863480311;
        Fri, 09 Jul 2021 13:44:40 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:5944:1743:c40a:f492])
        by smtp.gmail.com with ESMTPSA id o34sm8558852pgm.6.2021.07.09.13.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 13:44:39 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: add sysfs nodes to get GC info for each GC mode
Date:   Fri,  9 Jul 2021 13:44:30 -0700
Message-Id: <20210709204430.1293298-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added gc_dirty_segs and gc_dirty_segs_mode sysfs nodes.
1) "gc_dirty_segs" shows how many dirty segments have been
reclaimed by GC during a specific GC mode.
2) "gc_dirty_segs_mode" is used to control for which gc mode
the "gc_dirty_segs" node shows.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 14 +++++++++++++
 fs/f2fs/debug.c                         |  9 ++++++++
 fs/f2fs/f2fs.h                          |  5 +++++
 fs/f2fs/gc.c                            |  1 +
 fs/f2fs/sysfs.c                         | 28 +++++++++++++++++++++++++
 5 files changed, 57 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 95155e4ec7fe..0d863eb185f6 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -493,3 +493,17 @@ Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:	When ATGC is on, it controls age threshold to bypass GCing young
 		candidates whose age is not beyond the threshold, by default it was
 		initialized as 604800 seconds (equals to 7 days).
+
+What:		/sys/fs/f2fs/<disk>/gc_dirty_segs
+Date:		July 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show how many dirty segments have been reclaimed by GC during
+		a specific GC mode (0: GC normal, 1: GC idle CB, 2: GC idle greedy,
+		3: gc idle AT, 4: GC urgent high, 5: GC urgent low)
+		You can re-initialize this value to "0".
+
+What:		/sys/fs/f2fs/<disk>/gc_dirty_segs_mode
+Date:		July 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	You can control for which gc mode the "gc_dirty_segs" node shows.
+		Refer to the description of the modes in "gc_dirty_segs".
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
index 16ce1ade9fa6..74b1e621c15f 100644
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
 
+	/* For reclaimed dirty segs statistics per each GC mode */
+	unsigned int gc_dirty_segs_mode;	/* GC state for reclaimed dirty segments */
+	unsigned int gc_reclaimed_segs[MAX_GC_MODE];	/* Reclaimed dirty segs for each mode */
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
index 6642246206bd..6e5d46b1dbf5 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -307,6 +307,14 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		return sysfs_emit(buf, "%u\n", sbi->compr_new_inode);
 #endif
 
+	if (!strcmp(a->attr.name, "gc_dirty_segs_mode"))
+		return sysfs_emit(buf, "%u\n", sbi->gc_dirty_segs_mode);
+
+	if (!strcmp(a->attr.name, "gc_dirty_segs")) {
+		return sysfs_emit(buf, "%u\n",
+			sbi->gc_reclaimed_segs[sbi->gc_dirty_segs_mode]);
+	}
+
 	ui = (unsigned int *)(ptr + a->offset);
 
 	return sprintf(buf, "%u\n", *ui);
@@ -515,6 +523,21 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_dirty_segs_mode")) {
+		if (t < MAX_GC_MODE)
+			sbi->gc_dirty_segs_mode = t;
+		else
+			return -EINVAL;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "gc_dirty_segs")) {
+		if (t != 0)
+			return -EINVAL;
+		sbi->gc_reclaimed_segs[sbi->gc_dirty_segs_mode] = 0;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -740,6 +763,9 @@ F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_count, max_candidate_cou
 F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_weight, age_weight);
 F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_threshold, age_threshold);
 
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_dirty_segs_mode, gc_dirty_segs_mode);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_dirty_segs, gc_reclaimed_segs);
+
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_urgent_sleep_time),
@@ -812,6 +838,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(atgc_candidate_count),
 	ATTR_LIST(atgc_age_weight),
 	ATTR_LIST(atgc_age_threshold),
+	ATTR_LIST(gc_dirty_segs_mode),
+	ATTR_LIST(gc_dirty_segs),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.32.0.93.g670b81a890-goog

