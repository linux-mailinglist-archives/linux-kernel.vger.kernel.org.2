Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622B23230DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhBWSe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:34:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45676 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbhBWSee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:34:34 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8E0411F44744
Received: by jupiter.universe (Postfix, from userid 1000)
        id 2CFA44800C3; Tue, 23 Feb 2021 19:33:49 +0100 (CET)
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
Subject: [PATCHv1 0/4] Bx50v3 DT improvements
Date:   Tue, 23 Feb 2021 19:33:42 +0100
Message-Id: <20210223183346.138575-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These are a bunch of small unrelated improvements for the GE Bx50v3
device tree (and BA16 system on module, which is currently only used
by Bx50v3).

Thanks for reviewing/merging them,

-- Sebastian

Ian Ray (1):
  ARM: dts: imx: bx50v3: Define GPIO line names

Sebastian Reichel (3):
  ARM: dts: imx: ba16: add USB OTG VBUS enable GPIO
  ARM: dts: imx: ba16: improve PHY information
  ARM: dts: imx: bx50v3: i2c GPIOs are open drain

 arch/arm/boot/dts/imx6q-b450v3.dts  |  5 +++++
 arch/arm/boot/dts/imx6q-b650v3.dts  |  5 +++++
 arch/arm/boot/dts/imx6q-b850v3.dts  |  5 +++++
 arch/arm/boot/dts/imx6q-ba16.dtsi   | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/imx6q-bx50v3.dtsi | 12 ++++++------
 5 files changed, 43 insertions(+), 6 deletions(-)

-- 
2.30.0

