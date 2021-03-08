Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28253330B8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhCHKpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:45:00 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:37427 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhCHKoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:44:32 -0500
Received: by mail-lf1-f47.google.com with SMTP id n16so20278401lfb.4;
        Mon, 08 Mar 2021 02:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g6KXF2cO+/WsPFrySbP0d+MtTPWx9VNXLUCASuU4iuQ=;
        b=N5McxUbG8Cf/oYRliHgDqyHHY+opsqq/hgrWu2yAIY7s3CCJqmR96/inQi4phf3Ipp
         J1um9pZxjZzROnKG3+PYsr1MajGn3FT6UvNYZPsZBZ4kyNjuAkyRKTDQrM3L+Z3OKysI
         ZS/trGPUgk+akapAvjwErGivSXDfTLlehdOVN6g9wGL5VQZwG9K5mUJCDi55fj4r4Kyu
         lcODvHuse1UA0quYxY3dKcDZxdk1G+jwkwQKBqe7ufNctazHq1DWzxY1Z23w+fSZT8If
         mgTImTNgkLiOd0Y3rElKxd001vpOqYhzL1XCZwCD5ngq6qaRZeV2nRbTwH+fyZO0MA4f
         chFw==
X-Gm-Message-State: AOAM533Tpe2BFpbheVOpXotPSWD4WqM4BB08EdEVcsHgY6qAkPzrOpCM
        xRSTTOwCANYb4NHbyInchbw=
X-Google-Smtp-Source: ABdhPJy/wGdMG9YXmkxjFUh6u8jfGfaCYpSzqk3EioG6Hj+TQppsOFOLvV9YIpQrZENOpPRk91bstQ==
X-Received: by 2002:a19:9105:: with SMTP id t5mr13657570lfd.89.1615200271148;
        Mon, 08 Mar 2021 02:44:31 -0800 (PST)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id m7sm1312875lfg.285.2021.03.08.02.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 02:44:30 -0800 (PST)
Date:   Mon, 8 Mar 2021 12:44:24 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [PATCH v3 11/15] regulator: rohm-regulator: Support SNVS HW state.
Message-ID: <4e9d048689acb3570159e87f31becf39455af3c9.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ROHM BD71815 supports setting voltage levels/regulator status
for HW-states "RUN", "SUSPEND", "LPSR" and "SNVS". Add DT parsing
helper also for SNVS state.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
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
index e5392bcbc098..afcd1760c5d3 100644
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
