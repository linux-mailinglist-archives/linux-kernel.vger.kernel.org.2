Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A76B32C38B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357409AbhCDAHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:07:50 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:39843 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1389846AbhCCVsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 16:48:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614808057; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=oHL2QLuF0yTmY0Us4bq25wLVQqk2jf6gVgZs2Pe951s=; b=wlCEVhPAIcYwebmkIxkV/IigL/GCidYGpEmhShei5ZfYpZxFb5ooHUi+rHUlLnnsAEYriyIj
 VLNNh0Z1bZLBIsKFTN+Ka2JLNa5pCQ0NvOsc+BxFmqHyX9YELP8coqKnlOfiWFCiM0xaPh0j
 sRtK0R0D+WF3fUsCnWl/H6zd2+s=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 604003df7b648e24363cfac4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Mar 2021 21:47:11
 GMT
Sender: sidgup=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AED14C433C6; Wed,  3 Mar 2021 21:47:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from sidgup-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB3FBC433CA;
        Wed,  3 Mar 2021 21:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB3FBC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sidgup@codeaurora.org
From:   Siddharth Gupta <sidgup@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Raghavendra Rao Ananta <rananta@codeaurora.org>,
        Siddharth Gupta <sidgup@codeaurora.org>
Subject: [PATCH v2] remoteproc: sysfs: Use sysfs_emit instead of sprintf
Date:   Wed,  3 Mar 2021 13:47:02 -0800
Message-Id: <1614808022-26062-1-git-send-email-sidgup@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raghavendra Rao Ananta <rananta@codeaurora.org>

For security reasons sysfs_emit() is preferred over sprintf().
Hence, convert the remoteproc's sysfs show functions accordingly.

Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
---
 drivers/remoteproc/remoteproc_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 1dbef89..6840dad 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -15,7 +15,7 @@ static ssize_t recovery_show(struct device *dev,
 {
 	struct rproc *rproc = to_rproc(dev);
 
-	return sprintf(buf, "%s", rproc->recovery_disabled ? "disabled\n" : "enabled\n");
+	return sysfs_emit(buf, "%s", rproc->recovery_disabled ? "disabled\n" : "enabled\n");
 }
 
 /*
@@ -82,7 +82,7 @@ static ssize_t coredump_show(struct device *dev,
 {
 	struct rproc *rproc = to_rproc(dev);
 
-	return sprintf(buf, "%s\n", rproc_coredump_str[rproc->dump_conf]);
+	return sysfs_emit(buf, "%s\n", rproc_coredump_str[rproc->dump_conf]);
 }
 
 /*
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

