Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF4390EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 05:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhEZDqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 23:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhEZDql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 23:46:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98139C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 20:45:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e15so10818326plh.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 20:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4I/lmQLF7eC8YbAULo0vp9ivpmc3ogOd9LjXS/v39w=;
        b=SzSx9r9HU/jMj0DDp7j1fvpf9gRVLJgQtiIxEvauQmoGTi6R0+unIOdrY4NvuMUmxF
         5Gqy+CAq+0r5pT2ZpkzwicCwEjbLswDdLHFF6eqrtsPbsiSOlPNo+oodm+kIvPIiqyWm
         Q/oK8qIV4ESWKWEilADDIGOuEMX66zubqCa3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4I/lmQLF7eC8YbAULo0vp9ivpmc3ogOd9LjXS/v39w=;
        b=SqvoBpyNfeIMAFmobXRPygAeogg7b3f1JAMgJtga1zo4DLxqrAIvOKc0KtaEUZ4I0Z
         XwU00Ip3IhNAOCPlC6UIO8ZEltE8RDAt+FpCaRu9/4qd8IrE/q5APXDcqZaz13eFK9zo
         KULFnlWvylU88xMW7VrQFrZSjALrQlPs15CpU/XlAv8xpCVh50AhED5qiBNKxAqdI/2K
         MgwNuVR/OOwo3z7xmLOcUkWZSiPrW2rTSIyP1Ylf9iyEgSKX+4V488qC39TMS4JHCCz2
         8QriztRiJVBN+Ub73i0+FJ06xPI35G4tIIkzGCPDMOu4xvgcmD2J8oCSxAxZExnvTD7l
         Knqw==
X-Gm-Message-State: AOAM530ALigNcd/vcquVGtCJnTAnMOKXFYngnlTt4Y/SR+ExXhaTWOMH
        PLfS/I2LBNI+vHb5Tg8jB/xJsmFm8Dl4dQ==
X-Google-Smtp-Source: ABdhPJzpcSpL/D0IOJhYnLyiQ98q/DWCln3KtbxhNW8LjToJFbSAAjIKTj3YdS8b+Op75WJq20cu1w==
X-Received: by 2002:a17:90a:7306:: with SMTP id m6mr1727889pjk.217.1622000709070;
        Tue, 25 May 2021 20:45:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b7aa:6a6d:a1cc:d75c])
        by smtp.gmail.com with UTF8SMTPSA id lp13sm3203909pjb.0.2021.05.25.20.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 20:45:08 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        swboyd@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] mfd: cros_ec_dev: Load lightbar module only present
Date:   Tue, 25 May 2021 20:45:00 -0700
Message-Id: <20210526034500.954219-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pixel lightbar is only present on chromebook pixel (link), pixel 2
and pixel C. For the latter two, the EC reports its presence.
Instead of always loading the lightbar driver on all chromebook, only
load it when reported by the EC or Link device.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mfd/cros_ec_dev.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index d07b43d7c761a..a9700436e5e51 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2014 Google, Inc.
  */
 
+#include <linux/dmi.h>
 #include <linux/kconfig.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
@@ -112,10 +113,13 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
 static const struct mfd_cell cros_ec_platform_cells[] = {
 	{ .name = "cros-ec-chardev", },
 	{ .name = "cros-ec-debugfs", },
-	{ .name = "cros-ec-lightbar", },
 	{ .name = "cros-ec-sysfs", },
 };
 
+static const struct mfd_cell cros_ec_lightbar_cells[] = {
+	{ .name = "cros-ec-lightbar", }
+};
+
 static const struct mfd_cell cros_ec_vbc_cells[] = {
 	{ .name = "cros-ec-vbc", }
 };
@@ -206,6 +210,20 @@ static int ec_device_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * Lightbar is a special case. Newer devices support autodetection,
+	 * but older ones do not.
+	 */
+	if (cros_ec_check_features(ec, EC_FEATURE_LIGHTBAR) ||
+	    dmi_match(DMI_PRODUCT_NAME, "Link")) {
+		retval = mfd_add_hotplug_devices(ec->dev,
+					cros_ec_lightbar_cells,
+					ARRAY_SIZE(cros_ec_lightbar_cells));
+		if (retval)
+			dev_warn(ec->dev, "failed to add lightbar: %d\n",
+				 retval);
+	}
+
 	/*
 	 * The PD notifier driver cell is separate since it only needs to be
 	 * explicitly added on platforms that don't have the PD notifier ACPI
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

