Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3EB3BE8C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 15:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhGGNbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 09:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhGGNbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 09:31:49 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8E0C061574;
        Wed,  7 Jul 2021 06:29:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 62so2267439pgf.1;
        Wed, 07 Jul 2021 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=23ZatZSetSOL/bCz9HGawdO9/WPF019AoV+UlfiewDc=;
        b=GbH38pebjALyFptmNAFB9QTEAbeOQeQspIBpBWjgSkl+CW6F20Y5XQAVIYzN4vccwK
         VHbL/NpiG5da9crIk3GRk1XYTgo9Zb7BHItF4IiUQaC0ithw90ZRDkXEBEyTctKhAvfX
         Txhz4TkDL2PeVxD43wCLVwXnHPDRp2MiYyf4YtNvYnlsLLiVTNz30byB+VJhZNGW6CIa
         STO+WBDFur5iPZPTZBEXJCOT8YGOWqTp7mGFXsyBDm0ytvO/KhC3e3xLU04Q0W+QQu6q
         pFDLEN8lP+Qw0JbTLmLqGxBDK6UtYKdhbAoJT0cr956GsnEpBvYJJXrPAQf7eHQQg732
         ssMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=23ZatZSetSOL/bCz9HGawdO9/WPF019AoV+UlfiewDc=;
        b=Kb7bTzbPf/07h2hPtRhYf2FVXnfIs0eoNTMyqEiVsxIKlXxgGn4cDhFhcNmcd6mfdR
         miUebMyeCRJMmDN+HcBhsCTT7jdaudpkEHQIShSlbNcfka7B7vscGRgZReUawQ36J1fg
         xXedQEyo+tZdCcw4KkggWaf7ObtqliE90fxENYbrNUgechYmP/CsIawGDlWkhj+H7vPs
         t4NQAH92cpavqhc2smxlcEPnWjB+QP/0az63D2078N+LgpDvdracF83a7GcauXTxyvtH
         7ZEjg/2+9l5EfkU53VyeyOSwUOOZRiN0Ne7G+0wTVl++YmXT+KZlgXRRO9GqnwMdOJ9z
         HGNA==
X-Gm-Message-State: AOAM5301PCEHF0CMNppBfk0+2XvpGr32NkYmQe2J1c0BtpIK2A/VSekr
        7ojx40hRgE4Os0GCZcItGdk=
X-Google-Smtp-Source: ABdhPJxd1MQP3Ek4cAIq6Dw8dtk4Ye3VyRtnMui2yCxJ0Wq+TRVzMzFBz5VzmMECnzYS8Bzc56OhOA==
X-Received: by 2002:a63:dc04:: with SMTP id s4mr26298239pgg.75.1625664548602;
        Wed, 07 Jul 2021 06:29:08 -0700 (PDT)
Received: from localhost.lan (p1284205-ipngn14601marunouchi.tokyo.ocn.ne.jp. [153.205.193.205])
        by smtp.gmail.com with ESMTPSA id q3sm20125059pfj.89.2021.07.07.06.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:29:07 -0700 (PDT)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 52314900853;
        Wed,  7 Jul 2021 13:29:05 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: [PATCH v3 1/3] mfd: da9063: Add HWMON dependencies
Date:   Wed,  7 Jul 2021 13:25:02 +0000
Message-Id: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>

Dependencies required for DA9063 HWMON support.

Signed-off-by: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>

Moved temperature offset reading to hwmon driver.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
Changes in v3:
- moved temperature offset reading to hwmon driver

Changes in v2:
- registers.h changes moved from patch 2

Originally submitted by Steve Twiss in 2014:
  https://marc.info/?l=linux-kernel&m=139560864709852&w=2

 include/linux/mfd/da9063/registers.h | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

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

