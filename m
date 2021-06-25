Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B953B436E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhFYMhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhFYMh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:37:29 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6F4C061767
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:35:08 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g21so6236732pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ONtT1ELTSrw1mSRZB+8b9XFyoudbRa+VTUtUIpf2uNg=;
        b=Hy65QO2GBVFDg5pZZhWRdmeGYjaXwBpDs00P4nEHc/QWsnaZFmT/6oo6rMhXd//RgT
         mi0hhr2nR6Z0tcXQnTQI5r0vcuHzO2qU9Sx4hZuLEyf7LoJDBrS5hr4L6Y8fjrbTJBjf
         WsN6I0sPuDvJVbUTh+jBWjA7srlHs1pKMtdaD8wOX/hYvgenA5+QEy5VpBKTfEjEumMD
         mpfmz9iYsDRqfY6214B7h96j/m0jAeec1y/6ZKojaWJSOYnx0SocAGEUq5ipbjbjNSKI
         D2eRyGC0ED2QWTfKfeMtw5edBPs/y/7x3L0uWgnOjEPiEGHFKYgemhOFGEDqqD3eMWlJ
         86nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONtT1ELTSrw1mSRZB+8b9XFyoudbRa+VTUtUIpf2uNg=;
        b=NI4iyTYSMFZN8WEg+ErAtgLKrSfREY/55OsR+dV5DB0pZ+BduZYnwNyGaCyXUVQfQL
         DXYrnARbse4lq2v1+3QYwcj2pQUuyZ4qnW6KnLGAkAiQvzN/UzHW73P3UFLwXDB7290T
         GLTCvB0lffb8f3c/ecwy9wClhr2KTNl34a0hN1I3cmsVWP0zVYisJmq94Sglk4qfgtHf
         FLH3KvG/mi+2k/lzouHaK7J5YLnb/sCY3W+5iFqYEOJuKosyk/AA5K46biHWgiPD4l7q
         wrPKZBXOJG3EKP9i3Jr/JbOZsvlDVPObiEA+iVbmgQdwMSD4OJ9XuIOKIhYQONnF1hiX
         dRmw==
X-Gm-Message-State: AOAM533ms03+kE+zbKG4qFj5sZmj8yq4Z1rzGd2KabXo30M6teczN3Tb
        vB+sH69Z3ZgRJjmCyLB8dfb9
X-Google-Smtp-Source: ABdhPJy6ctpRRTDQ9vIWKKGxmHWh8dOdLV2oV4farViio3Ya7w6oLgZ60+8rft7a6qwc49Q41ckWDA==
X-Received: by 2002:a05:6a00:1356:b029:301:a406:636d with SMTP id k22-20020a056a001356b0290301a406636dmr10252742pfu.39.1624624507776;
        Fri, 25 Jun 2021 05:35:07 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:600b:2a0:ed5d:53e7:c64e:1bac])
        by smtp.gmail.com with ESMTPSA id y7sm6077780pfy.153.2021.06.25.05.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 05:35:07 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 10/10] bus: mhi: core: Add range checks for BHI and BHIe
Date:   Fri, 25 Jun 2021 18:03:55 +0530
Message-Id: <20210625123355.11578-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210625123355.11578-1-manivannan.sadhasivam@linaro.org>
References: <20210625123355.11578-1-manivannan.sadhasivam@linaro.org>
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

