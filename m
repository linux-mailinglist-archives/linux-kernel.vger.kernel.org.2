Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2927943C7C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 12:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241485AbhJ0Kgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 06:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241472AbhJ0Kgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 06:36:37 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E40C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 03:34:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso2650620wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vVb6A2wbzx6p3fdJxIaJnlRxaaRSljbVVgtWN9PLGqQ=;
        b=GgCXBxjFWZIEpfEQlaaRu+cPNTw5e5bd1kf7Ia+LF7eILeRBb2XrMKdrllHECCz5IU
         tdzLndK8YF5vgtu5Vo0PTF/ewcLrHDgZN5Xqo23pWhFp2dPAwFEYimJyS097/33+m9Kz
         ndKeumGS9HMMja7T6TUm7DDW45bU3IuZ8x23JOXFH7ltzHsJO/H6xuHn3FcaE+iVBmHw
         BZQz6OwyxsmujknQfCwzi6tnCc3CjWU/2MXY0edZPcfspeNEKHIbKETokAww90rJqdD7
         c8OOg8MfO0Yh5M+m8xPhBWrTuku/Hl9vEIoSHSYkxcS0F9+yNTh9mRbe5O4bOhsE0hlv
         QNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vVb6A2wbzx6p3fdJxIaJnlRxaaRSljbVVgtWN9PLGqQ=;
        b=TvbhCh2cOL9sZb5CzbuBdJL39wRoXTzlXB2VnfAakaS2LPW3Q4Dq0MHz53YAQQNBiG
         RB10v9YIcEO2b4LN8hz0/xiYHNYeECHrJ2/P6pKwEyQKoxy7MR/83xhxB46zM5LEm/2n
         AqdH3knoUQ3SoGRsH8qcbA9iWiwCDykZ6TsTCjFj1LiU+b5dwHkL8efBnvWUjy7Ss0am
         hBH9g2aAmv+/Jx3fjQPigokmZBvNe98Z4QqJBbFeZggR8zAHhLjBru35YXs9pwuqKeRx
         wiwdGzH0mPNFUPGxz1Rm1hYh7DhU393Bn2jUfOvoxfLQUpZiiVpenAEHFgNnLgSWj4XJ
         /fTw==
X-Gm-Message-State: AOAM530pNUiXFk7EK33wtx5a7goFhRIE40g26vWGsatik5NAagcuLav1
        kQ1LHmlgyW+F+R4ez1IEBpwaGWqyLpVohw==
X-Google-Smtp-Source: ABdhPJyXSW9/ahDyrFTQnjw0IkP//VS8L5xUjcfQMATx8+Ky7jQR09yMl9ejckwpYA5h4T9TmAHBgA==
X-Received: by 2002:a05:600c:4f96:: with SMTP id n22mr4874941wmq.168.1635330850930;
        Wed, 27 Oct 2021 03:34:10 -0700 (PDT)
Received: from authentaworks.lxd (ip5f5be9ad.dynamic.kabel-deutschland.de. [95.91.233.173])
        by smtp.gmail.com with ESMTPSA id j10sm7140198wrx.94.2021.10.27.03.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 03:34:10 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     tudor.ambarus@microchip.com, michael@walle.cc, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH 2/4] mtd: spi-nor: add advanced protection and security features support
Date:   Wed, 27 Oct 2021 10:33:50 +0000
Message-Id: <20211027103352.8879-3-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027103352.8879-1-sshivamurthy@micron.com>
References: <20211027103352.8879-1-sshivamurthy@micron.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Added functionalities to support advanced securtiy and protection
features in new SPI NOR flashes.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/spi-nor/Makefile     |   2 +-
 drivers/mtd/spi-nor/advprotsec.c | 209 +++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.c       |   2 +
 include/linux/mtd/mtd.h          |  19 +++
 4 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/spi-nor/advprotsec.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 6b904e439372..8e96e2c65c7a 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-spi-nor-objs			:= core.o sfdp.o swp.o otp.o sysfs.o
+spi-nor-objs			:= core.o sfdp.o swp.o otp.o advprotsec.o sysfs.o
 spi-nor-objs			+= atmel.o
 spi-nor-objs			+= catalyst.o
 spi-nor-objs			+= eon.o
