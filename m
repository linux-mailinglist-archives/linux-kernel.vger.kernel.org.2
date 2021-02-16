Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A151831D23A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 22:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhBPVj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 16:39:29 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:25392 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhBPVj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 16:39:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613511539; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=394gxo912siOqaIpJl71yvRDB0TG0CrguHcjHcHjxjg=; b=uWhZMtn7p93KqDuiVSEhYFKxOHtFiHZY7hFPUFDmPqep/UMUnAOkQw/o8lSaRKVClpt42CRb
 yyIxYv+w207sO4cYx/FhAIG3heTWjBBAE1lNjyUy3f1KPh5ulHaz4QXRGGQdYlqyHgZw+Xpf
 qzrd/W1F09aqP+EbsnTkh/pLoYc=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 602c3b524129d8cb4a6f04ac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Feb 2021 21:38:26
 GMT
Sender: jhugo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3B93BC43462; Tue, 16 Feb 2021 21:38:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jhugo-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4A4EC433CA;
        Tue, 16 Feb 2021 21:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4A4EC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org, hemantk@codeaurora.org
Cc:     bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH] mhi_bus: core: Check state before processing power_down
Date:   Tue, 16 Feb 2021 14:38:16 -0700
Message-Id: <1613511496-22271-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot process a power_down if the power state is DISABLED.  There is
no valid mhi_ctxt in that case, so attepting to process the power_down
will likely result in a null pointer dereference.  If the power state is
DISABLED, there is nothing to do anyways, so just bail early.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/bus/mhi/core/pm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 56ba3ab..dc69074 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -1144,6 +1144,7 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 		mhi_deinit_dev_ctxt(mhi_cntrl);
 
 error_dev_ctxt:
+	mhi_cntrl->pm_state = MHI_PM_DISABLE;
 	mutex_unlock(&mhi_cntrl->pm_mutex);
 
 	return ret;
@@ -1155,6 +1156,12 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
 	enum mhi_pm_state cur_state, transition_state;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 
+	mutex_lock(&mhi_cntrl->pm_mutex);
+	cur_state = mhi_cntrl->pm_state;
+	mutex_unlock(&mhi_cntrl->pm_mutex);
+	if (cur_state == MHI_PM_DISABLE)
+		return; /* Already powered down */
+
 	/* If it's not a graceful shutdown, force MHI to linkdown state */
 	transition_state = (graceful) ? MHI_PM_SHUTDOWN_PROCESS :
 			   MHI_PM_LD_ERR_FATAL_DETECT;
-- 
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

