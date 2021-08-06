Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C2C3E26DA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244196AbhHFJLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:11:48 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36097 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244076AbhHFJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:11:46 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 70BDA5C00D5;
        Fri,  6 Aug 2021 05:11:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 06 Aug 2021 05:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=g9wudjUtrEMXk
        fDxrXF6vMS1DzUYOZGPuyKZw5Tmyb0=; b=ERgNHvscO+71TYy0UrudV4Suhdiwn
        KRvfTyBF1iFUShXwhf3MugYjDYxKVXy7eSDK0Y8c2jQQaUMeILx+kgBxUhwzMLer
        EdmvPktcLsdWmcwUvZX6IMqzrEKF88xUxM+HykaJkV4eHmuK5HPNQzSwzVxMbwSV
        NPeuQKhTi6U5X1MbRl3Is2BVoQE2AG0lXtZz6Rr70jAUElfqIFsnivioPMRig0tu
        acbY5PlT1/tqX4OGu35bCAc8plTcsT9qCFaKkCo6epQB1pcfvIBf0/vtSyzi9Lnv
        JEXlx7OYVV+GvvHv/DmMznGjCWkn1qHIFgbq4AF1UKVuotVQSMx/pKphQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=g9wudjUtrEMXkfDxrXF6vMS1DzUYOZGPuyKZw5Tmyb0=; b=MZS/oMY2
        l7NtbfimZD7oUMfpAQ6TeuUUSS002UQQH7DR2QQSk/fii8yt5tsdiW7wwSpuQLK9
        U8raVHrii6MCXqWTDWOur6KGPMlq2Tr1R5oTE4+yW7zg3IAxHFz8BGjJsFFVT3Sz
        hsCF/T2pgq29jrEmR8um4Xp4C8W9Ta98EmU3y11GJ9RX3D+nhi6otg1LZ0y1Kqvr
        pdWFNM6ifdA2Rdi19z4NcWy4u8whh8ZmXDnMi8Fy0rGIamm+iw91QjFfPzaqkpjx
        7pWL7S9K4h1WMevAX9mOuMNKP1Zet5UDObksT65gJeJ6GCTQzw1bYj5opuL1O5mi
        3NR60Oigvwupew==
X-ME-Sender: <xms:wvwMYVWBpd_dnWy4Ex_d3i1qsIH0CNGUqaDhIrpt1YvKZfsDutq0ZQ>
    <xme:wvwMYVmL_CPjsiafgIMaWCPS18NB1bq_HblF_Cr2SHl5xL_ZvTb36ObgK3HuBv-t9
    B9S_K1acXIM9y-mIKE>
X-ME-Received: <xmr:wvwMYRajJdONEbaZP0VZzdNqRolEElBPe6ExKpa7gIdWlwtCWvg60VB6YD9q4KRl3dLlH7xtGcKFPNpZP0E9Aw6wwxouGuUyQgA2x-dBzlCfNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheffjeetteetke
    ffhfdvgefhgeevvddvueejheehfeevfedufeegiedtheeujeelnecuffhomhgrihhnpehr
    vghmrghrkhgrsghlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:wvwMYYWgt2jhySc1oYMKAC7m5PvBp20401fLxy8h1DFTObDOtY0WSw>
    <xmx:wvwMYfmaRh0bvYkuuHnaxMPgnNME2wfjll0e1UyXPoppcMgMHPh8Sg>
    <xmx:wvwMYVdOvjLHihH_MA92-PlQz7w32mPtODybHEyWCNDxjX93nlHW6Q>
    <xmx:wvwMYdWd85KlzxskMKX3XuRs0KTa5Kg4HJXT7E_LoL_bR4Xqlmk0mQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 05:11:26 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v9 04/12] mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
Date:   Fri,  6 Aug 2021 19:10:50 +1000
Message-Id: <20210806091058.141-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210806091058.141-1-alistair@alistair23.me>
References: <20210806091058.141-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/mfd/simple-mfd-i2c.c | 12 +++++++++++
 include/linux/mfd/sy7636a.h  | 41 ++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 include/linux/mfd/sy7636a.h

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 633a2b28b6cb..5c4b6fd59fa1 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -64,8 +64,20 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
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

