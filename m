Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AE332BE68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453011AbhCCRVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349200AbhCCNoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:44:14 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB991C061797
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:33 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o16so6404852wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/33rrW6tAmVtxRYoiv0PK1lc5LAomei+z6FwtqsCisM=;
        b=dhSUUgmE7ZX33ei022sF4B/eNLt7eRn6jyC6OPLLge7KLxxCOeCa28VOHm8A2NqkOz
         rC5HtpmrZfFZTpr1oxG4X536z+qSdFWpmImIvI0zypVu71zTpz2EWNslYDCj5a+ibt09
         TKB3YH++0UGqcXv4EqTw863+Sup2Nio3mTY788B7rDNCTnhq8t7oYkaqgvC9Oi9Ns5U8
         PEDhLB0l5/UlEsh2yZkvIGxEOwr2hdNd1JAEm3lzqNhrZ/F78oTmE/S2AGHFnm+F3W41
         wAL/9MqBdbhvvMpKruwntRhuemSAEs9b4568GTwFsUW57U544g+jjXC8m4uaD4PGB/sh
         niIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/33rrW6tAmVtxRYoiv0PK1lc5LAomei+z6FwtqsCisM=;
        b=Q9pFRRkWWDf2gZlLx8S7/YAQf2rVXj3xL69JCDXnVbVSzczPjLwjWbnF22/7yombRg
         3w5t9PiSFuOUnFZla+EmHb8nvi4S//Vd6AeFCF4v07px13hAV4eLJslQbtVYccWq2zq0
         OBJovOLun44x8Gc0gm4en1ihTAFIs5gFFDM0PwLpblKthM1GU81EDN8Lh2t6L7OsWw5d
         JRn8iQJKJ71CxqeufeD81Fq201OFoM9CIkYkLlDOKrQFys63FJJmEHoM6GW4B4hh0SUK
         UP46sZWZ+xyD8XvKQVt/SPRqyuoqj38tInt7s84NHJVlXBOgd9mMwN6GBNcP/b0zV1eU
         IyIQ==
X-Gm-Message-State: AOAM530tSpWeRJAQKPYRVgSC07ndvIiGvi53jHQ61PfxLD4wWfSa8I3v
        2i4eo/CLHyqleQVkYreoLgFu8A==
X-Google-Smtp-Source: ABdhPJx6MantSUmHLqZL3Rdo8nhUHc4SqNiVIbqa5aYBg6L1cry77BtTByahiAyHKLttAj1nH+JoMw==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr9539427wmq.159.1614779012467;
        Wed, 03 Mar 2021 05:43:32 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:31 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 03/53] drm/msm/dp/dp_display: Remove unused variable 'hpd'
Date:   Wed,  3 Mar 2021 13:42:29 +0000
Message-Id: <20210303134319.3160762-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/msm/dp/dp_display.c: In function ‘dp_display_usbpd_attention_cb’:
 drivers/gpu/drm/msm/dp/dp_display.c:496:19: warning: variable ‘hpd’ set but not used [-Wunused-but-set-variable]

Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Kuogee Hsieh <khsieh@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 5a39da6e1eaf2..31bf2a40a9eb2 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -493,7 +493,6 @@ static int dp_display_usbpd_attention_cb(struct device *dev)
 	int rc = 0;
 	u32 sink_request;
 	struct dp_display_private *dp;
-	struct dp_usbpd *hpd;
 
 	if (!dev) {
 		DRM_ERROR("invalid dev\n");
@@ -507,8 +506,6 @@ static int dp_display_usbpd_attention_cb(struct device *dev)
 		return -ENODEV;
 	}
 
-	hpd = dp->usbpd;
-
 	/* check for any test request issued by sink */
 	rc = dp_link_process_request(dp->link);
 	if (!rc) {
-- 
2.27.0

