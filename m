Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7785D3912EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhEZIuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbhEZIt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06661C061346
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x8so184722wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zQBHzs8bUaTq312vSS5VlkiBcTZpiBpI37cda1Zuvw=;
        b=UYtZk9Vp8FVe1rY6Ub1SdN2wtVTZoiQfb1OhbnN4uLhKytekELKH71HLthvfaEEBMv
         wBIa/HxlnMC/sO10tzKeNoWt/ywjW06knZiDtCEVvOJXP3GjgFeCGsU+g9bXcJsaQn//
         Vc1DynqHbRBauWzVeIg1c5RZOgmjN9sfZv6lrByDjqxkdtSi169CuIVPeGtXEdLospw6
         SwPcfZgQAz6smSpgvagmsFqAQwuZMUUhNAH4TGMj+Ee1bPlv7RADSi3mlU56zfRspTCD
         s/HwXup2wyf51Vbr455hzBeyzl6GzjAbR3I4/eIyvyWQ9iCzvPPFgN+trC6H456n4pdt
         4UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zQBHzs8bUaTq312vSS5VlkiBcTZpiBpI37cda1Zuvw=;
        b=NIdkPsdgXqxc7ZKr/VvzHMxZI7kQxDwGuqF89zufrCR4+mRpOkWa4VV/GPQKaTr+Wd
         AmRwvqhHqYD4RnUuf8TdVcIF3ajFo0QHx4HXw+0flBr9JQ5wjElrSI4qWI43xOIuVWfD
         NS9CXBS4UqPoAZUu8p/9IiAUplxiaVqUnyVyMWNLI2ohNbT04NfS4CD98CX296bHs61B
         CCVUz8aSfJY5fS70rfNzA6Drv+mTMbJQ9Kx1nOWrBFL994aJsJYA0zsD1fDFqPgk5fis
         DQJ2lI7mifLe7uxKQCFvFWZhtbl1sQDOOUdL47kn34hkIMbLwIWVxsPeZAcGYNkD7jJZ
         qcLw==
X-Gm-Message-State: AOAM5316wY2G1PWco27xnnxLs7fxPomaDY+O7tZCqTwIIcjIcU0dJ0QZ
        1P31dmb3HeQ8wGixSuMWIG78GQ==
X-Google-Smtp-Source: ABdhPJwyM9q2L9wpp27S/zlBOBO4M2Oi04r375BiI90Tc7cDBIN5mL6gA3bcyKIjSdVdtrVg29ksqQ==
X-Received: by 2002:a5d:45c6:: with SMTP id b6mr31627763wrs.333.1622018873564;
        Wed, 26 May 2021 01:47:53 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:53 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 22/34] drm/amd/display/dc/core/dc: Convert function headers to kernel-doc
Date:   Wed, 26 May 2021 09:47:14 +0100
Message-Id: <20210526084726.552052-23-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3324: warning: Cannot understand  *****************************************************************************
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3344: warning: Cannot understand  *****************************************************************************
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3417: warning: Cannot understand  *****************************************************************************

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 46 ++++++------------------
 1 file changed, 11 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ef157b83bacd2..34c207f92df98 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3335,18 +3335,10 @@ void dc_hardware_release(struct dc *dc)
 #endif
 
 /**
- *****************************************************************************
- *  Function: dc_enable_dmub_notifications
+ * dc_enable_dmub_notifications - Returns whether dmub notification can be enabled
+ * @dc: dc structure
  *
- *  @brief
- *		Returns whether dmub notification can be enabled
- *
- *  @param
- *		[in] dc: dc structure
- *
- *	@return
- *		True to enable dmub notifications, False otherwise
- *****************************************************************************
+ * Returns: True to enable dmub notifications, False otherwise
  */
 bool dc_enable_dmub_notifications(struct dc *dc)
 {
@@ -3355,21 +3347,13 @@ bool dc_enable_dmub_notifications(struct dc *dc)
 }
 
 /**
- *****************************************************************************
- *  Function: dc_process_dmub_aux_transfer_async
- *
- *  @brief
- *		Submits aux command to dmub via inbox message
- *		Sets port index appropriately for legacy DDC
- *
- *  @param
- *		[in] dc: dc structure
- *		[in] link_index: link index
- *		[in] payload: aux payload
+ * dc_process_dmub_aux_transfer_async - Submits aux command to dmub via inbox message
+ *                                      Sets port index appropriately for legacy DDC
+ * @dc: dc structure
+ * @link_index: link index
+ * @payload: aux payload
  *
- *	@return
- *		True if successful, False if failure
- *****************************************************************************
+ * Returns: True if successful, False if failure
  */
 bool dc_process_dmub_aux_transfer_async(struct dc *dc,
 				uint32_t link_index,
@@ -3428,16 +3412,8 @@ bool dc_process_dmub_aux_transfer_async(struct dc *dc,
 }
 
 /**
- *****************************************************************************
- *  Function: dc_disable_accelerated_mode
- *
- *  @brief
- *		disable accelerated mode
- *
- *  @param
- *		[in] dc: dc structure
- *
- *****************************************************************************
+ * dc_disable_accelerated_mode - disable accelerated mode
+ * @dc: dc structure
  */
 void dc_disable_accelerated_mode(struct dc *dc)
 {
-- 
2.31.1

