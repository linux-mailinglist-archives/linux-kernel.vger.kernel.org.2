Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33FA32AE6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360950AbhCBXIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 18:08:21 -0500
Received: from z11.mailgun.us ([104.130.96.11]:45015 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379526AbhCBWk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:40:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614724832; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=irFjp3OXBELaSYPn1K+FzLD4EX0IA2xL5B3czqzsB3g=; b=wZylMVtCX9IwjO/54vRQefEBlFqozHnfMN3ZPUmNJ/SRIrxg+o9D7x44i/aXIsFJQRZ+JD8F
 vwRXa0FdfuAWeb999WTY/2dg4p+Rdmm5sdlAcLx9SxPRontK4I9KVsA/2frLW5I2nR/2c43P
 wikevnqsEe5L3okE4bIPFZAMd8k=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 603ebebd2a53a9538a212ef6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Mar 2021 22:39:56
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2988AC433CA; Tue,  2 Mar 2021 22:39:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C60DC433C6;
        Tue,  2 Mar 2021 22:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C60DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, carl.yin@quectel.com,
        naveen.kumar@quectel.com, Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH] bus: mhi: core: Remove pre_init flag used for power purposes
Date:   Tue,  2 Mar 2021 14:39:49 -0800
Message-Id: <1614724789-36051-1-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some controllers can choose to skip preparation for power up.
In that case, device context is initialized based on the pre_init
flag not being set during mhi_prepare_for_power_up(). There is no
reason MHI host driver should maintain and provide controllers
with two separate paths for preparing MHI.

Going forward, all controllers will be required to call the
mhi_prepare_for_power_up() API followed by their choice of sync
or async power up. This allows MHI host driver to get rid of the
pre_init flag and sets up a common way for all controllers to use
MHI. This also helps controllers fail early on during preparation
phase in some failure cases.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/init.c |  3 ---
 drivers/bus/mhi/core/pm.c   | 20 --------------------
 include/linux/mhi.h         |  2 --
 3 files changed, 25 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 33323ad..59ff832 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -1080,8 +1080,6 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
 			mhi_rddm_prepare(mhi_cntrl, mhi_cntrl->rddm_image);
 	}
 
-	mhi_cntrl->pre_init = true;
-
 	mutex_unlock(&mhi_cntrl->pm_mutex);
 
 	return 0;
@@ -1112,7 +1110,6 @@ void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
 	}
 
 	mhi_deinit_dev_ctxt(mhi_cntrl);
-	mhi_cntrl->pre_init = false;
 }
 EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
 
diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index 681960c..fa5454d 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -1033,13 +1033,6 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 	mutex_lock(&mhi_cntrl->pm_mutex);
 	mhi_cntrl->pm_state = MHI_PM_DISABLE;
 
-	if (!mhi_cntrl->pre_init) {
-		/* Setup device context */
-		ret = mhi_init_dev_ctxt(mhi_cntrl);
-		if (ret)
-			goto error_dev_ctxt;
-	}
-
 	ret = mhi_init_irq_setup(mhi_cntrl);
 	if (ret)
 		goto error_setup_irq;
@@ -1121,10 +1114,6 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 	mhi_deinit_free_irq(mhi_cntrl);
 
 error_setup_irq:
-	if (!mhi_cntrl->pre_init)
-		mhi_deinit_dev_ctxt(mhi_cntrl);
-
-error_dev_ctxt:
 	mutex_unlock(&mhi_cntrl->pm_mutex);
 
 	return ret;
@@ -1166,15 +1155,6 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
 	flush_work(&mhi_cntrl->st_worker);
 
 	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
-
-	if (!mhi_cntrl->pre_init) {
-		/* Free all allocated resources */
-		if (mhi_cntrl->fbc_image) {
-			mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
-			mhi_cntrl->fbc_image = NULL;
-		}
-		mhi_deinit_dev_ctxt(mhi_cntrl);
-	}
 }
 EXPORT_SYMBOL_GPL(mhi_power_down);
 
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index d26acc8..a401271 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -352,7 +352,6 @@ struct mhi_controller_config {
  * @index: Index of the MHI controller instance
  * @bounce_buf: Use of bounce buffer
  * @fbc_download: MHI host needs to do complete image transfer (optional)
- * @pre_init: MHI host needs to do pre-initialization before power up
  * @wake_set: Device wakeup set flag
  * @irq_flags: irq flags passed to request_irq (optional)
  *
@@ -445,7 +444,6 @@ struct mhi_controller {
 	int index;
 	bool bounce_buf;
 	bool fbc_download;
-	bool pre_init;
 	bool wake_set;
 	unsigned long irq_flags;
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

