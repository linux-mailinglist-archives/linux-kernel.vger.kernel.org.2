Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCFF4437FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhKBVof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhKBVoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:44:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDB1C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 14:41:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m14so2432928edd.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 14:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WN24Kgl4QZIdc8ig20qJuLoSbRFkVIP4dcbYad4hL7E=;
        b=M1vic/WQeJmIbPfrsF4AwDYtLbMC6GTPfiBEc4NQ6VZRgkBM38d5D3PSViamJTugcJ
         idDRKYQqUMKQYhKnnGIu9td3Ai1xeLZz21dD0j9AUxZSKli3+kwGbE7c5UN9Of9mx5bN
         T7chZx9aczjjWYT9+WZkezpGTF8KbENa+1UdaCEV+gdOcwsX6whxbbZuBA8ghn3hNdgw
         Rsn1Qh1afdUYTMmbngL4Ng7gAEydGwsq09BZCxVbFbnA3KZwAf9uyMUO4tHxutCsiO/1
         DAGLEfjjM5RLzQjP9EOkXQxd1Ow1mF7hj/rCaDlF3Kd/yqUiLvof8KxyP04W8A7Ur1iy
         dg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WN24Kgl4QZIdc8ig20qJuLoSbRFkVIP4dcbYad4hL7E=;
        b=DmE+FiiRJ5wNtPbfEUaqZlnMfalJB9qepEU9zO9oKFhsapuDcmCJvukh2wED7S5yl3
         Np1sexGn+LOOrMZF8P/vi9/IiVRrGrx+JVFmT9x6bz5DajzRj1gujcTw2LWIibLrbhn+
         5OZc5KSbWXpBoqccutd6iDIMnkJHbsxeS6o6NVpOx289mQlh+yYJLU3tR600MWJYrDJ+
         3NZB5x44MKOb+CPsKkoowWtdYq+tge08ja75mk1jJhECl4uOl1XjNXDwJOJeUAxGka/D
         a3BlZetwe1mr01Tb1nsmDJ8O2JauNwYZHisGW4BqAQB7xPVPpn9J15uT+s9Ajp+7tecb
         RORA==
X-Gm-Message-State: AOAM531Si5MAuEYj6/x3XubUjj4tMTkKoD9G0hvokq8n+euP7744aFGw
        fBBfgO1RzK9jZOmrQ/4G/HhSBg4IEBk=
X-Google-Smtp-Source: ABdhPJz/riCn73uli2Z9Znvf4To6VcLyGbErzIYY5Aysha4MB7/zkdP/kGTZhZGXG64t2pJKHLJ6Vg==
X-Received: by 2002:aa7:cac2:: with SMTP id l2mr54962660edt.168.1635889317252;
        Tue, 02 Nov 2021 14:41:57 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id p25sm120922edt.23.2021.11.02.14.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 14:41:57 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH] regmap: allow to define reg_update_bits for no bus configuration
Date:   Tue,  2 Nov 2021 22:41:38 +0100
Message-Id: <20211102214138.28873-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some device requires a special handling for reg_update_bits and can't use
the normal regmap read write logic. An example is when locking is
handled by the device and rmw operations requires to do atomic operations.
Allow to declare a special function in regmap_config for reg_update_bits
as we do with the bus config and append it to the regmap_volatile logic in
_regmap_update_bits.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/base/regmap/regmap.c | 3 ++-
 include/linux/regmap.h       | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 21a0c2562ec0..d6fcb45194b0 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -876,6 +876,7 @@ struct regmap *__regmap_init(struct device *dev,
 	if (!bus) {
 		map->reg_read  = config->reg_read;
 		map->reg_write = config->reg_write;
+		map->reg_update_bits = config->reg_update_bits;
 
 		map->defer_caching = false;
 		goto skip_format_initialization;
@@ -3064,7 +3065,7 @@ static int _regmap_update_bits(struct regmap *map, unsigned int reg,
 	if (change)
 		*change = false;
 
-	if (regmap_volatile(map, reg) && map->reg_update_bits) {
+	if ((regmap_volatile(map, reg) || !map->bus) && map->reg_update_bits) {
 		ret = map->reg_update_bits(map->bus_context, reg, mask, val);
 		if (ret == 0 && change)
 			*change = true;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index e3c9a25a853a..22652e5fbc38 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -290,6 +290,11 @@ typedef void (*regmap_unlock)(void *);
  *		  read operation on a bus such as SPI, I2C, etc. Most of the
  *		  devices do not need this.
  * @reg_write:	  Same as above for writing.
+ * @reg_update_bits: Optional callback that if filled will be used to perform
+ *		     all the update_bits(rmw) operation. Should only be provided
+ *		     if the function require special handling with lock and reg
+ *		     handling and the operation cannot be represented as a simple
+ *		     update_bits operation on a bus such as SPI, I2C, etc.
  * @fast_io:	  Register IO is fast. Use a spinlock instead of a mutex
  *	     	  to perform locking. This field is ignored if custom lock/unlock
  *	     	  functions are used (see fields lock/unlock of struct regmap_config).
@@ -372,6 +377,8 @@ struct regmap_config {
 
 	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
 	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
+	int (*reg_update_bits)(void *context, unsigned int reg,
+			       unsigned int mask, unsigned int val);
 
 	bool fast_io;
 
-- 
2.32.0

