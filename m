Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808433DCFFD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 07:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhHBFOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 01:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhHBFOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 01:14:00 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679B1C061799
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 22:13:51 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id j3so3270813plx.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 22:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ONtT1ELTSrw1mSRZB+8b9XFyoudbRa+VTUtUIpf2uNg=;
        b=DzedpiaTx+uN3cE29+JskCKaCIYbE1PXe9tyG8r+7l0n8M4de4F9xpexiAb6tNwZjj
         x4tKcBUQbJeAssfNpHdjZxfyVe6SOxlJ607aZTWCtfxt92cGZArt+850Wj/ttvemnuZ0
         O9981KyVRdJF59tCQufl8p+5V+NkxrT9AyWjAjfs7Vwbl+uRn0xq0lkZb5/MeeaurhF8
         N1co0lPEPpipBiDysNF9PFAF61MG4bPGuxk7KfXcgMabocPLA9kNLeF//oJqatzg+flC
         Lh3krxDMlkptHdV3Gja1s1JOCGl5sx1u/ugnXliYmGXan5QXJLW+vLvJYWrg+AjPloST
         y1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONtT1ELTSrw1mSRZB+8b9XFyoudbRa+VTUtUIpf2uNg=;
        b=T011umTsgpOaDoxq5n0sPxiqDIWYLxXMH2j4ACcyr9ze+T5RHPxuimODCT4JrjaKdK
         kqqsXDTsaPkyGLizbOahLUp30nHvvGcxLeeT0JWcV8zIRnQHOoJXyFjRTtTXFJYIRkQA
         1191gU7Xe55A49tYeqKpsIjF8McrEGOzcCVG1MdL5hD/7SOExqiyUHOactN0KSnjKGxW
         bkgZukQwK9tqWeMG3RPiYhz58gd41fvQL7fks/WHOVImBsWbAI3O1pnKdOzpgjtLS2PP
         GRO2jGp7Fn9KRT1Kl2dghNnmSjH203yBW8X53cR0DtL7Evclety7bHit7+hvl+k3ORKK
         /e7Q==
X-Gm-Message-State: AOAM530Jx04BVjLVjALbZqQv+mn/URtFIFB0UNtIF/t82JO3APmXOPS6
        OyAi34+xnTTHyAHYKllX0QUJ
X-Google-Smtp-Source: ABdhPJwKErvI5mFrop1jPc+1+SnsSVUlDPuqfL7KiPaCaGMKoxGtuCpbLb3AIqLbFYlLV7aSBgnOQQ==
X-Received: by 2002:a65:6a01:: with SMTP id m1mr265063pgu.201.1627881230787;
        Sun, 01 Aug 2021 22:13:50 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6e99:242f:6391:b1b4:1ad8:fbdf])
        by smtp.gmail.com with ESMTPSA id x26sm9947000pfm.77.2021.08.01.22.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 22:13:50 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 08/10] bus: mhi: core: Add range checks for BHI and BHIe
Date:   Mon,  2 Aug 2021 10:42:53 +0530
Message-Id: <20210802051255.5771-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802051255.5771-1-manivannan.sadhasivam@linaro.org>
References: <20210802051255.5771-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

When obtaining the BHI or BHIe offsets during the power up
preparation phase, range checks are missing. These can help
controller drivers avoid accessing any address outside of the
MMIO region. Ensure that mhi_cntrl->reg_len is set before MHI
registration as it is a required field and range checks will
fail without it.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/1620330705-40192-7-git-send-email-bbhatt@codeaurora.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 1cc2f225d3d1..aeb1e3c2cdc4 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -885,7 +885,8 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->regs ||
 	    !mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
 	    !mhi_cntrl->status_cb || !mhi_cntrl->read_reg ||
-	    !mhi_cntrl->write_reg || !mhi_cntrl->nr_irqs || !mhi_cntrl->irq)
+	    !mhi_cntrl->write_reg || !mhi_cntrl->nr_irqs ||
+	    !mhi_cntrl->irq || !mhi_cntrl->reg_len)
 		return -EINVAL;
 
 	ret = parse_config(mhi_cntrl, config);
@@ -1077,6 +1078,13 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
 		dev_err(dev, "Error getting BHI offset\n");
 		goto error_reg_offset;
 	}
+
+	if (bhi_off >= mhi_cntrl->reg_len) {
+		dev_err(dev, "BHI offset: 0x%x is out of range: 0x%zx\n",
+			bhi_off, mhi_cntrl->reg_len);
+		ret = -EINVAL;
+		goto error_reg_offset;
+	}
 	mhi_cntrl->bhi = mhi_cntrl->regs + bhi_off;
 
 	if (mhi_cntrl->fbc_download || mhi_cntrl->rddm_size) {
@@ -1086,6 +1094,14 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
 			dev_err(dev, "Error getting BHIE offset\n");
 			goto error_reg_offset;
 		}
+
+		if (bhie_off >= mhi_cntrl->reg_len) {
+			dev_err(dev,
+				"BHIe offset: 0x%x is out of range: 0x%zx\n",
+				bhie_off, mhi_cntrl->reg_len);
+			ret = -EINVAL;
+			goto error_reg_offset;
+		}
 		mhi_cntrl->bhie = mhi_cntrl->regs + bhie_off;
 	}
 
-- 
2.25.1

