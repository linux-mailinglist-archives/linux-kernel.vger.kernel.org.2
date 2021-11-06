Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA12446CF4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 08:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhKFH7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 03:59:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:15777 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbhKFH7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 03:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1636185383; x=1667721383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1hiT/iIgFr9BAOgFai4frwzmFe3aJdvpP7oNILgTiQ4=;
  b=Gc2cpOHF6eL1rlvgWciH8SYiYL6a3TjouoBqJArElJTqUT9iNhPPbAtG
   89jfYrTCX4PozX7ki4FsEF/yO+JZ3Hfe+1/gcOQvDmZcnRoJtEa5YhYFP
   sm6hkhaD6KgDqpiOIuwlz1CNRE8k37Drsd2dEOSD7f04M1U8KfDybZJDs
   4izkmF8SD0u09Pp2+r5ugQwbW0czgQAl7+ufjPBfpOzAztnzwsU1IYlEs
   XNe+pnVc7peEtZV5j67btoCCuSktkrs7VtM25gkj9C4xa+z1SNyhJfpcp
   dCjLvLxTmUMVdLuFU206VTmIkbTr/L5vU/omuiS9nz+SnIEifDxTJjIHH
   w==;
IronPort-SDR: ZFzpXZudR4g9mjF3bnulaoIZz8Cnn9dXlfmIToUOkhQSf7ak2lhTFK+ssgrkUqY/E0YQhNhUaa
 AxpeOlpWvpjVMMcNkjaenI8AdYWofNLKhdD3VY9sMvplv9omGWWTsGzKCiiBbl3tvznvm0+ExR
 DDfrqRCkeJbdMXlq+bw8PTrlqYVEHsT/VGuFjnX3hPdW3wlDe3uymHv8T1rPINNjhzS7F31oc1
 BtJ8Z3c9gFE/6Gr3SOqwI6no9CQexsyR6xTmka5Oo3rM5J/aWYamKNawdcWQDTsUiStdj2kE3q
 /ZeySTxOMPYpdsN9YjVaInsn
X-IronPort-AV: E=Sophos;i="5.87,213,1631602800"; 
   d="scan'208";a="142410383"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2021 00:56:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 6 Nov 2021 00:56:22 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 6 Nov 2021 00:56:20 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <Alexander.Stein@tq-group.com>, <michael@walle.cc>,
        <p.yadav@ti.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 1/2] mtd: spi-nor: Fix shift-out-of-bounds
Date:   Sat, 6 Nov 2021 09:56:15 +0200
Message-ID: <20211106075616.95401-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211106075616.95401-1-tudor.ambarus@microchip.com>
References: <20211106075616.95401-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When paring SFDP we may choose to mask out an erase type, passing
an erase size of zero to spi_nor_set_erase_type().
Fix shift-out-of-bounds and just clear the erase params when
passing zero for erase size.
While here avoid a superfluous dereference and use 'size' directly.

UBSAN: shift-out-of-bounds in drivers/mtd/spi-nor/core.c:2237:24
shift exponent 4294967295 is too large for 32-bit type 'int'

Fixes: 5390a8df769e ("mtd: spi-nor: add support to non-uniform SFDP SPI NOR flash memories")
Reported-by: Alexander Stein <Alexander.Stein@tq-group.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 3d97c189c332..a1b5d5432f41 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2230,8 +2230,13 @@ void spi_nor_set_erase_type(struct spi_nor_erase_type *erase, u32 size,
 	erase->size = size;
 	erase->opcode = opcode;
 	/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
-	erase->size_shift = ffs(erase->size) - 1;
-	erase->size_mask = (1 << erase->size_shift) - 1;
+	if (size) {
+		erase->size_shift = ffs(size) - 1;
+		erase->size_mask = (1 << erase->size_shift) - 1;
+	} else {
+		erase->size_shift = 0;
+		erase->size_mask = 0;
+	}
 }
 
 /**
-- 
2.25.1

