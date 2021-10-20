Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C23434747
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhJTIvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:51:43 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:25192 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhJTIvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:51:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634719768; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=hcAWFLkrr3vyex+n2PUyQV7o3dqbvwtfVb8aoLuhovg=; b=Dl9WSPex9jdD0vuTx+2uGD+blYmm9XBELHCFIMYkdOWn+Lb2ClEyZwZ5iMG+M4iGFlevlPg+
 pngRJtMODYhxPprriewxBNUvpYiZkd4h6Rna3o9ISu0Hn7DksStWu6wHDJ8j4X2uq/G6A0fR
 sPmlFmOTHmEekDBZY53YQx2qTMM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 616fd81859612e0100d6042b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Oct 2021 08:49:28
 GMT
Sender: mkshah=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B4C81C4360C; Wed, 20 Oct 2021 08:49:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mkshah-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9EE6EC43460;
        Wed, 20 Oct 2021 08:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9EE6EC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, rnayak@codeaurora.org, lsrao@codeaurora.org,
        stephan@gerhold.net, shawn.guo@linaro.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH] soc: qcom: qcom_stats: Fix client votes offset
Date:   Wed, 20 Oct 2021 14:19:13 +0530
Message-Id: <1634719753-26064-1-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Client votes starts at 0x20 offset. Correct the offset.

Reported-and-suggested-by: Shawn Guo <shawn.guo@linaro.org>
Fixes: 1d7724690344 ("soc: qcom: Add Sleep stats driver")
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/soc/qcom/qcom_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
index 817505b..131d24c 100644
--- a/drivers/soc/qcom/qcom_stats.c
+++ b/drivers/soc/qcom/qcom_stats.c
@@ -22,7 +22,7 @@
 #define LAST_ENTERED_AT_OFFSET	0x8
 #define LAST_EXITED_AT_OFFSET	0x10
 #define ACCUMULATED_OFFSET	0x18
-#define CLIENT_VOTES_OFFSET	0x1c
+#define CLIENT_VOTES_OFFSET	0x20
 
 struct subsystem_data {
 	const char *name;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

