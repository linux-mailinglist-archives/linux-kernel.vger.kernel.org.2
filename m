Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B732C28E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbhCDAAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:00:20 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:15379 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1387457AbhCCUCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:02:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614801735; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=K6mawvdpQdOxwjMF5rdf/APlmSOmG3tRL7olNo2nmNI=; b=Z3hAKYA7IdyDPOo5n7S8z27LGLTst0uw8dCxwGy5EjN58dYX76w7YCpiYCOGxhJbNaeA0YAY
 abrIJ7nvG/TUGblV16c1pXzRdil3Jsx5rCwQZgODoaTYvD2njmyTJqG/Fq4/zkQPPSdzun2k
 14KVmSU/G7GhvYLpCw/Mpr0h7yo=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 603feb2ac862e1b9fd4edf20 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Mar 2021 20:01:46
 GMT
Sender: sidgup=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25DACC43462; Wed,  3 Mar 2021 20:01:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from sidgup-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1DECFC43461;
        Wed,  3 Mar 2021 20:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DECFC43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sidgup@codeaurora.org
From:   Siddharth Gupta <sidgup@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Raghavendra Rao Ananta <rananta@codeaurora.org>,
        Siddharth Gupta <sidgup@codeaurora.org>
Subject: [PATCH] remoteproc: sysfs: Use scnprintf instead of sprintf
Date:   Wed,  3 Mar 2021 12:01:38 -0800
Message-Id: <1614801698-25987-1-git-send-email-sidgup@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raghavendra Rao Ananta <rananta@codeaurora.org>

For security reasons scnprintf() is preferred over sprintf().
Hence, convert the remoteproc's sysfs show functions accordingly.

Signed-off-by: Raghavendra Rao Ananta <rananta@codeaurora.org>
Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
---
 drivers/remoteproc/remoteproc_sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 1dbef89..853f569 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -15,7 +15,8 @@ static ssize_t recovery_show(struct device *dev,
 {
 	struct rproc *rproc = to_rproc(dev);
 
-	return sprintf(buf, "%s", rproc->recovery_disabled ? "disabled\n" : "enabled\n");
+	return scnprintf(buf, PAGE_SIZE, "%s",
+			 rproc->recovery_disabled ? "disabled\n" : "enabled\n");
 }
 
 /*
@@ -82,7 +83,7 @@ static ssize_t coredump_show(struct device *dev,
 {
 	struct rproc *rproc = to_rproc(dev);
 
-	return sprintf(buf, "%s\n", rproc_coredump_str[rproc->dump_conf]);
+	return scnprintf(buf, PAGE_SIZE, "%s\n", rproc_coredump_str[rproc->dump_conf]);
 }
 
 /*
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

