Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5B383AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhEQRNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235732AbhEQRN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:13:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4BB2611CC;
        Mon, 17 May 2021 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621271530;
        bh=Yi7dhruYvuFsXOcUWR1DB0bUICbzBR8Mtvr/y/GA60A=;
        h=From:To:Cc:Subject:Date:From;
        b=Nd6C642WSUAlj32PcDgSEnfJx96MmNV7tsTw41uA2A0VAW3MZo2GM/D3vuyi5KVKl
         aewNB4nHxyTF+nSS4QgpjrtsKC4pjeWSMokKQHKuf/QAXwAZJGp/Xrq3A/Z3HwNt1Q
         7T8cX0ILcCdpCvqv6b1CK1fD5EzBVDVgCDSjf+Dv9Me7hIEy2it5/6szy8XHHqcDp5
         7Pg/Iq3trqK98ELgalYMzeiXkisurtd9H7ZhEd93DVcY9ULMdRNuTFdHPR+xMGbHZA
         MtsDSjm5di1VnGu9fG2lPTSsVqWkqj2TAV4FAmapKQUMoOy/kv8be7O+gPjO9YhHvo
         8w+hc1ajlHoSw==
From:   abelvesa@kernel.org
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 0/7] arm64: dts: freescale: Add i.MX8DXL support
Date:   Mon, 17 May 2021 20:11:58 +0300
Message-Id: <20210517171205.1581938-1-abelvesa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

This work is taken from NXP's internal tree. In order to fast track
the upstreaming, I took the latest versions of the files, trying to
keep the original author where possible.

With this patchset, i.MX8DXL boots to prompt with SD rootfs.

Abel Vesa (2):
  arm64: dts: imx8-ss-lsio: Add mu5a mailbox
  arm64: dts: freescale: Add adma subsystem dtsi for imx8dxl

Jacky Bai (5):
  arm64: dts: freescale: Add the top level dtsi support for imx8dxl
  arm64: dts: freescale: Add the imx8dxl connectivity subsys dtsi
  arm64: dts: freescale: Add ddr subsys dtsi for imx8dxl
  arm64: dts: freescale: Add lsio subsys dtsi for imx8dxl
  arm64: dts: imx8dxl: Add i.MX8DXL evk board support

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8-ss-lsio.dtsi      |   9 +
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 429 ++++++++++++++++++
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   |  53 +++
 .../boot/dts/freescale/imx8dxl-ss-conn.dtsi   | 133 ++++++
 .../boot/dts/freescale/imx8dxl-ss-ddr.dtsi    |  34 ++
 .../boot/dts/freescale/imx8dxl-ss-lsio.dtsi   |  68 +++
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi    | 286 ++++++++++++
 8 files changed, 1013 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl.dtsi

-- 
2.31.1

