Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A011412B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244868AbhIUCJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237796AbhIUB4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:56:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5451CC0313C0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 16:48:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v19so13141445pjh.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 16:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GXO1wbRzNiGMHz2o26Et+v1WYPV9a08wLqIvztsWDp8=;
        b=MI4totTbl7bqZBrKwH4GAlkcVjqcG4FuL7sWGXvTjcJ2wn1pAiYWNJXDQ7axFUMZ7d
         oNoui6VmOYxtOtqrxw9hwDe/sRNV5syMSB3pQ1ctJQdOIO6CMu8+XSNdATMu1ONrgWrF
         biOEF5ofyybSAKIh3KeaZylLmk/fP/IdEygzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GXO1wbRzNiGMHz2o26Et+v1WYPV9a08wLqIvztsWDp8=;
        b=fsyKYZypVe7g6jTYw5RAUNzf9bpN8gIksJLVqcR6we9SRQKzI/u/gpatjl5UsfpsAg
         mHsua4+Ab8H71Jl1P2qPqCZyOhwhKCpWYRZ67I3LTbWk2am+3hF4ikm/L6pOfqNlDVE4
         ZsOXi62q6KwjB162D6DjGSPnb7PgTTvfLH0pWMaNj/slU9bFhlPjP1TQSTuIuDEJSRlD
         YMiGS1WJ1SNoFRrvowT+IF1rq1Lh4rczmjgAu8WRGD/IPgWPqbud9Ij+YiD+vGt1myjh
         Xd1jzSbbgWrWUYANIunuwzPTr2zuF40rXefRnY0YXoxZ3wf7R5iVJuIWsB8n4hvu3+AH
         vE1A==
X-Gm-Message-State: AOAM5306PC5TKLoa2mprzBAhIK0s+tQr8DioRFy1qgCOuKrVtwzuAYQp
        mJm+oSVjbilmK8MoeBoEBUmOvg==
X-Google-Smtp-Source: ABdhPJzukq92QpTILb/L706jNqFOu/NzEB+biYZ0j6kOE8HdWCbQvYdiuZwD+TSntBQZfUd5ucfNPQ==
X-Received: by 2002:a17:902:e88a:b0:13c:9ca3:f724 with SMTP id w10-20020a170902e88a00b0013c9ca3f724mr24907847plg.10.1632181730842;
        Mon, 20 Sep 2021 16:48:50 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:63bc:d1a1:9f14:3ee5])
        by smtp.gmail.com with ESMTPSA id c12sm14462776pfc.161.2021.09.20.16.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:48:50 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        satya priya <skakit@codeaurora.org>
Subject: [PATCH] spmi: pmic-arb: Add sid and address to error messages
Date:   Mon, 20 Sep 2021 16:48:49 -0700
Message-Id: <20210920234849.3614036-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's useful to know what particular device/component is having trouble
accessing the bus. Add the sid and address to error messages here so
that debugging is a little simpler.

Cc: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Cc: satya priya <skakit@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spmi/spmi-pmic-arb.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index bbbd311eda03..e397c2532c8d 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -261,20 +261,21 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
 
 		if (status & PMIC_ARB_STATUS_DONE) {
 			if (status & PMIC_ARB_STATUS_DENIED) {
-				dev_err(&ctrl->dev, "%s: transaction denied (0x%x)\n",
-					__func__, status);
+				dev_err(&ctrl->dev, "%s: %#x %#x: transaction denied (%#x)\n",
+					__func__, sid, addr, status);
 				return -EPERM;
 			}
 
 			if (status & PMIC_ARB_STATUS_FAILURE) {
-				dev_err(&ctrl->dev, "%s: transaction failed (0x%x)\n",
-					__func__, status);
+				dev_err(&ctrl->dev, "%s: %#x %#x: transaction failed (%#x)\n",
+					__func__, sid, addr, status);
+				WARN_ON(1);
 				return -EIO;
 			}
 
 			if (status & PMIC_ARB_STATUS_DROPPED) {
-				dev_err(&ctrl->dev, "%s: transaction dropped (0x%x)\n",
-					__func__, status);
+				dev_err(&ctrl->dev, "%s: %#x %#x: transaction dropped (%#x)\n",
+					__func__, sid, addr, status);
 				return -EIO;
 			}
 
@@ -283,8 +284,8 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
 		udelay(1);
 	}
 
-	dev_err(&ctrl->dev, "%s: timeout, status 0x%x\n",
-		__func__, status);
+	dev_err(&ctrl->dev, "%s: %#x %#x: timeout, status %#x\n",
+		__func__, sid, addr, status);
 	return -ETIMEDOUT;
 }
 
-- 
https://chromeos.dev

