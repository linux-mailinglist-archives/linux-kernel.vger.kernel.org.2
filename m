Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53B143C7C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 12:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbhJ0Kgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 06:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbhJ0Kgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 06:36:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB34C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 03:34:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u18so3303450wrg.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 03:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+FphN78AXgH28AkDzvYuNYo1zQmgzrR8QaTKrIUkdiI=;
        b=k6Ua2ee1w06mtAjfJ3KHTf/v2vkQFo6AZYm2DASbGJMbypwEtIlXMp1pe/0X/l8YcQ
         3foBi5QZHJhFXCXsdZL2fij3+Yogf/mTtVaqgEjAv2Fkw7iYpT+8gb+s9MYHFpO3hj2i
         TN36fvU2MfTs6XhEY0qPz54cApiYabkVVmdaWfOBxPv8hXX2GOFj0TX4Dx4N2wxHi8ZX
         Uz1xsOQ48LrG/8D0ugIv4CJ4z6u7Slh4rfxqm1HnZSEq8eQ+FP4xKZMAsQv49Q0N0CLe
         XAcU0fKgLVWwAseKkTpJs8hO7rkbBGZUp0R6fuLEYJ22GjKzaaWaSKL5w7R39tqx50wT
         pBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FphN78AXgH28AkDzvYuNYo1zQmgzrR8QaTKrIUkdiI=;
        b=J2XcdzWQQd3NBfagKISL21uraJxTyf7xdXlsG9gPU1O3m475gNVkHzu89FIzflNKQi
         KNxodbzhj9EvlXZmjl0D4UNS1Ce24EDbf1EYgU3GPWwW9iSFGuRZilCrmYgVLvdo8bEn
         RD5Nv6bwxm1e0ew+zJqN0S0kcOkuP+lqv1zzHAU7IBXFGqVdzI0ZcpwZ3xhGDCwZE080
         XZw9q/FmWcIctLxVdEMXuTdUsYU/NYjUdeIkSgykZp1xbnbNsf2qww19QJNpEePAM1WH
         dmXCpWfKqxB49S2THS++SEHtX5C9iSJAyfJoJDNqrXoagyAV8LKNSKiAE0p4FuevZdA1
         XBFw==
X-Gm-Message-State: AOAM533RG+se7Z58XqIBLB/kKiccjWw9DW1OZR/Ud/gK4XsnxKZUf+1/
        lDvLdvSVnsRqSzxXkKFPZ1E=
X-Google-Smtp-Source: ABdhPJy/5w9k7meVlbP35LqiI7Vh5leFYIjzw5vaSU0Y1ldDFWZzUgTKKRWrwEtPK1ZHGKV5eBckDA==
X-Received: by 2002:a05:6000:184c:: with SMTP id c12mr38630307wri.127.1635330849031;
        Wed, 27 Oct 2021 03:34:09 -0700 (PDT)
Received: from authentaworks.lxd (ip5f5be9ad.dynamic.kabel-deutschland.de. [95.91.233.173])
        by smtp.gmail.com with ESMTPSA id j10sm7140198wrx.94.2021.10.27.03.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 03:34:08 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     tudor.ambarus@microchip.com, michael@walle.cc, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH 1/4] mtd: spi-nor: micron-st: add advanced protection and security features
Date:   Wed, 27 Oct 2021 10:33:49 +0000
Message-Id: <20211027103352.8879-2-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027103352.8879-1-sshivamurthy@micron.com>
References: <20211027103352.8879-1-sshivamurthy@micron.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Micron SPI NOR flashes are enabled with advanced sector protection
features, using volatile lock bits, non-volatile lock bits, global
freeze bits and password.

