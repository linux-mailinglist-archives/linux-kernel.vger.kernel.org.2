Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAFE3BD8B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhGFOqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhGFOqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:46:02 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43359C05BD13;
        Tue,  6 Jul 2021 07:34:56 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id u14so21544480pga.11;
        Tue, 06 Jul 2021 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mARFh6+7tn007k6JVuJELUR7h4Zv3keBjqK+Epxvigc=;
        b=R//2YuHT/dHU6CRVRht4GHW2zLFpZFpbmaofQan8eke06UMAr0gqHkf5W3RqFX77Mj
         OGKy0Kt8NlahKfqlF/yc1Q7VxTkpXrHtkMGhGl5reGGzBFF5fmWU+CVc37IWrDQWuNCv
         WdEfA0zH9UHW41r0uQyK46paZFfJ7zHiHOH5Bh1Fhjm0xBnY/1iFUQSEyhXCPlXZxfB5
         7vxvY3EgrhR8D3p5y+62at7kxDDeAS4ZWLPyGY1iYrbmCA6WMsry0K7s1QuBlIEWSdz7
         663pP5ZMkHW20WbpqXLkgaM10AK3J0SR284B9agVT0ZphQi/3DijH7wKw6YMrHXpg2bM
         +gtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mARFh6+7tn007k6JVuJELUR7h4Zv3keBjqK+Epxvigc=;
        b=pfS+C8SiL++x1Y3451jIxZb1pRah++DOUaxfyJ9C8l/df0G2Mti4Nj9N3jkxIkxHeU
         z0GMQydxC7S72gXHmWK7UhygE+NUJxb56RNoo0EhMZPpvSZV9z0Xa18yMmK3/1LEOsey
         in1ip1sTupkJ+XFE93FPb99hwp9BbtMyNepmMNS1NI4SFbJfJDJQAz0VfZZTJKU5UlTW
         3u4kb3JWUjFjUyS1fVL+Cr1IF1tD3GPsRR1nGMZMqn/y/W1O7QVQWVV6t5G0M3v8Ctu6
         +9dMossgLXsaCblGXPreCiYC3wlQSlJwqYfvVyAUUpLqrp6+XLKypxU9ZXhG18lDibkj
         k7dw==
X-Gm-Message-State: AOAM532krdTUQLoJIdN8mHb0HR3YZkVsRllLaiqvY5wleG5v5j0mu+my
        IkUjrLlqMcFyJQrhsg+9SGNQ1So/dkZJ1w==
X-Google-Smtp-Source: ABdhPJyK77XLAqQvpf6bTNIYIMaJ+t/cKqv1bFbVE28bpXc73I5rkI9L22JXByqBKB98fjDpaFHJ4A==
X-Received: by 2002:a63:d511:: with SMTP id c17mr21273492pgg.219.1625582095691;
        Tue, 06 Jul 2021 07:34:55 -0700 (PDT)
Received: from localhost.lan (p1284205-ipngn14601marunouchi.tokyo.ocn.ne.jp. [153.205.193.205])
        by smtp.gmail.com with ESMTPSA id b18sm3314789pjq.2.2021.07.06.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 07:34:54 -0700 (PDT)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 6BD16900904;
        Tue,  6 Jul 2021 14:34:52 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: [PATCH 1/3] mfd: da9063: Add HWMON dependencies
Date:   Tue,  6 Jul 2021 14:34:47 +0000
Message-Id: <850a353432cd676f96889cede291232abf58918d.1625581991.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>

Dependencies required for DA9063 HWMON support.

Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>

Directly set da9063->t_offset.
Let MFD probe succeed even if DA9063_REG_T_OFFSET cannot be read.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
Changes in v2:
- registers.h changes moved from patch 2

Originally submitted by Steve Twiss in 2014:
  https://marc.info/?l=linux-kernel&m=139560864709852&w=2

 drivers/mfd/da9063-core.c            |  8 +++++++
 include/linux/mfd/da9063/core.h      |  3 +++
 include/linux/mfd/da9063/registers.h | 34 ++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index df407c3afce3..14c2a8df9ae3 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -197,6 +197,14 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 		}
 	}
 
+	ret = regmap_read(da9063->regmap, DA9063_REG_T_OFFSET, &da9063->t_offset);
+	if (ret < 0) {
+		da9063->t_offset = 0;
+		dev_warn(da9063->dev,
+			 "Temperature trimming value cannot be read (defaulting to 0)\n");
+		ret = 0;
+	}
+
 	return ret;
 }
 
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index fa7a43f02f27..c0c57c6f6230 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -85,6 +85,9 @@ struct da9063 {
 	int		chip_irq;
 	unsigned int	irq_base;
 	struct regmap_irq_chip_data *regmap_irq;
+
+	/* Trimming */
+	int		t_offset;
 };
 
 int da9063_device_init(struct da9063 *da9063, unsigned int irq);
