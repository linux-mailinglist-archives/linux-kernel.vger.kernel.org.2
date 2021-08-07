Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB7F3E34DF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhHGKkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:40:15 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36733 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231866AbhHGKkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:40:12 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 75D585C00C2;
        Sat,  7 Aug 2021 06:39:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 07 Aug 2021 06:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=qBlHc/HzAsSKMeFA1XMS6ZPxfm
        sCIHtt2iKmIwR3PKY=; b=ZI1i3pU7JmexFwteQ+DC5PER7UCUAHT9Q6dcZ6Tk5X
        jLleqKpG8nKvpnjNJ6XI8KeAnv/0lDqR80/BRBXgRLGxuSynFWN3Hncb/XS6RV7u
        FB9v/9hU/RooHqzoJ6Qtdvlsvi3zKQqh0PbwrDAtyQVQuxaE94ZXqhmW1azVAtzP
        ER5RDZ7+GQwgFqE1z9y8IkFP4T2+xs7SPqm6hFBPNMf+2wvrZ7JUO6mEQ9WVuiKw
        Ai/oGaSBdLl73wCLGohTMjXJ8OlGJSq2WBHrrn2d8p92m/1ipQo3uJKJwIyLzdUy
        as1q4F8eQYKvPXHsJd0pv1mr0JJnYG9nw1mk9EftgUCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qBlHc/HzAsSKMeFA1
        XMS6ZPxfmsCIHtt2iKmIwR3PKY=; b=D/EbGsvnMDKSmyGg5VQlFs1WTC+9QnvK4
        nm+X/4vmHmoA+SpyBjg/nDyOcIr2ozYRQAvyNy1x3du6GWJEc+jFI1kUf7mbhAHF
        XEkOLCUvAvsVjoz9aq7/83TH2KTmmt4qonDmEGAnjkxUJLXHf39Cofi07PngZnrj
        bwNwAPVt5XjFXh9pXe0fmt/kpKVlomJwdFQPY1xZa21pfLApBOYQ71m0XdmXlAw7
        4K2MhqYwqYTNJk6Fb5tp9HRKIxAPrzFU/tCa5FV1MMXERXbEh3viZm6p0OS3qRb5
        cPv3BeQuZr/R0D7ixlaTp4qM3Pqpwy20wfi6RjplBEqb4Ft/baAEw==
X-ME-Sender: <xms:-GIOYa05UfqKGqGPxUXGxiCYKnkPUaR3LxKf5_l1WhTDnx4bOaV99w>
    <xme:-GIOYdEY2QeEqJYIJvdZNfVSMKoc0oZH7dG12tIskxQUjtM_CU54aEajstZaWj9Sz
    G9gi34_aHWwX-qBByE>
X-ME-Received: <xmr:-GIOYS6vx3nYbXnuF-rZNbV6xlR88_htdsYI5YhZJUU0L88kNaoxGLhFYnP-ZNS5gNyTpfmOa9OEi1rZ-D0SK4tP2EcChY0t3N_5qzcGc9PAGSYbaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeefgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhes
    rghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepjeeliefhvdetgfdtte
    fhtdegffdtiefffeejiefffeevueeljeehjeevhfffueeknecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrg
    hirhdvfedrmhgv
X-ME-Proxy: <xmx:-GIOYb1WtOg8EmnhkRWv2Q9CV5MlvmZYW-PoGmLG71N4H6QWzxUMXw>
    <xmx:-GIOYdGANjM0NJuuZN0dA0iab5YK0y9KIhlACEYCLWSMFzKYbhiGVg>
    <xmx:-GIOYU87g0XdueV5s7M2jtwz_I1a8TQpaXC5o9n9CVZDz3DfpTbViQ>
    <xmx:-WIOYU15bkEwZAmegQxDQsdQdkCfB4f44z_7bFDX8d8CjPzfdrxkGw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Aug 2021 06:39:48 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v10 00/11] Add support for the silergy,sy7636a
Date:   Sat,  7 Aug 2021 20:39:29 +1000
Message-Id: <20210807103940.152-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series applied on top of the "mfd: simple-mfd-i2c: Add support for
registering devices via MFD cells" patch. Once "mfd: simple-mfd-i2c: Add
support for registering devices via MFD cells" is merged this series is
ready to go.

v10:
 - Use dev_get_regmap() instead of dev_get_drvdata()
v9:
 - Convert to use the simple-mfd-i2c instead

Alistair Francis (11):
  dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
  mfd: simple-mfd-i2c: Add a Kconfig name
  mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
  regulator: sy7636a: Use the regmap directly
  regulator: sy7636a: Remove requirement on sy7636a mfd
  thermal: sy7636a: Add thermal driver for sy7636a
  hwmon: sy7636a: Add temperature driver for sy7636a
  ARM: imx_v6_v7_defconfig: Enable silergy,sy7636a
  ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
  ARM: imx_v6_v7_defconfig: Enable backlight class devices
  ARM: dts: imx7d: remarkable2: Enable lcdif

 .../bindings/mfd/silergy,sy7636a.yaml         |  79 ++++++++++++
 arch/arm/boot/dts/imx7d-remarkable2.dts       | 115 ++++++++++++++++++
 arch/arm/configs/imx_v6_v7_defconfig          |   5 +
 drivers/hwmon/Kconfig                         |  10 ++
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sy7636a-hwmon.c                 |  77 ++++++++++++
 drivers/mfd/Kconfig                           |   2 +-
 drivers/mfd/simple-mfd-i2c.c                  |  12 ++
 drivers/regulator/Kconfig                     |   1 -
 drivers/regulator/sy7636a-regulator.c         |  13 +-
 drivers/thermal/Kconfig                       |   6 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/sy7636a_thermal.c             |  91 ++++++++++++++
 include/linux/mfd/sy7636a.h                   |  41 +++++++
 14 files changed, 445 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
 create mode 100644 drivers/hwmon/sy7636a-hwmon.c
 create mode 100644 drivers/thermal/sy7636a_thermal.c
 create mode 100644 include/linux/mfd/sy7636a.h

-- 
2.31.1

