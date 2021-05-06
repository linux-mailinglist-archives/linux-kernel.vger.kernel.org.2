Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF9C375BC4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbhEFTeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:34:23 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63499 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235197AbhEFTeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:34:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620329603; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=WfLNhJhOkG3h0UidyMRRyHaE+tXE9TU0reD21uN9rEw=; b=Rjkb0NcCLK+zj3UEHICYT9ITjmc12a38yL4o/7T8d9zzqV6tXvnWogGusCPrFllEMx/iiemL
 Rxpa4yw8O0fYeVvE0sVzZO/Gbi65vXvZD7cHJ3yfYIneqz6C/RruD+uRyoD7+T/eukPP+ViG
 joIO6mSXZhzIAcy5ssGp4oG2U6c=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6094447f79b6f9e57b0e0023 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 06 May 2021 19:33:19
 GMT
Sender: bbhatt=qti.qualcomm.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EE3EFC4160D; Thu,  6 May 2021 19:33:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3F46C43143;
        Thu,  6 May 2021 19:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3F46C43143
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=pass (p=none dis=none) header.from=qti.qualcomm.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=pass smtp.mailfrom=bbhatt@qti.qualcomm.com
From:   Bhaumik Bhatt <bbhatt@qti.qualcomm.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org, linux-wireless@vger.kernel.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v4 4/6] ath11k: set register access length for MHI driver
Date:   Thu,  6 May 2021 12:32:23 -0700
Message-Id: <1620329545-32328-5-git-send-email-bbhatt@qti.qualcomm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620329545-32328-1-git-send-email-bbhatt@qti.qualcomm.com>
References: <1620329545-32328-1-git-send-email-bbhatt@qti.qualcomm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

MHI driver requires register space length to add range checks and
prevent memory region accesses outside of that for MMIO space.
Set it before registering the MHI controller.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 09858e5..c0f013c 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -235,6 +235,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 	mhi_ctrl->cntrl_dev = ab->dev;
 	mhi_ctrl->fw_image = ab_pci->amss_path;
 	mhi_ctrl->regs = ab->mem;
+	mhi_ctrl->reg_len = ab->mem_len;
 
 	ret = ath11k_mhi_get_msi(ab_pci);
 	if (ret) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

