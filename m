Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED6536ED09
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbhD2PIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbhD2PH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:07:57 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052D6C06138F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:07:11 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z5so11228108qts.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FUSrZlERR89hZzHNyP4QRMbV2CihmITrCmz3k1LlYk4=;
        b=MHnQJNbVziLM0NPBDtmnwCmOJ2FoMf3Ip14Lec6yiW9Uw6wXJuecmb+TjAI0QTEitc
         WNpma+n25xPeN4F8PqiRZsQ6R4aIVkCH8d6gs9+6AfMPjY8703EY42h09Hbts2W5+UaI
         7bSZMJ1iZtva1r4TQEM9PtgSONILCgKOb5B2IOoR9Q4vGpzBW04aewKE2JlYZG1wp/Q8
         IBVIhhlfHUPc+UsCWZMk2wz3B+9/8qML3QPrJzw2tvPHDQ8XFUWsMVUqYSqeFE6ztPPt
         nM80jMCXcIZ/xuB/Q6/o3HFuQBnSqLdiOHnlJTv+/Q5Goxb65N+HCS6tj7RP2wi/KOl9
         LU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FUSrZlERR89hZzHNyP4QRMbV2CihmITrCmz3k1LlYk4=;
        b=VdHqGlJVA5bM4jKpihn6Yfl+kz5KAUinjZuYJdcG96MjdsTZ7SixVAEZxD1/3z4aLG
         ptXSOsm5sjm90rqObFjFL056LHzXhNYe3tWCRh79ZD9GzgNRVOoydsiiulyyg+JJZvLC
         Ov+wWOXwnQu1XwdnzMYY+mbIeDoUrEykKb13KxAUKPPvIOzHhG6X2dB7deAEejKARNF2
         bb/VQnuJGKjjKsUJNArfMu0ih5PDTut1JQNZDBcVXpLoU5kH7E6L9/PkBcmINBNXrNyd
         YsflDaSfSn4tYTO6/YgaAXFzvQWDmo1w5z4ihwPW2zVk8yyl6KIWujEhVYig63Fa2Uy+
         xMbQ==
X-Gm-Message-State: AOAM532sklH1uMlByL1ty2yvsu1VdG3NgeLXm3tEK+1gZMxyqbvvXF7E
        9zlNC5NrVErKDSKYMDANbdbaaw==
X-Google-Smtp-Source: ABdhPJxnEVT2K9UkClrAOM08gSZ9saJsmBh5srRf+Bp4JISfSe2v4i9eQbW+SiK5/rikm63ANJHTmA==
X-Received: by 2002:ac8:7344:: with SMTP id q4mr22981494qtp.278.1619708829856;
        Thu, 29 Apr 2021 08:07:09 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id j191sm2223822qke.131.2021.04.29.08.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:07:09 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [Patch v4 1/7] crypto: qce: common: Add MAC failed error checking
Date:   Thu, 29 Apr 2021 11:07:01 -0400
Message-Id: <20210429150707.3168383-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210429150707.3168383-1-thara.gopinath@linaro.org>
References: <20210429150707.3168383-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAC_FAILED gets set in the status register if authenthication fails
for ccm algorithms(during decryption). Add support to catch and flag
this error.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v1->v2:
	- Split the error checking for -ENXIO and -EBADMSG into if-else clause
	  so that the code is more readable as per Bjorn's review comment.

 drivers/crypto/qce/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index dceb9579d87a..dd76175d5c62 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -419,6 +419,8 @@ int qce_check_status(struct qce_device *qce, u32 *status)
 	 */
 	if (*status & STATUS_ERRORS || !(*status & BIT(OPERATION_DONE_SHIFT)))
 		ret = -ENXIO;
+	else if (*status & BIT(MAC_FAILED_SHIFT))
+		ret = -EBADMSG;
 
 	return ret;
 }
-- 
2.25.1

