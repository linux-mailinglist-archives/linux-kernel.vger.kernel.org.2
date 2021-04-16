Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3043627F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245393AbhDPSsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:48:01 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23079 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245258AbhDPSr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:47:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618598851; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=N6ub7wtSp5eMgZGQ6htSpcYkY47epXuiTqKIqP/coGY=; b=SotBZttLpS5Ng3+PSqaRG4kmRr04cYL04RDjMS0agNWfb9fAVzIcUQ+W35C+55tE50nQVCIq
 iLqyvYTaaN4h9mXLjmpkj/ds3UdRS0HAMEiaxtnVE1QSbzf56mJKKverw61LilLwJ0vilONP
 Aa8unJ3fawhhbz9jBVSwECiXIeY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6079dbb6c39407c327e501c2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Apr 2021 18:47:18
 GMT
Sender: bbhatt=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2A038C43469; Fri, 16 Apr 2021 18:47:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 181C8C43461;
        Fri, 16 Apr 2021 18:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 181C8C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v1 2/6] bus: mhi: core: Set BHI and BHIe pointers to NULL in clean-up
Date:   Fri, 16 Apr 2021 11:47:01 -0700
Message-Id: <1618598825-18629-3-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618598825-18629-1-git-send-email-bbhatt@codeaurora.org>
References: <1618598825-18629-1-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the BHI and BHIe pointers to NULL as part of clean-up. This
makes sure that stale pointers are not accessed after powering
MHI down.

Suggested-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 11c7a3d..1cc2f22 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -1132,6 +1132,9 @@ void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
 		mhi_cntrl->rddm_image = NULL;
 	}
 
+	mhi_cntrl->bhi = NULL;
+	mhi_cntrl->bhie = NULL;
+
 	mhi_deinit_dev_ctxt(mhi_cntrl);
 }
 EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

