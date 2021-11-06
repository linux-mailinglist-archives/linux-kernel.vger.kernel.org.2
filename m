Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D27446D69
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 11:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhKFKcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 06:32:03 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:28489 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbhKFKcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 06:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1636194562; x=1667730562;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cwGC7vbpUfH2AgVPghTZzn/Q1IkkcS2d/zGTMW0bCag=;
  b=uz6ptIsaZi2c+DjA52u4wBPr/B7XozWpGuDQSUob7Ru5DIba5W3jjB37
   rKHkQ6Og075RTi7Ti5hlrw3xipigUol+sDk8mnhNVp3jDYJal76Q+ooHZ
   lvf3g6EjgKM95ZVFlM2pxm/XP9aMYtPzF+RJlOSCl1HRDo2xWMu4ti3yp
   ZmYgZywyJWrsHjasd5WMXKKFgid9920NTZlnZAMjKCkTS1QIOwWk+C0M6
   y7232SI7iEZQu2ofQWupea758tEfGya4dCzRH8zV4WG/qP2ks+ihSp/Cp
   Yyh5aiCjz4NXIV7Ebm7rOWP4yV77Oi+xJrqD2vpVup3SloczF+q6BRSkw
   g==;
IronPort-SDR: aLSSWat978B1+KZ7ilecPIGV7yRGElIC8LJnW73Gu0CfBbBBMF0OCz0tFpIJ1yEqh87pexs2+8
 yh3gUIjYsOMXlAPSd7rIjwqqvTfxw4hx9hE6HopTiDFJ4O+eT1BJYMFcG3KlOOyQVP0SgAZOi+
 JGdTjcDjd+4yqe+P9pEUQbE7LbA9YAZcvRfRnbuA02NUNXwaE/3hUy3bgGJXI38wxGZaobWQx/
 pnm2VaH15XQu+4b8yHRZ0v8/x2b3P+KsUlU5B6sZMKP7yz1VNIq+ylMAb+Bv+8GW3D3oeYs2PG
 ok9nZ1wD70uQYUA6eJ4K3+QA
X-IronPort-AV: E=Sophos;i="5.87,214,1631602800"; 
   d="scan'208";a="142414207"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2021 03:29:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 6 Nov 2021 03:29:18 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 6 Nov 2021 03:29:16 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] mtd: spi-nor: Constify part specific fixup hooks
Date:   Sat, 6 Nov 2021 12:29:15 +0200
Message-ID: <20211106102915.153552-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Respect flash_info structure declaration.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
Depends on:
https://lore.kernel.org/all/20211029172633.886453-19-tudor.ambarus@microchip.com/T/

 drivers/mtd/spi-nor/gigadevice.c | 2 +-
 drivers/mtd/spi-nor/issi.c       | 2 +-
 drivers/mtd/spi-nor/macronix.c   | 2 +-
 drivers/mtd/spi-nor/micron-st.c  | 2 +-
 drivers/mtd/spi-nor/spansion.c   | 4 ++--
 drivers/mtd/spi-nor/winbond.c    | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/gigadevice.c b/drivers/mtd/spi-nor/gigadevice.c
index 90573c59ad8b..916115bcb92e 100644
--- a/drivers/mtd/spi-nor/gigadevice.c
+++ b/drivers/mtd/spi-nor/gigadevice.c
@@ -19,7 +19,7 @@ static void gd25q256_default_init(struct spi_nor *nor)
 	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
 }
 
-static struct spi_nor_fixups gd25q256_fixups = {
+static const struct spi_nor_fixups gd25q256_fixups = {
 	.default_init = gd25q256_default_init,
 };
 
diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index 3c5ce2c2c646..ca17997df3c5 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -25,7 +25,7 @@ is25lp256_post_bfpt_fixups(struct spi_nor *nor,
 	return 0;
 }
 
-static struct spi_nor_fixups is25lp256_fixups = {
+static const struct spi_nor_fixups is25lp256_fixups = {
 	.post_bfpt = is25lp256_post_bfpt_fixups,
 };
 
diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index bd7b1d63783e..ffd702ec8f50 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -28,7 +28,7 @@ mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 	return 0;
 }
 
-static struct spi_nor_fixups mx25l25635_fixups = {
+static const struct spi_nor_fixups mx25l25635_fixups = {
 	.post_bfpt = mx25l25635_post_bfpt_fixups,
 };
 
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index c982458d5e31..944d2c995f44 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -113,7 +113,7 @@ static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
 	nor->params->quad_enable = NULL;
 }
 
-static struct spi_nor_fixups mt35xu512aba_fixups = {
+static const struct spi_nor_fixups mt35xu512aba_fixups = {
 	.default_init = mt35xu512aba_default_init,
 	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
 };
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 463ddd0776ec..3f0b849a7a54 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -168,7 +168,7 @@ static int s28hs512t_post_bfpt_fixup(struct spi_nor *nor,
 	return 0;
 }
 
-static struct spi_nor_fixups s28hs512t_fixups = {
+static const struct spi_nor_fixups s28hs512t_fixups = {
 	.default_init = s28hs512t_default_init,
 	.post_sfdp = s28hs512t_post_sfdp_fixup,
 	.post_bfpt = s28hs512t_post_bfpt_fixup,
@@ -190,7 +190,7 @@ s25fs_s_post_bfpt_fixups(struct spi_nor *nor,
 	return 0;
 }
 
-static struct spi_nor_fixups s25fs_s_fixups = {
+static const struct spi_nor_fixups s25fs_s_fixups = {
 	.post_bfpt = s25fs_s_post_bfpt_fixups,
 };
 
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index fd65fa7a5d94..cb6f3a2c57e5 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -28,7 +28,7 @@ w25q256_post_bfpt_fixups(struct spi_nor *nor,
 	return 0;
 }
 
-static struct spi_nor_fixups w25q256_fixups = {
+static const struct spi_nor_fixups w25q256_fixups = {
 	.post_bfpt = w25q256_post_bfpt_fixups,
 };
 
-- 
2.25.1

