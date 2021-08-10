Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9647D3DCFF4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 07:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhHBFNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 01:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbhHBFNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 01:13:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7796BC061798
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 22:13:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so23059645pjh.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 22:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YH9RqDwj3Hxwa7+6WVhzvigR5j4AY8ETFRKdu6OaqBQ=;
        b=blOinbp2TXOPDqv6bdBdL2rd9HvkvFhk10+RA5xVfJb0q5wIFEquiNAQxfMLAFtb7R
         uPzskefIAJPHB2MiKNoBRURViB7EmYKTygEoSQ70T3hbWIjLGHdoCzXr/b2NqVvNAWLU
         3xaw97BfrrpFv/PHOoCgvoQGKY9z3lzK2JghsIipMcHOChzRNSW3jLZMWAAKJew1E7Io
         3NEb92j9eycwBW4azyxzIKrFb8jNrUUSFUu3J7GyBGKXi7YTtWRc92FzHUBMUiKaF/mR
         RucnPzfY17O2X/fcr8LnEgpBaw7hYczFGX2o1oq3QRWBrCWtS6XrrI9AnuNi27FeB3mc
         hhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YH9RqDwj3Hxwa7+6WVhzvigR5j4AY8ETFRKdu6OaqBQ=;
        b=rJl80jw/5akl5UETb8NxbG5EdbT/dwjWFkBuNFxjT6gUzIqQoicoP64xgbWT34q5so
         9/z9C7MdI0FWlF8kBUAYX+OUkzyLciQgyyQ7gPgv1eTKFUQJS/8FFl6wrnWS7JXgW/Pc
         /LCDKhpU6I41wSReHv0swGG0dwM8TjFA7rz3wetfAyyl7hCEN/D9SxesBCEsGK35A4/Q
         49knyYw0tfLna7msz7ewCtYxBnksGuiAFNDc28GO+ZOswC21dq5h3yh7249TJZxDsDgS
         OsoL8qFT/Y5mu94vrdnuU+c1uytL7LRNln5R6azgT2pDcWcKQgi3mPOLPBNiZrN21yWc
         qvYA==
X-Gm-Message-State: AOAM532X7etL9fc8UaOBUgZdt53tbNhn5St5y3DFbzaafkDoRWBLOqIW
        ts+/maEly0XCbifFecIMRb1U
X-Google-Smtp-Source: ABdhPJyU/3AfaD03IPy5fAmQykK4Wb/SqJad4FS3c4iFTnWzBEX6wqnzDlxXZ4CIrcmnOIoXTd323Q==
X-Received: by 2002:a17:90a:df05:: with SMTP id gp5mr15562702pjb.165.1627881213065;
        Sun, 01 Aug 2021 22:13:33 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6e99:242f:6391:b1b4:1ad8:fbdf])
        by smtp.gmail.com with ESMTPSA id x26sm9947000pfm.77.2021.08.01.22.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 22:13:32 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 04/10] bus: mhi: core: Set BHI and BHIe pointers to NULL in clean-up
Date:   Mon,  2 Aug 2021 10:42:49 +0530
Message-Id: <20210802051255.5771-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802051255.5771-1-manivannan.sadhasivam@linaro.org>
References: <20210802051255.5771-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

Set the BHI and BHIe pointers to NULL as part of clean-up. This
makes sure that stale pointers are not accessed after powering
MHI down.

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

