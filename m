Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CA345A64F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhKWPQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhKWPQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:16:27 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2BBC061574;
        Tue, 23 Nov 2021 07:13:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 7412E1F45691
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637680397; bh=oJR9tH0gHSGTkdT7fgPrfeb9cH9XD4szkiUpeUkvyZc=;
        h=From:To:Cc:Subject:Date:From;
        b=dEIjPm3AHxPBJBwAHSKm3Xs0NTKkgDR/LcE4d2UpPAuGCU64AYxynzx48AsV+UInI
         d2QEyLMjM0Z/6mtQY9Iub6Xlng1/46/fTtQCMwIDrsm5gFK+6AlmEWkEgyXejEQfvG
         JwSYwdmCUiIDBp9xyNfQqmyF3j8o/fG21x+tQQ0dM2io3SRP97cDaIG1Y4zk5bI5gq
         aozcUARcesyyRxepWABiG/brjdVHOjsjBaF/pRrFw1tocvjMFtMDA9kKUbV8/xIT+g
         E+0LPZ/Tmdx8omRrs3aksPn4Vyzz9osq3QtLyR8XkkLtpzRp5VeHf10TTo+N2WcrBC
         cjWyDdhaEj2GA==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     aisheng.dong@nxp.com, ariel.dalessandro@collabora.com,
        festevam@gmail.com, ioana.ciornei@nxp.com,
        jagan@amarulasolutions.com, kernel@pengutronix.de, krzk@kernel.org,
        linux-imx@nxp.com, matt@traverse.com.au, matteo.lisi@engicam.com,
        meenakshi.aggarwal@nxp.com, michael@amarulasolutions.com,
        nathan@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, tharvey@gateworks.com
Subject: [PATCH v2 0/5] Add support for BSH SMM M2 and S2 boards
Date:   Tue, 23 Nov 2021 12:12:47 -0300
Message-Id: <20211123151252.143631-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce BSH SystemMaster (SMM) M2 and S2 board family.

Changes in v2:
* Added M2 board support.
* Added dt-bindings for vendor prefix and board compatible.
* Fixed pmic dt entry.

Ariel D'Alessandro (4):
  dt-bindings: Add vendor prefix for BSH Hausgeraete GmbH
  dt-bindings: arm: fsl: Add iMX8MN BSH SMM S2 boards
  arm64: dts: imx8mn-bsh-smm-s2/pro: Add iMX8MN BSH SMM S2 boards
  dt-bindings: arm: fsl: Add BSH SMM-M2 IMX6ULZ SystemMaster board

Michael Trimarchi (1):
  arm: dts: imx8ulz-bsh-smm-m2: Add BSH SMM-M2 IMX6ULZ SystemMaster

 .../devicetree/bindings/arm/fsl.yaml          |   3 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts      | 153 +++++++
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../freescale/imx8mn-bsh-smm-s2-common.dtsi   | 426 ++++++++++++++++++
 .../boot/dts/freescale/imx8mn-bsh-smm-s2.dts  |  48 ++
 .../dts/freescale/imx8mn-bsh-smm-s2pro.dts    |  80 ++++
 8 files changed, 716 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts

-- 
2.30.2