Advanced sector protection and security features offers additional
levels of protection against accidentally corrupting code and data
stored, and it also prevents malicious attacks that could intentionally
modify or corrupt the code or data stored.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/spi-nor/core.h      |  20 +++
 drivers/mtd/spi-nor/micron-st.c | 238 ++++++++++++++++++++++++++++++++
 2 files changed, 258 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 3348e1dd1445..f6890973cb4a 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -187,6 +187,24 @@ struct spi_nor_locking_ops {
 	int (*is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
 };
 
+struct spi_nor_sec_ops {
+	int (*secure_read)(struct spi_nor *nor, size_t len, u8 *buf);
+	int (*secure_write)(struct spi_nor *nor, size_t len, u8 *buf);
+	int (*read_nvlock_bits)(struct spi_nor *nor, u32 addr, size_t len,
+				u8 *buf);
+	int (*read_vlock_bits)(struct spi_nor *nor, u32 addr, size_t len,
+			       u8 *buf);
+	int (*read_global_freeze_bits)(struct spi_nor *nor, size_t len,
+				       u8 *buf);
+	int (*read_password)(struct spi_nor *nor, size_t len, u8 *buf);
+	int (*write_global_freeze_bits)(struct spi_nor *nor, size_t len,
+					u8 *buf);
+	int (*write_vlock_bits)(struct spi_nor *nor, u32 addr, size_t len,
+				u8 *buf);
+	int (*write_nvlock_bits)(struct spi_nor *nor, u32 addr);
+	int (*erase_nvlock_bits)(struct spi_nor *nor);
+};
+
 /**
  * struct spi_nor_otp_organization - Structure to describe the SPI NOR OTP regions
  * @len:	size of one OTP region in bytes.
@@ -285,6 +303,8 @@ struct spi_nor_flash_parameter {
 	int (*setup)(struct spi_nor *nor, const struct spi_nor_hwcaps *hwcaps);
 
 	const struct spi_nor_locking_ops *locking_ops;
+
+	const struct spi_nor_sec_ops *sec_ops;
 };
 
 /**
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index c224e59820a1..b5d82e85fb92 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -16,6 +16,23 @@
 #define SPINOR_MT_OCT_DTR	0xe7	/* Enable Octal DTR. */
 #define SPINOR_MT_EXSPI		0xff	/* Enable Extended SPI (default) */
 
+#define AUTHENTA_ID		0x8c
+#define AUTHENTA_ID_BYTE	0x05
+
+#define SPINOR_OP_SECURE_READ			0x96
+#define SPINOR_OP_SECURE_WRITE			0x9b
+
+#define SPINOR_OP_RD_VOL_LOCK_BITS		0xe8
+#define SPINOR_OP_WR_VOL_LOCK_BITS		0xe5
+#define SPINOR_OP_RD_NV_LOCK_BITS		0xe2
+#define SPINOR_OP_WR_NV_LOCK_BITS		0xe3
+#define SPINOR_OP_ER_NV_LOCK_BITS		0xe4
+
+#define SPINOR_OP_RD_GLOBAL_FREEZE_BITS		0xa7
+#define SPINOR_OP_WR_GLOBAL_FREEZE_BITS		0xa6
+
+#define SPINOR_OP_RD_PASSWORD			0x27
+
 static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor, bool enable)
 {
 	struct spi_mem_op op;
@@ -247,12 +264,233 @@ static int st_micron_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 	return spi_nor_write_disable(nor);
 }
 
