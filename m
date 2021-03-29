Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2420C34D0B3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhC2M7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:59:09 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:44750 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhC2M6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:58:41 -0400
Received: by mail-lf1-f44.google.com with SMTP id b83so18246261lfd.11;
        Mon, 29 Mar 2021 05:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZfS8Vt87E1ADblwrU6g+l0X23kT/AQ0c9dBIVi99eLI=;
        b=XgGjhU0o1we/1CDlk44efjPUj/JMYAuKi7SxiE/756KM7SS8+p/asE2vfU+Iw+FCZU
         w/vaQEaFmBIXB6qWu4wbgimVTCuPIelZOsYAhqpSE0MawFsE7quZbhxdvH03UfVhnKtd
         NWI1uwNSrFOFc5Pn0tZ5yIDJqinl0858LL+Em52sgXBT+z9jAnwZh3R5lQ6orsbScBRP
         6dBBZuJ2COjRdfc9cPkei/F2lSlG3XZG+cPIYPrkB327+Em1obrwyfpmZ0iJ4OxaAsiC
         ms79b0gySAa2qvVULggtKOWhRWEY+brXHOJzLh1UV9TrNg7UvXKJSrROX4V0nbm+U7Wi
         6Yuw==
X-Gm-Message-State: AOAM5333u1Q8HiGd9sV329vA2yZn00w9HNGbTtQJH3ncTC+CpyccnLdV
        wkwXgpFvfVpfftPZ/NyQYWM=
X-Google-Smtp-Source: ABdhPJy3OFBf/wiw2VKDbATJLvfpBsQB89O5R1h6wDj2YUu1yUIHXL+rlvCQhYfh+QTVE+Lw4KWO8A==
X-Received: by 2002:a05:6512:108b:: with SMTP id j11mr15944535lfg.289.1617022719667;
        Mon, 29 Mar 2021 05:58:39 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id f13sm2424584ljc.20.2021.03.29.05.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 05:58:39 -0700 (PDT)
Date:   Mon, 29 Mar 2021 15:58:33 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [PATCH v5 12/19] regulator: rohm-regulator: Support SNVS HW state.
Message-ID: <7a8323c92bcc039436b142e91bb86bbb9112aaf7.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617020713.git.matti.vaittinen@fi.rohmeurope.com>
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
