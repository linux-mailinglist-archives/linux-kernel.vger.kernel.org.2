Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4028C3B436C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhFYMhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhFYMh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:37:26 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3588C0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:35:02 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y4so7915588pfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3DgnnTTSnmT/peV2biYKlFU/kMTbnc/Zi2T2QGThm6g=;
        b=Z6mW3ccQN2YBGjwffpJ73Duxw2kzlNc3b4cHutlQBqVWyoJmNhswvJXGEFOk2WB5qU
         kkptZQqQ1o481oe2WiehWE3FNtq02Zue2ZCHyjqalzIbhNv1tv4hC6nNIgCErdBHfQ/3
         kiD/2TB8H6xe2KvJFKhX72fI9SB2dWoCQvSKi6QFLbdKivWUTD4h706ganAsEcxqYaDM
         D0OBejyeEFuIUE1WqugERo3plTuoYotGPM3hdP3UYJT2oT7VFSriD8mTV5eXqWyo6uX7
         lji/5RU/ZK/yqAuRBPWtPr3giwKCHRX57uZ8iHyG/P6X5pp0s7hjjTqXy/pSEoSTzWz2
         0iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3DgnnTTSnmT/peV2biYKlFU/kMTbnc/Zi2T2QGThm6g=;
        b=Whyn7IVsu/jL39niKwBtdTAGsQaF5Ugei7np1lmhKIrtTyBBTwOsYq2yKgdl7uY1w0
         m6kjAyytFnWHwVtTYSBWWXMXtp8y1292pA0gTtKniCr2Rny9GK3+bwODvwFHW/MlC1FA
         qNsJ+YxKkEXUmMORcwEyKf6BpRa6cb9Ud5owMEB5tbu0e7CiFDQ6uenn1Ta9UAaSp8yh
         NJ/RABz40VFyFFC46oXa1r5QcLrRl7DKrexrczWrQEtnVGeTmy0F69Jze2tx7C35/nwA
         jd2fgFHM0OykKL6ZYA0ncMfthcPdYfnVbXacUmQKCihVk/qLvTaYabNsihtOaiwLvp8c
         ItpA==
X-Gm-Message-State: AOAM531j+3akleid4+Wv/opfBeZTt7edElo8EJ0WQo3aux3xfo8ranYp
        fBT/fANsr5Q27ZazrADutBBp
X-Google-Smtp-Source: ABdhPJz+AKbIE1lpJhRVdxL7q3a/gDPAo2H+3JGDAdVYZy679F3z1BEtakar0D/fUWHx/cJwU8BXKw==
X-Received: by 2002:a05:6a00:2491:b029:308:d524:1a26 with SMTP id c17-20020a056a002491b0290308d5241a26mr5630575pfv.45.1624624502242;
        Fri, 25 Jun 2021 05:35:02 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:600b:2a0:ed5d:53e7:c64e:1bac])
        by smtp.gmail.com with ESMTPSA id y7sm6077780pfy.153.2021.06.25.05.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 05:35:01 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        kvalo@codeaurora.org, ath11k@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 09/10] bus: mhi: pci_generic: Set register access length for MHI driver
Date:   Fri, 25 Jun 2021 18:03:54 +0530
Message-Id: <20210625123355.11578-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210625123355.11578-1-manivannan.sadhasivam@linaro.org>
References: <20210625123355.11578-1-manivannan.sadhasivam@linaro.org>
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
index 89f71e6db23f..8bc6149249e3 100644
--- a/drivers/bus/mhi/pci_generic.c
+++ b/drivers/bus/mhi/pci_generic.c
@@ -508,6 +508,7 @@ static int mhi_pci_claim(struct mhi_controller *mhi_cntrl,
 		return err;
 	}
 	mhi_cntrl->regs = pcim_iomap_table(pdev)[bar_num];
+	mhi_cntrl->reg_len = pci_resource_len(pdev, bar_num);
 
 	err = pci_set_dma_mask(pdev, dma_mask);
 	if (err) {
-- 
2.25.1

