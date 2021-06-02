Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6718398CFB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhFBOf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhFBOfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:35:13 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3D8C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 07:33:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h8so2527212wrz.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AV8ypLVFqPQaG8ImkTPidzOwU8OZuMCnDE642RmrYdM=;
        b=p3+jsdMrgcaJkJnXd2tptd14Mk1isNUcDV4LXBYeZFHXMeFmYoBo2PZjh5bUHprvBq
         amccJeNF6hAUYrfLing1CDMI1lReu7p2/ZAPfNGglUqM+2Rosu78ZD4ZV2ViNAIQScMe
         wcJ6ppFXrlweNftZsGxihOEpbqUhKj9zZ+SBmXx8WlKP35h3ApyUFlHv1WuX4/aRYecr
         UusaQA09LCi1+W2zmLQxxNfnPYNx3oYZ87WeKqo4H2PsuuzWCEMdq/OBUnTDjCAaWYIC
         hDz0pDtBIqho0/CX2qKIHMxLUYwUoQVRYTGzccznsPwNZV5ctCqhoRsYdfJ3+rB2OCNV
         oDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AV8ypLVFqPQaG8ImkTPidzOwU8OZuMCnDE642RmrYdM=;
        b=NNg3AAlORmoUKWbU60p4ObMbbMWnhNk9uqPyopwdGdeuXqzNqn2mQMflICQA6BHDla
         eHe7eCZZZDJbrGGH9otnMNp7shCeRVnT3LG2dnSRg7e3/PUwwqag9MD0xYZm4ipw7VPl
         sTDSbRwPEGBYHBa83j+c1WoecXV8SaVF86DC/wiW3modC7yQYSmR89AYSzl1nxzaXzEj
         urpM9Z/SV6CLe3x5J/C6viuUDZhKsbAVzWZC90RC59nFNIJzCHBMDzJCuoZdj6Ny5DVa
         YyUdZtJuXpt5XHkjQoUOT6eTeS0u+QcqSz0x4qMqGQZY+WlyXYAzjM2imwQc5tUq4xf5
         rLjQ==
X-Gm-Message-State: AOAM531YAewZBE6wHcmzc7RhV04TIRALrTTcqQ6A4Gvm7scQ9Tpq2/Ye
        v98quJqsq4VCYry+9FnuditCXGJo/pry2g==
X-Google-Smtp-Source: ABdhPJxv8/tXnt3jZGpEevkz+eyTG2Mxqu7ZVtAd/LSIfmLkLKLboeHduLpBdhMqhKvTfjt1eKrKQA==
X-Received: by 2002:a5d:5049:: with SMTP id h9mr23002280wrt.221.1622644396475;
        Wed, 02 Jun 2021 07:33:16 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org
