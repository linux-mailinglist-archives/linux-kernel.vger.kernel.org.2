Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364143E26D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbhHFJLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:11:38 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46383 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244130AbhHFJLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:11:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 73FDE5C0069;
        Fri,  6 Aug 2021 05:11:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 06 Aug 2021 05:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=ogU9rvn58H76K
        bCYMD7NwPKqr7V2CMfGEVCJQIcAJsE=; b=OQ/i1pKU525+gDH+dq0eoWVtZCIZN
        c+5/441UAtHtt+IPNp8ZCyXTaEgGHZue0c8jKj31bxucf1iBX1Du1p6PwM0n04FW
        WtfaRaZM6mD19zx3uDhmpzg/pBgeIFTkI2dMklUC76X/bwdIzS2k0J8yU0tUtVoF
        5qo/S0GCZhl6uvjsHVafc5s0UrFaWXW5TvsNbepV4BARmGJpHMX0KeAla9tsV5KR
        W49BJEkDQkxLKmZf2smpwK9fRrWZtpIRY3SdSttA3TQ56gAn1FAJtsa5WvEamfz6
        UwEPVLTn0/sgJbENRVaJiKBOn1RlC4CNf3SgsPx4enbkvCwWnqLvayG9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ogU9rvn58H76KbCYMD7NwPKqr7V2CMfGEVCJQIcAJsE=; b=wpke7ptQ
        dO8At2TKvJ3f9pyPCOl8+jB2dPQy+Zcpy306k8eNCgVaQbisdy9Uo4I1h4ba1m/C
        jBNKJBzMnz+ZZVjXNGi2mDwFIfoZCeAU3Ac0aByxn30Cxnp0qfYxvneEX2QH9+tP
        qyfOazYNLZGCKLiYlTKZqrO8krMAH21D0awBuCpwW2ayUIZZAahR4xIanbW3DSqV
        RaqmYJu7ivVlK01izxhDqBCLX1ya1XSoEE4hEY7Tj+bgL4c+JtHx8jO3Ajarkrz3
        NYTbE+Ka5tu4gULMFEc0T5onLBV2B3I1JwYvlXo6RH5EhMgfMjZ75V69RmGuflma
        dO479eq55cWczw==
X-ME-Sender: <xms:ufwMYWbVJVsn6IJ_482EUw2ieDqRPPX_kAZTcjJEq0jNKYg3vxHV4Q>
    <xme:ufwMYZac00Jo_LRQgoHkN_Hctx9ubIMZWoXw5Mpz4l0Lr57l9UViJAbgrcPwd6KM7
    JCCNopnVp4sxoJ-UFo>
X-ME-Received: <xmr:ufwMYQ_IcPigHWoMPR7HJwB-ULalk4S21-6jHSD-4m8fGHiuw559f0h31E4df4y_m8jvRFYVCzEXc3gTZ1WnOtzWGN2MmMGUq27tCZ33KaQ36Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:ufwMYYoUetBvwHu9zC4rWVJGvEOCHdHik-w5YO9uS_nawz-B3a2CCQ>
    <xmx:ufwMYRp_6kktDYdEYa6snn6lb5bKfWbnUWzjcvz5bOX1TCb2kt4Nvw>
    <xmx:ufwMYWQW6F_0NNQ3vWEhfnFfj-Q02fp1PJqq-Myqu2XnU29vPbW5FQ>
    <xmx:ufwMYVJ4VcVYbDZ2hCKF6dkEiiMPiyyGveS3zODlbr8g3oD2hHzWkQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 05:11:17 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v9 02/12] mfd: simple-mfd-i2c: Add a Kconfig name
Date:   Fri,  6 Aug 2021 19:10:48 +1000
Message-Id: <20210806091058.141-3-alistair@alistair23.me>
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
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6a3fd2d75f96..09a939f8b7ff 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1176,7 +1176,7 @@ config MFD_SI476X_CORE
 	  module will be called si476x-core.
 
 config MFD_SIMPLE_MFD_I2C
-	tristate
+	tristate "Simple MFD device"
 	depends on I2C
 	select REGMAP_I2C
 	help
-- 
2.31.1

