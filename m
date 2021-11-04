Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4B84455F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 16:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhKDPE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhKDPE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:04:28 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFB7C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 08:01:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b15so3175151edd.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 08:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fsqqBBom1OF+pm88cC1uLEtKqdZI0w1dgvH8iUFv1Q=;
        b=iNsytnXk+7qWPr5rGdd/9ZeIoCEQ/rh2KEd9wU2QfCb4YrTbjY8VhT0MqX8qcAJf0t
         rYUdiAam74EU8AjD575mvkBJXhNOzZseyrHglg1/Gwj2NcFySf3Ox+EaHvlpByD1B+s2
         Nk9rrHrHuP0572S3y5P3/jli2mjMxTZ2se6x1jtwFnsyCz0GDSdNnrUKhAIr2EQf93rC
         dOGeWiNaBn7qLkF027ToQFOF1Ag1SfcC8SVy3HsbZcqHIzAdIOPBZz46NxhP6R6WgQ2X
         E/IBwwKrkZ3BVQVYCoPv2T3JW0BS0g3eh+MEscDguMI6bYEkJs2ER43rt1Ys5HbHSSnE
         1/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fsqqBBom1OF+pm88cC1uLEtKqdZI0w1dgvH8iUFv1Q=;
        b=Ag3VVkv3TuVXbU4fQ7HP3be8dAuxAKTOotfSRnC2TSG5iYMGLWXuByRAkE3nPzSIHW
         NiMghBR9iAsUp1bxaSkOeZipJLhBscgEk9luJ+p0KnVKP1EgmtC3CfKbu0CguEnFFnMT
         iHwT0/xs3kzHdeKREJEtiucX8twrkVkYrrWhHm3ErsAxOUXTduwjtkZfBqszKlET8Jyd
         B2PqE+cPhO3F8UKV16RQo9Upxzu/BxcojrF4taCD6S1R4pnk0+A3agTyDxg+hs0JFlqN
         r/3zg7MiUwGCiI1roQapes/+r+oBdj5O/TD+T1G8BJ4HZcyGl14a+tQoJALWb2/B8oYH
         Lsaw==
X-Gm-Message-State: AOAM530xfEAosrCdIGBM2wDpJsKXC4TfAclXpMJq+T8iopPMaCIRR1aX
        Dtps3Sz/IeDKQ8wQ/56N1e0yOGYowDo=
X-Google-Smtp-Source: ABdhPJyQQEDoX4nNoKpTSMTo7SnVBiWkRNclfCMyCVrHVvzGaHI5rRdaqNYioUu4vdm8OdKdRKuX0Q==
X-Received: by 2002:aa7:cc96:: with SMTP id p22mr70290882edt.91.1636038097773;
        Thu, 04 Nov 2021 08:01:37 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id cw20sm2668464ejc.32.2021.11.04.08.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 08:01:32 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2] regmap: allow to define reg_update_bits for no bus configuration
Date:   Thu,  4 Nov 2021 16:00:40 +0100
Message-Id: <20211104150040.1260-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some device requires a special handling for reg_update_bits and can't use
the normal regmap read write logic. An example is when locking is
handled by the device and rmw operations requires to do atomic operations.
Allow to declare a dedicated function in regmap_config for
reg_update_bits in no bus configuration.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/base/regmap/regmap.c | 1 +
 include/linux/regmap.h       | 7 +++++++
 2 files changed, 8 insertions(+)

v2:
- Drop stupid and not necessary extra condition in _regmap_update_bits.

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 21a0c2562ec0..2d74f9f82aa9 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -876,6 +876,7 @@ struct regmap *__regmap_init(struct device *dev,
 	if (!bus) {
 		map->reg_read  = config->reg_read;
 		map->reg_write = config->reg_write;
+		map->reg_update_bits = config->reg_update_bits;
 
 		map->defer_caching = false;
 		goto skip_format_initialization;
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

