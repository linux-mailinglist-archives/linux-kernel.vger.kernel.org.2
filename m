Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD773E898D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 06:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhHKEq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 00:46:29 -0400
Received: from mail-m17636.qiye.163.com ([59.111.176.36]:37352 "EHLO
        mail-m17636.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbhHKEq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 00:46:26 -0400
Received: from comdg01144022.vivo.xyz (unknown [218.104.188.165])
        by mail-m17636.qiye.163.com (Hmail) with ESMTPA id 4A83BC40106;
        Wed, 11 Aug 2021 12:45:59 +0800 (CST)
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] f2fs: improve sbi status info in debugfs/f2fs/status
Date:   Wed, 11 Aug 2021 12:45:57 +0800
Message-Id: <20210811044557.23951-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUNNS0hWSx4ZHhlNQx5MGU
        hIVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTo6SRw5Lz9COSMVPjkiMU84
        Ig9PCklVSlVKTUlDTU5MSk5CQ05CVTMWGhIXVR0JGhUQVRcSOw0SDRRVGBQWRVlXWRILWUFZSUpD
        VUpLT1VKQ0NVSk1OWVdZCAFZQUlCSkw3Bg++
X-HM-Tid: 0a7b33880d17d996kuws4a83bc40106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use numbers but strings to improve readability when flag is set.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-starting to print sb related status in a new line
 fs/f2fs/debug.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 473ad04d1891..d8c09346545d 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -323,22 +323,43 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 #endif
 }
 
+static char *s_flag[] = {
+	[SBI_IS_DIRTY]		= " fs_dirty",
+	[SBI_IS_CLOSE]		= " closing",
+	[SBI_NEED_FSCK]		= " need_fsck",
+	[SBI_POR_DOING]		= " recovering",
+	[SBI_NEED_SB_WRITE]	= " sb_dirty",
+	[SBI_NEED_CP]		= " need_cp",
+	[SBI_IS_SHUTDOWN]	= " shutdown",
+	[SBI_IS_RECOVERED]	= " recovered",
+	[SBI_CP_DISABLED]	= " cp_disabled",
+	[SBI_CP_DISABLED_QUICK]	= " cp_disabled_quick",
+	[SBI_QUOTA_NEED_FLUSH]	= " quota_need_flush",
+	[SBI_QUOTA_SKIP_FLUSH]	= " quota_skip_flush",
+	[SBI_QUOTA_NEED_REPAIR]	= " quota_need_repair",
+	[SBI_IS_RESIZEFS]	= " resizefs",
+};
+
 static int stat_show(struct seq_file *s, void *v)
 {
 	struct f2fs_stat_info *si;
-	int i = 0;
-	int j;
+	int i = 0, j = 0;
 
 	mutex_lock(&f2fs_stat_mutex);
 	list_for_each_entry(si, &f2fs_stat_list, stat_list) {
 		update_general_status(si->sbi);
 
-		seq_printf(s, "\n=====[ partition info(%pg). #%d, %s, CP: %s (sbi: 0x%lx)]=====\n",
+		seq_printf(s, "\n=====[ partition info(%pg). #%d, %s, CP: %s]=====\n",
 			si->sbi->sb->s_bdev, i++,
 			f2fs_readonly(si->sbi->sb) ? "RO": "RW",
 			is_set_ckpt_flags(si->sbi, CP_DISABLED_FLAG) ?
-			"Disabled": (f2fs_cp_error(si->sbi) ? "Error": "Good"),
-			si->sbi->s_flag);
+			"Disabled" : (f2fs_cp_error(si->sbi) ? "Error" : "Good"));
+		if (si->sbi->s_flag) {
+			seq_puts(s, "[SBI:");
+			for_each_set_bit(j, &si->sbi->s_flag, 32)
+				seq_puts(s, s_flag[j]);
+			seq_puts(s, "]\n");
+		}
 		seq_printf(s, "[SB: 1] [CP: 2] [SIT: %d] [NAT: %d] ",
 			   si->sit_area_segs, si->nat_area_segs);
 		seq_printf(s, "[SSA: %d] [MAIN: %d",
-- 
2.32.0

