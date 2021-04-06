Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F36354F95
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbhDFJJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:09:53 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:64570 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbhDFJJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:09:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617700173; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=F4jdbffDeZDNKhypu4nbWbPE4bfUYUk0a5UryZXysDE=; b=Iwu+Ro1lRqaealaSfacsMl5UVB0nTjYpoqS0JVZfyChIxRRGycdsYzeV1hi2u7CskKqGmf5i
 oFbL83gDRkcB+6d9NKjvbcnbUOZ3m7X3V8+MoTfJIo4xYpORCi3Hjn73kMIp96rqOW5T06PB
 D6Y19wzlA02SEuGN3aocaPcLdtY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 606c254cc06dd10a2d3fbeb2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 06 Apr 2021 09:09:32
 GMT
Sender: stummala=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0D61EC433C6; Tue,  6 Apr 2021 09:09:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44B04C43463;
        Tue,  6 Apr 2021 09:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44B04C43463
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: fix the periodic wakeups of discard thread
Date:   Tue,  6 Apr 2021 14:39:16 +0530
Message-Id: <1617700156-19719-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20210316093406.GC8562@codeaurora.org>
References: <20210316093406.GC8562@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the unnecessary periodic wakeups of discard thread that happens under
below two conditions -

1. When f2fs is heavily utilized over 80%, the current discard policy
sets the max sleep timeout of discard thread as 50ms
(DEF_MIN_DISCARD_ISSUE_TIME). But this is set even when there are
no pending discard commands to be issued.

2. In the issue_discard_thread() path when there are no pending discard
commands, it fails to reset the wait_ms to max timeout value.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v2:
- Fix the second scenario mentioned above in commit text

 fs/f2fs/segment.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d7076796..59efec5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1112,6 +1112,8 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 				struct discard_policy *dpolicy,
 				int discard_type, unsigned int granularity)
 {
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+
 	/* common policy */
 	dpolicy->type = discard_type;
 	dpolicy->sync = true;
@@ -1131,7 +1133,9 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 		dpolicy->ordered = true;
 		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL) {
 			dpolicy->granularity = 1;
-			dpolicy->max_interval = DEF_MIN_DISCARD_ISSUE_TIME;
+			if (atomic_read(&dcc->discard_cmd_cnt))
+				dpolicy->max_interval =
+					DEF_MIN_DISCARD_ISSUE_TIME;
 		}
 	} else if (discard_type == DPOLICY_FORCE) {
 		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
@@ -1747,8 +1751,15 @@ static int issue_discard_thread(void *data)
 	set_freezable();
 
 	do {
-		__init_discard_policy(sbi, &dpolicy, DPOLICY_BG,
-					dcc->discard_granularity);
+		if (sbi->gc_mode == GC_URGENT_HIGH ||
+			!f2fs_available_free_memory(sbi, DISCARD_CACHE))
+			__init_discard_policy(sbi, &dpolicy, DPOLICY_FORCE, 1);
+		else
+			__init_discard_policy(sbi, &dpolicy, DPOLICY_BG,
+						dcc->discard_granularity);
+
+		if (!atomic_read(&dcc->discard_cmd_cnt))
+		       wait_ms = dpolicy.max_interval;
 
 		wait_event_interruptible_timeout(*q,
 				kthread_should_stop() || freezing(current) ||
@@ -1775,10 +1786,6 @@ static int issue_discard_thread(void *data)
 		if (!atomic_read(&dcc->discard_cmd_cnt))
 			continue;
 
-		if (sbi->gc_mode == GC_URGENT_HIGH ||
-			!f2fs_available_free_memory(sbi, DISCARD_CACHE))
-			__init_discard_policy(sbi, &dpolicy, DPOLICY_FORCE, 1);
-
 		sb_start_intwrite(sbi->sb);
 
 		issued = __issue_discard_cmd(sbi, &dpolicy);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

