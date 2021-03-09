Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD021331EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 06:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCIFcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 00:32:18 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:33251 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhCIFby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 00:31:54 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DvkNT0K3cz1qs39;
        Tue,  9 Mar 2021 06:31:53 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DvkNT06V0z1qql9;
        Tue,  9 Mar 2021 06:31:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id XUCAijo_7w9i; Tue,  9 Mar 2021 06:31:52 +0100 (CET)
X-Auth-Info: 0rO/okNEWyZHKrvSmsXtTDWGiA2Hjr/so/OdDAAKC2I=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  9 Mar 2021 06:31:52 +0100 (CET)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 9E58A181BA1;
        Tue,  9 Mar 2021 06:31:18 +0100 (CET)
Received: by pollux.denx.de (Postfix, from userid 515)
        id 775871A0092; Tue,  9 Mar 2021 06:31:18 +0100 (CET)
From:   Heiko Schocher <hs@denx.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Heiko Schocher <hs@denx.de>, Alice Guo <alice.guo@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Li Jun <jun.li@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Teresa Remmet <t.remmet@phytec.de>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH v2 0/4] enable flexspi support on imx8mp
Date:   Tue,  9 Mar 2021 06:31:12 +0100
Message-Id: <20210309053116.1486347-1-hs@denx.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series enables support for the SPI NOR on the
imx8mp based phyboard-pollux-rdk board.

Patches new in v2:
"spi: fspi: enable fspi driver for on imx8mp"
which adds own compatible entry for imx8mp

and seperate in own patch the documentation entry in
patch "dt-bindings: spi: add compatible entry for imx8mp in FlexSPI controller"
as checkpatch says:

warning: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst


Changes in v2:
- work in comments from Marco
  add own compatible entry for imx8mp
- work in comments from Marco
  - add own compatible entry "nxp,imx8mp-fspi"
  - reworked order of properties as Marco mentioned
- work in comments from Marco and Teresa
  - rename node into "'som_flash: flash@0 { }"
  - compatible is now first entry
  - removed #size-cells and #address-cells
    as no child node. If bootloader adds them bootloader
    can add them too.

Heiko Schocher (4):
  spi: fspi: enable fspi driver for on imx8mp
  dt-bindings: spi: add compatible entry for imx8mp in FlexSPI
    controller
  arm64: dts: imx8mp: add flexspi node
  arm64: imx8mp: imx8mp-phycore-som enable spi nor

 .../devicetree/bindings/spi/spi-nxp-fspi.txt  |  1 +
 .../dts/freescale/imx8mp-phycore-som.dtsi     | 25 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 16 ++++++++++++
 drivers/spi/spi-nxp-fspi.c                    |  1 +
 4 files changed, 43 insertions(+)

-- 
2.29.2

