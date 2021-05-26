Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C763912F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhEZIuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbhEZIt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097D3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y14so163815wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4jVnFwrLdvYbe+J6fnuiCvB9x4vw8NgmPskUsZo7eXM=;
        b=HNTh7zdUvwEtjEWA62LQCOv5WbZVwfiFak+3qFdaky7HvKVpVvwY4opo1mlTiR/meN
         WP6x3hiWK3l/gA1WqdHuuXaoJZZPW/6FNAur7QJr5Dy+04ye7p4buPeL+pvqMMBriARj
         arf+UEDOVQTSXNCioRBw3xKVZE2ClviZA+yuMCNkXKULUH3AaKGKpUahBxLV3HHyuJQS
         NljYpyEQQmc6uP/gq9zUSEaqvwrK776TkKxHAC9XDGl1IMaWrCxsCSGSTmD4gBYL4pD8
         qr7KJhvkL0jsF8keu21jzl+o4JSzogjgYcXzffE2KH4dt10f7dRqJueXo8n9tO7sBzU2
         UH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4jVnFwrLdvYbe+J6fnuiCvB9x4vw8NgmPskUsZo7eXM=;
        b=ltcQ5S4J52gzLcAjULcDFaV+KkbYs2EOkYjCKRjqI9cqjhDlLOuR6YKGf0rt/t95wv
         b3qCcC/kSttgsgEsRarnNHeFicT9KS9W5ehMxxmaluKQdM5rLTBmoNIInJqgjQGrLymY
         l/KFfwqU54C75ofNKtrnMRoWYBrsWuIQtgi5Q3fYcfICCxSD+rNuWUUnOPuoKw667+VF
         9KeO8cr75Y2D07YHUkCEd31Pz6r2CT1aR1kGcNqQYQX8P12mtht/yU7TWW5O7TSM84Qj
         mMcvX9ZtZ3kKjFhat/FXzrvANqc9JwE/gGGiw4FIfGZJ2jUG22/zIDdzEaPO5vE1Xn1V
         nZYg==
X-Gm-Message-State: AOAM5309rXL2y6h8PBbZM9D+KIet2ALq3yC5ABlKwdredeeBA3OZFOQ5
        xF+7dEkhM2RJV6aOkmLo01EsOg==
X-Google-Smtp-Source: ABdhPJy3fD/qyOe5xh29n4/y0jvix0HVQE48nrimbqrGSprkCLU68dwAISlYsNwaN55GcVMxHjfWVg==
X-Received: by 2002:a05:6000:104a:: with SMTP id c10mr31722911wrx.45.1622018874571;
        Wed, 26 May 2021 01:47:54 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Jun Lei <Jun.Lei@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 23/34] drm/amd/display/dmub/src/dmub_srv_stat: Convert function header to kernel-doc
Date:   Wed, 26 May 2021 09:47:15 +0100
Message-Id: <20210526084726.552052-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_srv_stat.c:38: warning: Cannot understand  *****************************************************************************

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jun Lei <Jun.Lei@amd.com>
Cc: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
index e6f3bfab33d3e..70766d534c9c8 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
@@ -35,20 +35,13 @@
  */
 
 /**
- *****************************************************************************
- *  Function: dmub_srv_stat_get_notification
+ * dmub_srv_stat_get_notification - Retrieves a dmub outbox notification, set up dmub notification
+ *                                  structure with message information. Also a pending bit if queue
+ *                                  is having more notifications
+ *  @dmub: dmub srv structure
+ *  @notify: dmub notification structure to be filled up
  *
- *  @brief
- *		Retrieves a dmub outbox notification, set up dmub notification
- *		structure with message information. Also a pending bit if queue
- *		is having more notifications
- *
- *  @param [in] dmub: dmub srv structure
- *  @param [out] pnotify: dmub notification structure to be filled up
- *
- *  @return
- *     dmub_status
- *****************************************************************************
+ *  Returns: dmub_status
  */
 enum dmub_status dmub_srv_stat_get_notification(struct dmub_srv *dmub,
 						struct dmub_notification *notify)
-- 
2.31.1

