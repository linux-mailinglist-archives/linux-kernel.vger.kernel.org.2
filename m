Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68EB3541C1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 13:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbhDELoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 07:44:04 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:36821 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhDELn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 07:43:59 -0400
Received: by mail-lf1-f53.google.com with SMTP id n138so16989676lfa.3;
        Mon, 05 Apr 2021 04:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HPfHlonj7QV2o47lSOaLGNO+kQSOj7PcfpuWnReFPUo=;
        b=f7rdlIOM0BErk1HXzvXRa4GCjil2maOtey1lMIGNNAwc44UlK7o0+3JPJAzSyGGyEf
         gnjXy5TSWg6UHW5Y46Gp0PmkITlrYFMdy88IjzZu3/peQ4BM9n8bDn16djjrFl91QnGK
         du9WzR6KB+ZEk64gyg+fyH9A9ozq7tSmSpQ+36LQf18VlnwzucC8BF2j8D/OtB305vMk
         6lBcrcqPCR0xqRCBIoU2paW9LKAoDRsYYPUJKTkjsFQTzE2QvdNky7JU8oyYt7iD3tfe
         ltN5Rnf2khpeT7aEF+Aon22frkJA6nKZmpW4TTTks8jAxHsPqAmqIH0veIBwfl7aFO5r
         OYEw==
X-Gm-Message-State: AOAM5335nQjZLxbxN6GubiA1AhAdebNtjdu6tqabk5UM1gu082g2O9k7
        TYW9vA9hnxCCmfb5WII2yBA=
X-Google-Smtp-Source: ABdhPJwN+wq91hewtuJS7+BgOBYJxTGdEbYeszBhfJhwQe2RYR3GGkN/8kg4QkTi9kIsWU4G08qTLw==
X-Received: by 2002:ac2:5306:: with SMTP id c6mr16913825lfh.88.1617623030688;
        Mon, 05 Apr 2021 04:43:50 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id j18sm1765991lfm.209.2021.04.05.04.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 04:43:50 -0700 (PDT)
Date:   Mon, 5 Apr 2021 14:43:44 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [PATCH v6 11/16] regulator: rohm-regulator: Support SNVS HW state.
Message-ID: <3f7dae23da12e67e8ce1d9724e99cf09b6a73b3a.1617616855.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1617616855.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617616855.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ROHM BD71815 supports setting voltage levels/regulator status
for HW-states "RUN", "SUSPEND", "LPSR" and "SNVS". Add DT parsing
helper also for SNVS state.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Mark Brown <broonie@kernel.org>
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
