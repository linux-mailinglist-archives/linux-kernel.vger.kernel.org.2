Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720823E34E5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhHGKkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:40:25 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58187 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232050AbhHGKkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:40:23 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 74C4C5C00E4;
        Sat,  7 Aug 2021 06:40:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 07 Aug 2021 06:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Y+R86tHeDAExu
        pHL82StJkBXeuy0hLrNl1PAhb3tmnQ=; b=Vvpp7ryRq90TjFSFoUpKr03LH0bcR
        Z2DW/ooxF7+LZJvu4F+cEtmMLnDojdtZw/8OkMBRoNXixN4XJFLOeplGlXLIn0Ru
        j0gWZM1ViU4wB9/q2XBDub+oylZIliVkIKwxFwClv16C9J+HvdfWdHBLDMrV/kms
        im5qsMGt1+m7lONTXMMNL2rZA68nNPU+02/G3YmQ1F3r9fmJVp0qIqJ7DSEoY+XS
        FN8BssMfazcHnFlHvX4ksM9E4j+aJfJfCPirkC7A1Ah4PKPY6c6LuaoSvOyXqCgG
        +msd08GZKtOlIbdIzz87/NmoiyKhASbtFpui14IL5O6q73Zmm7xBN4/Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Y+R86tHeDAExupHL82StJkBXeuy0hLrNl1PAhb3tmnQ=; b=TO/OLZdB
        FDaqy+o6Ol+wMwTPxFG8b65YfKCJ7idNGFIw42w8XiYlF2y4L7pQuF0Ls9hvHtvJ
        luh5ryGAAD8cMLz/gQyAXL7HZuBjNvJ1rK2JArsB5A/C8AjeAVTRKvjshwoGjrtF
        Sl6eL90pAn6rspVlnLwGixyEn7r+0FIjeNv8qIkbW2PsqTm5O16Q+DxDZIVOJN0e
        AsXA/dYKpQYLaEvdgFB31etMvHD/aUxOkjZki9j/Esh40al7whvxrwi7OYUD3hg4
        xflJA2mZAbDZjSxKhbrLzA6xalYZ0dMzzXt+NoTQxuihaXWxG8lX3mJ7CrjH4lX4
        9vh4501IIB556A==
X-ME-Sender: <xms:BmMOYaeoQOYbRFK1holFX0kLMwkQbrN___xAn6wZCEJJ52EdEwWTag>
    <xme:BmMOYUP197QUS28IHj0fykfklbNNX2V79tp3r5RGGIF10kFpT6GWocYc-GJJm6UFT
    F0Z_3ynf6X5W3pPVRg>
X-ME-Received: <xmr:BmMOYbj3Ef_WXPfBVIyUaCpI91AMLz-JuL_Ohz7EWBVOJEpjHXI4S1Jt5160sM4_QhNr97AeTU_H17DI4cCYjOG5CEizE_dNj-mT_qM_ycT_83oCCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeefgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:BmMOYX81ufG3h7kW-SjzwftJ2DbOgmcS-6Tt0KHmYPqXllETjEPvdw>
    <xmx:BmMOYWulQwGaZdXji8wxbbB9PAIL6aoMvl3Y25oipHoKWjVUr2GI_A>
    <xmx:BmMOYeEs9hm3DkkVc8tpHXwCces4eQ3CQpqYpIE6X7h5ZcGGxHLq0g>
    <xmx:BmMOYT9WpRc3gX3zsg-MGvZntNWTMtycqN_7jnQIslElU5xEvx3FBQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Aug 2021 06:40:02 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v10 03/11] mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
Date:   Sat,  7 Aug 2021 20:39:32 +1000
Message-Id: <20210807103940.152-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807103940.152-1-alistair@alistair23.me>
References: <20210807103940.152-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/simple-mfd-i2c.c | 12 +++++++++++
 include/linux/mfd/sy7636a.h  | 41 ++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 include/linux/mfd/sy7636a.h

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 583e8c7924af..ce213c68b8cf 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -62,8 +62,20 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 	return ret;
 }
 
+static const struct mfd_cell sy7636a_cells[] = {
+	{ .name = "sy7636a-regulator", },
+	{ .name = "sy7636a-temperature", },
+	{ .name = "sy7636a-thermal", },
+};
+
+static const struct simple_mfd_data silergy_sy7636a = {
+	.mfd_cell = sy7636a_cells,
+	.mfd_cell_size = ARRAY_SIZE(sy7636a_cells),
+};
+
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
 	{ .compatible = "kontron,sl28cpld" },
+	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
 	{}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
diff --git a/include/linux/mfd/sy7636a.h b/include/linux/mfd/sy7636a.h
new file mode 100644
index 000000000000..15caa54f0432
--- /dev/null
+++ b/include/linux/mfd/sy7636a.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Functions to access SY3686A power management chip.
+ *
+ * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
+ */
+
+#ifndef __MFD_SY7636A_H
+#define __MFD_SY7636A_H
+
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+
+#define SY7636A_REG_OPERATION_MODE_CRL		0x00
+#define SY7636A_OPERATION_MODE_CRL_VCOMCTL	BIT(6)
+#define SY7636A_OPERATION_MODE_CRL_ONOFF	BIT(7)
+#define SY7636A_REG_VCOM_ADJUST_CTRL_L		0x01
+#define SY7636A_REG_VCOM_ADJUST_CTRL_H		0x02
+#define SY7636A_REG_VCOM_ADJUST_CTRL_MASK	0x01ff
+#define SY7636A_REG_VLDO_VOLTAGE_ADJULST_CTRL	0x03
+#define SY7636A_REG_POWER_ON_DELAY_TIME		0x06
+#define SY7636A_REG_FAULT_FLAG			0x07
+#define SY7636A_FAULT_FLAG_PG			BIT(0)
+#define SY7636A_REG_TERMISTOR_READOUT		0x08
+
+#define SY7636A_REG_MAX				0x08
+
+#define VCOM_MIN		0
+#define VCOM_MAX		5000
+
+#define VCOM_ADJUST_CTRL_MASK	0x1ff
+// Used to shift the high byte
+#define VCOM_ADJUST_CTRL_SHIFT	8
+// Used to scale from VCOM_ADJUST_CTRL to mv
+#define VCOM_ADJUST_CTRL_SCAL	10000
+
+#define FAULT_FLAG_SHIFT	1
+
+#endif /* __LINUX_MFD_SY7636A_H */
-- 
2.31.1

