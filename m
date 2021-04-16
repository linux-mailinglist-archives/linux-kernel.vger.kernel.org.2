Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70833622F7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244985AbhDPOlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244589AbhDPOiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F19BC061359
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:12 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id mh2so20938568ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9wjRJ3K6gEJWw7cmRlm1PWa18kr/G6l9t1XfKeR5i0=;
        b=hsB6bda4PBPLddVEBDk0vz5lUc3uon7c5uczoWgeIVSXi6HGmocnf3hJ3J13pM4afH
         hFR8QMsXah3FZwP4gROY/5i0pujiWAdJtP4BfvAk1xqq7KVZcbyGzzsKGuIwotI/T6Ap
         Kky9Zzseqo688VrTBA5uGnRJnH3FXLykl4s8gRJlkCIZjjqCkYqUhevHh+Avgp/Bs9xV
         7S8aBaTrqBpGI5tq3XE7PStwvaQgqMbeTxsibvxDDohT1nypFcIO3lUfHFowvFwmxU3o
         nWrfZhB4GZwUA6DAG+kBo3BvtShUJeyTDS6LHRHu3DeZayPj0TDExB8LHQoXaL0z/9hq
         sAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9wjRJ3K6gEJWw7cmRlm1PWa18kr/G6l9t1XfKeR5i0=;
        b=YY0lzbSTzQinzhpVhRiYggqGV1X3AfQ9uZkZpJrDz5rMeP7gzG0nFtCK743Zh0ewd8
         zB+15RPZjZWZPCYx9s9mOKewZFjKUm5nhZobeyiqEd4mn2HYVmtN2SpY08P0UKvzCkia
         Aw3CmObQNhV/ymuRZI2fU7af0vT4DFXuXjGSpbK62zG/kr4LAkSnAY/OHL+fZxW2a8e4
         ZCpQ2qTH2tQLHMFvXDkJZmlhI3kRGaFz0CHYEGTBwPPKWRz43X1Jj6hfWhXQV8vrEGui
         VEiYWKoJCr0GrctLeNOWwjFiMD9Dvx53pJ+x4xpBKommVBOnPUt1w6vjG/OpbkamkBbl
         8uZg==
X-Gm-Message-State: AOAM530jTMIo6+olln+XB4vfRQ/K2R/HXpbOi3Wi5gnW9Ik3VfCthgdO
        ebZFncfDZ4+obYWl2dxafSJbTg==
X-Google-Smtp-Source: ABdhPJyu162ulu0SvfYCwjPDNoMz4ehF0YKxWNjcaeHrMN7tLesqEuNfuMeh0cHl6rXVzMJImkpgsQ==
X-Received: by 2002:a17:906:c218:: with SMTP id d24mr8348994ejz.363.1618583891366;
        Fri, 16 Apr 2021 07:38:11 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:38:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 39/40] drm/sti/sti_hdmi: Provide kernel-doc headers with function names
