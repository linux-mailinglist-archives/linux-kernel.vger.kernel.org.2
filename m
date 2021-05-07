Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BD2376BB0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 23:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhEGV0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 17:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhEGV0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 17:26:10 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A3BC0613ED
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 14:25:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b15so8817402pfl.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 14:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w7qU0L4Ghb4CDxo7QXwP01EaDZwAPCg8iNdM0vaFanE=;
        b=XdgUX9BU0EfF9iq2Mk1qPxb4M/jFLVcOTOOyxD2foBPY44oz9rXJk3Kq3i89V2iGLW
         8XxDpYb/vIFYQbe8Njb7uHTHqUE6JheauBLmHiUbew7fMZS/gEb6x7z3iUt8NhloLm38
         9DLvJNyuY8XNbfbVPV+jjpAP8P8w2RSRkAeNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7qU0L4Ghb4CDxo7QXwP01EaDZwAPCg8iNdM0vaFanE=;
        b=Tmh7XQ8Ih/iq3z319M0MZy8YzIDMzFhtxYmmGJOY0o0MxbkqyQpDI4LR8n04P6Fj3h
         k+RV7N4y7zckmaU3/h+m3TovhWnLiHkLtqtjts7ccDP60X56J2Io40jy0TA1Bwz9b+Zl
         RwDzAOv70sgRCByrxMJE3HSWV/ZAjKVBQgOb6tg4AA3j+Bnn88WZ6rgVMxOL2ek79lC5
         2TEHWAv7RvPKlfayuJOLx9C+hl4ohOrgd540ujN0lUhNBIOwwXzBTmmjH/vTC9XKMQ28
         SGMjJguKL7pPXfidDMztZeZDCNMwOMVvrmZGTblI5RIHMwjdTwRhIu8Lr85Mz7pYvtJ/
         f2xQ==
X-Gm-Message-State: AOAM53010HjPGP8OFCO1U+HTQxCRY456FufJM7M9jINJEE95BANA1CFu
        9t/qCZAQBtwFAPO4aAK9Q5NcnqOwgxhmcA==
X-Google-Smtp-Source: ABdhPJzuXnkaex5EPKxyYb3+tGce0cj1UnpTZAtXkCnSy3u/dQq7nXNraVXLIaMKOLAN0jEAZSUr7w==
X-Received: by 2002:a63:a64:: with SMTP id z36mr12037116pgk.342.1620422709512;
        Fri, 07 May 2021 14:25:09 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:ab8b:4a3d:46ab:361c])
        by smtp.gmail.com with ESMTPSA id t1sm4996298pjo.33.2021.05.07.14.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 14:25:09 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>, aravindh@codeaurora.org,
        Sean Paul <sean@poorly.run>
Subject: [PATCH 2/3] drm/msm/dp: Shrink locking area of dp_aux_transfer()
Date:   Fri,  7 May 2021 14:25:04 -0700
Message-Id: <20210507212505.1224111-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210507212505.1224111-1-swboyd@chromium.org>
References: <20210507212505.1224111-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to hold the lock to inspect the message we're going to
transfer, and we don't need to clear the busy flag either. Take the lock
later and bail out earlier if conditions aren't met.

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abhinav Kumar <abhinavk@codeaurora.org>
Cc: Kuogee Hsieh <khsieh@codeaurora.org>
Cc: aravindh@codeaurora.org
Cc: Sean Paul <sean@poorly.run>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_aux.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index 91188466cece..b49810396513 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -329,30 +329,29 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
 	ssize_t ret;
 	int const aux_cmd_native_max = 16;
 	int const aux_cmd_i2c_max = 128;
-	struct dp_aux_private *aux = container_of(dp_aux,
-		struct dp_aux_private, dp_aux);
+	struct dp_aux_private *aux;
 
-	mutex_lock(&aux->mutex);
+	aux = container_of(dp_aux, struct dp_aux_private, dp_aux);
 
 	aux->native = msg->request & (DP_AUX_NATIVE_WRITE & DP_AUX_NATIVE_READ);
 
 	/* Ignore address only message */
-	if ((msg->size == 0) || (msg->buffer == NULL)) {
+	if (msg->size == 0 || !msg->buffer) {
 		msg->reply = aux->native ?
 			DP_AUX_NATIVE_REPLY_ACK : DP_AUX_I2C_REPLY_ACK;
-		ret = msg->size;
-		goto unlock_exit;
+		return msg->size;
 	}
 
 	/* msg sanity check */
-	if ((aux->native && (msg->size > aux_cmd_native_max)) ||
-		(msg->size > aux_cmd_i2c_max)) {
+	if ((aux->native && msg->size > aux_cmd_native_max) ||
+	    msg->size > aux_cmd_i2c_max) {
 		DRM_ERROR("%s: invalid msg: size(%zu), request(%x)\n",
 			__func__, msg->size, msg->request);
-		ret = -EINVAL;
-		goto unlock_exit;
+		return -EINVAL;
 	}
 
+	mutex_lock(&aux->mutex);
+
 	dp_aux_update_offset_and_segment(aux, msg);
 	dp_aux_transfer_helper(aux, msg, true);
 
-- 
https://chromeos.dev

