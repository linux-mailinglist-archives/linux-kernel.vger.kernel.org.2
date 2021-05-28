Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F91393F62
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbhE1JJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbhE1JI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:08:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CFAC061761
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j14so2534735wrq.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yz5xumMTCw+/Q8kLm3VGuNA+QWFDXuFwV3AKtQecOD4=;
        b=VlZPXHRz4mtUhK6EFAdV4cWfZhD1/6wXL+y251g6u2COSh/oiPC4DQiCD/nwzw81LX
         /EtOdips5rXPlzhb4CRe8t2MQ3iMFRkBLxqyFyk5ZjmQunm/kAXuTmlJPRFTIqnTZAoa
         niQ+p6NjzsVaARmkozu2pH09Dvf46zJLwjhLHmLLsVSSyZRC46nY6M9b0IFpnvglxNul
         ricmhsmUKdP+cOTQQVxg+qSaupqCcwugeGwSUDTeR50Ewbi9oWBq4UP/nBiT/JF7V7w/
         N21/G6HaBJ+6hT9qwHg8f32sBiwmkIGSpj3WTONGK1qwIHrgfbTpQSLNgsnC6jEQOYiz
         ssbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yz5xumMTCw+/Q8kLm3VGuNA+QWFDXuFwV3AKtQecOD4=;
        b=mNbfNshCSODsBYhodT4b9MuRnMcAdM3fk2dPXu79VW5yrQw4GYjse4Je3gH4hbMgIA
         dSw8T5r5XVg4g23y7Ts0MGtdvU/pgekjrXogJC5/CvkxrsFXKnZgP2W9a0nQ69mEx0PQ
         6+P1Z5ofLBevLJoELsfpzZJ6xucqqgG+My3nWCttAhiw5kIuc3BD7X/luaHIxlOo1NAZ
         PZYcL1ZiflJyWq2l1HMD0W/xFz//w9E1VGMdm1L+NRjpDKh1wEeUb14sm52Mwlo+CP6d
         g5RQX4LbDg5C5sxgnrH26CvPpaOg2xXZjXkHruvc/SZiuq9dbVyyZnKJo/aKBnhfcfWe
         wBMQ==
X-Gm-Message-State: AOAM532UyiZG/AIW7QqMM4GrTFfdwH04XYJksT0XdeeKYZHe7oL7ravE
        PJcqalq+QCzvAV1F6TqbL9ep7AJ0S81e6A==
X-Google-Smtp-Source: ABdhPJxP2ntsWCKWNkNn9WQ4uPZBKWXYBjDTYyMI0a2JFxpJan9l7sjiBiZv7QWPMUNrMx9finasdg==
X-Received: by 2002:a5d:490d:: with SMTP id x13mr7608915wrq.49.1622192807017;
        Fri, 28 May 2021 02:06:47 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id m132sm6105911wmf.11.2021.05.28.02.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:06:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Subject: [PATCH 15/15] leds: leds-mlxcpld: Fix a bunch of kernel-doc formatting issues
Date:   Fri, 28 May 2021 10:06:29 +0100
Message-Id: <20210528090629.1800173-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528090629.1800173-1-lee.jones@linaro.org>
References: <20210528090629.1800173-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/leds/leds-mlxcpld.c:72: warning: cannot understand function prototype: 'struct mlxcpld_param '
 drivers/leds/leds-mlxcpld.c:83: warning: cannot understand function prototype: 'struct mlxcpld_led_priv '
 drivers/leds/leds-mlxcpld.c:98: warning: cannot understand function prototype: 'struct mlxcpld_led_profile '
 drivers/leds/leds-mlxcpld.c:114: warning: cannot understand function prototype: 'struct mlxcpld_led_pdata '

Cc: Vadim Pasternak <vadimp@nvidia.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/leds/leds-mlxcpld.c | 38 ++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/leds/leds-mlxcpld.c b/drivers/leds/leds-mlxcpld.c
index f4721f8065f0f..1355c84a2919b 100644
--- a/drivers/leds/leds-mlxcpld.c
+++ b/drivers/leds/leds-mlxcpld.c
@@ -64,10 +64,10 @@
 #define MLXCPLD_LED_BLINK_6HZ		83 /* ~83 msec off/on */
 
 /**
- * mlxcpld_param - LED access parameters:
- * @offset - offset for LED access in CPLD device
- * @mask - mask for LED access in CPLD device
- * @base_color - base color code for LED
+ * struct mlxcpld_param - LED access parameters:
+ * @offset: offset for LED access in CPLD device
+ * @mask: mask for LED access in CPLD device
+ * @base_color: base color code for LED
 **/
 struct mlxcpld_param {
 	u8 offset;
@@ -76,9 +76,9 @@ struct mlxcpld_param {
 };
 
 /**
- * mlxcpld_led_priv - LED private data:
- * @cled - LED class device instance
- * @param - LED CPLD access parameters
+ * struct mlxcpld_led_priv - LED private data:
+ * @cled: LED class device instance
+ * @param: LED CPLD access parameters
 **/
 struct mlxcpld_led_priv {
 	struct led_classdev cdev;
@@ -88,12 +88,12 @@ struct mlxcpld_led_priv {
 #define cdev_to_priv(c)		container_of(c, struct mlxcpld_led_priv, cdev)
 
 /**
- * mlxcpld_led_profile - system LED profile (defined per system class):
- * @offset - offset for LED access in CPLD device
- * @mask - mask for LED access in CPLD device
- * @base_color - base color code
- * @brightness - default brightness setting (on/off)
- * @name - LED name
+ * struct mlxcpld_led_profile - system LED profile (defined per system class):
+ * @offset: offset for LED access in CPLD device
+ * @mask: mask for LED access in CPLD device
+ * @base_color: base color code
+ * @brightness: default brightness setting (on/off)
+ * @name: LED name
 **/
 struct mlxcpld_led_profile {
 	u8 offset;
@@ -104,12 +104,12 @@ struct mlxcpld_led_profile {
 };
 
 /**
- * mlxcpld_led_pdata - system LED private data
- * @pdev - platform device pointer
- * @pled - LED class device instance
- * @profile - system configuration profile
- * @num_led_instances - number of LED instances
- * @lock - device access lock
+ * struct mlxcpld_led_pdata - system LED private data
+ * @pdev: platform device pointer
+ * @pled: LED class device instance
+ * @profile: system configuration profile
+ * @num_led_instances: number of LED instances
+ * @lock: device access lock
 **/
 struct mlxcpld_led_pdata {
 	struct platform_device *pdev;
-- 
2.31.1

