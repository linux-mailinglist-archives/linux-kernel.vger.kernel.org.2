Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A87734DD85
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhC3B24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:28:56 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:24557 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhC3B2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:28:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617067715; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=7RE9Ch4lBMFrnGhRUawawo6M/t35RqpFdbd5NoQ0tgo=; b=VyI5LsuMLdiJJ+5kNeRefZoF8jxmnJuPi8O3aoYdxEndnSF8y5zm+4n3US3mGu7x7roSmsmx
 IHcTv+J9yfwkjOPQ7Ct30/kV910p08JcYdUsOgaV9cg/oRz7jQXbqv1jsEGoFH7NGqQBXpHk
 O4DMk0A/fkeopkIp8z7l18ePWCI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60627ec2a2ab6642db192e6a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 30 Mar 2021 01:28:34
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B761AC43463; Tue, 30 Mar 2021 01:28:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F55EC433C6;
        Tue, 30 Mar 2021 01:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F55EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org, abickett@codeaurora.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v1 6/7] bus: mhi: core: Wait for MHI READY state in most scenarios
Date:   Mon, 29 Mar 2021 18:28:23 -0700
Message-Id: <1617067704-28850-7-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617067704-28850-1-git-send-email-bbhatt@codeaurora.org>
References: <1617067704-28850-1-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When moving from SYS_ERROR transition to a different execution
environment, MHI host relies on the BHI register read to spawn
the next image download or wait for READY -> M0 states. The
device can at times move the execution environment to mission
mode when a pass through is expected, which can result in a
stall. Initiate a wait for MHI READY and write M0 such that the
device can proceed with state change event updates for any new
execution environment being entered. This allows us to remove
conditionals in handling firmware load for PBL modes and keeps
the execution environment out of the picture as it can change at
any time.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/boot.c | 4 ++--
 drivers/bus/mhi/core/pm.c   | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index 0f0ae88..8100cf5 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -416,8 +416,8 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 		}
 	}
 
-	/* If device is in pass through, do reset to ready state transition */
-	if (mhi_cntrl->ee == MHI_EE_PTHRU)
+	/* wait for ready on pass through or any other execution environment */
+	if (mhi_cntrl->ee != MHI_EE_EDL && mhi_cntrl->ee != MHI_EE_PBL)
 		goto fw_load_ready_state;
 
 	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 7ac9dfe..b6920a5 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -763,8 +763,7 @@ void mhi_pm_st_worker(struct work_struct *work)
 			if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
 				mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
 			write_unlock_irq(&mhi_cntrl->pm_lock);
-			if (MHI_IN_PBL(mhi_cntrl->ee))
-				mhi_fw_load_handler(mhi_cntrl);
+			mhi_fw_load_handler(mhi_cntrl);
 			break;
 		case DEV_ST_TRANSITION_SBL:
 			write_lock_irq(&mhi_cntrl->pm_lock);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