diff --git a/drivers/mtd/spi-nor/advprotsec.c b/drivers/mtd/spi-nor/advprotsec.c
new file mode 100644
index 000000000000..4dc8e67b16ef
--- /dev/null
+++ b/drivers/mtd/spi-nor/advprotsec.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SPI NOR Advanced Sector Protection and Security Features
+ *
+ * Copyright (C) 2021 Micron Technology, Inc.
+ */
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/spi-nor.h>
+
+#include "core.h"
+
+static int spi_nor_secure_read(struct mtd_info *mtd, size_t len, u8 *buf)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->sec_ops->secure_read(nor, len, buf);
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+static int spi_nor_secure_write(struct mtd_info *mtd, size_t len, u8 *buf)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->sec_ops->secure_write(nor, len, buf);
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+static int spi_nor_read_vlock_bits(struct mtd_info *mtd, u32 addr, size_t len,
+				   u8 *buf)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->sec_ops->read_vlock_bits(nor, addr, len, buf);
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+static int spi_nor_write_vlock_bits(struct mtd_info *mtd, u32 addr, size_t len,
+				    u8 *buf)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->sec_ops->write_vlock_bits(nor, addr, len, buf);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_write_disable(nor);
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+static int spi_nor_read_nvlock_bits(struct mtd_info *mtd, u32 addr, size_t len,
+				    u8 *buf)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->sec_ops->read_nvlock_bits(nor, addr, len, buf);
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+static int spi_nor_write_nvlock_bits(struct mtd_info *mtd, u32 addr)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->sec_ops->write_nvlock_bits(nor, addr);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_write_disable(nor);
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+static int spi_nor_erase_nvlock_bits(struct mtd_info *mtd)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->sec_ops->erase_nvlock_bits(nor);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_write_disable(nor);
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+static int spi_nor_read_global_freeze_bits(struct mtd_info *mtd, size_t len,
+					   u8 *buf)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->sec_ops->read_global_freeze_bits(nor, len, buf);
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+static int spi_nor_write_global_freeze_bits(struct mtd_info *mtd, size_t len,
+					    u8 *buf)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->sec_ops->write_global_freeze_bits(nor, len, buf);
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+static int spi_nor_read_password(struct mtd_info *mtd, size_t len, u8 *buf)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->sec_ops->read_password(nor, len, buf);
+
+	spi_nor_unlock_and_unprep(nor);
+	return ret;
+}
+
+void spi_nor_register_security_ops(struct spi_nor *nor)
+{
+	struct mtd_info *mtd = &nor->mtd;
+
+	if (!nor->params->sec_ops)
+		return;
+
+	mtd->_secure_packet_read = spi_nor_secure_read;
+	mtd->_secure_packet_write = spi_nor_secure_write;
+	mtd->_read_vlock_bits = spi_nor_read_vlock_bits;
+	mtd->_write_vlock_bits = spi_nor_write_vlock_bits;
+	mtd->_read_nvlock_bits = spi_nor_read_nvlock_bits;
+	mtd->_write_nvlock_bits = spi_nor_write_nvlock_bits;
+	mtd->_erase_nvlock_bits = spi_nor_erase_nvlock_bits;
+	mtd->_read_global_freeze_bits = spi_nor_read_global_freeze_bits;
+	mtd->_write_global_freeze_bits = spi_nor_write_global_freeze_bits;
+	mtd->_read_password = spi_nor_read_password;
+}
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index cc08bd707378..864f3c7783b3 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3199,6 +3199,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 
 	spi_nor_register_locking_ops(nor);
 
+	spi_nor_register_security_ops(nor);
+
 	/* Send all the required SPI flash commands to initialize device */
 	ret = spi_nor_init(nor);
 	if (ret)
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 88227044fc86..bce358c9fb94 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -360,6 +360,25 @@ struct mtd_info {
 	int (*_get_device) (struct mtd_info *mtd);
 	void (*_put_device) (struct mtd_info *mtd);
 
+	/*
+	 * Security Operations
+	 */
+	int (*_secure_packet_read)(struct mtd_info *mtd, size_t len, u8 *buf);
+	int (*_secure_packet_write)(struct mtd_info *mtd, size_t len, u8 *buf);
+	int (*_read_vlock_bits)(struct mtd_info *mtd, u32 addr, size_t len,
+				u8 *buf);
+	int (*_write_vlock_bits)(struct mtd_info *mtd, u32 addr, size_t len,
+				 u8 *buf);
+	int (*_read_nvlock_bits)(struct mtd_info *mtd, u32 addr, size_t len,
+				 u8 *buf);
+	int (*_write_nvlock_bits)(struct mtd_info *mtd, u32 addr);
+	int (*_erase_nvlock_bits)(struct mtd_info *mtd);
+	int (*_read_global_freeze_bits)(struct mtd_info *mtd, size_t len,
+					u8 *buf);
+	int (*_write_global_freeze_bits)(struct mtd_info *mtd, size_t len,
+					 u8 *buf);
+	int (*_read_password)(struct mtd_info *mtd, size_t len, u8 *buf);
+
 	/*
 	 * flag indicates a panic write, low level drivers can take appropriate
 	 * action if required to ensure writes go through
-- 
2.25.1

