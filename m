Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFB3338783
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhCLIgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhCLIgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:36:12 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785DCC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 00:36:12 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z25so5695807lja.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 00:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4qnmPLi/3vFMImNPyFJdVdAB/XfujIxJWjerLOvtJbY=;
        b=DpaOQ5jtBc25ez9/yMdZSswDPLLKVSOxCkV+kgyNzpZn5BlWspZWIhHEIekQaRSF4S
         jM13uLq2b5Ywg/z0+5wYjKpX187p4L/3JuAZ8YR7jxdI2ggtS3i9CnCoUIti7ZrxOk87
         4FaKbRk+JTVT50PE4aRfGyqoGYq5bJ/Oz0xFa9rji7xZ+LfLeCHmbMIO2YcySYqFx6sW
         TaJC5uio3XdRiRd7aJQEYr6t6S09B5Sy9/HtLamjICdkCLBew8g5aNsx1njR8EwedX8B
         F1ldCJKFVnw1LiTVDv9/llusbqwbRBA8HbmKnaEZ1hD3qCSTf8M7ayKRBJGUXYNpWq66
         Dftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4qnmPLi/3vFMImNPyFJdVdAB/XfujIxJWjerLOvtJbY=;
        b=Hu/xsQns64SLYg/3SUoxgxc9rmKd2+DiCasAio41FYgry/Ti2E+thrjbnYYu3HuB2T
         /ZkIwMG3liI3u3X8KBUzxS5KWdPwaDvw5rSvrDLAsE4kSmWR58K/EdYcbYqiPkkqqAU5
         4I/0+qq/uCaTObVrZLumOObShp14U/twe+ROcq6sQgjqPbqBxUXnTv4iQZK5xxlwq7Us
         K+LipR8nr8EMpFNMrL62RYy2J6lSmxbehI4W36lXRfYvGl8MaBCnSC2ECz+XoEiE33tU
         OVFidFjX6pECFFpwB3i3dpbWh8pf563fi22zMICDYuRKXnSXgxrxR/pJ48l8+6kBVekf
         Fycg==
X-Gm-Message-State: AOAM531Xh0UU6VEvcI8yjKUheHyJkG7H9tgUUi+513KKyMJMAlRFtxgx
        QUFNDnh6LlyHKmb0ehYn9kVBHw==
X-Google-Smtp-Source: ABdhPJxkyyEkVyKJMRXz0+LsUpzj5mZuXBz8hpv1LKtBC+919tio0fF30OeP309qPIrJPKGOFFEHTw==
X-Received: by 2002:a2e:22c6:: with SMTP id i189mr1734136lji.346.1615538170960;
        Fri, 12 Mar 2021 00:36:10 -0800 (PST)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id p6sm1617532lfc.71.2021.03.12.00.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 00:36:10 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     lee.jones@linaro.org, Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/4] mfd/power: ab8500: Require device tree
Date:   Fri, 12 Mar 2021 09:36:01 +0100
Message-Id: <20210312083604.3708890-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312083604.3708890-1-linus.walleij@linaro.org>
References: <20210312083604.3708890-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core AB8500 driver and the whole platform is completely
dependent on being probed from device tree so remove the
non-DT probe paths.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/Kconfig           |  2 +-
 drivers/power/supply/ab8500_btemp.c    | 10 ++++------
 drivers/power/supply/ab8500_charger.c  | 15 ++++++---------
 drivers/power/supply/ab8500_fg.c       | 10 ++++------
 drivers/power/supply/abx500_chargalg.c | 10 ++++------
 5 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 006b95eca673..a910571e8d4f 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -698,7 +698,7 @@ config BATTERY_GAUGE_LTC2941
 
 config AB8500_BM
 	bool "AB8500 Battery Management Driver"
-	depends on AB8500_CORE && AB8500_GPADC && (IIO = y)
+	depends on AB8500_CORE && AB8500_GPADC && (IIO = y) && OF
 	help
 	  Say Y to include support for AB8500 battery management.
 
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 7095ea4c68d6..ca5153c82c81 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -1008,12 +1008,10 @@ static int ab8500_btemp_probe(struct platform_device *pdev)
 	}
 	di->bm = plat;
 
-	if (np) {
-		ret = ab8500_bm_of_probe(dev, np, di->bm);
-		if (ret) {
-			dev_err(dev, "failed to get battery information\n");
-			return ret;
-		}
+	ret = ab8500_bm_of_probe(dev, np, di->bm);
+	if (ret) {
+		dev_err(dev, "failed to get battery information\n");
+		return ret;
 	}
 
 	/* get parent data */
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index ac77c8882d17..aa573cd299e2 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3360,15 +3360,12 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	}
 	di->bm = plat;
 
-	if (np) {
-		ret = ab8500_bm_of_probe(dev, np, di->bm);
-		if (ret) {
-			dev_err(dev, "failed to get battery information\n");
-			return ret;
-		}
-		di->autopower_cfg = of_property_read_bool(np, "autopower_cfg");
-	} else
-		di->autopower_cfg = false;
+	ret = ab8500_bm_of_probe(dev, np, di->bm);
+	if (ret) {
+		dev_err(dev, "failed to get battery information\n");
+		return ret;
+	}
+	di->autopower_cfg = of_property_read_bool(np, "autopower_cfg");
 
 	/* get parent data */
 	di->dev = dev;
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 06ff42c71f24..079e11325a81 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3043,12 +3043,10 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	}
 	di->bm = plat;
 
-	if (np) {
-		ret = ab8500_bm_of_probe(dev, np, di->bm);
-		if (ret) {
-			dev_err(dev, "failed to get battery information\n");
-			return ret;
-		}
+	ret = ab8500_bm_of_probe(dev, np, di->bm);
+	if (ret) {
+		dev_err(dev, "failed to get battery information\n");
+		return ret;
 	}
 
 	mutex_init(&di->cc_lock);
diff --git a/drivers/power/supply/abx500_chargalg.c b/drivers/power/supply/abx500_chargalg.c
index a9d84d845f24..591ddd2987a3 100644
--- a/drivers/power/supply/abx500_chargalg.c
+++ b/drivers/power/supply/abx500_chargalg.c
@@ -1997,12 +1997,10 @@ static int abx500_chargalg_probe(struct platform_device *pdev)
 	}
 	di->bm = plat;
 
-	if (np) {
-		ret = ab8500_bm_of_probe(&pdev->dev, np, di->bm);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to get battery information\n");
-			return ret;
-		}
+	ret = ab8500_bm_of_probe(&pdev->dev, np, di->bm);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to get battery information\n");
+		return ret;
 	}
 
 	/* get device struct and parent */
-- 
2.29.2

