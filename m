Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0E23DD000
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 07:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhHBFOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 01:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbhHBFOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 01:14:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5894AC0613D5
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 22:14:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so4060575pjs.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 22:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y3jqjblyF+bNujjzoE4Dt1sYtyoNDw930jBhejpyDsQ=;
        b=MHi+EK7adrpO/F23uzLcoFSgWDsz4wjsWR5IPfheS7GzkIfS/CEtozyCFzE7GjSZrE
         wYpqO99ar3MIgEnVHUsdAc2hARx4ciq/oHBs4q0Q8kSr4GoeXWoNuoNqExSOWG2+ywn+
         hEcUFQjkQTpitrcK0O7Jh6EasK6Qkq57lzvpiYL4cQUJ0k5HEr5JQlLliHdoJ815pSet
         E2x0Vv1PD/iHoGTPfLtChceDmTXaJRFidxuJG4dgDCzyjLk/zh01CDh7QhzmM5QSnuHj
         ol1bNFY6JdyKqVtVK6ttsN8DBTxixwq48IEnS0oHyi3g/43mmRb7cIVcoiX3C2TxMfqh
         3WBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y3jqjblyF+bNujjzoE4Dt1sYtyoNDw930jBhejpyDsQ=;
        b=gPJxcG4vzEmvQ2q7dUJQ7ApQOj5FZ2zv437R91el6acV+5nc+ZElqD3m4K8qmVslZB
         xf1V9KrkNU0M5peFwfGeFumffmnbRKZTNE7PQzWotF4sKf90cHQh9BTZ3S2eXadM3W/Q
         PnDyARTa5tZ+gH3fPHlhaKb6H1xKgb2JPo7wrtiFJ2lBoUWj+QP/KO3S165P3iU9uQeL
         /5kk0QOr7zvX1GRIBOkHrcNwYCKaUhanUt9r+sdQrOjWOkZcNQmDK/SqY5kZPPiSG/+x
         TwVZYefsECEELmokc8ju8NZV08i9dXcoDu9aIAJfySQYe05avFR8IhZufXIwVyDdUfTO
         Y6iQ==
X-Gm-Message-State: AOAM531ByajmKIFx15KLLJ3LOqN2m8/ItZ2Eny3iA+MaDLtuLBUd7Br+
        Bt8Jk0xO95ZIWgt8q2RUB70W
X-Google-Smtp-Source: ABdhPJzqQyFPyeWjcyPOB5BsNVcswXcJgkqnNPCQLnhw89QF2s2pepwJ6OOIMJUYiCcHB6nrtAVBhw==
X-Received: by 2002:a17:902:b116:b029:12b:84fa:8c70 with SMTP id q22-20020a170902b116b029012b84fa8c70mr12736550plr.40.1627881240898;
        Sun, 01 Aug 2021 22:14:00 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6e99:242f:6391:b1b4:1ad8:fbdf])
        by smtp.gmail.com with ESMTPSA id x26sm9947000pfm.77.2021.08.01.22.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 22:14:00 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 10/10] bus: mhi: core: Improve debug messages for power up
Date:   Mon,  2 Aug 2021 10:42:55 +0530
Message-Id: <20210802051255.5771-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802051255.5771-1-manivannan.sadhasivam@linaro.org>
References: <20210802051255.5771-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

Improve error message to be more descriptive if a failure occurs
with an invalid power up execution environment. Additionally, add
a debug log to print the execution environment and MHI state
before a power up is attempted to confirm if the device is in an
expected state. This helps clarify reasons for power up failures
such as the device being found in a PBL or Emergency Download
Mode execution environment and the host expected a full power up
with Pass-Through and no image loading involved.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/1620072038-36160-1-git-send-email-bbhatt@codeaurora.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/pm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index ff7cdc8653ef..fb99e3727155 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -1069,12 +1069,16 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 
 	/* Confirm that the device is in valid exec env */
 	if (!MHI_IN_PBL(current_ee) && current_ee != MHI_EE_AMSS) {
-		dev_err(dev, "Not a valid EE for power on\n");
+		dev_err(dev, "%s is not a valid EE for power on\n",
+			TO_MHI_EXEC_STR(current_ee));
 		ret = -EIO;
 		goto error_async_power_up;
 	}
 
 	state = mhi_get_mhi_state(mhi_cntrl);
+	dev_dbg(dev, "Attempting power on with EE: %s, state: %s\n",
+		TO_MHI_EXEC_STR(current_ee), TO_MHI_STATE_STR(state));
+
 	if (state == MHI_STATE_SYS_ERR) {
 		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
 		ret = wait_event_timeout(mhi_cntrl->state_event,
-- 
2.25.1

