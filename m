Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45BA336E61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 09:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhCKI74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 03:59:56 -0500
Received: from z11.mailgun.us ([104.130.96.11]:28493 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231735AbhCKI7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:59:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615453171; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=jpoQuUcHs5i9VLRk71qu3ijoBzDv7GXlwEbrC3WwVlM=; b=q2QSac3MxAO/F+3iqNwYM/7A39Wh/C6Fe+Gd/AA2pzj3u49u9I7sQvZtB5nvhHCbOQtpSUlL
 HNWEgCXbd2Gb1ZHeWgZSfcJz0XlCZ+ofQE92GTpd3qAdLhdxETwguIvG+BMld5U8AkwnTCop
 56njpB8Yql/9lj+BcZ4qsuuwh3s=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6049dbf2f14e98d35dc207c0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Mar 2021 08:59:30
 GMT
Sender: stummala=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF62FC43461; Thu, 11 Mar 2021 08:59:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CCFAC433CA;
        Thu, 11 Mar 2021 08:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CCFAC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: allow to change discard policy based on cached discard cmds
Date:   Thu, 11 Mar 2021 14:29:08 +0530
Message-Id: <1615453148-30443-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the default DPOLICY_BG discard thread is ioaware, which prevents
the discard thread from issuing the discard commands. On low RAM setups,
it is observed that these discard commands in the cache are consuming
high memory. This patch aims to relax the memory pressure on the system
due to f2fs pending discard cmds by changing the policy to DPOLICY_FORCE
based on the nm_i->ram_thresh configured.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v2:
- by mistake the last else condition was modified, fix it now. 

 fs/f2fs/node.c    | 5 +++++
 fs/f2fs/node.h    | 1 +
 fs/f2fs/segment.c | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3a24423..03d99f9 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -44,6 +44,7 @@ int f2fs_check_nid_range(struct f2fs_sb_info *sbi, nid_t nid)
 bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct sysinfo val;
 	unsigned long avail_ram;
 	unsigned long mem_size = 0;
@@ -90,6 +91,10 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		/* it allows 20% / total_ram for inmemory pages */
 		mem_size = get_pages(sbi, F2FS_INMEM_PAGES);
 		res = mem_size < (val.totalram / 5);
+	} else if (type == DISCARD_CACHE) {
+		mem_size = (atomic_read(&dcc->discard_cmd_cnt) *
+				sizeof(struct discard_cmd)) >> PAGE_SHIFT;
+		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100));
 	} else {
 		if (!sbi->sb->s_bdi->wb.dirty_exceeded)
 			return true;
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index f84541b..7a45c0f 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -147,6 +147,7 @@ enum mem_type {
 	INO_ENTRIES,	/* indicates inode entries */
 	EXTENT_CACHE,	/* indicates extent cache */
 	INMEM_PAGES,	/* indicates inmemory pages */
+	DISCARD_CACHE,	/* indicates memory of cached discard cmds */
 	BASE_CHECK,	/* check kernel status */
 };
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index deca74c..13b3d728 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1773,7 +1773,8 @@ static int issue_discard_thread(void *data)
 			continue;
 		}
 
-		if (sbi->gc_mode == GC_URGENT_HIGH)
+		if (sbi->gc_mode == GC_URGENT_HIGH ||
+			!f2fs_available_free_memory(sbi, DISCARD_CACHE))
 			__init_discard_policy(sbi, &dpolicy, DPOLICY_FORCE, 1);
 
 		sb_start_intwrite(sbi->sb);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