diff --git a/include/linux/mfd/da9063/registers.h b/include/linux/mfd/da9063/registers.h
index 6e0f66a2e727..297631ddda39 100644
--- a/include/linux/mfd/da9063/registers.h
+++ b/include/linux/mfd/da9063/registers.h
@@ -512,6 +512,7 @@
 
 /* DA9063_REG_GPIO_0_1 (addr=0x15) */
 #define	DA9063_GPIO0_PIN_MASK			0x03
+#define	DA9063_GPIO0_PIN_MASK_SHIFT		0
 #define		DA9063_GPIO0_PIN_ADCIN1		0x00
 #define		DA9063_GPIO0_PIN_GPI		0x01
 #define		DA9063_GPIO0_PIN_GPO_OD		0x02
@@ -523,6 +524,7 @@
 #define		DA9063_GPIO0_TYPE_GPO_VDD_IO2	0x04
 #define	DA9063_GPIO0_NO_WAKEUP			0x08
 #define	DA9063_GPIO1_PIN_MASK			0x30
+#define	DA9063_GPIO1_PIN_MASK_SHIFT		4
 #define		DA9063_GPIO1_PIN_ADCIN2_COMP	0x00
 #define		DA9063_GPIO1_PIN_GPI		0x10
 #define		DA9063_GPIO1_PIN_GPO_OD		0x20
@@ -536,6 +538,7 @@
 
 /* DA9063_REG_GPIO_2_3 (addr=0x16) */
 #define	DA9063_GPIO2_PIN_MASK			0x03
+#define	DA9063_GPIO2_PIN_MASK_SHIFT		0
 #define		DA9063_GPIO2_PIN_ADCIN3		0x00
 #define		DA9063_GPIO2_PIN_GPI		0x01
 #define		DA9063_GPIO2_PIN_GPO_PSS	0x02
@@ -851,6 +854,7 @@
 #define	DA9063_VSYS_VAL_BASE			0x00
 
 /* DA9063_REG_ADC_RES_L (addr=0x37) */
+#define	DA9063_ADC_RES_L_SHIFT			6
 #define	DA9063_ADC_RES_L_BITS			2
 #define	DA9063_ADC_RES_L_MASK			0xC0
 
@@ -1014,6 +1018,36 @@
 #define DA9063_GPIO_DIM				0x80
 #define DA9063_GPIO_PWM_MASK			0x7F
 
+/* DA9063_REG_ADC_CFG (addr=0xC9) */
+#define DA9063_REG_ADCIN1_CUR_MASK		0x03
+#define DA9063_REG_ADCIN1_CUR_SHIFT		0
+#define		DA9063_ADCIN1_CUR_1UA		0x00
+#define		DA9063_ADCIN1_CUR_2UA		0x01
+#define		DA9063_ADCIN1_CUR_10UA		0x02
+#define		DA9063_ADCIN1_CUR_40UA		0x03
+#define DA9063_REG_ADCIN2_CUR_MASK		0x0C
+#define DA9063_REG_ADCIN2_CUR_SHIFT		2
+#define		DA9063_ADCIN2_CUR_1UA		0x00
+#define		DA9063_ADCIN2_CUR_2UA		0x01
+#define		DA9063_ADCIN2_CUR_10UA		0x02
+#define		DA9063_ADCIN2_CUR_40UA		0x03
+#define DA9063_REG_ADCIN3_CUR_MASK		0x10
+#define DA9063_REG_ADCIN3_CUR_SHIFT		4
+#define		DA9063_ADCIN3_CUR_10UA		0x00
+#define		DA9063_ADCIN3_CUR_40UA		0x01
+#define DA9063_REG_ADCIN1_DEB_MASK		0x20
+#define DA9063_REG_ADCIN1_DEB_SHIFT		5
+#define		DA9063_ADCIN1_DEB_OFF		0x00
+#define		DA9063_ADCIN1_DEB_ON		0x01
+#define DA9063_REG_ADCIN2_DEB_MASK		0x40
+#define DA9063_REG_ADCIN2_DEB_SHIFT		6
+#define		DA9063_ADCIN2_DEB_OFF		0x00
+#define		DA9063_ADCIN2_DEB_ON		0x01
+#define DA9063_REG_ADCIN3_DEB_MASK		0x80
+#define DA9063_REG_ADCIN3_DEB_SHIFT		7
+#define		DA9063_ADCIN3_DEB_OFF		0x00
+#define		DA9063_ADCIN3_DEB_ON		0x01
+
 /* DA9063_REG_CONFIG_H (addr=0x10D) */
 #define DA9063_PWM_CLK_MASK			0x01
 #define		DA9063_PWM_CLK_PWM2MHZ		0x00
-- 
2.32.0

