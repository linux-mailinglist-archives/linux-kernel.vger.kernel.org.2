Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4FF3B4366
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhFYMhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhFYMhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:37:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466D1C061283
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:34:46 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id d12so7460997pgd.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sNO7OvoezOyKwRQqQPCTAGHXfd3P08Ex5P2XMikHwWs=;
        b=e9MtdpfGHP20g++UmMZA7v/PwkSWPmVAUxQ1kUZC76KT2yBOov0+XQs6prxQxXR2JU
         J0RlewuEWXnVf2dy2yeBZdZvVDfV1jC9PF/xziGneT/XMx/iRdxdAEc1r96xrIy9l816
         0FUtsFEgPVbP2Xzfvlg3QF9t/1vkQYKDmQATgckKnyMnzIATgGlSYnDkUEwedWOUS8QP
         H/5EMgjlapCD/mrgLvIj1zFWhWCdZo4jYMFjww3c4QC8gjDF54bKWDxx9HVEicB4mjjK
         l/AVlaKHWQaTME7XvE/XUSA8Lu219Qp/aiGadiyAhw1kKyHSIgoqN+r9Cl7BBUEHpIWf
         QHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sNO7OvoezOyKwRQqQPCTAGHXfd3P08Ex5P2XMikHwWs=;
        b=uRvBm5wvyoI6XS16IA+ukECN1L7A3hCK3cmXNRjydn6DFq9xyEoIPKQVD/xhW+tQBw
         TbH6R1118dpuIGUmjvpnNnXXsHOUOUcdQR6UZN8n98M4lffCxky9elP+LRE1xdgF2Los
         twAwIet1XNtxTauMSBZhLLwz+6DkDR9kkJu5srBgS2V0dFQrj0xh6HOKDcbx1ebFZ8ka
         aGlfxtUqvXkudjxPYOYOhQyKP4Zv89ooa1oi/32NeLeDz4e2CIFC3Lpy7C6TeKWpYVbI
         oOnyOfVq4jocDLOy1XqGVE1/SNnriV96fJms4QcTEn8w6f2PKk97Y7V+0cB1+QIGfE2o
         Pg/A==
X-Gm-Message-State: AOAM531Drwi5mskYMaXxL2WO6e7xOYCdosfsk09l7ULjFXD6Zdx5aHC4
        T531DZcP9+B/f+AfGR3b4gD0
X-Google-Smtp-Source: ABdhPJxG2i6xZEvuWCUBDKfc9EaIHgiHlAUIJ5/atMQPCixk52P1mNDwspVOrh28gdRWtiQ4AGZbpw==
X-Received: by 2002:a63:7404:: with SMTP id p4mr9338107pgc.405.1624624485806;
        Fri, 25 Jun 2021 05:34:45 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:600b:2a0:ed5d:53e7:c64e:1bac])
        by smtp.gmail.com with ESMTPSA id y7sm6077780pfy.153.2021.06.25.05.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 05:34:45 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org,
        stable@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 06/10] bus: mhi: core: Set BHI and BHIe pointers to NULL in clean-up
Date:   Fri, 25 Jun 2021 18:03:51 +0530
Message-Id: <20210625123355.11578-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210625123355.11578-1-manivannan.sadhasivam@linaro.org>
References: <20210625123355.11578-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

Set the BHI and BHIe pointers to NULL as part of clean-up. This
makes sure that stale pointers are not accessed after powering
MHI down.

Cc: stable@vger.kernel.org
Suggested-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/1620330705-40192-3-git-send-email-bbhatt@codeaurora.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 11c7a3d3c9bf..1cc2f225d3d1 100644
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
2.25.1

