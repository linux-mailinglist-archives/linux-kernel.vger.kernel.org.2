Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225513472A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhCXHau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:30:50 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:36616 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbhCXHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:30:21 -0400
Received: by mail-lj1-f173.google.com with SMTP id z25so28914516lja.3;
        Wed, 24 Mar 2021 00:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZfS8Vt87E1ADblwrU6g+l0X23kT/AQ0c9dBIVi99eLI=;
        b=I3/O8jSML7d7Wips6ppDI0YNBrV/DKjJ21LyuBsF0uG40HqDZ2ZHwuFS0la0BB+kx4
         dR0vhEbhJakRB1jTB++VXW+dQAZTd29C5ZqEjH3pTBOGMiYzR7UFqv1uLqH60yS/dZUX
         puWRUGBldED/bvE5HRD8eWBN0S1u2oF9s7FLK0oAgDV4bWny0Eh7WWhZ4uZ51TucQMcN
         m3J50x+2qGve58knsX6Vm61fY2y4rU8xxcuO+WOPC2CIYgmYLY/OJYMl37jK34kXziOn
         EcvkyHnkLJeWLS5gcRDf9Rxym9Zf/9e45uS2MJjIKsQ7maDdYKHzOMmOusYMvKTGkMqo
         Tsdg==
X-Gm-Message-State: AOAM531rH0zDMxqfGku9Inropu+am5Jczkbdwl8JWEMS0/4IGT6pQheV
        4CdU4bHzSCuPqg5t97pNFps=
X-Google-Smtp-Source: ABdhPJxpCzosCG8i9L14DSH5sbrU1UCDFJ67uMWkXuteXe/gd7Hm12L+lX5BizKF5PQqItjuqbrboQ==
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr1198830ljp.495.1616571019587;
        Wed, 24 Mar 2021 00:30:19 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id h10sm142897lfc.266.2021.03.24.00.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 00:30:19 -0700 (PDT)
Date:   Wed, 24 Mar 2021 09:30:13 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [PATCH v4 12/16] regulator: rohm-regulator: Support SNVS HW state.
Message-ID: <c2721cd2932e26cbe92e655cea3d95041a8a65e1.1616566395.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1616566395.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616566395.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ROHM BD71815 supports setting voltage levels/regulator status
for HW-states "RUN", "SUSPEND", "LPSR" and "SNVS". Add DT parsing
helper also for SNVS state.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
Changes since v3:
 - No changes
 drivers/regulator/rohm-regulator.c | 6 ++++++
 include/linux/mfd/rohm-generic.h   | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/rohm-regulator.c b/drivers/regulator/rohm-regulator.c
index 63aabb8c7786..6e0d9c08ec1c 100644
--- a/drivers/regulator/rohm-regulator.c
+++ b/drivers/regulator/rohm-regulator.c
@@ -95,6 +95,12 @@ int rohm_regulator_set_dvs_levels(const struct rohm_dvs_config *dvs,
 				mask = dvs->lpsr_mask;
 				omask = dvs->lpsr_on_mask;
 				break;
+			case ROHM_DVS_LEVEL_SNVS:
+				prop = "rohm,dvs-snvs-voltage";
+				reg = dvs->snvs_reg;
+				mask = dvs->snvs_mask;
+				omask = dvs->snvs_on_mask;
+				break;
 			default:
 				return -EINVAL;
 			}
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-generic.h
index 9e2880e06950..a9144284cf6d 100644
--- a/include/linux/mfd/rohm-generic.h
+++ b/include/linux/mfd/rohm-generic.h
@@ -27,7 +27,8 @@ struct rohm_regmap_dev {
 #define ROHM_DVS_LEVEL_IDLE		BIT(1)
 #define ROHM_DVS_LEVEL_SUSPEND		BIT(2)
 #define ROHM_DVS_LEVEL_LPSR		BIT(3)
-#define ROHM_DVS_LEVEL_VALID_AMOUNT	4
+#define ROHM_DVS_LEVEL_SNVS		BIT(4)
+#define ROHM_DVS_LEVEL_VALID_AMOUNT	5
 #define ROHM_DVS_LEVEL_UNKNOWN		0
 
 /**
@@ -66,6 +67,9 @@ struct rohm_dvs_config {
 	unsigned int lpsr_reg;
 	unsigned int lpsr_mask;
 	unsigned int lpsr_on_mask;
+	unsigned int snvs_reg;
+	unsigned int snvs_mask;
+	unsigned int snvs_on_mask;
 };
 
 #if IS_ENABLED(CONFIG_REGULATOR_ROHM)
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
