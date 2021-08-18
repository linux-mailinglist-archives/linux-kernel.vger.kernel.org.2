Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA633F17D4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbhHSLQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:16:49 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42519 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238577AbhHSLQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:16:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6EC295C00C9;
        Thu, 19 Aug 2021 07:16:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 19 Aug 2021 07:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=e6he+/Ctx/CNm
        IsbU2QMgTzDIo771ajT2nYYxlA1LyM=; b=FPPsQWSaWd0pXA2DuBwOLiW6FFbP/
        tLXSeQeulECpS9Vqh62ExYqX7gW3mg4r3YR1Lbi4h5XXUdjDpEucwBTd46FJjDUU
        TE1R6EOOUBZHXVpp+Y0r8gf9TQ4+or33A2vRuUASICtbL+qp0mcNm6gJ5UMVYFgr
        O9QVweyjDKQqltEq53UexZLGsPU7ezhQfiOq2Dr/eTwXmoRBdgAxVJhCseakyVjI
        FYYzUEGDpHc/IEI3OFSSzZLWiqTDX8jQMm/rBNh5Wbz0yKAumzsk97fuxVGIsZeO
        mmyFTsQ6g14gUc9A4Tsai63g7blTdni/b1doNrT3XjqSE3juXGSiGXs4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=e6he+/Ctx/CNmIsbU2QMgTzDIo771ajT2nYYxlA1LyM=; b=HNiJ0D8C
        adTE4Hg3ErKly7OUJkM71+NxT0tSQLtc4DECSHtCNEjOx2jLEZL82iYJfrlbFKHX
        aBcZx3xDP+ZW8aEuhkLg4DN569E7LpQRlCIpcdKFBMvyqF3Y3QCeez6RTALHJNSO
        nuo4LaNVah71hAfucjT1AeVg6zfFWS+z1E3SNesCRSxJ31eqYmidq4hF701ZnE+n
        wgDE16ncG4m62jISSv8u6Ja7wpnX/AUUDbRFD0GG7hgGT+ErTooZ7QzNNxMaRv6K
        EXOphBB/9ZsIcM26Uc2X0Ij1ZyN2CNewIuU2VQtwAO/fL5+7T2rK+tHnZtZjgQdn
        4ClAjdzNNcDKCA==
X-ME-Sender: <xms:dT0eYfYZOhBSftHi87hHtKxQ_GT0u4pSDGocpX_scXeteINIUj-7TA>
    <xme:dT0eYeYtzqbDbZDNNE_uZTkFE4CjL6WiEvEN6XXpDjBhhNlK5lqSy5L8FhIwKrFqA
    ekE8LhYHpEq_bVGTeY>
X-ME-Received: <xmr:dT0eYR-Hbv71Mx7yWnTt_MAGEtCDaVguZYI1GMuKovfe99qVITzaQRA4t1t8sZdKhPSIbo6lWZwBeAJ-xnhDArSeTOdaUWoAePPrJv7Ez-LTMJg2_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:dT0eYVrO7FmsuuFjj282eKvuIRireS_-hOWfZFqwpQSAQB2BfYUhzA>
    <xmx:dT0eYap8dI5mqADHzLTooIFxs5jyqliHKETC5KVCh-fEGNyQiCAdUA>
    <xmx:dT0eYbRsOCn3hn5RBzlqutN17ytHz0JAEgcoCqV7qFSlsYve-3UtCQ>
    <xmx:dT0eYaL9VvVd9fsC2z8j4WtxqGcSJVa0E90Q5EwxBSYuG5ixOD6MHw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 07:16:01 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v11 04/10] regulator: sy7636a: Remove requirement on sy7636a mfd
Date:   Thu, 19 Aug 2021 01:44:43 +1000
Message-Id: <20210818154449.1037-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818154449.1037-1-alistair@alistair23.me>
References: <20210818154449.1037-1-alistair@alistair23.me>
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

