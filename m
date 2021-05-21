Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E74638CD87
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbhEUShx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbhEUShw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:37:52 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CE0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:36:28 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 76so20710715qkn.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3x/Aot+oC7uVKYlCUOZopFHsKZ9QU/hidUurQqUpu+8=;
        b=AOGOa+aYUZMfm8aHqvRvnqr1nQ3BLmR0niaL2vOTiV0kH1wsINypCWZfnzBWc7Db54
         BBF4eRnRNrIla4G6OX5bDXWTLYY+XFJJjthfg7zpDCzPjnmjzwpQmF9bpf0CRFY/kWmC
         bvkx+4ERaSdKDpdpghqkcvEOLI3AfxSWEqGw90drxp6r+7GLLmHYF1KBkbCrBilj+vM7
         AwFe4sdlnG/o3K05EH79Cso5dpkPCgu545paM+98F+w9YF6BkM3PIgk+7Wz4km1SuJ10
         Z5jqQeSuQY8/v26eW6UQloOik4XbU63T/HRJAlZkeJHo7d0tcjf5TidYIzgitXLDstXm
         qGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3x/Aot+oC7uVKYlCUOZopFHsKZ9QU/hidUurQqUpu+8=;
        b=DCMU3E/yX4ApI2eXtim6Tj22G0bJB/phwulqn2XSt8kO+S3zycq9laA4a1xx/iEjg/
         XaYQU0wvJ2MA0l8xAajWiCna7T0vkTR3t4WqxvMEKSHQ/YGwR9u/98Oj2zXCDhpyDtDM
         ZAFTqcHpZ5j6BmNFPnHSRsUpw5Ajv0a/vCUeRwnwBSce8eZ06BlXOlN7BGStn02hPVCf
         nf7EPuorIZflkKBrrWSkl4PgDv2FJBBRwrOXQcAyQIx1mcM/JYc22MsamuQqZrDswLnT
         XoogoWd855ABa0okS6SrHrOOl7zi9ZBWptBqdOhb8RPDfpuZAfpEOSUVpoWB9ur2rb4w
         HJXQ==
X-Gm-Message-State: AOAM530GqHSBBahvbLZotEMuCd9RAJ2D/YbviJ4gniOfAB86c1o76PHh
        GkiIR35Oxx27cyHB3eCI/wNDm1c6FI543Q==
X-Google-Smtp-Source: ABdhPJyk4rcErwmMon7Nf9juiizccwOByhYx7uTBe3ZtfseHVXjF5oKWEF+rwj5pAbCvJXklYauNlw==
X-Received: by 2002:a37:aa4c:: with SMTP id t73mr14932957qke.79.1621622187795;
        Fri, 21 May 2021 11:36:27 -0700 (PDT)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id v6sm5346526qkv.54.2021.05.21.11.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 11:36:27 -0700 (PDT)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     shorne@gmail.com, kgugala@antmicro.com, mholenko@antmicro.com,
        pczarnecki@internships.antmicro.com, davidgow@google.com,
        florent@enjoy-digital.fr, joel@jms.id.au
