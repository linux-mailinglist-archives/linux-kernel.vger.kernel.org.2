Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60E83912C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbhEZItS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbhEZItI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA898C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z17so198053wrq.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKeBwQNxcs7ocYKzN7a4O8oaRQu8Cp6t2SySVOZEvJc=;
        b=XOJIerymun8QzB6XXP5wNjsVJygRfMn2bCBX9V9gUfDFMpm25kLTV3EO44NAoo2j5i
         3iSfQk+RtozfLSE0bhk6MeGJ4vV9gQUIcIUOnkztB3q+u6z3oOYlQMoiGMHpN5FJN6w+
         FJx6hQchMJlsPYYhAVlbBncVfoyFjoUOMTQPJ8OT7dIVoQidhzO6Ll+gpXM24TD2tcMj
         EnXiVSmwBuz5TtNVx4MQrvi3cETPA8jpmfUKM1fWQGxom9/PgKjui7Y+fL6dEUstAtMg
         YmxmvEkwUJ5ku14LxFPHGLrMrqg3+wzlam2x+s8tVWPneDACFWNYdsAdduDGQ1mqPxMZ
         J7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKeBwQNxcs7ocYKzN7a4O8oaRQu8Cp6t2SySVOZEvJc=;
        b=dIlm0tqacarDwgHACXa3G1aLO49OgBM8PnERRGCT64T0Cqp6uQSNhC0r+3nSIqBG09
         Z44/TO37hQT0U1PxlyXGbz4T+9l4cg+bYC/3QqxlvBZRrtlwubsJg55M09okh3jEQIWk
         2NMNWaRoiZ+uSlU37egYRC4P8cxOfQvmC1GoTK6zZTOOypQz12V8fw1MO0P8oUAAfoy2
         LZrwXwaic7ihSnRvMP0PuwHrftbWAVO03gAZT9akA2c/YeUBHZZOj9b+m/4BstPZGfu1
         KOUNootHiFrxWy9y3brdiQvRcy2iRWM6oV1aGeTGbDaePzfTzwlT230QFjoIILmdC9IE
         N7Fg==
X-Gm-Message-State: AOAM532ABs8Pb+wba5CWfWs6/olZmAwQIQVwpCOwEgKV9NGUivAXe33b
        a7zFldcu/ciRAe5R1dPrZpOk9w==
X-Google-Smtp-Source: ABdhPJy/h/7qOMA8yJfz6iMHcuzoO5CwW7Hw3FnfBC/SrmnqXEESL7RSx5gJYYaar6l8ipNBfQNyYA==
X-Received: by 2002:a05:6000:1189:: with SMTP id g9mr31168739wrx.385.1622018855535;
        Wed, 26 May 2021 01:47:35 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 05/34] drm/amd/pm/powerplay/hwmgr/vega12_hwmgr: Provide 'vega12_init_smc_table()' function name
Date:   Wed, 26 May 2021 09:46:57 +0100
Message-Id: <20210526084726.552052-6-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_hwmgr.c:812: warning: expecting prototype for Initializes the SMC table and uploads it(). Prototype was for vega12_init_smc_table() instead

Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 1a097e608808e..29e0d1d4035ad 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -803,7 +803,7 @@ static int vega12_save_default_power_profile(struct pp_hwmgr *hwmgr)
 #endif
 
 /**
- * Initializes the SMC table and uploads it
+ * vega12_init_smc_table - Initializes the SMC table and uploads it
  *
  * @hwmgr:  the address of the powerplay hardware manager.
  * return:  always 0
-- 
2.31.1

