Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944B53F17CB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbhHSLQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:16:25 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48955 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230089AbhHSLQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:16:24 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8423F5C0183;
        Thu, 19 Aug 2021 07:15:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 19 Aug 2021 07:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=gzG3udI3AdEvoCdC3yMHecAclK
        S/dCHsHIRkDLel0UY=; b=gGg044R+ymHy/nCZT0I2sFKTyVXApDsK8jozpwddXv
        dMwzfp5e2d6AShgcqMwciH6Rhou/Bg5dhfR1UWm+A3SVefmSBQuWPKT3SVt2kclZ
        4HN3LglTIru/HWEQ93YRaV2lpf2iFLPsc5eTCmI6GDiYFAepCnXPiCVMGH2AMQ5F
        q5IMO6kkV+e+PXMxokMaVNFKccmw2EKlS3Xjp1SwczHTJyOwJzauKHF/EFydkhEW
        yU0p/ATH3s70Yy1Ul656SKVzX1LQaSDuEoTVla4E2oh6ORERpUzfMB7fJnqX0Tw3
        gHU67ihsvBLcSxASvIvDhYX9KYn49xIojqWtx1eRtn3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=gzG3udI3AdEvoCdC3
        yMHecAclKS/dCHsHIRkDLel0UY=; b=TumMCQgH+o6K2I4xn0J85r2ZLtFF6zSCE
        oBoi29c28ooGPU2xks8RxURct0LzBIe7yLH2abdzSu/YH4FNDubTZEUgL3FOXVc+
        CWsDeudfgw1G+Mnum1D2K2Sh0lZO5nYhRhKEEpnN2rjTJSuiz0HsbFYuxjmQ9Ob2
        FJUdO98QnQQw4ZWqmUm/T/LLE4Hgx2DZahq3xiXIyYV8EKR/aLhP3WimWnSy5/Tt
        9PcH6cZExSxuc/tD0+LLIlFgdCDa+YNuxbz7FCSvQIk5GbA/Ba+/LUdd0xfbOgzU
        iG0OyjqQ7rZBtjZfDggrHzl4oTkD/UGw7G3R7kqhGK3a5lLfy2DTg==
X-ME-Sender: <xms:Yj0eYcKiUvJcnzZ7cpGyU5N-BPCC68VhZS8o2bV0bCDh9aorvgn92g>
    <xme:Yj0eYcK0N_p0fxsTzQJWu6Azqy7yA5wSV_uQrQSHEmefcZQg4Vg2w3N01g0eNELdI
    iJ1CGIVaFPggCFow5s>
X-ME-Received: <xmr:Yj0eYcuaVmx_SDAVhMXZvfM_IJFCQyyQoYmLAFnvSPvOLwaCoW9FEes80xNrWlAWFvyroyPTyl_12EICYmBClG7RyqH4o_y5hat5wROeMTVKGwM0Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhes
    rghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepjeeliefhvdetgfdtte
    fhtdegffdtiefffeejiefffeevueeljeehjeevhfffueeknecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrg
    hirhdvfedrmhgv
X-ME-Proxy: <xmx:Yj0eYZa2-fHfXYNR54fbPFueCiieq5tHeANw0NHmiQJMgUWNZHjF4g>
    <xmx:Yj0eYTZG6QO2wPuPC2Ia0aV8Ku34enwhjFbvHQavAmvl0RtsQurohQ>
    <xmx:Yj0eYVAFFk6GAOxv7UP0R6Aj6G7W9BV-O2wrvkD49uUuXrMV6Cr7bQ>
    <xmx:Yz0eYX7z35FIAD5dHZv8IPX7Hg5rb1MqLnND4yw0JOVb6HiudLTpcA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 07:15:43 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v11 00/10] Add support for the silergy,sy7636a
Date:   Thu, 19 Aug 2021 01:44:39 +1000
Message-Id: <20210818154449.1037-1-alistair@alistair23.me>
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

v11:
 - Address comments on hwmon
 - Improve "mfd: simple-mfd-i2c: Add a Kconfig name" commit message
v10:
 - Use dev_get_regmap() instead of dev_get_drvdata()
v9:
 - Convert to use the simple-mfd-i2c instead

Alistair Francis (10):
  dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
  mfd: simple-mfd-i2c: Add a Kconfig name
  mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
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
 drivers/regulator/sy7636a-regulator.c         |   2 +-
 drivers/thermal/Kconfig                       |   6 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/sy7636a_thermal.c             |  94 ++++++++++++++
 include/linux/mfd/sy7636a.h                   |  41 +++++++
 14 files changed, 443 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
 create mode 100644 drivers/hwmon/sy7636a-hwmon.c
 create mode 100644 drivers/thermal/sy7636a_thermal.c
 create mode 100644 include/linux/mfd/sy7636a.h

-- 
2.31.1

