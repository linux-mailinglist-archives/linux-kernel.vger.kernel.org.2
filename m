Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9023B393F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbhE1JI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbhE1JIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:08:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91506C06134F
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r13so1207248wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B561knCm3hMdwiY1zEm2fk2A2w3U3tZY38Y+WeeFnKA=;
        b=ORxRl4HqzfacHOjojVZ6eUN7HB/IbfDkpH80yFSWIcdvebHO7mRzr668pDtgbjdwqt
         zTgQNWdQbDjl0yT+DdsuWcVuvqXeNd2V8Il6g9nHU71IKaUOvnUUeDsbbt1UX4kx086O
         OSUMcULAT3essaJkrtjJ5DIBF0xkkU9iwwYCyO7kSENJS8lv3NfewQNwR8DviaRrK1b7
         aVHleD2WTGkv/vUTNrIaqZmt2r224o4AVxbmlAOTkGC623qoI5qKg4S1WPKmMxJNXak2
         7TC0knhtAac7HgluAz0DrqQhC7T7/LT2wv/r51PrHeHlb/Q2jc4YOhqjNguTLJjOsoTv
         M8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B561knCm3hMdwiY1zEm2fk2A2w3U3tZY38Y+WeeFnKA=;
        b=doqTMFmXgx3J3CNAU/6jaRuMH6rGpaONXAWr7arkSXJ/G2B+F0dTw/2vJDOHlyDxCX
         0Rym6LBUibjZ4G8idk62+oUhNE4FCK9oOVMCYQRsryFbHNFuSTt2DPqM8xAwGw4nQw/c
         mLzEim4ry5M5vvOgYYUVLXCHxgH9yzObzNHyPbbFfj8xMi6sk8e5E6obkxhDLtzoVY3J
         JWG2oJFUIOQmhaKPWAS7ehPBttLZPGwVecyfGOGu9qMYecx4OZUsuquiMURubJydwqC4
         vc4oQ3kEqdWDIzYbk+TFPb+rDKmrFF3hMyHKlE5M+Jd0MG3jhcQ8kXXgdPGpsRvm12Bg
         WDig==
X-Gm-Message-State: AOAM532YwU5uge3Yewk71oOhgwznur/Lw3Pema5QyqMmIvLmWYQqalai
        sOfG6vyWZefi5No4paWffPyCiA==
X-Google-Smtp-Source: ABdhPJz7UMO2xLrq/Vja5cE9p63QATYwK9oVKC1Wi5gov6OPckDFHSvZGHUS7z+xTpN7Dly34oCtfw==
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr12604476wmq.48.1622192802227;
        Fri, 28 May 2021 02:06:42 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id m132sm6105911wmf.11.2021.05.28.02.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:06:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org
Subject: [PATCH 10/15] leds: leds-lm3692x: Fix some kernel-doc formatting issues
Date:   Fri, 28 May 2021 10:06:24 +0100
Message-Id: <20210528090629.1800173-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528090629.1800173-1-lee.jones@linaro.org>
References: <20210528090629.1800173-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/leds/leds-lm3692x.c:121: warning: Function parameter or member 'lock' not described in 'lm3692x_led'
 drivers/leds/leds-lm3692x.c:121: warning: Function parameter or member 'client' not described in 'lm3692x_led'
 drivers/leds/leds-lm3692x.c:121: warning: Function parameter or member 'led_dev' not described in 'lm3692x_led'
 drivers/leds/leds-lm3692x.c:121: warning: Function parameter or member 'regmap' not described in 'lm3692x_led'
 drivers/leds/leds-lm3692x.c:121: warning: Function parameter or member 'enable_gpio' not described in 'lm3692x_led'
 drivers/leds/leds-lm3692x.c:121: warning: Function parameter or member 'regulator' not described in 'lm3692x_led'
 drivers/leds/leds-lm3692x.c:121: warning: Function parameter or member 'led_enable' not described in 'lm3692x_led'
 drivers/leds/leds-lm3692x.c:121: warning: Function parameter or member 'model_id' not described in 'lm3692x_led'
 drivers/leds/leds-lm3692x.c:121: warning: Function parameter or member 'boost_ctrl' not described in 'lm3692x_led'
 drivers/leds/leds-lm3692x.c:121: warning: Function parameter or member 'brightness_ctrl' not described in 'lm3692x_led'
 drivers/leds/leds-lm3692x.c:121: warning: Function parameter or member 'enabled' not described in 'lm3692x_led'

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/leds/leds-lm3692x.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index e945de45388ca..a2ab6bd5de111 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -96,15 +96,15 @@
 #define LM3692X_FAULT_FLAG_OPEN BIT(4)
 
 /**
- * struct lm3692x_led -
- * @lock - Lock for reading/writing the device
- * @client - Pointer to the I2C client
- * @led_dev - LED class device pointer
- * @regmap - Devices register map
- * @enable_gpio - VDDIO/EN gpio to enable communication interface
- * @regulator - LED supply regulator pointer
- * @led_enable - LED sync to be enabled
- * @model_id - Current device model ID enumerated
+ * struct lm3692x_led
+ * @lock: Lock for reading/writing the device
+ * @client: Pointer to the I2C client
+ * @led_dev: LED class device pointer
+ * @regmap: Devices register map
+ * @enable_gpio: VDDIO/EN gpio to enable communication interface
+ * @regulator: LED supply regulator pointer
+ * @led_enable: LED sync to be enabled
+ * @model_id: Current device model ID enumerated
  */
 struct lm3692x_led {
 	struct mutex lock;
-- 
2.31.1

