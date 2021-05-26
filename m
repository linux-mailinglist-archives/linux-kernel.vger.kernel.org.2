Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490DF3912BA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhEZItM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbhEZItG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE40CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n4so222809wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G7iaDAB2ZuYVyZx68crg6QhzsOg2OHh06HlhEV13AEw=;
        b=I44CIXDqN65PoObP1/rnC7UjnZafXPh+DuBi0Kq2AWIMOpWajEcw78rMhgD/TBi7oB
         wQgH4fcGxdTk4hb1J/Z9fSCeumJdhs0xsuW5LIMQKFUtFdY6YpqGYGgty7pr46KVg5ny
         7q7Ea6E5YIAanyRZeCH40+Ipeq7NKd9LXLVQX7/ckkNe4lhcSsJTgZleDyj3sBvKcyYo
         X0Ssu4Uq4x6S4+g6/RC+pZsBe3yvR/6OjXnGTRdRkX9fK+pU9iexVjgDaBKyrtm/HJr/
         t0cXJxRJSOAnFQ9RPkc78nW8/5+Y4ZSP0fA51KvYlXl2dd/6gFl+keus84Ue65vf6oO8
         IYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7iaDAB2ZuYVyZx68crg6QhzsOg2OHh06HlhEV13AEw=;
        b=K/WEhJJMiw4vQ+C6tNDyqgTpdlNkZlkljHFG6zfG4TfnB13KAMvED59ep1GWwiA1TF
         53whABlSTT4Tlzbjp3UuDBilhfwHxZNGE+nEDGeFpsfJb29JgamT4hr5PAXilEW8SJWW
         Zy38XO/yyVxP+beJQiiwEN68iR+9caXkBTtQdoomZilsaUgekq3hXaVgZSuQ8zVXQyGZ
         IHATtnPlshLxq1OuCL7NSjCIO2cRJrefTwBk8Py/eeaUOHfu9G7mN7GIZVtetVADSaDR
         Ad4Cms6MVO7EHNqZ6hUb/WeJ4e/sK5gGNU3Pk+T+Ioftf+OVttDY1Qax7ptOhkU+dZBL
         jEJw==
X-Gm-Message-State: AOAM532ut8R/yzeLOhAB1bynYwX1dtse96GSgziPiVuOzsG+yAIljgZ7
        LNJjKVxssaI68NnPpQs1I47vLA==
X-Google-Smtp-Source: ABdhPJyISrVWreIUVorPlzyIi2UoKk92HM0mafCSCAAuFnhn6pcE2wxasr0XIJ9wDl0RbS9Aht9XuQ==
X-Received: by 2002:a5d:52ce:: with SMTP id r14mr17258203wrv.395.1622018853569;
        Wed, 26 May 2021 01:47:33 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 03/34] drm/amd/pm/powerplay/hwmgr/smu7_thermal: Provide function name for 'smu7_fan_ctrl_set_default_mode()'
Date:   Wed, 26 May 2021 09:46:55 +0100
Message-Id: <20210526084726.552052-4-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:132: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
index 0d38d4206848a..6cfe148ed45bb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
@@ -129,10 +129,10 @@ int smu7_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
 }
 
 /**
-* Reset Fan Speed Control to default mode.
-* @hwmgr:  the address of the powerplay hardware manager.
-* Exception: Should always succeed.
-*/
+ * smu7_fan_ctrl_set_default_mode - Reset Fan Speed Control to default mode.
+ * @hwmgr:  the address of the powerplay hardware manager.
+ * Exception: Should always succeed.
+ */
 int smu7_fan_ctrl_set_default_mode(struct pp_hwmgr *hwmgr)
 {
 	if (!hwmgr->fan_ctrl_is_in_default_mode) {
-- 
2.31.1

