Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54330323364
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 22:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhBWVq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 16:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhBWVqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 16:46:23 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06806C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 13:45:43 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z7so10669716plk.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 13:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0m+u5aZAd9dcIGjz/xkZGfwxe/2CHxZAPhdRmcDTJ+c=;
        b=MQqpA6L+xv4gK1UfJbbjRa6WoukR2X4+1TPl6atilFwMyysdIrNje6ivCgKj+adw8K
         UAo3T3IKCAie6RVLwZ2q5K6asb9KRcfooOKn+8ZXp0YC5KG6SnCGb73ri1vnHqUV99eB
         C0VF4qbwETjejsIO6ROTUUqa/P/DDgSSC1KLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0m+u5aZAd9dcIGjz/xkZGfwxe/2CHxZAPhdRmcDTJ+c=;
        b=nm94RxADbLQxBddOvm984r+AhjzASnTuxkSfS+4BXTpMesDze3KpDwIZMMHVUyV+kK
         P6DMrEh6UE+CPKUzkxZ3EzKSVOHS0PstsTkxfRzK6cHtZKykMEHFA1CyNHKygBOn9IUV
         Gq8TesoXQqsKbmjBu9miKTGO7nFTlfjIadsx2+R5Y/kKtInW1T6yZdVx80t4gf10kvoF
         CgqK5oG31LiSxemgDqNsjJg/cOpuQl3mf0o6OVTzSVD0FpO0dus+6QtcnQn6mHc3Xjwp
         pPEnDqPq32O81Y7uE40NKhPQ9Re4oE0qf+8oO7geAHfsjlGFoZaib/oKSl1BG+7cIo0r
         V+pg==
X-Gm-Message-State: AOAM531CkeqQDZtgqXSWLOJGtVMqI+icq/KGUeG5MxosS5F+7Ax7hNDb
        qP6A88/ysSgyi9dVaknnhBw4Kg==
X-Google-Smtp-Source: ABdhPJyiF11FhotGN8vvmdkM2cu1T9dli+VpxHQ/yf0ZrnPTo8yQyqgS0w6BEwxcsniRKzsPrJTbJg==
X-Received: by 2002:a17:90a:ea86:: with SMTP id h6mr760077pjz.135.1614116742624;
        Tue, 23 Feb 2021 13:45:42 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:68e6:d68b:3887:f216])
        by smtp.gmail.com with ESMTPSA id r68sm137951pfc.49.2021.02.23.13.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 13:45:42 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/6] firmware: qcom_scm: Make __qcom_scm_is_call_available() return bool
Date:   Tue, 23 Feb 2021 13:45:34 -0800
Message-Id: <20210223214539.1336155-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
In-Reply-To: <20210223214539.1336155-1-swboyd@chromium.org>
References: <20210223214539.1336155-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make __qcom_scm_is_call_available() return bool instead of int. The
function has "is" in the name, so it should return a bool to indicate
the truth of the call being available. Unfortunately, it can return a
number < 0 which also looks "true", but not all callers expect that and
thus they think a call is available when really the check to see if the
call is available failed to figure it out.

Cc: Elliot Berman <eberman@codeaurora.org>
Cc: Brian Masney <masneyb@onstation.org>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Jeffrey Hugo <jhugo@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Fixes: 0f206514749b ("scsi: firmware: qcom_scm: Add support for programming inline crypto keys")
Fixes: 0434a4061471 ("firmware: qcom: scm: add support to restore secure config to qcm_scm-32")
Fixes: b0a1614fb1f5 ("firmware: qcom: scm: add OCMEM lock/unlock interface")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/qcom_scm.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index f57779fc7ee9..2be5573dce53 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -113,9 +113,6 @@ static void qcom_scm_clk_disable(void)
 	clk_disable_unprepare(__scm->bus_clk);
 }
 
-static int __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
-					u32 cmd_id);
-
 enum qcom_scm_convention qcom_scm_convention;
 static bool has_queried __read_mostly;
 static DEFINE_SPINLOCK(query_lock);
@@ -219,8 +216,8 @@ static int qcom_scm_call_atomic(struct device *dev,
 	}
 }
 
-static int __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
-					u32 cmd_id)
+static bool __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
+					 u32 cmd_id)
 {
 	int ret;
 	struct qcom_scm_desc desc = {
@@ -247,7 +244,7 @@ static int __qcom_scm_is_call_available(struct device *dev, u32 svc_id,
 
 	ret = qcom_scm_call(dev, &desc, &res);
 
-	return ret ? : res.result[0];
+	return ret ? false : !!res.result[0];
 }
 
 /**
@@ -585,9 +582,8 @@ bool qcom_scm_pas_supported(u32 peripheral)
 	};
 	struct qcom_scm_res res;
 
-	ret = __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
-					   QCOM_SCM_PIL_PAS_IS_SUPPORTED);
-	if (ret <= 0)
+	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
+					  QCOM_SCM_PIL_PAS_IS_SUPPORTED))
 		return false;
 
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
@@ -1060,17 +1056,18 @@ EXPORT_SYMBOL(qcom_scm_ice_set_key);
  */
 bool qcom_scm_hdcp_available(void)
 {
+	bool avail;
 	int ret = qcom_scm_clk_enable();
 
 	if (ret)
 		return ret;
 
-	ret = __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_HDCP,
+	avail = __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_HDCP,
 						QCOM_SCM_HDCP_INVOKE);
 
 	qcom_scm_clk_disable();
 
-	return ret > 0;
+	return avail;
 }
 EXPORT_SYMBOL(qcom_scm_hdcp_available);
 
-- 
https://chromeos.dev

