Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F08E30A282
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhBAHIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:08:40 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:47044 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232283AbhBAHFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:05:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612163103; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=1BYDlohroQBmsn+HRU6Cg7Qz97+nC+gSHgZesry6ziY=; b=gXssG7bnMbav8ppsFlkxmUl9146NCCMf9+PjNE6mCyImwS6FCGwH0oL+kT1XUMlKON7lvBZd
 4G7VbYG3xHgSeZ3RbstvML6A4Meo9ScrGVLHF0iPKvOV9B59VaHbNwzSxXhOKkjfNYKTrddH
 3i3laXuyw+B5ygq28xmLSkCyfNQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6017a7f667765734883ee532 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Feb 2021 07:04:22
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28F81C43461; Mon,  1 Feb 2021 07:04:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vjitta-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8338C433C6;
        Mon,  1 Feb 2021 07:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8338C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     sfr@canb.auug.org.au, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, vjitta@codeaurora.org,
        vinmenon@codeaurora.org
Subject: [PATCH] lib: stackdepot: fix ignoring return value warning
Date:   Mon,  1 Feb 2021 12:34:08 +0530
Message-Id: <1612163048-28026-1-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayanand Jitta <vjitta@codeaurora.org>

fix the below ignoring return value warning for kstrtobool
in is_stack_depot_disabled function.

lib/stackdepot.c: In function 'is_stack_depot_disabled':
lib/stackdepot.c:154:2: warning: ignoring return value of 'kstrtobool'
declared with attribute 'warn_unused_result' [-Wunused-result]

Fixes: b9779abb09a8 ("lib: stackdepot: add support to disable stack depot")
Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
---
 lib/stackdepot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index cc21116..49f67a0 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -151,8 +151,10 @@ static struct stack_record **stack_table;
 
 static int __init is_stack_depot_disabled(char *str)
 {
-	kstrtobool(str, &stack_depot_disable);
-	if (stack_depot_disable) {
+	int ret;
+
+	ret = kstrtobool(str, &stack_depot_disable);
+	if (!ret && stack_depot_disable) {
 		pr_info("Stack Depot is disabled\n");
 		stack_table = NULL;
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
2.7.4
