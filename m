Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2A4330846
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 07:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbhCHGlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 01:41:44 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:56261 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbhCHGlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:41:22 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Dv7z557hwz1qs0h
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:41:21 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Dv7z552Zjz1qr5p
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:41:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id BQ64WyueXx6z for <linux-kernel@vger.kernel.org>;
        Mon,  8 Mar 2021 07:41:21 +0100 (CET)
X-Auth-Info: lqonFEuEy0q/QOZYz7/ZqXQnR3lU1ApsQNu8jd45+8g=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 07:41:21 +0100 (CET)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id AD411181B6F;
        Mon,  8 Mar 2021 07:40:50 +0100 (CET)
Received: by pollux.denx.de (Postfix, from userid 515)
        id 851E71A0092; Mon,  8 Mar 2021 07:40:50 +0100 (CET)
From:   Heiko Schocher <hs@denx.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Heiko Schocher <hs@denx.de>, Alice Guo <alice.guo@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Li Jun <jun.li@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Teresa Remmet <t.remmet@phytec.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] enable flexspi support on imx8mp
Date:   Mon,  8 Mar 2021 07:40:44 +0100
Message-Id: <20210308064046.1576267-1-hs@denx.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series enables support for the SPI NOR on the
imx8mp based phyboard-pollux-rdk board.



Heiko Schocher (2):
  arm64: dts: imx8mp: add flexspi node
  arm64: imx8mp: imx8mp-phycore-som enable spi nor

 .../dts/freescale/imx8mp-phycore-som.dtsi     | 27 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 16 +++++++++++
 2 files changed, 43 insertions(+)

-- 
2.29.2

