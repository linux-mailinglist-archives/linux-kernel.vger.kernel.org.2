Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A709A33AA9D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCOE5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:57:13 -0400
Received: from z11.mailgun.us ([104.130.96.11]:37721 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhCOE4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:56:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615784212; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=VPQLi2OI4TfV8yqp40xNH75AHkUMN4RCTBTNwk+/Bsg=; b=IhjUnmmtaVwIygN6QPKH0E78q7pznNrrggwvUgf/SXDmm8QMScehWysxTNcWE932Wxghe8TW
 CfKY/RQRGQPQM3ux2flGXq4H+dl4VvEY2MtG4p85DmPQbW4mT09G5eta7/jXG0jG8DZjShfa
 n2NEIUeceC+KtmkbSypB2xgw7eg=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 604ee905c32ceb3a914be5d3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Mar 2021 04:56:37
 GMT
Sender: stummala=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C0DDBC43464; Mon, 15 Mar 2021 04:56:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30629C433C6;
        Mon, 15 Mar 2021 04:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30629C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: fix the discard thread sleep timeout under high utilization
Date:   Mon, 15 Mar 2021 10:26:26 +0530
Message-Id: <1615784186-2693-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When f2fs is heavily utilized over 80%, the current discard policy
sets the max sleep timeout of discard thread as 50ms
(DEF_MIN_DISCARD_ISSUE_TIME). But this is set even when there are
no pending discard commands to be issued. This results into
unnecessary frequent and periodic wake ups of the discard thread.
This patch adds check for pending  discard commands in addition
to heavy utilization condition to prevent those wake ups.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/segment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index dced46c..df30220 100644
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
@@ -1129,7 +1131,8 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 		dpolicy->io_aware = true;
 		dpolicy->sync = false;
 		dpolicy->ordered = true;
-		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL) {
+		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL &&
+				atomic_read(&dcc->discard_cmd_cnt)) {
 			dpolicy->granularity = 1;
 			dpolicy->max_interval = DEF_MIN_DISCARD_ISSUE_TIME;
 		}
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

