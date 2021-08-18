Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F183F17CF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238579AbhHSLQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:16:35 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56461 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238546AbhHSLQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:16:33 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CC6995C018A;
        Thu, 19 Aug 2021 07:15:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 19 Aug 2021 07:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=A2r/hYIyBwcyH
        JC0wUiLCZaI1cWMDK2yP1TGNmVEp74=; b=ACwNQ8LwBwmhslkMtqLWA/RJZW+3E
        QPoln2CMRKj6sD/T8ygBwEZ4//Aug3L+Kf2dyofJipmLBmpUIWHInqJCv27Hx74Z
        azRfbbEuLc6fRbvptb3IumjFv9a6a2qN253P1V3aCn43kk8ANEYWE5Vy7i8aQ+sl
        HAhme+qWMbDgK70wCyIZozaNOA2vI5RfLKfdkTXmiQIlC0xKI2oC+NfAj45Mz4NA
        GPBQw1IBk1hiov/xxhppUEnGj0YSidtZwCahpk6M5CYpt/sRR4gL9iqGkBURFQmu
        36N/Yi4jCUElqXiJBaDvL2N3peSApgyK7dK00m+DIEF7VIDl3h8dtGJqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=A2r/hYIyBwcyHJC0wUiLCZaI1cWMDK2yP1TGNmVEp74=; b=cTS4E1GS
        S1Z9TGHi2wK/odaeYK4iM2pZeVzZVJG9QsDuoOa9D9PBJcQNUUoBiQPVuUwpL/Gr
        XwBbe7eggwupw+VyCcK4Ic5tm9Ese3drC6DRajs8lkWJnIeQWCMfe926AJUydWvI
        GjNBXKlxJ0323V657oB9ewesNkrqwnTEvY1Plxb1RFQuh17p6KGUKukLeCGivWr6
        NzeR6z7KWESuJpPMX1Qs9MWNlccmKvYNU0iXbjyXm+B67AUcWa6PIGXtbc/Mp+S1
        x3k9saJKreACf5YxsU/vsTFrI/prgLXKry1z0k7y9YbTtczvkd0RVLhPj8NK45sn
        B1tA0DGGK3pfrA==
X-ME-Sender: <xms:bD0eYRgB0UJ_BwHpi48AGe56UJVg9voU1HuaEzHxoQAY9BNxVUBU9Q>
    <xme:bD0eYWAjD1RpzqruP3k-2yU2Ui5-wI6IXu1rIbTZ1Ee8G2VZKlwHA_fPKqfXE4vaf
    u5dgunBpzs-FKWx9GE>
X-ME-Received: <xmr:bD0eYRGoGjhP5JYIAFrasKZYYSnIPxQxVkTiTvlTkUS51Qh0ZVfTfIdDVzyyaJVnJLQxqfIadfwn8mFSFvPX_yqfzBmP2KnJo1DpLOWlQJB4VzmhqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:bD0eYWRB6MhiaO0tmgI7NiNvJSm8wA8-ahrhe39loYuX-tkD1LPk8w>
    <xmx:bD0eYexzF3I2h_pwtqLEvFWcQdqynP7YFNRPvXCbqkXjPd5L4gf5DA>
    <xmx:bD0eYc7_mKzjU-T6gsFfFS843HCs6QJ_AMcdX2QbSzgqI5p0IeRnag>
    <xmx:bD0eYZxFCHDTyp7b-A9PVN3PHKr4QKNV9n_6QaiHZQpa0Ck80kRjjQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 07:15:53 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v11 02/10] mfd: simple-mfd-i2c: Add a Kconfig name
Date:   Thu, 19 Aug 2021 01:44:41 +1000
Message-Id: <20210818154449.1037-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818154449.1037-1-alistair@alistair23.me>
References: <20210818154449.1037-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Kconfig name to the "Simple Multi-Functional Device support (I2C)"
device so that it can be enabled via menuconfig.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6a3fd2d75f96..ff95d00dc1ac 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1176,7 +1176,7 @@ config MFD_SI476X_CORE
 	  module will be called si476x-core.
 
 config MFD_SIMPLE_MFD_I2C
-	tristate
+	tristate "Simple Multi-Functional Device support (I2C)"
 	depends on I2C
 	select REGMAP_I2C
 	help
-- 
2.31.1

