Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E4C362CA8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 03:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhDQBME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 21:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDQBMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 21:12:02 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF7DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 18:11:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a12so19423364pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 18:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DjE5M9M5jRthI7V37X8gqi/YzZYKLarjADVCR4EpqlU=;
        b=rIkha+FoUYvB7CL0e1okwuoTh16BMF5NzOjcugAU5HxEkojxwQX0EYuq+NnFI9uSD5
         Fk2ta2jZp/LDO1mbohtJ6mKrSBb+P8cTDHXl5Nht2hEvgRR7/dHzZXJkVb23lpJC9ww+
         TLGMUPy1+ngmU+rJdKkX5SeP6E/7PNSHPdAeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjE5M9M5jRthI7V37X8gqi/YzZYKLarjADVCR4EpqlU=;
        b=YT3mk9wv9lr+tnjceldIcPdLQwigiGfFNm0jwUqOLfvH0bLmM/gWbJ+cQS+t9TwVai
         5g0Mc1e9y+4Xi7HGKnpZrknRB76m47DHZNsVpqbTawgApSkZbFX/4JwR1IE/cLaLY6N7
         6iAl2Gq4y3qfMLOrmvPyFiRPLWS2yFoQFIxySkRrXD0BbXvWSRCp40yAd2N+25yLqiKr
         wdkjDf2gkhOHMstiBS8taJFd2BrvUhg2Z+DCrdOCfLvUPGYweG2mCP4UYavQDh9y2f/d
         aboAnvxHIglLhGDIEbaEkfrglrob7Y0hjydsQskSrw5qowErhPhBpUu8eQP38PsQ+7qU
         +GBg==
X-Gm-Message-State: AOAM530YScFWLad9EGZY1gwv9w9ALsCrmcS1SITVd2G5i2/E07BkEpOL
        w2TZh8oTsza/XmhixIDUVKgdCtyUWir2tw==
X-Google-Smtp-Source: ABdhPJxYL4jwj2wr5/CUQx0LynwDfVQMtuuKB+roDjT7Tn79/nRKrbabWXhRKM4RNtQReyLD/qFe3A==
X-Received: by 2002:a62:cf83:0:b029:24a:935:e2f1 with SMTP id b125-20020a62cf830000b029024a0935e2f1mr10149297pfg.8.1618621897269;
        Fri, 16 Apr 2021 18:11:37 -0700 (PDT)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id x17sm2181515pjr.0.2021.04.16.18.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 18:11:37 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, olof@lixom.net, arnd@kernel.org
Cc:     w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 3/3] ARM: dts: mstar: Add a dts for M5Stack UnitV2
Date:   Sat, 17 Apr 2021 10:10:15 +0900
Message-Id: <20210417011015.2105280-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210417011015.2105280-1-daniel@0x0f.com>
References: <20210417011015.2105280-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

M5Stack are releasing a new widget based on the
SigmaStar SSD202D. We have some support for the
SSD202D so lets add a dts for it.

Link: https://m5stack-store.myshopify.com/products/unitv2-ai-camera-gc2145
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/Makefile                    |  1 +
 .../dts/mstar-infinity2m-ssd202d-unitv2.dts   | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 8e5d4ab4e75e..66ddc7d0bd03 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1397,6 +1397,7 @@ dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
 dtb-$(CONFIG_ARCH_MSTARV7) += \
 	mstar-infinity-msc313-breadbee_crust.dtb \
 	mstar-infinity2m-ssd202d-ssd201htv2.dtb \
+	mstar-infinity2m-ssd202d-unitv2.dtb \
 	mstar-infinity3-msc313e-breadbee.dtb \
 	mstar-mercury5-ssc8336n-midrived08.dtb
 dtb-$(CONFIG_ARCH_ASPEED) += \
diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
new file mode 100644
index 000000000000..a81684002e45
--- /dev/null
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-unitv2.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+/dts-v1/;
+#include "mstar-infinity2m-ssd202d.dtsi"
+
+/ {
+	model = "UnitV2";
+	compatible = "m5stack,unitv2", "mstar,infinity2m";
+
+	aliases {
+		serial0 = &pm_uart;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&pm_uart {
+	status = "okay";
+};
-- 
2.31.0

