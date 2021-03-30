Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F93F34DD88
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhC3B3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 21:29:01 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:24557 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhC3B2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:28:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617067724; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=lwOjkKACdLF8hYYKY8FC5AVAMMPXgCd9mWOI9JZF8hI=; b=FhJxsL6HmqBWehs0Di+4DKKQIsio7Kgpnh5/N//Qe9wJDHpF+edHnT5XZPGzO8x0Kz6pFVQ3
 p7N3AzRFCYWFSBXBu70erll8PjTvr8mv9hxzX/7RTzZjKeCrG/WM4l7h2q4xJD2XUasmOZe+
 lLA9Hw8ji0Y88beiaTAEGqcojmQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60627ec087ce1fbb56a95bbb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 30 Mar 2021 01:28:32
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C32A6C43463; Tue, 30 Mar 2021 01:28:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9DFC6C43461;
        Tue, 30 Mar 2021 01:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9DFC6C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org, abickett@codeaurora.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v1 2/7] bus: mhi: core: Wait for ready after an EDL firmware download
Date:   Mon, 29 Mar 2021 18:28:19 -0700
Message-Id: <1617067704-28850-3-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617067704-28850-1-git-send-email-bbhatt@codeaurora.org>
References: <1617067704-28850-1-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the firmware load handler returns after the EDL image
is downloaded. Wait for an MHI READY transition instead as the
specification expects so as to proceed with further bootup such
as device entering Flash Programmer execution environment.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/boot.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index 84c2117..0f0ae88 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -418,7 +418,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 
 	/* If device is in pass through, do reset to ready state transition */
 	if (mhi_cntrl->ee == MHI_EE_PTHRU)
-		goto fw_load_ee_pthru;
+		goto fw_load_ready_state;
 
 	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
 		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
@@ -460,10 +460,10 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 		goto error_fw_load;
 	}
 
-	/* Exit if EDL image was loaded */
+	/* Wait for ready since EDL image was loaded */
 	if (fw_name == mhi_cntrl->edl_image) {
 		release_firmware(firmware);
-		return;
+		goto fw_load_ready_state;
 	}
 
 	write_lock_irq(&mhi_cntrl->pm_lock);
@@ -488,7 +488,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
 
 	release_firmware(firmware);
 
-fw_load_ee_pthru:
+fw_load_ready_state:
 	/* Transitioning into MHI RESET->READY state */
 	ret = mhi_ready_state_transition(mhi_cntrl);
 	if (ret) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

