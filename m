Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505873912F5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhEZIuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhEZIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C28C061349
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:58 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so8110137wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gCK0jqtaLc6j+lM4CKdqVnjdeawCrSThn6Bsjq7wZAM=;
        b=S/lbe/k94fAO1B82T5EbehOEOXJHnpj/Y7hT8SSnPoU4Kn0bBq9I2FZr6KAS/tTtC7
         kYQveIhxDKqYQ4kejsVIUXMPQZErILArnTEjQ0ZoCBODTbytq5/f/8EgGyi4bH5AAW5y
         chw+QPj8Q2+srX3qr4lkFZAUeCyqvx7haVK3T4NY4MhmthRMpfpUxdSTYsdXDmRJ7fIH
         9lfys5C8BU3v6LWAc5TzalAOgMQEaiOxOpy9ZQyIxmo2U9TZOgayi9F5n7vo+yAlYZg5
         HLcyGxafNyJErO+sLspSQqdwfeL+9U8X3vOlCfnHUoftXh7zTEvNpJy/5xianOnlz1GC
         Ssng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCK0jqtaLc6j+lM4CKdqVnjdeawCrSThn6Bsjq7wZAM=;
        b=puj89IZg6tMk2Xgj+81MwCYlekYM+F5tpHeUgg8asc+g4ab3gbQnYYMBcWk/bfLFZQ
         IhbQJgWHUfFBK1W8m3rY72mo1UEH4CDOagndfzj66zC3KvbljPH6Z5A0Jr+bzMg9d0t5
         mz8K0aZ51O5x+ela60i8aCPhj6cKTsPXsnihhbhlFtZqb7NCfY8Fp6R7HXNVavoW9fCq
         CphFpREE86KA7jpTeSmdlmXbao9ZAdbFmXMNL/pvYykxwoSmqlU7tJLz3m7qqJKEwAhh
         /WOnkaoQakEsFsxY4AQ5JnfkOFWnWEZ3N73aKBwtXrxRCdEFlMWpKuymhLwb4BVyBPch
         iCZw==
X-Gm-Message-State: AOAM533vwUs2ZgcaWCujdfDzxcRw+VROA5Nu0U1uv8H/+MIiL0TeBdhx
        KjIQ+EBQ3zU7ZkznGZ+dkaVN0Q==
X-Google-Smtp-Source: ABdhPJwJd1v1a7T0DAb2MrAEKqsloEZSJQsbA3WKSILpJ/DjbljpumEhx24mJnT73wZkKQ4M5912Dw==
X-Received: by 2002:a05:600c:21c3:: with SMTP id x3mr27065352wmj.131.1622018876689;
        Wed, 26 May 2021 01:47:56 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 25/34] drm/xlnx/zynqmp_disp: Fix incorrectly named enum 'zynqmp_disp_layer_id'
Date:   Wed, 26 May 2021 09:47:17 +0100
Message-Id: <20210526084726.552052-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/xlnx/zynqmp_disp.c:101: warning: expecting prototype for enum zynqmp_disp_id. Prototype was for enum zynqmp_disp_layer_id instead

Cc: Hyun Kwon <hyun.kwon@xilinx.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 109d627968ac0..ca1161ec9e16f 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -91,7 +91,7 @@ struct zynqmp_disp_format {
 };
 
 /**
- * enum zynqmp_disp_id - Layer identifier
+ * enum zynqmp_disp_layer_id - Layer identifier
  * @ZYNQMP_DISP_LAYER_VID: Video layer
  * @ZYNQMP_DISP_LAYER_GFX: Graphics layer
  */
-- 
2.31.1

