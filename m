Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DC344CF24
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 02:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhKKBpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 20:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhKKBpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:45:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4B4C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 17:42:26 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c4so7074215wrd.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 17:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WN24Kgl4QZIdc8ig20qJuLoSbRFkVIP4dcbYad4hL7E=;
        b=Ulf7vX1XnSsdohLu42mU1uxO3a4fu3aIp3VOas3V8HJdPEDVHoD6AXPlOCMkfjr1Ga
         L+pccpTsq2XIE6QoeD5RIesOacs/B6olTGYOY90JF6a8tnvYlMpg5d6JH0AMfXTbt/iD
         VBeShCSVJe9zKlnWCZtS0NGOExPA7+TczDpx6vVPotQYKHCs6k2txbU1xjNv+CZqZ5i9
         imNoXMkV1RFLwO8BnVT8JH9G0Qfc0SOVWbQl+kYMAetJyt+J0ju1DXITcETwRi7QGZr0
         OeHkak8H4eKRQILVTqQZsz0nJeT2abjgL/r+f12l9c9uQlmD2TLvX2xva3GyoqVH/ECx
         Zdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WN24Kgl4QZIdc8ig20qJuLoSbRFkVIP4dcbYad4hL7E=;
        b=YWMDfsVAmznuOE2JFN1gMCRqRIjV1seG17lhA/xIUGegqBQEDfBgGIurqoRdEVrcs7
         ztm+tVTrqNRJ66i/8cFiheC+UYv4jbsnCRaANLls3kyYH1/5ZNeEt8OB0tTv1k6ZxvQJ
         wwbSCE2P6lPEXadVxJQt9/zsHwwbLtXQOxS+eN5JckC4dr+vLyBCskdkNzVnTv9VaPKt
         SC8qZ0yWKaKNIZHX9gwnG+xMnA0TYQkHTaLs+JK9+UeonLVzTd75JUgwQZd2iCYiVFIB
         sAVixTG2X+e+AgLMd3n7C0mlBi434tsdc6Z2ZPCyCwSHF9h1pL7/7tytNMyxDkm1yVqx
         vBXw==
X-Gm-Message-State: AOAM531/XFq6r0Uz/Od48E4IaAqjZnK4AKYuzNKWzaOFfsr0j3iKf9hx
        YYwZ8tbi/1jPnOnxyuwW7Qo=
X-Google-Smtp-Source: ABdhPJw85HacrYkhKlYL8AecQZJEwHkHwHlBOqXrgqNPUEZdm5sLg44p8LdMiQ8XhyqslJg34yG7/Q==
X-Received: by 2002:adf:ea51:: with SMTP id j17mr4457878wrn.421.1636594944720;
        Wed, 10 Nov 2021 17:42:24 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id m14sm2051323wrp.28.2021.11.10.17.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 17:42:24 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [RESEND PATCH] regmap: allow to define reg_update_bits for no bus configuration
Date:   Thu, 11 Nov 2021 02:41:38 +0100
Message-Id: <20211111014138.15645-1-ansuelsmth@gmail.com>
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

