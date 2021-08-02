Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9FF3DCFF6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 07:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhHBFNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 01:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhHBFNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 01:13:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3901C061796
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 22:13:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so29792596pja.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 22:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vCP14x51ZT3xHTsGRwNOFfupBHNf+HcNjz+uJv37tc=;
        b=x/mIjNE+24kV1H5SQ6ix8OLO7gv+5Tz0esOdFtziEesVaCOm1kXKAxxCQdJ2+bR4Vi
         U+2T4GTCWg/BOhvjPFSktswOBLHuFvwGmCiZa2HEAd91mM3g50TkcN9+8DLQb/nrqAiy
         W8uXSZLCoFjayPTMOf/HW8jVNOw7LMI2XK92t6Le0Phf34ruyQ6sqVRk8h7TRWoHqpap
         NBfnd9vEXtdO8x5c2lohK+IESBH3mW623HSV460BCNkdlRTR8bPiJrF71NrVeGAyKDZy
         X0I07I71EJn/rtt8SZrgqGgbN4Sn10VSPLUHcgDsx3Zp7/GUuA5AZL4Qu3rmsA0xhbzg
         q1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vCP14x51ZT3xHTsGRwNOFfupBHNf+HcNjz+uJv37tc=;
        b=YFSejdDZzZAGaVw9WoWvbzLBASWAs5VVoW9FQMQQLqetF2j62TzFlUImWN01oNKM5f
         3YligOVPYiRjgs1//UseGzaCCN6fInlRZReJkIHi9L5t0pxrcw/McM0SbGAiRKhE68Ng
         wUALUzUZm8aLtNKNUe86W0HSI0ITP003UZbKf/c4T9ZwrvI7DD3LynLe9NXqd1FXXLfE
         QdbVDlT8iv3jM0OUAwGbw0am2t+PX3YuW9RkvKdeP2LLQ4tx8Oti/1PT69h3YLgtD96B
         RQLQrTRhbmdvoe9fc0YlDMZqUnO8so1QBUM+VyvLNfKPHf9OwOdkF5BwGKGLMJQsLtDd
         KJcA==
X-Gm-Message-State: AOAM530X4NNMdZYSVIQv0vOghmSugaGQlSIGzIWAV/h7hvOJwJCp+tr4
        TZ081KDmUIVTPcPfvG8GuDVf
X-Google-Smtp-Source: ABdhPJwIgL7DjD+lO/IcKy9pCLYAJQ+Q+hqyRM472MIKtxQ+ZBSnu8eu4I02mbxULY3n+xLcRFH7AA==
X-Received: by 2002:a17:90b:514:: with SMTP id r20mr15221889pjz.80.1627881217301;
        Sun, 01 Aug 2021 22:13:37 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6e99:242f:6391:b1b4:1ad8:fbdf])
        by smtp.gmail.com with ESMTPSA id x26sm9947000pfm.77.2021.08.01.22.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 22:13:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 05/10] bus: mhi: Add MMIO region length to controller structure
Date:   Mon,  2 Aug 2021 10:42:50 +0530
Message-Id: <20210802051255.5771-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802051255.5771-1-manivannan.sadhasivam@linaro.org>
References: <20210802051255.5771-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

Make controller driver specify the MMIO register region length
for range checking of BHI or BHIe space. This can help validate
that offsets are in acceptable memory region or not and avoid any
boot-up issues due to BHI or BHIe memory accesses.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/1620330705-40192-4-git-send-email-bbhatt@codeaurora.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 include/linux/mhi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 5e08468854db..b8ca6943f0b7 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -303,6 +303,7 @@ struct mhi_controller_config {
  * @rddm_size: RAM dump size that host should allocate for debugging purpose
  * @sbl_size: SBL image size downloaded through BHIe (optional)
  * @seg_len: BHIe vector size (optional)
+ * @reg_len: Length of the MHI MMIO region (required)
  * @fbc_image: Points to firmware image buffer
  * @rddm_image: Points to RAM dump buffer
  * @mhi_chan: Points to the channel configuration table
@@ -386,6 +387,7 @@ struct mhi_controller {
 	size_t rddm_size;
 	size_t sbl_size;
 	size_t seg_len;
+	size_t reg_len;
 	struct image_info *fbc_image;
 	struct image_info *rddm_image;
 	struct mhi_chan *mhi_chan;
-- 
2.25.1

