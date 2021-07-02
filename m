Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8613D3BA538
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 23:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhGBVr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 17:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGBVr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 17:47:59 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E95AC061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 14:45:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id in17-20020a17090b4391b0290170ba0ec7fcso9799821pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 14:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uVHj1jU9GFC6OPD/uRvI5jmyC+48qLeGOTCGFoZzT0w=;
        b=fMshkRIOTpaTjLxL+LchLjk6Lnxp1cmjms30Hzvbv793YH1e2+WIQLL8f7tZ5kk19s
         mBTgcZMpMEd8nYHW1v7Zfsj9jWG7sNI4bbELilTVrZZrQEefSNNQpnXG3Gq6KYlLRAHG
         G8eGAW5sSDBccQEn1h665O4WcfDMyWqgEFZHAJ0aqI9CMg0YvAZj/SDtbFyqXX5lwHtl
         i5R1lssfoJQzGrMsicGIZeMJ6Bj9EthxyjzRrGgzheshsZJ9y/8Rx/aDE6up2QXrtd8I
         IqXxTbWyYJKmBAkqm9L0b/It0Lqjl0MGdOXArxihEapy7Lll9rgHpX+IBeoXL74z5IOr
         4OVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uVHj1jU9GFC6OPD/uRvI5jmyC+48qLeGOTCGFoZzT0w=;
        b=g37mMvwY8x8QIk+i/UKSud2HKrwod4hXJE++kn7sXrVzXzAiphAfKZvs8TS6HbUEuG
         OKYtpnBcRflg3+ne5tvlq/H1ma2ZBnX/FT7b2BBstkgfsf0Rfk/yxefduEGlz63XbBw8
         6jhOv+NKzJsvfMqedwWaYd0Y5lX1lSa3x2jq6nUvhdtJhTCtoNZqHbKTIAhGoKWFKeO9
         Y3JQ15tYB/aSKna65wB9kvJF+Fr/VP8fFOaOUcVhd9E5jHmSa80wTsIPE21B5IqWJrIz
         Ee8ScAkASOzj9pUKYg9UJ5UeWL3tSPoOfDVE8opmIk0XldMDxhNa4ZNVlmtsBiXz3uWc
         2U9Q==
X-Gm-Message-State: AOAM530DqGM++xjcIv2TfKVWEta1YEK4n1rHL22vmj7OY4f/OhQ8/6qO
        r4VwT70K7vQ8eO5RlOpIHyTojFUsmks=
X-Google-Smtp-Source: ABdhPJzBKoMgnj2DUOTp28ranUS89rDOllstCbX8zG9HS6Ns+UO6q9cLuNq7pj9mqu/Yb4jTucz+IQ==
X-Received: by 2002:a17:902:c3c6:b029:128:f061:889d with SMTP id j6-20020a170902c3c6b0290128f061889dmr1441481plj.50.1625262325685;
        Fri, 02 Jul 2021 14:45:25 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:26e9:b6e7:e122:4649])
        by smtp.gmail.com with ESMTPSA id q24sm5121234pgk.32.2021.07.02.14.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 14:45:25 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: add sysfs nodes to get GC info for each GC urgent mode
Date:   Fri,  2 Jul 2021 14:44:58 -0700
Message-Id: <20210702214458.3876398-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added gc_urgent_dirty_segs and gc_urgent_dirty_segs_mode sysfs nodes.
1) "gc_urgent_dirty_segs" shows how many dirty segments have been
reclaimed by GC during a specific GC urgent mode.
2) "gc_urgent_dirty_segs_mode" is used to control for which gc urgent
mode the "gc_urgent_dirty_segs" node shows.
(1: GC urgent high, 2: GC urgent low)

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 14 ++++++++
 fs/f2fs/f2fs.h                          |  5 +++
 fs/f2fs/gc.c                            |  4 +++
 fs/f2fs/sysfs.c                         | 46 +++++++++++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 95155e4ec7fe..9851c3f2efad 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -493,3 +493,17 @@ Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:	When ATGC is on, it controls age threshold to bypass GCing young
 		candidates whose age is not beyond the threshold, by default it was
 		initialized as 604800 seconds (equals to 7 days).
