Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFA43E26D7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244118AbhHFJLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:11:43 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60059 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244196AbhHFJLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:11:42 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5EAD45C0069;
        Fri,  6 Aug 2021 05:11:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 06 Aug 2021 05:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=XKlXLoBNlaHND
        u0EOANVveZ6LtrEhJqjY1foOLxcJtw=; b=HEVLYXJayBB0cvfNmwtGWuWycJtNG
        dZdpl3X+9sPCyAh5DhgZ9q/+j1N6GF3udMKW4WTMfFjy9sxpXoiHK4z9XdGij5sF
        5KVcdT6T5xqHybMAdnd2OZvYCpOtnDEwh8Z9faGRdnIPudFjvMtVo4GFTJooxZnO
        J8smUI+PHFV+CS3aRVPG4vfjmfFljMLah2NTrW0QptBKXgSHjFWjBvyazWuakRCL
        r76Agb5IhAdVMbDxp+/JxdBmRYTgqf22bY3qCI/BnjSoFkJkVopCI0VvFFCFtRYZ
        jjAoYDSJ84Ery1fqw+6Dzm9qRbRYhPVx1efGzPnhsWzS6UM0B2bj/Q6zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=XKlXLoBNlaHNDu0EOANVveZ6LtrEhJqjY1foOLxcJtw=; b=A0h/Cr7G
        ZkaoDGN++lVBFZX7gBwVOtqwcIIp2x+kmOJQMy31X0Wq+SVyMitiDiTCLAfnwsYv
        z7yEifNYYOMkl9aW8xzBnYeEGSE3tKMEzO1I7/oHgbiw5uyeZabpiLWTykl9o/6e
        kNmeyS9pvgiX0YRk3SwZf6e+bVJPjD7hi4JyfuvVT0RE5XwdW5fcU6BgkkmLvq0p
        X6kqGhhn+vmYPQrovet7knaKP94ZAzcjUYUQnrdKg4DaH26n0I0P73BQUxTNRLyB
        /zrEndHof4SoHkqYVrXcZE2QNTxkXB+YtD62rLWA7JfdLsmxFy6Lb5uUHBmLxRtY
        wv6R1wlUzgCzaQ==
X-ME-Sender: <xms:vvwMYXEIhBaVAKQA-mwcjvOsbKKzVshKEgrRBlaazKdgfvnQY8iL3w>
    <xme:vvwMYUU670PwuDIhQazyki6v_-O10JKZ4AH_TSiLPIwjN1v3AZ2jOWPJYAlI7XTPy
    JD4xp51MqWsBw2b5hY>
X-ME-Received: <xmr:vvwMYZIlMmCv2ramAXvUYIvXx-AmEuhMO93nfjB6875ytuP7iHj_snkmz08ShWU566_-dStDxtt9BGVDue71MyqTGgOdCrVsg1D8JGGMnCWPjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:vvwMYVGXlobLEowlGPOT4vv_kRT2DM8sE75F_5vUnbgvjPzQT1BdVA>
    <xmx:vvwMYdX3AJMNnWi-Yxv89sKmfBXT-QMRJCIyy3Cj0BNEqR5hZGBClw>
    <xmx:vvwMYQOAVSU-MwbhQdVHkrMjhqMXKaRpLGJX64_xXJOYl5FAjgc9ug>
    <xmx:vvwMYcHf31cTOhI4Z8Ff2TFH2WDRnxeJwJo0fBEPFNr55zQAK5x6tA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 05:11:21 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v9 03/12] mfd: simple-mfd-i2c: Save the register client data
Date:   Fri,  6 Aug 2021 19:10:49 +1000
Message-Id: <20210806091058.141-4-alistair@alistair23.me>
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
 drivers/mfd/simple-mfd-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 583e8c7924af..633a2b28b6cb 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -48,6 +48,8 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
+	i2c_set_clientdata(i2c, regmap);
+
 	/* If no MFD cells are spedified, use register the DT child nodes instead */
 	if (!simple_mfd_data || !simple_mfd_data->mfd_cell)
 		return devm_of_platform_populate(&i2c->dev);
-- 
2.31.1

