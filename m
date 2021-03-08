Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4923311F9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhCHPTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:19:03 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47462 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCHPSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:18:35 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 93F0D1F45126
Received: by jupiter.universe (Postfix, from userid 1000)
        id D4ED24800C3; Mon,  8 Mar 2021 16:18:30 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCHv2 0/4] Bx50v3 DT improvements
Date:   Mon,  8 Mar 2021 16:18:25 +0100
Message-Id: <20210308151829.60056-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bx50v3 DT improvements

These are a bunch of small unrelated improvements for the GE Bx50v3
device tree (and BA16 system on module, which is currently only used
by Bx50v3).

Changes since PATCHv1 [1]:
 * change patch prefix for BA16 patches
 * remove extra newline from PATCH 1/4
 * keep 'status' at the end of FEC in PATCH 2/4

[1] https://lore.kernel.org/lkml/20210223183346.138575-1-sebastian.reichel@collabora.com/

Thanks for reviewing/merging them,

-- Sebastian

Ian Ray (1):
  ARM: dts: imx: bx50v3: Define GPIO line names

Sebastian Reichel (3):
  ARM: dts: imx6q-ba16: add USB OTG VBUS enable GPIO
  ARM: dts: imx6q-ba16: improve PHY information
  ARM: dts: imx: bx50v3: i2c GPIOs are open drain

 arch/arm/boot/dts/imx6q-b450v3.dts  |  5 +++++
 arch/arm/boot/dts/imx6q-b650v3.dts  |  5 +++++
 arch/arm/boot/dts/imx6q-b850v3.dts  |  5 +++++
 arch/arm/boot/dts/imx6q-ba16.dtsi   | 21 +++++++++++++++++++++
 arch/arm/boot/dts/imx6q-bx50v3.dtsi | 12 ++++++------
 5 files changed, 42 insertions(+), 6 deletions(-)

-- 
2.30.1