+
+What:		/sys/fs/f2fs/<disk>/gc_urgent_dirty_segs
+Date:		July 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Show how many dirty segments have been reclaimed by GC during
+		a specific GC urgent mode (1: GC urgent high, 2: GC urgent low)
+		You can re-initialize this value to "0".
+
+What:		/sys/fs/f2fs/<disk>/gc_urgent_dirty_segs_mode
+Date:		July 2021
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	You can control for which gc urgent mode the "gc_urgent_dirty_segs"
+		node shows (1: GC urgent high, 2: GC urgent low). You can set the
+		value to "0" when you want not to select one of them.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 16ce1ade9fa6..d838c373f188 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1728,6 +1728,11 @@ struct f2fs_sb_info {
 	struct kmem_cache *inline_xattr_slab;	/* inline xattr entry */
 	unsigned int inline_xattr_slab_size;	/* default inline xattr slab size */
 
+	/* For reclaimed dirty segs statistics per each GC urgent mode */
+	unsigned int gc_dirty_segs_mode;	/* GC state for reclaimed dirty segments */
+	u64 gc_urgent_high_dirty_segs;		/* Reclaimed dirty segs in GC_URGENT_HIGH */
+	u64 gc_urgent_low_dirty_segs;		/* Reclaimed dirty segs in GC_URGENT_LOW */
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	struct kmem_cache *page_array_slab;	/* page array entry */
 	unsigned int page_array_slab_size;	/* default page array slab size */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index da5947b30142..233e2a500379 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1648,6 +1648,10 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 							force_migrate);
 
 		stat_inc_seg_count(sbi, type, gc_type);
+		if (sbi->gc_dirty_segs_mode == GC_URGENT_HIGH)
+			sbi->gc_urgent_high_dirty_segs++;
+		else if (sbi->gc_dirty_segs_mode == GC_URGENT_LOW)
+			sbi->gc_urgent_low_dirty_segs++;
 		migrated++;
 
 freed:
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 6642246206bd..9ede97fe12cf 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -307,6 +307,25 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		return sysfs_emit(buf, "%u\n", sbi->compr_new_inode);
 #endif
 
+	if (!strcmp(a->attr.name, "gc_urgent_dirty_segs_mode")) {
+		if (sbi->gc_dirty_segs_mode == GC_NORMAL)
+			return sysfs_emit(buf, "0\n");
+		else if (sbi->gc_dirty_segs_mode == GC_URGENT_HIGH)
+			return sysfs_emit(buf, "1\n");
+		else if (sbi->gc_dirty_segs_mode == GC_URGENT_LOW)
+			return sysfs_emit(buf, "2\n");
+	}
+
+	if (!strcmp(a->attr.name, "gc_urgent_dirty_segs")) {
+		if (sbi->gc_dirty_segs_mode == GC_URGENT_HIGH)
+			return sysfs_emit(buf, "%llu\n",
+					sbi->gc_urgent_high_dirty_segs);
+		if (sbi->gc_dirty_segs_mode == GC_URGENT_LOW)
+			return sysfs_emit(buf, "%llu\n",
+					sbi->gc_urgent_low_dirty_segs);
+		return sysfs_emit(buf, "0\n");
+	}
+
 	ui = (unsigned int *)(ptr + a->offset);
 
 	return sprintf(buf, "%u\n", *ui);
@@ -515,6 +534,28 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_urgent_dirty_segs_mode")) {
+		if (t == 0)
+			sbi->gc_dirty_segs_mode = GC_NORMAL;
+		else if (t == 1)
+			sbi->gc_dirty_segs_mode = GC_URGENT_HIGH;
+		else if (t == 2)
+			sbi->gc_dirty_segs_mode = GC_URGENT_LOW;
+		else
+			return -EINVAL;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "gc_urgent_dirty_segs")) {
+		if (t != 0 || sbi->gc_dirty_segs_mode == GC_NORMAL)
+			return -EINVAL;
+		if (sbi->gc_dirty_segs_mode == GC_URGENT_HIGH)
+			sbi->gc_urgent_high_dirty_segs = 0;
+		else if (sbi->gc_dirty_segs_mode == GC_URGENT_LOW)
+			sbi->gc_urgent_low_dirty_segs = 0;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -740,6 +781,9 @@ F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_count, max_candidate_cou
 F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_weight, age_weight);
 F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_threshold, age_threshold);
 
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_urgent_dirty_segs_mode, gc_dirty_segs_mode);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_urgent_dirty_segs, gc_urgent_high_dirty_segs);
+
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_urgent_sleep_time),
@@ -812,6 +856,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(atgc_candidate_count),
 	ATTR_LIST(atgc_age_weight),
 	ATTR_LIST(atgc_age_threshold),
+	ATTR_LIST(gc_urgent_dirty_segs_mode),
+	ATTR_LIST(gc_urgent_dirty_segs),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.32.0.93.g670b81a890-goog