Subject: [RESEND 07/26] drm/sti/sti_tvout: Provide a bunch of missing function names
Date:   Wed,  2 Jun 2021 15:32:41 +0100
Message-Id: <20210602143300.2330146-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/sti/sti_tvout.c:166: warning: expecting prototype for Set the clipping mode of a VIP(). Prototype was for tvout_vip_set_color_order() instead
 drivers/gpu/drm/sti/sti_tvout.c:187: warning: expecting prototype for Set the clipping mode of a VIP(). Prototype was for tvout_vip_set_clip_mode() instead
 drivers/gpu/drm/sti/sti_tvout.c:203: warning: expecting prototype for Set the rounded value of a VIP(). Prototype was for tvout_vip_set_rnd() instead
 drivers/gpu/drm/sti/sti_tvout.c:223: warning: expecting prototype for Select the VIP input(). Prototype was for tvout_vip_set_sel_input() instead
 drivers/gpu/drm/sti/sti_tvout.c:258: warning: expecting prototype for Select the input video signed or unsigned(). Prototype was for tvout_vip_set_in_vid_fmt() instead
 drivers/gpu/drm/sti/sti_tvout.c:274: warning: expecting prototype for Set preformatter matrix(). Prototype was for tvout_preformatter_set_matrix() instead
 drivers/gpu/drm/sti/sti_tvout.c:299: warning: expecting prototype for Start VIP block for DVO output(). Prototype was for tvout_dvo_start() instead
 drivers/gpu/drm/sti/sti_tvout.c:353: warning: expecting prototype for Start VIP block for HDMI output(). Prototype was for tvout_hdmi_start() instead
 drivers/gpu/drm/sti/sti_tvout.c:402: warning: expecting prototype for Start HDF VIP and HD DAC(). Prototype was for tvout_hda_start() instead

Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vincent Abriou <vincent.abriou@st.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/sti/sti_tvout.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_tvout.c
index df3817f0fd302..2499715a69b79 100644
--- a/drivers/gpu/drm/sti/sti_tvout.c
+++ b/drivers/gpu/drm/sti/sti_tvout.c
@@ -153,7 +153,7 @@ static void tvout_write(struct sti_tvout *tvout, u32 val, int offset)
 }
 
 /**
- * Set the clipping mode of a VIP
+ * tvout_vip_set_color_order - Set the clipping mode of a VIP
  *
  * @tvout: tvout structure
  * @reg: register to set
@@ -177,7 +177,7 @@ static void tvout_vip_set_color_order(struct sti_tvout *tvout, int reg,
 }
 
 /**
- * Set the clipping mode of a VIP
+ * tvout_vip_set_clip_mode - Set the clipping mode of a VIP
  *
  * @tvout: tvout structure
  * @reg: register to set
@@ -193,7 +193,7 @@ static void tvout_vip_set_clip_mode(struct sti_tvout *tvout, int reg, u32 range)
 }
 
 /**
- * Set the rounded value of a VIP
+ * tvout_vip_set_rnd - Set the rounded value of a VIP
  *
  * @tvout: tvout structure
  * @reg: register to set
@@ -209,7 +209,7 @@ static void tvout_vip_set_rnd(struct sti_tvout *tvout, int reg, u32 rnd)
 }
 
 /**
- * Select the VIP input
+ * tvout_vip_set_sel_input - Select the VIP input
  *
  * @tvout: tvout structure
  * @reg: register to set
@@ -247,7 +247,7 @@ static void tvout_vip_set_sel_input(struct sti_tvout *tvout,
 }
 
 /**
- * Select the input video signed or unsigned
+ * tvout_vip_set_in_vid_fmt - Select the input video signed or unsigned
  *
  * @tvout: tvout structure
  * @reg: register to set
@@ -264,7 +264,7 @@ static void tvout_vip_set_in_vid_fmt(struct sti_tvout *tvout,
 }
 
 /**
- * Set preformatter matrix
+ * tvout_preformatter_set_matrix - Set preformatter matrix
  *
  * @tvout: tvout structure
  * @mode: display mode structure
@@ -289,7 +289,7 @@ static void tvout_preformatter_set_matrix(struct sti_tvout *tvout,
 }
 
 /**
- * Start VIP block for DVO output
+ * tvout_dvo_start - Start VIP block for DVO output
  *
  * @tvout: pointer on tvout structure
  * @main_path: true if main path has to be used in the vip configuration
@@ -343,7 +343,7 @@ static void tvout_dvo_start(struct sti_tvout *tvout, bool main_path)
 }
 
 /**
- * Start VIP block for HDMI output
+ * tvout_hdmi_start - Start VIP block for HDMI output
  *
  * @tvout: pointer on tvout structure
  * @main_path: true if main path has to be used in the vip configuration
@@ -392,7 +392,7 @@ static void tvout_hdmi_start(struct sti_tvout *tvout, bool main_path)
 }
 
 /**
- * Start HDF VIP and HD DAC
+ * tvout_hda_start - Start HDF VIP and HD DAC
  *
  * @tvout: pointer on tvout structure
  * @main_path: true if main path has to be used in the vip configuration
-- 
2.31.1

