Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2B33E34E9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhHGKkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:40:45 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43187 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232030AbhHGKkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:40:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BD4645C00C2;
        Sat,  7 Aug 2021 06:40:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 07 Aug 2021 06:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=e6he+/Ctx/CNm
        IsbU2QMgTzDIo771ajT2nYYxlA1LyM=; b=bqIoMXnUOaher/RJW21cq4vAuNdi7
        R2f0o0R7UAQtOFspGZOZ7K6HmbM6ucKTsxyFX4rma/SVYki1k1RbZqIYuc/B77w+
        FaZcn7519ayBx/JkGgDvSVVqsH0NVNZ4uNb9sbzRiB0rSCzz3sVL+NUmJ5Di1en0
        +3uZdrfLSpIj8QYqK67t1vlgfTo9DXKtYLbTB6v7f8z90eq2dewXcZhvq2bpS+yK
        KNjgsDZrOY5kVBJUNq6KXkVFZ5SVVv8k018N3tDT3KOIH3I5+T/r4YCu8BT6mEtp
        wcT1upJ/jGPN7/HyxSyismUU6bWud32VIT2+bNgzz/OgNDxNcuiWkSkmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=e6he+/Ctx/CNmIsbU2QMgTzDIo771ajT2nYYxlA1LyM=; b=FcEZRYsJ
        qwikopfsTOhaN2pzLTiXFBoQTxHmh/eWm8xW+xoPQBYzDDIiEajZGvNl79tOLiPM
        R+gmLAH7xr871BXG8/ThpUlAEzLib8+FL77WVsoDaFH8iq5b2wR65q2vZUABTKVh
        UMdEYQF+ylLFGMBZk2VTgiF45DiYzrm4k0avrSAGJmvhY9hmUsMqKCElCSRUeIGK
        nU4OfVxDEyAk0C6jj6dx/lbxXJPEBvNCfa6ocmTOyMB/t8cgesIzGJ2JYfMIqoQ9
        tdxmXS+58YoDHcLfn0ShWFtpG2NH5Fu/+3gMaBdEt1KrwNTmn5qVHf02tTGLujob
        fs1DJrzPk2GDrg==
X-ME-Sender: <xms:DmMOYdsb0H7J7ApVgMQZ_yNUj6MnfDWmjQvnBJd91asf0WLuLXuUBQ>
    <xme:DmMOYWe6fNd7NmO5JbekGAfIH4Cj34YedhSHD46MJQyqN1Luex2twvIBjw7yFpC_u
    vLxZdeAR_swRPkI05k>
X-ME-Received: <xmr:DmMOYQxA6O_1HaZNHyL-pu6ShhvNs6Pxpyk0fRNPboMve1z64DSMDOgBlg9jfRuKefvECoO9fAQDfZUM5HK0nNg_6KUs-I1ncHYoxEjldp0qYEu5Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeefgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:DmMOYUN5YYdJZYGJJzenHrOmM8UMWJeQUjoEwY5XPZf96zs3zCjHyQ>
    <xmx:DmMOYd-XelcwGDMpwUDFN5V8F6KAEXn0qc4KqHnWCxkNz9O0h68I7A>
    <xmx:DmMOYUWgH0hYTZmekAMR93TRl_YhEihVFAyGePr2WSsX6GZ_DeMz3g>
    <xmx:DmMOYWOsNbnoutr2swylNVmhy57QatBSr6HXqgj95_-6Di-slrasXQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Aug 2021 06:40:10 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v10 05/11] regulator: sy7636a: Remove requirement on sy7636a mfd
Date:   Sat,  7 Aug 2021 20:39:34 +1000
Message-Id: <20210807103940.152-6-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807103940.152-1-alistair@alistair23.me>
References: <20210807103940.152-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/regulator/Kconfig             | 1 -
 drivers/regulator/sy7636a-regulator.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 24ce9a17ab4f..54ba141d114a 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1179,7 +1179,6 @@ config REGULATOR_STW481X_VMMC
 
 config REGULATOR_SY7636A
 	tristate "Silergy SY7636A voltage regulator"
-	depends on MFD_SY7636A
 	help
 	  This driver supports Silergy SY3686A voltage regulator.
 
diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index 8360b3947ead..22fddf868e4c 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -70,7 +70,7 @@ static const struct regulator_desc desc = {
 
 static int sy7636a_regulator_probe(struct platform_device *pdev)
 {
-	struct regmap *regmap = dev_get_drvdata(pdev->dev.parent);
+	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
 	struct gpio_desc *gdp;
-- 
2.31.1

