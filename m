Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D433E26CE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244060AbhHFJL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:11:29 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58525 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242767AbhHFJL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:11:28 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BDC665C00A5;
        Fri,  6 Aug 2021 05:11:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 06 Aug 2021 05:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=2jOybSs9TtAexc1FVgXsMMKDxA
        C3jAkiB3EktBm34Hg=; b=iMbyNR0xJUcFCOUhXU+iuHZXw2XItkl9REyT/UldQx
        cWjUGdYDew0wrHeiz6/trVxw5rpUMn5LkjVqb/m3nCoLMW9RJWu1gYBLpY10PduA
        PQIpKJKyYnlrrdmowuI0NyAiDi8RMG4z+HR7qHO7pFaowymbiDiU72GPK7Z+9aDZ
        hF5J3nkBQBotyhzikDcZsf8ShvLLwC7SId6nt99auSNQ+VZ1MOsNIvf/ByJeqEI3
        hQix1noiAVpp1CKnRzv6lZP7P/k0XmWu+E2nOhznFZAlIrtEtg2SoTvAdK2dFgQc
        9t0/Nf7hDj23Wz2EOiylxFuvZuzPrztEnwZo+wB+vOLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=2jOybSs9TtAexc1FV
        gXsMMKDxAC3jAkiB3EktBm34Hg=; b=rkXkWOdWFjH2iYYtyey8SDE7QZMUvxTQ7
        cAym4hMDt6nplR3opieYqoyogGtF9ZDdkiKrrxAarKEEf6crMOCotGlXwU8Xo5oS
        5/lYxj3zM800VUiD7cxpQ7jiQ0SgeksVMWhWU876mbRZeVDLzX/mM4wbu2+LR5Dk
        o+EEGtsNdo+s7hsOsZ/K/13pQNOwWfrxN/ruickwyyn1vGSX1NFPGBnDBdHmOyv6
        DnBnKjDUheiFojRm9A9laaYdojGFl1ugUvBu9H0MXTWlFlnT75COx0jdukVMgtje
        MNxSHHgvaOhTtaq+scinBzK3M4X7UF8l2E0e/2z9mpKsOoSiHjYdQ==
X-ME-Sender: <xms:rvwMYREocutIzwxWnx7r5ZJTHNQoqWncioksT_IaVWcwoAhihLf1pw>
    <xme:rvwMYWVxPMWAkVyVl5ukI9O1bEYO1QtdnQ9pCRzcqcGGMbCrNbZ8QtFJjCL7R_1fL
    vdtwCoYhDTl5sn2HT4>
X-ME-Received: <xmr:rvwMYTJeGV-1VSKR8HDh_4yt1BnI65v6T85wJN0z0R5wz2JLzCQI0lGWwMy4fmfwMDKw1_XffPTJeJ0c2uAgL6Yo6CrxvOccpTiTgmGnnxWOoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhes
    rghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepjeeliefhvdetgfdtte
    fhtdegffdtiefffeejiefffeevueeljeehjeevhfffueeknecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrg
    hirhdvfedrmhgv
X-ME-Proxy: <xmx:rvwMYXFzab_sXSCLcJFm56r0_E8UWgg7fpW94i_j2y5rzIwN11b92A>
    <xmx:rvwMYXVxDeSay2sAiOXQIyGhm4gFhQEw-NRp012eB7zaWe8QAGA4Ew>
    <xmx:rvwMYSMJa7xSQItov_Iz7tsU-k1xLjfMYdyzfWquxP-jtnzyzPU-jA>
    <xmx:r_wMYeEeacEyFxc7XEPBoDZYfj_et614AEelIsb5yJ4GFanHzjlbYQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 05:11:06 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v9 00/12] Add support for the silergy,sy7636a
Date:   Fri,  6 Aug 2021 19:10:46 +1000
Message-Id: <20210806091058.141-1-alistair@alistair23.me>
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

v9:
 - Convert to use the simple-mfd-i2c instead

Alistair Francis (12):
  dt-bindings: mfd: Initial commit of silergy,sy7636a.yaml
  mfd: simple-mfd-i2c: Add a Kconfig name
  mfd: simple-mfd-i2c: Save the register client data
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
 drivers/mfd/simple-mfd-i2c.c                  |  14 +++
 drivers/regulator/Kconfig                     |   1 -
 drivers/regulator/sy7636a-regulator.c         |  13 +-
 drivers/thermal/Kconfig                       |   6 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/sy7636a_thermal.c             |  91 ++++++++++++++
 include/linux/mfd/sy7636a.h                   |  41 +++++++
 14 files changed, 447 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
 create mode 100644 drivers/hwmon/sy7636a-hwmon.c
 create mode 100644 drivers/thermal/sy7636a_thermal.c
 create mode 100644 include/linux/mfd/sy7636a.h

-- 
2.31.1

