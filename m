Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBF53F17D1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238628AbhHSLQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:16:40 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33667 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238597AbhHSLQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:16:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2FF9E5C016C;
        Thu, 19 Aug 2021 07:16:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 19 Aug 2021 07:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Y+R86tHeDAExu
        pHL82StJkBXeuy0hLrNl1PAhb3tmnQ=; b=FU+CDV7GKBm1FrrFUGld0ER1VT0Ts
        S2LuQS0Ax7xBtrtpX31c7pwvV4pIUSFTo8oOYx67POPDG/H1Jw7U7gqn7uON4jIy
        oGJTIihT/fPNIAZKfJ7k5NnIWO2AkCAygDz7yMFTB7OrJUhH6pkGUrYFS+8+XEki
        97Ci9GTEAOqbIAG1Wuk+uO83+xX6V7uZc/RaUG6NG8kaMTVvi4fdPlvcvDEYHjg1
        fQu/uYZqpa7HM2TqVqtoyGhNk2TLguJjBtJPEgK2c5FNIiLZO6qKwBg2JZqc3N6a
        RJmP2DCxeZIXAib7vKrFVkgxiH/HwFrrE5GwT9C5t+WtEmCENNf0KYYhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Y+R86tHeDAExupHL82StJkBXeuy0hLrNl1PAhb3tmnQ=; b=migdZzBl
        sUYcVyfFjimob5Csbv1K1E0NUv4zX/jiKrrZkkRbtUP1vpOmI9gCrLYPOHxdIzWf
        L56wFb6lh1g6zywAuyq+rwXN1v+iCJYyxE224IoB2Sff4WCjwr6F200copVK5+Yv
        0D8Outqjqo+q2JILAjx7T9Kl9OTfTzOUPDTMtKR2eUwgObgr/Q6WXpAhduNKrcBq
        2xXlox4VbUVrw64huAMHGt41w7ThrbvFawG7IEJmyClPIOgQg8bW+SzEeTTDjZpK
        utn+zciX15rkqoqIS1a/UhKk90xxYmFcXVGp+xuGJakRDHpPP55dB7gAQtiiPd/Y
        OH+Zw/b8a/nTKQ==
X-ME-Sender: <xms:cD0eYQF2rSbZJKPWlAtHSv3B-696xrxwfv1oNje1iyqTEWNKx9YOKA>
    <xme:cD0eYZVAwj5-OXT8BP_lT8FAXRSMf8R0yyixADAP8etMjTPQ-ItICVtsxjWlCSTHQ
    vwZbboymjTV1Stwt7A>
X-ME-Received: <xmr:cD0eYaK1d_Uiz2Qwvuu6-ISUU38quwSZEp9AJy6nbNLoPE-ENnKw4Q2n0O5LacI5ZHmr_XnNspji5EIehwIKmmzUXpg-KoQVyS2AfKwEfA5xeXyNhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:cD0eYSFOY0PJxI7F5905opTdC3Y6EzbjNy6wuQ85OvNSWUmlKoeOZQ>
    <xmx:cD0eYWWuKcpaPdGUKjJ-EdyA8NUPr4_hw03OWT6EVW0yequacx746w>
    <xmx:cD0eYVObcGJRsfpQyxyj777dZ_sTtAbIe_uHBVhP6YuSUG-Ez-SWGA>
    <xmx:cT0eYREawYk5k3yg9H7IBIKJP9VNY_9lgvAt3Guo8d8N_fjX51lhwQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 07:15:57 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v11 03/10] mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
Date:   Thu, 19 Aug 2021 01:44:42 +1000
Message-Id: <20210818154449.1037-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818154449.1037-1-alistair@alistair23.me>
References: <20210818154449.1037-1-alistair@alistair23.me>
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

