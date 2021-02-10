Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306E3316CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhBJRcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:32:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231626AbhBJR3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:29:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 371BB64E77;
        Wed, 10 Feb 2021 17:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612978153;
        bh=Z2eeJfNhR1XCvwkIDJtc90L1uhIuGpAMXisH5Uj1cyU=;
        h=From:To:Cc:Subject:Date:From;
        b=ivN5m7eAttqm4H2Zn1l2bNyWlqeTKZl4XVLfEbQFSC+B+z64+UKULgR57ytzvjLpo
         2IInXdQkfX1a+2hEUctoUn2PzSwdmG4BbakO+K61oQhsBVe3IzRgQL56/c2G0ftfr9
         TyT5hjxQd2YEh3MK1QQHXqqBIeBA78xFo7mOlRSezZxmcDbWAV55boKDlstxgb1+44
         jVX6qfnFTENBk6jKeEfFBXgkMBACQE0sPCPYCjbGv/vEgR5Xtlz7Z7QnS/nkiCf4bJ
         kXhN40vyKEdW0S6UJXl43Y7Ro/hw+Bgv8vRJoMTZYlFjomiH2XbYNt9gp0apeC2IkI
         /VxOT7GScw6hA==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sre@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [RESEND PATCH v3] MAINTAINERS: add Dan Murphy as TI LP8xxx drivers maintainer
Date:   Wed, 10 Feb 2021 18:29:08 +0100
Message-Id: <20210210172908.336537-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Milo Kim's email in TI bounces with permanent error (550: Invalid
recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
credits and add Dan Murphy from TI to look after:
 - TI LP855x backlight driver,
 - TI LP8727 charger driver,
 - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dan Murphy <dmurphy@ti.com>
Acked-by: Dan Murphy <dmurphy@ti.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Sebastian Reichel <sre@kernel.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Jingoo Han <jingoohan1@gmail.com>

---

Dear Lee,

Could you take care about this patch?

Best regards,
Krzysztof

Changes since v2:
1. Fix subject (TP -> TI)

Changes since v1:
1. Add Dan Murphy, do not remove the entries.
---
 CREDITS     | 3 +++
 MAINTAINERS | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/CREDITS b/CREDITS
index be097156bd71..71552790774d 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1933,6 +1933,9 @@ N: Kukjin Kim
 E: kgene@kernel.org
 D: Samsung S3C, S5P and Exynos ARM architectures
 
+N: Milo Kim
+D: TI LP855x, LP8727 and LP8788 drivers
+
 N: Sangbeom Kim
 E: sbkim73@samsung.com
 D: Samsung SoC Audio (ASoC) drivers
diff --git a/MAINTAINERS b/MAINTAINERS
index 00bca3e220cc..8f3887813d3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17881,20 +17881,20 @@ F:	sound/soc/codecs/isabelle*
 F:	sound/soc/codecs/lm49453*
 
 TI LP855x BACKLIGHT DRIVER
-M:	Milo Kim <milo.kim@ti.com>
+M:	Dan Murphy <dmurphy@ti.com>
 S:	Maintained
 F:	Documentation/driver-api/backlight/lp855x-driver.rst
 F:	drivers/video/backlight/lp855x_bl.c
 F:	include/linux/platform_data/lp855x.h
 
 TI LP8727 CHARGER DRIVER
-M:	Milo Kim <milo.kim@ti.com>
+M:	Dan Murphy <dmurphy@ti.com>
 S:	Maintained
 F:	drivers/power/supply/lp8727_charger.c
 F:	include/linux/platform_data/lp8727.h
 
 TI LP8788 MFD DRIVER
-M:	Milo Kim <milo.kim@ti.com>
+M:	Dan Murphy <dmurphy@ti.com>
 S:	Maintained
 F:	drivers/iio/adc/lp8788_adc.c
 F:	drivers/leds/leds-lp8788.c
-- 
2.25.1