+/**
+ * authenta_secure_read() - read the secure packet from authenta SPI NOR
+ *
+ * @nor: pointer to 'struct spi_nor'
+ * @len: number of bytes to read
+ * @buf: pointer to dst buffer
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+static int authenta_secure_read(struct spi_nor *nor, size_t len, u8 *buf)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SECURE_READ, 1),
+			   SPI_MEM_OP_NO_ADDR,
+			   SPI_MEM_OP_DUMMY(1, 1),
+			   SPI_MEM_OP_DATA_IN(len, buf, 1));
+
+	return spi_mem_exec_op(nor->spimem, &op);
+}
+
+/**
+ * authenta_secure_write() - write the secure packet to authenta SPI NOR
+ *
+ * @nor: pointer to 'struct spi_nor'
+ * @len: number of bytes to be written
+ * @buf: pointer to dst buffer
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+static int authenta_secure_write(struct spi_nor *nor, size_t len, u8 *buf)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SECURE_WRITE, 1),
+			   SPI_MEM_OP_NO_ADDR,
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(len, buf, 1));
+
+	return spi_mem_exec_op(nor->spimem, &op);
+}
+
+/**
+ * authenta_read_vlock_bits() - read the volatile lock bits
+ *
+ * @nor: pointer to 'struct spi_nor'
+ * @addr: address for volatile lock bits
+ * @len: number of bytes to read
+ * @buf: pointer to dst buffer
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+static int authenta_read_vlock_bits(struct spi_nor *nor, u32 addr,
+				    size_t len, u8 *buf)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_VOL_LOCK_BITS, 1),
+			   SPI_MEM_OP_ADDR(nor->addr_width, addr, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_IN(len, buf, 1));
+
+	return spi_mem_exec_op(nor->spimem, &op);
+}
+
+/**
+ * authenta_write_vlock_bits() - write data to the volatile lock bits
+ *
+ * @nor: pointer to 'struct spi_nor'
+ * @addr: address for volatile lock bits
+ * @len: number of bytes to be written
+ * @buf: pointer to dst buffer
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+static int authenta_write_vlock_bits(struct spi_nor *nor, u32 addr, size_t len,
+				     u8 *buf)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_VOL_LOCK_BITS, 1),
+			   SPI_MEM_OP_ADDR(nor->addr_width, addr, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(len, buf, 1));
+
+	return spi_mem_exec_op(nor->spimem, &op);
+}
+
+/**
+ * authenta_read_nvlock_bits() - read the non-volatile lock bits
+ *
+ * @nor: pointer to 'struct spi_nor'
+ * @addr: address for non-volatile lock bits
+ * @len: number of bytes to be written
+ * @buf: pointer to dst buffer
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+static int authenta_read_nvlock_bits(struct spi_nor *nor, u32 addr,
+				     size_t len, u8 *buf)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_NV_LOCK_BITS, 1),
+			   SPI_MEM_OP_ADDR(nor->addr_width, addr, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_IN(len, buf, 1));
+
+	return spi_mem_exec_op(nor->spimem, &op);
+}
+
+/**
+ * authenta_write_nvlock_bits() - write to the non-volatile lock bits
+ *
+ * @nor: pointer to 'struct spi_nor'
+ * @addr: address for non-volatile lock bits
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+static int authenta_write_nvlock_bits(struct spi_nor *nor, u32 addr)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_NV_LOCK_BITS, 1),
+			   SPI_MEM_OP_ADDR(nor->addr_width, addr, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_NO_DATA);
+
+	return spi_mem_exec_op(nor->spimem, &op);
+}
+
+/**
+ * authenta_erase_nvlock_bits() - erase the non-volatile lock bits
+ *
+ * @nor: pointer to 'struct spi_nor'
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+static int authenta_erase_nvlock_bits(struct spi_nor *nor)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_ER_NV_LOCK_BITS, 1),
+			   SPI_MEM_OP_NO_ADDR,
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_NO_DATA);
+
+	return spi_mem_exec_op(nor->spimem, &op);
+}
+
+/**
+ * authenta_read_global_freeze_bits() - read the global freeze bits
+ *
+ * @nor: pointer to 'struct spi_nor'
+ * @len: number of bytes to read
+ * @buf: pointer to dst buffer
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+static int authenta_read_global_freeze_bits(struct spi_nor *nor, size_t len,
+					    u8 *buf)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_GLOBAL_FREEZE_BITS, 1),
+			   SPI_MEM_OP_NO_ADDR,
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_IN(len, buf, 1));
+
+	return spi_mem_exec_op(nor->spimem, &op);
+}
+
+/**
+ * authenta_write_global_freeze_bits() - write data to the global freeze bits
+ *
+ * @nor: pointer to 'struct spi_nor'
+ * @len: number of bytes to be written
+ * @buf: pointer to dst buffer
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+static int authenta_write_global_freeze_bits(struct spi_nor *nor, size_t len,
+					     u8 *buf)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_GLOBAL_FREEZE_BITS, 1),
+			   SPI_MEM_OP_NO_ADDR,
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(len, buf, 1));
+
+	return spi_mem_exec_op(nor->spimem, &op);
+}
+
+/**
+ * authenta_read_password() - read the password
+ *
+ * @nor: pointer to 'struct spi_nor'
+ * @len: number of bytes to read
+ * @buf: pointer to dst buffer
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+static int authenta_read_password(struct spi_nor *nor, size_t len, u8 *buf)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_PASSWORD, 1),
+			   SPI_MEM_OP_NO_ADDR,
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_IN(len, buf, 1));
+
+	return spi_mem_exec_op(nor->spimem, &op);
+}
+
+static const struct spi_nor_sec_ops authenta_ops = {
+	.secure_read = authenta_secure_read,
+	.secure_write = authenta_secure_write,
+	.read_vlock_bits = authenta_read_vlock_bits,
+	.write_vlock_bits = authenta_write_vlock_bits,
+	.read_nvlock_bits = authenta_read_nvlock_bits,
+	.write_nvlock_bits = authenta_write_nvlock_bits,
+	.erase_nvlock_bits = authenta_erase_nvlock_bits,
+	.read_global_freeze_bits = authenta_read_global_freeze_bits,
+	.write_global_freeze_bits = authenta_write_global_freeze_bits,
+	.read_password = authenta_read_password,
+};
+
 static void micron_st_default_init(struct spi_nor *nor)
 {
 	nor->flags |= SNOR_F_HAS_LOCK;
 	nor->flags &= ~SNOR_F_HAS_16BIT_SR;
 	nor->params->quad_enable = NULL;
 	nor->params->set_4byte_addr_mode = st_micron_set_4byte_addr_mode;
+
+	if (nor->info->id[AUTHENTA_ID_BYTE] == AUTHENTA_ID)
+		nor->params->sec_ops = &authenta_ops;
 }
 
 static const struct spi_nor_fixups micron_st_fixups = {
-- 
2.25.1

