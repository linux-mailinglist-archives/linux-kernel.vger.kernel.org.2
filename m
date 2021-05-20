Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEDE38AEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242947AbhETMrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242447AbhETMnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:43:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0629CC056497
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d11so17359238wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pO5grwrsv4uMOhYf2ygGyZPPYt+9rmeszEZndYds2GE=;
        b=CT/EoTRfYVBMyN8Wzm8oIU6O8z4y0prNiAf2aGwl18sXL6nhs3Qa7lndrhUsKNpDNh
         lCPNbGFn1y4DmrNr28zOZrehZnATaWcMml5I3ocbHsxIkMeGsS2ZekSj2cVrN+8vUzOw
         sSuN90me/VUxRRa8I4hU3JwltTu8JZT90S3shAULwt0mBG7O/wb97drPL8NKXIltu6i1
         xMypzDARp+sAyjtdEKK0npV7sP1RPbELatr9TgObyh9m8es+7Kw3VdkkU6K40xJaPQ+1
         xWb2/INEkfii3jkvbu7kRkEciU+eiCKAPTU1Y2Tw9wyaA2n+N8KCQ/gjqjtc8BKAZsBm
         I3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pO5grwrsv4uMOhYf2ygGyZPPYt+9rmeszEZndYds2GE=;
        b=OKqYRdjrbGNWmqIZ/IYTVT1ZGNh5MzUPC6jUtplQ4Ohy+4+I/Yg/P5GKjh+uYl30ii
         rT5GRthG3b3WxSU+b9d8tJnaUnwYF6tgv0uUyFs0MF1ClZaoxa09zWxvrZ37k440TWd2
         7U7nPDvBslyLCCutpg1Oa6iWhIpN+WbPwuc2spwtIiG28S22B01NE8yoDIYCV1tw/RSZ
         gac+9dIVT1EygzXebNzPZSYnJUr/OwCy+X9HFOXZYckohM3InErBsnqu4MU1GXevJjJ4
         5LhFAYFxmlZCxCerxvOBYLisbDWIzkuAhzu+vmz4IwqQgYUSzqumo76mQzDjUR2M5Ub7
         xTdw==
X-Gm-Message-State: AOAM531ter2nKNJNIGuU+FpA5TpJ5fvjTbtjtl68k9cqGbsz4HbWErva
        FIhMNhHErVlKDYWmFbUZBNk3bA==
X-Google-Smtp-Source: ABdhPJyVGLD3pIUwDllaOAyh0KECeEj9Z5MxF/PEDD5PRs/ZcnbIVDDHh9VW+4L3f/5KCoQgYjwlxg==
X-Received: by 2002:adf:e0c6:: with SMTP id m6mr4105302wri.66.1621512191654;
        Thu, 20 May 2021 05:03:11 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 19/38] drm/radeon/cik: Fix incorrectly named function 'cik_irq_suspend()'
Date:   Thu, 20 May 2021 13:02:29 +0100
Message-Id: <20210520120248.3464013-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/cik.c:7450: warning: expecting prototype for cik_irq_disable(). Prototype was for cik_irq_suspend() instead

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/cik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 42a8afa839cbb..73ea5189dfb1a 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -7439,7 +7439,7 @@ static void cik_irq_disable(struct radeon_device *rdev)
 }
 
 /**
- * cik_irq_disable - disable interrupts for suspend
+ * cik_irq_suspend - disable interrupts for suspend
  *
  * @rdev: radeon_device pointer
  *
-- 
2.31.1

