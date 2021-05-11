Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19C137A471
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhEKKTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:19:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2629 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhEKKS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:18:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FfYhp4YNSzlcbD;
        Tue, 11 May 2021 18:15:38 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 18:17:43 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: atgc: export entries for better tunability via sysfs
Date:   Tue, 11 May 2021 18:17:35 +0800
Message-ID: <20210511101735.15573-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210511101735.15573-1-yuchao0@huawei.com>
References: <20210511101735.15573-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch export below sysfs entries for better ATGC tunability.

/sys/fs/f2fs/<disk>/atgc_candidate_ratio
/sys/fs/f2fs/<disk>/atgc_candidate_count
/sys/fs/f2fs/<disk>/atgc_age_weight
/sys/fs/f2fs/<disk>/atgc_age_threshold

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 28 +++++++++++++++++++++++++
 fs/f2fs/sysfs.c                         | 13 ++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 4849b8e84e42..5088281e312e 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -438,3 +438,31 @@ Description:	Show the count of inode newly enabled for compression since mount.
 		Note that when the compression is disabled for the files, this count
 		doesn't decrease. If you write "0" here, you can initialize
 		compr_new_inode to "0".
+
+What:		/sys/fs/f2fs/<disk>/atgc_candidate_ratio
+Date:		May 2021
+Contact:	"Chao Yu" <yuchao0@huawei.com>
+Description:	When ATGC is on, it controls candidate ratio in order to limit total
+		number of potential victim in all candidates, the value should be in
+		range of [0, 100], by default it was initialized as 20(%).
+
+What:		/sys/fs/f2fs/<disk>/atgc_candidate_count
+Date:		May 2021
+Contact:	"Chao Yu" <yuchao0@huawei.com>
+Description:	When ATGC is on, it controls candidate count in order to limit total
+		number of potential victim in all candidates, by default it was
+		initialized as 10 (sections).
+
+What:		/sys/fs/f2fs/<disk>/atgc_age_weight
+Date:		May 2021
+Contact:	"Chao Yu" <yuchao0@huawei.com>
+Description:	When ATGC is on, it controls age weight to balance weight proportion
+		in between aging and valid blocks, the value should be in range of
+		[0, 100], by default it was initialized as 60(%).
+
+What:		/sys/fs/f2fs/<disk>/atgc_age_threshold
+Date:		May 2021
+Contact:	"Chao Yu" <yuchao0@huawei.com>
+Description:	When ATGC is on, it controls age threshold to bypass GCing young
+		candidates whose age is not beyond the threshold, by default it was
+		initialized as 604800 seconds (equals to 7 days).
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 39b522ec73e7..1efd2f7b8770 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -37,6 +37,7 @@ enum {
 #endif
 	RESERVED_BLOCKS,	/* struct f2fs_sb_info */
 	CPRC_INFO,	/* struct ckpt_req_control */
+	ATGC_INFO,	/* struct atgc_management */
 };
 
 struct f2fs_attr {
@@ -75,6 +76,8 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 #endif
 	else if (struct_type == CPRC_INFO)
 		return (unsigned char *)&sbi->cprc_info;
+	else if (struct_type == ATGC_INFO)
+		return (unsigned char *)&sbi->am;
 	return NULL;
 }
 
@@ -710,6 +713,11 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_written_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_saved_block, compr_saved_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_new_inode, compr_new_inode);
 #endif
+/* For ATGC */
+F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_ratio, candidate_ratio);
+F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_count, max_candidate_count);
+F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_weight, age_weight);
+F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_threshold, age_threshold);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -778,6 +786,11 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(compr_saved_block),
 	ATTR_LIST(compr_new_inode),
 #endif
+	/* For ATGC */
+	ATTR_LIST(atgc_candidate_ratio),
+	ATTR_LIST(atgc_candidate_count),
+	ATTR_LIST(atgc_age_weight),
+	ATTR_LIST(atgc_age_threshold),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs);
-- 
2.29.2

