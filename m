Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EE7393F60
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbhE1JJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbhE1JI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:08:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A10C061352
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:46 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n2so2610379wrm.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MgQpzbqJb+8Q9FC/kK1WOOQByL4AxzW1tN2lsosITEI=;
        b=K25Oml5n3hZ/FfnIB+F7yFT8GMAjJJV1bkeDEFqIMIr5pGD153m4F9Ba8a2n2sU3Yo
         1I3ELMEJvsclpUlEZe4TgXEGT1BXyUlC17ItNCLWa5BgiXDPgzQHxu9RRwDkufsKz8+z
         QeMI6bHOYWXe1vOigcTLLyWGK4YGpAD+Sq8I5JeY+4tobY96gWPBGR0RYxlhtupaQa3k
         IQEyzkN/ECqWOpM32KSADah8eequHoC1pC09cpXJytKqRHumgLtMOeFaZeaU0EjS21L/
         /bptGIWK+BAJrWZfMx6zA+T39XMCn2FITkQv1MRKNcbPEstzhr4vDBh5OAiAiwiuBWtT
         ztKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MgQpzbqJb+8Q9FC/kK1WOOQByL4AxzW1tN2lsosITEI=;
        b=W8TEX7g/RhJ/EyCWSzvo2/H5jNis1NkIcFm0KBgL1thMA2sDBgWeH6EYEm+rzJzBFH
         8jEC8EkHAZw/CqeETplwYiNpC7B7eH0VFqzz4oRE+NwUkMeXcDJ5k6IMaDHz4ktlM4Mp
         tDFHXiRXB4FCv6JtDs+IsJ0prX0iglYEX9Az6mmpJT7CN8GdmdwQzsugNpOs7GQB7J8u
         +39CdTADorRa3ApQOQw9yChuQ/MSfQ3S414MQJV8YeJsdXhFGronpnUJa9gPUlNtsiVx
         Pcck2nlq0M+Xxg2Kw7AOMEsSLrdZTeVS8mPlAKbG2gLmmATVchezxpPf2UvZkXnZcgyF
         +HAg==
X-Gm-Message-State: AOAM531qoPjuJSrK/7bf3B1DKM13uKDbDFChoa0d5VhbgOmoPn9E7NEo
        ioKv/DVecgD5yl6994kMgThmyg==
X-Google-Smtp-Source: ABdhPJzSWzwyd2Uc3Y1xkAJz9pkGn2drYI7YCZ32xZMiBr1sT4VyTZRQLiRhvTSy7NL20Hzlw4613Q==
X-Received: by 2002:adf:e591:: with SMTP id l17mr6540651wrm.358.1622192805157;
        Fri, 28 May 2021 02:06:45 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id m132sm6105911wmf.11.2021.05.28.02.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:06:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org
Subject: [PATCH 13/15] leds: leds-lp8860: Fix kernel-doc related formatting issues
Date:   Fri, 28 May 2021 10:06:27 +0100
Message-Id: <20210528090629.1800173-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528090629.1800173-1-lee.jones@linaro.org>
References: <20210528090629.1800173-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/leds/leds-lp8860.c:105: warning: Function parameter or member 'lock' not described in 'lp8860_led'
 drivers/leds/leds-lp8860.c:105: warning: Function parameter or member 'client' not described in 'lp8860_led'
 drivers/leds/leds-lp8860.c:105: warning: Function parameter or member 'led_dev' not described in 'lp8860_led'
 drivers/leds/leds-lp8860.c:105: warning: Function parameter or member 'regmap' not described in 'lp8860_led'
 drivers/leds/leds-lp8860.c:105: warning: Function parameter or member 'eeprom_regmap' not described in 'lp8860_led'
 drivers/leds/leds-lp8860.c:105: warning: Function parameter or member 'enable_gpio' not described in 'lp8860_led'
 drivers/leds/leds-lp8860.c:105: warning: Function parameter or member 'regulator' not described in 'lp8860_led'

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/leds/leds-lp8860.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
index f0533a337bc15..3c693d5e3b44c 100644
--- a/drivers/leds/leds-lp8860.c
+++ b/drivers/leds/leds-lp8860.c
@@ -85,14 +85,14 @@
 #define LP8860_NAME			"lp8860"
 
 /**
- * struct lp8860_led -
- * @lock - Lock for reading/writing the device
- * @client - Pointer to the I2C client
- * @led_dev - led class device pointer
- * @regmap - Devices register map
- * @eeprom_regmap - EEPROM register map
- * @enable_gpio - VDDIO/EN gpio to enable communication interface
- * @regulator - LED supply regulator pointer
+ * struct lp8860_led
+ * @lock: Lock for reading/writing the device
+ * @client: Pointer to the I2C client
+ * @led_dev: led class device pointer
+ * @regmap: Devices register map
+ * @eeprom_regmap: EEPROM register map
+ * @enable_gpio: VDDIO/EN gpio to enable communication interface
+ * @regulator: LED supply regulator pointer
  */
 struct lp8860_led {
 	struct mutex lock;
-- 
2.31.1