Subject: [PATCH] drivers/soc/litex: remove 8-bit subregister option
Date:   Fri, 21 May 2021 14:36:21 -0400
Message-Id: <20210521183621.224260-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since upstream LiteX recommends that Linux support be limited to
designs configured with 32-bit CSR subregisters (see commit a2b71fde
in upstream LiteX, https://github.com/enjoy-digital/litex), remove
the option to select 8-bit subregisters, significantly reducing the
complexity of LiteX CSR (MMIO register) accessor methods.

NOTE: for details on the underlying mechanics of LiteX CSR registers,
see https://github.com/enjoy-digital/litex/wiki/CSR-Bus or the original
LiteX accessors (litex/soc/software/include/hw/common.h in the upstream
repository).

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Florent Kermarrec <florent@enjoy-digital.fr>
Cc: Mateusz Holenko <mholenko@antmicro.com>
Cc: Joel Stanley <joel@jms.id.au>

---
 drivers/soc/litex/Kconfig |  12 -----
 include/linux/litex.h     | 100 +++++++-------------------------------
 2 files changed, 17 insertions(+), 95 deletions(-)

diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
index e7011d665b15..e6ba3573a772 100644
--- a/drivers/soc/litex/Kconfig
+++ b/drivers/soc/litex/Kconfig
@@ -17,16 +17,4 @@ config LITEX_SOC_CONTROLLER
 	  All drivers that use functions from litex.h must depend on
 	  LITEX.
 
-config LITEX_SUBREG_SIZE
-	int "Size of a LiteX CSR subregister, in bytes"
-	depends on LITEX
-	range 1 4
-	default 4
-	help
-	LiteX MMIO registers (referred to as Configuration and Status
-	registers, or CSRs) are spread across adjacent 8- or 32-bit
-	subregisters, located at 32-bit aligned MMIO addresses. Use
-	this to select the appropriate size (1 or 4 bytes) matching
-	your particular LiteX build.
-
 endmenu
diff --git a/include/linux/litex.h b/include/linux/litex.h
index 5ea9ccf5cce4..aef6ca8af949 100644
--- a/include/linux/litex.h
+++ b/include/linux/litex.h
@@ -11,13 +11,8 @@
 
 #include <linux/io.h>
 
-/* LiteX SoCs support 8- or 32-bit CSR Bus data width (i.e., subreg. size) */
-#if defined(CONFIG_LITEX_SUBREG_SIZE) && \
-	(CONFIG_LITEX_SUBREG_SIZE == 1 || CONFIG_LITEX_SUBREG_SIZE == 4)
-#define LITEX_SUBREG_SIZE      CONFIG_LITEX_SUBREG_SIZE
-#else
-#error LiteX subregister size (LITEX_SUBREG_SIZE) must be 4 or 1!
-#endif
+/* Linux-capable LiteX SoCs support 32-bit CSR Bus data width (subreg. size) */
+#define LITEX_SUBREG_SIZE	  0x4
 #define LITEX_SUBREG_SIZE_BIT	 (LITEX_SUBREG_SIZE * 8)
 
 /* LiteX subregisters of any width are always aligned on a 4-byte boundary */
@@ -42,115 +37,54 @@ static inline u32 _read_litex_subregister(void __iomem *addr)
  * 32-bit wide logical CSR will be laid out as four 32-bit physical
  * subregisters, each one containing one byte of meaningful data.
  *
+ * For Linux support, upstream LiteX enforces a 32-bit wide CSR bus, which
+ * means that only larger-than-32-bit CSRs will be split across multiple
+ * subregisters (e.g., a 64-bit CSR will be spread across two consecutive
+ * 32-bit subregisters).
+ *
  * For details see: https://github.com/enjoy-digital/litex/wiki/CSR-Bus
  */
 
-/* number of LiteX subregisters needed to store a register of given reg_size */
-#define _litex_num_subregs(reg_size) \
-	(((reg_size) - 1) / LITEX_SUBREG_SIZE + 1)
-
-/*
- * since the number of 4-byte aligned subregisters required to store a single
- * LiteX CSR (MMIO) register varies with LITEX_SUBREG_SIZE, the offset of the
- * next adjacent LiteX CSR register w.r.t. the offset of the current one also
- * depends on how many subregisters the latter is spread across
- */
-#define _next_reg_off(off, size) \
-	((off) + _litex_num_subregs(size) * LITEX_SUBREG_ALIGN)
-
-/*
- * The purpose of `_litex_[set|get]_reg()` is to implement the logic of
- * writing to/reading from the LiteX CSR in a single place that can be then
- * reused by all LiteX drivers via the `litex_[write|read][8|16|32|64]()`
- * accessors for the appropriate data width.
- * NOTE: direct use of `_litex_[set|get]_reg()` by LiteX drivers is strongly
- * discouraged, as they perform no error checking on the requested data width!
- */
-
-/**
- * _litex_set_reg() - Writes a value to the LiteX CSR (Control&Status Register)
- * @reg: Address of the CSR
- * @reg_size: The width of the CSR expressed in the number of bytes
- * @val: Value to be written to the CSR
- *
- * This function splits a single (possibly multi-byte) LiteX CSR write into
- * a series of subregister writes with a proper offset.
- * NOTE: caller is responsible for ensuring (0 < reg_size <= sizeof(u64)).
- */
-static inline void _litex_set_reg(void __iomem *reg, size_t reg_size, u64 val)
-{
-	u8 shift = _litex_num_subregs(reg_size) * LITEX_SUBREG_SIZE_BIT;
-
-	while (shift > 0) {
-		shift -= LITEX_SUBREG_SIZE_BIT;
-		_write_litex_subregister(val >> shift, reg);
-		reg += LITEX_SUBREG_ALIGN;
-	}
-}
-
-/**
- * _litex_get_reg() - Reads a value of the LiteX CSR (Control&Status Register)
- * @reg: Address of the CSR
- * @reg_size: The width of the CSR expressed in the number of bytes
- *
- * Return: Value read from the CSR
- *
- * This function generates a series of subregister reads with a proper offset
- * and joins their results into a single (possibly multi-byte) LiteX CSR value.
- * NOTE: caller is responsible for ensuring (0 < reg_size <= sizeof(u64)).
- */
-static inline u64 _litex_get_reg(void __iomem *reg, size_t reg_size)
-{
-	u64 r;
-	u8 i;
-
-	r = _read_litex_subregister(reg);
-	for (i = 1; i < _litex_num_subregs(reg_size); i++) {
-		r <<= LITEX_SUBREG_SIZE_BIT;
-		reg += LITEX_SUBREG_ALIGN;
-		r |= _read_litex_subregister(reg);
-	}
-	return r;
-}
-
 static inline void litex_write8(void __iomem *reg, u8 val)
 {
-	_litex_set_reg(reg, sizeof(u8), val);
+	_write_litex_subregister(val, reg);
 }
 
 static inline void litex_write16(void __iomem *reg, u16 val)
 {
-	_litex_set_reg(reg, sizeof(u16), val);
+	_write_litex_subregister(val, reg);
 }
 
 static inline void litex_write32(void __iomem *reg, u32 val)
 {
-	_litex_set_reg(reg, sizeof(u32), val);
+	_write_litex_subregister(val, reg);
 }
 
 static inline void litex_write64(void __iomem *reg, u64 val)
 {
-	_litex_set_reg(reg, sizeof(u64), val);
+	_write_litex_subregister(val >> LITEX_SUBREG_SIZE_BIT, reg);
+	_write_litex_subregister(val, reg + LITEX_SUBREG_ALIGN);
 }
 
 static inline u8 litex_read8(void __iomem *reg)
 {
-	return _litex_get_reg(reg, sizeof(u8));
+	return _read_litex_subregister(reg);
 }
 
 static inline u16 litex_read16(void __iomem *reg)
 {
-	return _litex_get_reg(reg, sizeof(u16));
+	return _read_litex_subregister(reg);
 }
 
 static inline u32 litex_read32(void __iomem *reg)
 {
-	return _litex_get_reg(reg, sizeof(u32));
+	return _read_litex_subregister(reg);
 }
 
 static inline u64 litex_read64(void __iomem *reg)
 {
-	return _litex_get_reg(reg, sizeof(u64));
+	return ((u64)_read_litex_subregister(reg) << LITEX_SUBREG_SIZE_BIT) |
+		_read_litex_subregister(reg + LITEX_SUBREG_ALIGN);
 }
 
 #endif /* _LINUX_LITEX_H */
-- 
2.31.1

