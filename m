Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2712319AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 09:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhBLIBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 03:01:17 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:33823 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhBLIBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 03:01:14 -0500
Received: by mail-lj1-f182.google.com with SMTP id r23so10573208ljh.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 00:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=yPYj2lYXmsj9W+mRRHZb7R031SjCFkl+yjijgD0R8/A=;
        b=tDW+n8vdWEuOIkVL0bLmWmoRLiV+NwXxGIEJLrWhtNlRgD5nu693BU2TqPYFAAPZH7
         IumwF5aMh5kiK6PVCrBxl4WpbKxwIXiFtjWfUPLIIC8mYRBbpuOD+WRR+0KH1HuqZmq9
         tF2vRKCwuqqfE8uxIBBZ4kzd/iMaVhFXO/I4KByV6H4str4jcSZ7e7iK7QciA7eyM2AC
         LuaBlyC332bqBh4ebTHejD3MEaoC442hBOgru7uOBAh5/7mKuSvEf7p1yBVKleBfXxcF
         SS6S7HlBPV615HfxuEYK0xVGpJFtFcu3J5enACXndQNUGD9tPTFws8Cl9tyhzQqbP3vL
         8uqA==
X-Gm-Message-State: AOAM532t1y+iyZOmriihcKnU6AY9ySbaKwPeIiY+/NmXcX2HPMQUQ50O
        tgL3ysHq4mU491BUecWhbG8=
X-Google-Smtp-Source: ABdhPJw3e10dAeOPhx7cD2PTjYKRgQtpQ0cdRKSnGHMUZIxYXFZLoUSK959GFFpp0eKlHekDiST1Iw==
X-Received: by 2002:a2e:a40e:: with SMTP id p14mr1034118ljn.390.1613116831462;
        Fri, 12 Feb 2021 00:00:31 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id a1sm1218140lji.22.2021.02.12.00.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 00:00:30 -0800 (PST)
Date:   Fri, 12 Feb 2021 10:00:23 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-power@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] regulator: bd718x7, bd71828, Fix dvs voltage levels
Message-ID: <20210212080023.GA880728@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ROHM BD718x7 and BD71828 drivers support setting HW state
specific voltages from device-tree. This is used also by various
in-tree DTS files.

These drivers do incorrectly try to compose bit-map using enum
values. By a chance this works for first two valid levels having
values 1 and 2 - but setting values for the rest of the levels
do indicate capability of setting values for first levels as
well. Luckily the regulators which support setting values for
SUSPEND/LPSR do usually also support setting values for RUN
and IDLE too - thus this has not been such a fatal issue.

Fix this by defining the old enum values as bits and fixing the
parsing code. This allows keeping existing IC specific drivers
intact and only slightly changing the rohm-regulator.c

Fixes: 21b72156ede8b ("regulator: bd718x7: Split driver to common and bd718x7 specific parts")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

I just noticed this fix never made it in-tree. So this is a resend of a
resend :)

 drivers/regulator/rohm-regulator.c |  9 ++++++---
 include/linux/mfd/rohm-generic.h   | 14 ++++++--------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/rohm-regulator.c b/drivers/regulator/rohm-regulator.c
index 399002383b28..5c558b153d55 100644
--- a/drivers/regulator/rohm-regulator.c
+++ b/drivers/regulator/rohm-regulator.c
@@ -52,9 +52,12 @@ int rohm_regulator_set_dvs_levels(const struct rohm_dvs_config *dvs,
 	char *prop;
 	unsigned int reg, mask, omask, oreg = desc->enable_reg;
 
-	for (i = 0; i < ROHM_DVS_LEVEL_MAX && !ret; i++) {
-		if (dvs->level_map & (1 << i)) {
-			switch (i + 1) {
+	for (i = 0; i < ROHM_DVS_LEVEL_VALID_AMOUNT && !ret; i++) {
+		int bit;
+
+		bit = BIT(i);
+		if (dvs->level_map & bit) {
+			switch (bit) {
 			case ROHM_DVS_LEVEL_RUN:
 				prop = "rohm,dvs-run-voltage";
 				reg = dvs->run_reg;
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-generic.h
index 4283b5b33e04..2b85b9deb03a 100644
--- a/include/linux/mfd/rohm-generic.h
+++ b/include/linux/mfd/rohm-generic.h
@@ -20,14 +20,12 @@ struct rohm_regmap_dev {
 	struct regmap *regmap;
 };
 
-enum {
-	ROHM_DVS_LEVEL_UNKNOWN,
-	ROHM_DVS_LEVEL_RUN,
-	ROHM_DVS_LEVEL_IDLE,
-	ROHM_DVS_LEVEL_SUSPEND,
-	ROHM_DVS_LEVEL_LPSR,
-	ROHM_DVS_LEVEL_MAX = ROHM_DVS_LEVEL_LPSR,
-};
+#define ROHM_DVS_LEVEL_RUN		BIT(0)
+#define ROHM_DVS_LEVEL_IDLE		BIT(1)
+#define ROHM_DVS_LEVEL_SUSPEND		BIT(2)
+#define ROHM_DVS_LEVEL_LPSR		BIT(3)
+#define ROHM_DVS_LEVEL_VALID_AMOUNT	4
+#define ROHM_DVS_LEVEL_UNKNOWN		0
 
 /**
  * struct rohm_dvs_config - dynamic voltage scaling register descriptions

base-commit: 92bf22614b21a2706f4993b278017e437f7785b3
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
