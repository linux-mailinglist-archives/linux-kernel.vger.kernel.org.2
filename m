Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC3532336E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 22:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhBWVrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 16:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhBWVrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 16:47:05 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF22C0617AA
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 13:45:47 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u11so10659712plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 13:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GZZ4+isyvvBq3J9vCBIeGrq4NjZWjQ7x1vxpr0gQR+w=;
        b=mEhLT0SygSoX/t28f7YrV3MrUieLIR+/jhQtl7O26XtKMpO3tVFfTMVOFa1U+44Vj3
         BJl+NwKPDKmGj5CYbQImNlIikA1cNhmjRBJDoIDS3rZvrtnirAptezK05bdC6F7VZr5/
         fu6h8fsBCsVgtvCXGOjHBC3ejwLZ7uus4j2j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GZZ4+isyvvBq3J9vCBIeGrq4NjZWjQ7x1vxpr0gQR+w=;
        b=uISG20hptXaPz8bAhILidfFgqEYH+OaZc/4Mz15E2o0V6Nhiq0mnjNfxnZv6sEKd4U
         y2D4PkaXBBMX4U+yaL9Ab1RqPyYECHrvlSg6gb2l8p/xL3uLdDYk/xHF0KoLKegShpK6
         8XfwBeuoA15W6qeJQUhMFzYAzlWf6DGf67amB7KjQr7/xfMVNBcqXLnlooTdKnlSE3RT
         ujGf0FckK8IvCFUkmDBCTcGsKhTcl5ltK5vXdUcjHl4t4KtB3Fwy/1u1szAhaAO66zGh
         uplo+ryG7oXB8bmzjpiBjfmvcZYhhyUCaIoPSCCMd/5z7LyUg0cosHPlnfrHCT1MSn4T
         DQZA==
X-Gm-Message-State: AOAM531l5c3g2+qeyY4wua+MFxQL7ExZ/23KQuJZdiRnaXzxNPepasz3
        EuME3RV9F8FJMJjT5b83wN6H9A==
X-Google-Smtp-Source: ABdhPJxJc903sUIztTzxmi80UqFSkT08yZw93ZuA7sAIlH/fyGCqwro42X/gy76qQ1RH8A0sZrqXrw==
X-Received: by 2002:a17:90a:fb58:: with SMTP id iq24mr830916pjb.64.1614116747049;
        Tue, 23 Feb 2021 13:45:47 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:68e6:d68b:3887:f216])
        by smtp.gmail.com with ESMTPSA id r68sm137951pfc.49.2021.02.23.13.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 13:45:46 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 5/6] firmware: qcom_scm: Fix kernel-doc function names to match
Date:   Tue, 23 Feb 2021 13:45:38 -0800
Message-Id: <20210223214539.1336155-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
In-Reply-To: <20210223214539.1336155-1-swboyd@chromium.org>
References: <20210223214539.1336155-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions were renamed but the kernel doc didn't follow along. Fix
it.

Cc: Elliot Berman <eberman@codeaurora.org>
Cc: Brian Masney <masneyb@onstation.org>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Fixes: 9a434cee773a ("firmware: qcom_scm: Dynamically support SMCCC and legacy conventions")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/qcom_scm-legacy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom_scm-legacy.c b/drivers/firmware/qcom_scm-legacy.c
index eba6b60bfb61..1829ba220576 100644
--- a/drivers/firmware/qcom_scm-legacy.c
+++ b/drivers/firmware/qcom_scm-legacy.c
@@ -118,7 +118,7 @@ static void __scm_legacy_do(const struct arm_smccc_args *smc,
 }
 
 /**
- * qcom_scm_call() - Sends a command to the SCM and waits for the command to
+ * scm_legacy_call() - Sends a command to the SCM and waits for the command to
  * finish processing.
  *
  * A note on cache maintenance:
@@ -209,7 +209,7 @@ int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 				(n & 0xf))
 
 /**
- * qcom_scm_call_atomic() - Send an atomic SCM command with up to 5 arguments
+ * scm_legacy_call_atomic() - Send an atomic SCM command with up to 5 arguments
  * and 3 return values
  * @desc: SCM call descriptor containing arguments
  * @res:  SCM call return values
-- 
https://chromeos.dev