Date:   Fri, 16 Apr 2021 15:37:24 +0100
Message-Id: <20210416143725.2769053-40-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/sti/sti_hdmi.c:193: warning: expecting prototype for HDMI interrupt handler threaded(). Prototype was for hdmi_irq_thread() instead
 drivers/gpu/drm/sti/sti_hdmi.c:225: warning: expecting prototype for HDMI interrupt handler(). Prototype was for hdmi_irq() instead
 drivers/gpu/drm/sti/sti_hdmi.c:246: warning: expecting prototype for Set hdmi active area depending on the drm display mode selected(). Prototype was for hdmi_active_area() instead
 drivers/gpu/drm/sti/sti_hdmi.c:267: warning: expecting prototype for Overall hdmi configuration(). Prototype was for hdmi_config() instead
 drivers/gpu/drm/sti/sti_hdmi.c:346: warning: expecting prototype for Helper to concatenate infoframe in 32 bits word(). Prototype was for hdmi_infoframe_subpack() instead
 drivers/gpu/drm/sti/sti_hdmi.c:366: warning: expecting prototype for Helper to write info frame(). Prototype was for hdmi_infoframe_write_infopack() instead
 drivers/gpu/drm/sti/sti_hdmi.c:438: warning: expecting prototype for Prepare and configure the AVI infoframe(). Prototype was for hdmi_avi_infoframe_config() instead
 drivers/gpu/drm/sti/sti_hdmi.c:481: warning: expecting prototype for Prepare and configure the AUDIO infoframe(). Prototype was for hdmi_audio_infoframe_config() instead
 drivers/gpu/drm/sti/sti_hdmi.c:561: warning: expecting prototype for Software reset of the hdmi subsystem(). Prototype was for hdmi_swreset() instead

Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vincent Abriou <vincent.abriou@st.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index f3ace11209dd7..dd5a388898e79 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -184,7 +184,7 @@ void hdmi_write(struct sti_hdmi *hdmi, u32 val, int offset)
 }
 
 /**
- * HDMI interrupt handler threaded
+ * hdmi_irq_thread - HDMI interrupt handler threaded
  *
  * @irq: irq number
  * @arg: connector structure
@@ -216,7 +216,7 @@ static irqreturn_t hdmi_irq_thread(int irq, void *arg)
 }
 
 /**
- * HDMI interrupt handler
+ * hdmi_irq - HDMI interrupt handler
  *
  * @irq: irq number
  * @arg: connector structure
@@ -238,7 +238,7 @@ static irqreturn_t hdmi_irq(int irq, void *arg)
 }
 
 /**
- * Set hdmi active area depending on the drm display mode selected
+ * hdmi_active_area - Set hdmi active area depending on the drm display mode selected
  *
  * @hdmi: pointer on the hdmi internal structure
  */
@@ -259,7 +259,7 @@ static void hdmi_active_area(struct sti_hdmi *hdmi)
 }
 
 /**
- * Overall hdmi configuration
+ * hdmi_config - Overall hdmi configuration
  *
  * @hdmi: pointer on the hdmi internal structure
  */
@@ -337,7 +337,7 @@ static void hdmi_infoframe_reset(struct sti_hdmi *hdmi,
 }
 
 /**
- * Helper to concatenate infoframe in 32 bits word
+ * hdmi_infoframe_subpack - Helper to concatenate infoframe in 32 bits word
  *
  * @ptr: pointer on the hdmi internal structure
  * @size: size to write
@@ -354,7 +354,7 @@ static inline unsigned int hdmi_infoframe_subpack(const u8 *ptr, size_t size)
 }
 
 /**
- * Helper to write info frame
+ * hdmi_infoframe_write_infopack - Helper to write info frame
  *
  * @hdmi: pointer on the hdmi internal structure
  * @data: infoframe to write
@@ -424,7 +424,7 @@ static void hdmi_infoframe_write_infopack(struct sti_hdmi *hdmi,
 }
 
 /**
- * Prepare and configure the AVI infoframe
+ * hdmi_avi_infoframe_config - Prepare and configure the AVI infoframe
  *
  * AVI infoframe are transmitted at least once per two video field and
  * contains information about HDMI transmission mode such as color space,
@@ -467,7 +467,7 @@ static int hdmi_avi_infoframe_config(struct sti_hdmi *hdmi)
 }
 
 /**
- * Prepare and configure the AUDIO infoframe
+ * hdmi_audio_infoframe_config - Prepare and configure the AUDIO infoframe
  *
  * AUDIO infoframe are transmitted once per frame and
  * contains information about HDMI transmission mode such as audio codec,
@@ -552,7 +552,7 @@ static int hdmi_vendor_infoframe_config(struct sti_hdmi *hdmi)
 #define HDMI_TIMEOUT_SWRESET  100   /*milliseconds */
 
 /**
- * Software reset of the hdmi subsystem
+ * hdmi_swreset - Software reset of the hdmi subsystem
  *
  * @hdmi: pointer on the hdmi internal structure
  *
-- 
2.27.0

