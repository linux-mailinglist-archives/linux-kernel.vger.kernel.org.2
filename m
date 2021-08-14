Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAF03EC44F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 19:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbhHNR7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 13:59:16 -0400
Received: from mail-m17636.qiye.163.com ([59.111.176.36]:23382 "EHLO
        mail-m17636.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhHNR7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 13:59:14 -0400
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
        by mail-m17636.qiye.163.com (Hmail) with ESMTPA id A7591C400B0;
        Sun, 15 Aug 2021 01:58:42 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 1/2] f2fs: add sysfs nodes to get discard information
Date:   Sun, 15 Aug 2021 01:58:39 +0800
Message-Id: <20210814175840.115938-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRlKGBlWTklCQxkdHUIYSk
        JCVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ky46HBw4LT9ITB8QKzYZDw4R
        FS4aFClVSlVKTUlDQk1IQklISUlMVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
        VUpLT1VKQ0NVSk1OWVdZCAFZQU9CTk43Bg++
X-HM-Tid: 0a7b45d0e38fd996kuwsa7591c400b0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've added new sysfs nodes to show discard stat since mount, which
will help us analyze whether the performance problem is related to
discard.

issued_discard  - Shows the number of issued discard
queued_discard  - Shows the number of cached discard cmd count
discard_cmd_cnt - Shows the number of cached discard cmd count
undiscard_blks  - Shows the number of undiscard blocks

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 20 +++++++++++
 fs/f2fs/sysfs.c                         | 44 +++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index ef4b9218ae1e..32df6d16d74f 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -493,3 +493,23 @@ Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:	When ATGC is on, it controls age threshold to bypass GCing young
 		candidates whose age is not beyond the threshold, by default it was
 		initialized as 604800 seconds (equals to 7 days).
+
+What:		/sys/fs/f2fs/<disk>/issued_discard
+Date:		August 2021
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	Shows the number of issued discard.
+
+What:		/sys/fs/f2fs/<disk>/queued_discard
+Date:		August 2021
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	Shows the number of queued discard.
+
+What:		/sys/fs/f2fs/<disk>/discard_cmd_cnt
+Date:		August 2021
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	Shows the number of cached discard cmd count.
+
+What:		/sys/fs/f2fs/<disk>/undiscard_blks
+Date:		August 2021
+Contact:	"Yangtao Li" <frank.li@vivo.com>
+Description:	Shows the number of undiscard blocks.
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 6642246206bd..b7d6c1adc7f8 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -248,6 +248,42 @@ static ssize_t main_blkaddr_show(struct f2fs_attr *a,
 			(unsigned long long)MAIN_BLKADDR(sbi));
 }
 
+static ssize_t issued_discard_show(struct f2fs_attr *a,
+				struct f2fs_sb_info *sbi, char *buf)
+{
+	struct discard_cmd_control *dcc_info = SM_I(sbi)->dcc_info;
+
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+			(unsigned long long)atomic_read(&dcc_info->issued_discard));
+}
+
+static ssize_t queued_discard_show(struct f2fs_attr *a,
+				struct f2fs_sb_info *sbi, char *buf)
+{
+	struct discard_cmd_control *dcc_info = SM_I(sbi)->dcc_info;
+
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+			(unsigned long long)atomic_read(&dcc_info->queued_discard));
+}
+
+static ssize_t discard_cmd_cnt_show(struct f2fs_attr *a,
+				struct f2fs_sb_info *sbi, char *buf)
+{
+	struct discard_cmd_control *dcc_info = SM_I(sbi)->dcc_info;
+
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+			(unsigned long long)atomic_read(&dcc_info->discard_cmd_cnt));
+}
+
+static ssize_t undiscard_blks_show(struct f2fs_attr *a,
+				struct f2fs_sb_info *sbi, char *buf)
+{
+	struct discard_cmd_control *dcc_info = SM_I(sbi)->dcc_info;
+
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+			(unsigned long long)dcc_info->undiscard_blks);
+}
+
 static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 			struct f2fs_sb_info *sbi, char *buf)
 {
@@ -690,6 +726,10 @@ F2FS_GENERAL_RO_ATTR(unusable);
 F2FS_GENERAL_RO_ATTR(encoding);
 F2FS_GENERAL_RO_ATTR(mounted_time_sec);
 F2FS_GENERAL_RO_ATTR(main_blkaddr);
+F2FS_GENERAL_RO_ATTR(issued_discard);
+F2FS_GENERAL_RO_ATTR(queued_discard);
+F2FS_GENERAL_RO_ATTR(discard_cmd_cnt);
+F2FS_GENERAL_RO_ATTR(undiscard_blks);
 #ifdef CONFIG_F2FS_STAT_FS
 F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_foreground_calls, cp_count);
 F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_background_calls, bg_cp_count);
@@ -750,6 +790,10 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_urgent),
 	ATTR_LIST(reclaim_segments),
 	ATTR_LIST(main_blkaddr),
+	ATTR_LIST(issued_discard),
+	ATTR_LIST(queued_discard),
+	ATTR_LIST(discard_cmd_cnt),
+	ATTR_LIST(undiscard_blks),
 	ATTR_LIST(max_small_discards),
 	ATTR_LIST(discard_granularity),
 	ATTR_LIST(batched_trim_sections),
-- 
2.32.0

