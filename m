Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C723DCFFB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 07:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhHBFOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 01:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbhHBFN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 01:13:57 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E81C06179E
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 22:13:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so4059992pjs.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 22:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d6QO+qoPrYnXm6doNgVAXn8uk9174Od4qwkAZLnqxu4=;
        b=ahF6JFhQyFCCm4IkDoUHiLUvKcqe/AAERTdsultW2Im879ODNJUz/Mw1T9ezNytBvq
         dPpiZ6tqpwXjZvDEP3CM5ENUSE+TaDkQEtzpymiFBa/r3E426u2d0Q8CBhf+lVULn0Hf
         SlLerKSkJJjnZxFHh1hPy1OuyVXzUYka7SHZy1tPvq+oik+4DqGb+ZwrR5zeEMqn/6PK
         +51Cc4U44FNvb5ahhEQx9UhGuGfk03RuTcoZ+raYa6x/+f+pBwpMq1Zhk9fNfiR3mmaQ
         MYVHBQ5rHaf7nE7nmhv/lgDiO6JqUvBvqXESYa2uHWet0HrCMNK7JVFuf9ueOW80YmOo
         2Jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d6QO+qoPrYnXm6doNgVAXn8uk9174Od4qwkAZLnqxu4=;
        b=kfKrIANrzEJK3/+cy0/GG8yKQbuq41Nj2IARns0kSZwmbG7ucTGpe75ApoZCqSUih0
         tp+XkGAQ9SCcSC9+pKa36jesLeZFzgMOrSknAV81j5WlOetnsIufNZDMN3XY1sCb1XDB
         cLWJNiZqwAt6OtTCsLxDNDWVlDzHqTG7WqeYHMzbD9EqtECXj3FOPMlhNhoC98XTg9HF
         tKugoEc08pb51co8vFNCydIFBGGEEy1icKkuCXOGylYX0DLAB5JRRTt2vckcm7a8j25D
         j/KzJamagUMivjbUy/hmhW2z7F3+JZ7gbK/nL34CC1aePbc/M5OcdQGiMp/UGGgPdAPM
         sBVg==
X-Gm-Message-State: AOAM530iplyY8hpo8k70Cn+lmskaSvCTGYMOgBopbSGBr1+ZR7uYk69j
        feqQpS4kUKvbL2Henlvn5e3C
X-Google-Smtp-Source: ABdhPJwA1DYIz6396G8uC6nCVoqo6VzmvPArQJJENMfyDyZTG4qwTG1b5EL9HuCGw6/nx3znzifW4A==
X-Received: by 2002:a63:1155:: with SMTP id 21mr1053634pgr.346.1627881226039;
        Sun, 01 Aug 2021 22:13:46 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6e99:242f:6391:b1b4:1ad8:fbdf])
        by smtp.gmail.com with ESMTPSA id x26sm9947000pfm.77.2021.08.01.22.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 22:13:45 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 07/10] bus: mhi: pci_generic: Set register access length for MHI driver
Date:   Mon,  2 Aug 2021 10:42:52 +0530
Message-Id: <20210802051255.5771-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802051255.5771-1-manivannan.sadhasivam@linaro.org>
References: <20210802051255.5771-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

MHI driver requires register space length to add range checks and
prevent memory region accesses outside of that for MMIO space.
Set it from the PCI generic controller driver before registering
the MHI controller.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/1620330705-40192-6-git-send-email-bbhatt@codeaurora.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/pci_generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
index 6e1a86021b75..c772d94025fe 100644
--- a/drivers/bus/mhi/pci_generic.c
+++ b/drivers/bus/mhi/pci_generic.c
@@ -500,6 +500,7 @@ static int mhi_pci_claim(struct mhi_controller *mhi_cntrl,
 		return err;
 	}
 	mhi_cntrl->regs = pcim_iomap_table(pdev)[bar_num];
+	mhi_cntrl->reg_len = pci_resource_len(pdev, bar_num);
 
 	err = pci_set_dma_mask(pdev, dma_mask);
 	if (err) {
-- 
2.25.1

