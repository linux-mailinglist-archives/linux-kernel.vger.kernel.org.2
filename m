Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FDD368D97
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240991AbhDWHGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:06:20 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:39090 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240784AbhDWHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:06:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619161542; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=b7v361fMDiWhekwai7q1Ri1EdCgLVn0dC9Wo9a3s/Ks=; b=D4trrDHSpSW5yeW8uVMAVzpvDXApix+EYY+2ppXhkDyWSaxa9XPGkIRhNf2PY00MUmUo9L9Y
 oMwTWUWDuX8RI9lLj4MlL2ckK/FCx3EDsSnIycTn66uzg8mi493Ezg1YMysu50D6zxun2ZCW
 Cc+YUIyPxTjo6VVdozebVPKjdRg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 608271bd03cfff34526c7240 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 23 Apr 2021 07:05:33
 GMT
Sender: rnayak=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EBF81C43460; Fri, 23 Apr 2021 07:05:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98760C433D3;
        Fri, 23 Apr 2021 07:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98760C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rbokka@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH] nvmem: qfprom: minor nit fixes, no functional change
Date:   Fri, 23 Apr 2021 12:35:02 +0530
Message-Id: <1619161503-8784-1-git-send-email-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a missed newline, and update a comment which is stale
after the merge of '5a1bea2a: nvmem: qfprom: Add support for fuse
blowing on sc7280'
No other functional change in this patch.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
Sending a follow-up patch for these nits since they came in after
the previous patch was already pulled in
https://lore.kernel.org/patchwork/patch/1401964/

 drivers/nvmem/qfprom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index d6d3f24..b7d2060 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -122,6 +122,7 @@ static const struct qfprom_soc_compatible_data sc7280_qfprom = {
 	.keepout = sc7280_qfprom_keepout,
 	.nkeepout = ARRAY_SIZE(sc7280_qfprom_keepout)
 };
+
 /**
  * qfprom_disable_fuse_blowing() - Undo enabling of fuse blowing.
  * @priv: Our driver data.
@@ -195,7 +196,7 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
 	}
 
 	/*
-	 * Hardware requires 1.8V min for fuse blowing; this may be
+	 * Hardware requires a min voltage for fuse blowing; this may be
 	 * a rail shared do don't specify a max--regulator constraints
 	 * will handle.
 	 */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

