Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F17E3912E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhEZItq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhEZItR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:17 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A7CC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o127so239069wmo.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y4rHhgO5kc8Uj3Lmp2tl7QIeeh0JqKynJlHlJf9HHsE=;
        b=pTKy7PwPYMsEXaJH7oJfEPlkKYTVzDOWLgysWs0lli66m1+1b9YZwKwKje1Y0AtAwS
         ua2YswIkDmK/6J5vymRUjqigKGrVmrx1BBlzlFjv1w9naTfx2iR2TVZvavFrVVgYj2NF
         p3wpU4dx+LyBifeZLRvnkkS3jlHEkeOyv9wKC7pAsi1jNzzzbH2kaflP0eULkRGHPwrO
         hWM5uSFAKWo+b7Eond1ho04GldbKOIP/ayNZubYoU4QXrOwHTY19FMoigoAk1nAwrm58
         JyiyOEjN+aAU0GiufMh6JFioygCs2IAbnM/T1taDb/VmHq2IfD4ZiKnC55QdQgE+YrrT
         8wdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y4rHhgO5kc8Uj3Lmp2tl7QIeeh0JqKynJlHlJf9HHsE=;
        b=RCXu2F+DYH/lMWNOVfLozdzZxD9F3+zIH7ob/85o7ZXYmXL0heOg9CJj4kXQuRNl9n
         YNu3FEmNqKATzP+mtmNPhgkWigRGfxov4gJCtFNDzzPm2RV1EK2WNrghwk4EIpRW60uU
         EFTOOQJtxi63GCzngOImrtb6tdnCzcQ8hCnevLAKAyVjixJ6P14apiodBmXpRlwXeZ/d
         aJfIvKzht1L0QyWLe7v6/uR/s4itjlpt1xgAvxpNcsJFuj9ErhZX1NqOkUc8AreH6fQT
         YEs8kCqDsD4THWOGL5bugoBpggCcZX2V6A/ZBdxAa4KRNHSjQ5g0PK2cQGS6TMFzJ7ia
         sNdA==
X-Gm-Message-State: AOAM5338RIfhq3uJ18/YBo7i+Kt/tUi8ngIxskb17nYMtaWOVbzX4ZBH
        l/Im0RikMg22JA+ceDWwQKBCbA==
X-Google-Smtp-Source: ABdhPJwmWlATieeB+cyUTNVhAlZSX2mheWuMR+R5VDc+yQmXYSlx5mLFXqmUAz2zy0vAKuMkWpotOw==
X-Received: by 2002:a05:600c:896:: with SMTP id l22mr28149778wmp.164.1622018864815;
        Wed, 26 May 2021 01:47:44 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:44 -0700 (PDT)
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
Subject: [PATCH 14/34] drm/amd/display/dc/gpio/gpio_service: Pass around correct dce_{version,environment} types
Date:   Wed, 26 May 2021 09:47:06 +0100
Message-Id: <20210526084726.552052-15-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/gpio_service.c: In function ‘dal_gpio_service_create’:
 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/gpio_service.c:71:4: warning: implicit conversion from ‘enum dce_version’ to ‘enum dce_environment’ [-Wenum-conversion]
 drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/gpio_service.c:77:4: warning: implicit conversion from ‘enum dce_version’ to ‘enum dce_environment’ [-Wenum-conversion]

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
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c   | 12 ++++++------
 .../drm/amd/display/include/gpio_service_interface.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index 92280cc05e2db..dae8e489c8cf4 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -53,8 +53,8 @@
  */
 
 struct gpio_service *dal_gpio_service_create(
-	enum dce_version dce_version_major,
-	enum dce_version dce_version_minor,
+	enum dce_version dce_version,
+	enum dce_environment dce_environment,
 	struct dc_context *ctx)
 {
 	struct gpio_service *service;
@@ -67,14 +67,14 @@ struct gpio_service *dal_gpio_service_create(
 		return NULL;
 	}
 
-	if (!dal_hw_translate_init(&service->translate, dce_version_major,
-			dce_version_minor)) {
+	if (!dal_hw_translate_init(&service->translate, dce_version,
+			dce_environment)) {
 		BREAK_TO_DEBUGGER();
 		goto failure_1;
 	}
 
-	if (!dal_hw_factory_init(&service->factory, dce_version_major,
-			dce_version_minor)) {
+	if (!dal_hw_factory_init(&service->factory, dce_version,
+			dce_environment)) {
 		BREAK_TO_DEBUGGER();
 		goto failure_1;
 	}
diff --git a/drivers/gpu/drm/amd/display/include/gpio_service_interface.h b/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
index 9c55d247227ea..7e3240e73c1fc 100644
--- a/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
+++ b/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
@@ -42,8 +42,8 @@ void dal_gpio_destroy(
 	struct gpio **ptr);
 
 struct gpio_service *dal_gpio_service_create(
-	enum dce_version dce_version_major,
-	enum dce_version dce_version_minor,
+	enum dce_version dce_version,
+	enum dce_environment dce_environment,
 	struct dc_context *ctx);
 
 struct gpio *dal_gpio_service_create_irq(
-- 
2.31.1

