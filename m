Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B935F430D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 03:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243046AbhJRBjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 21:39:41 -0400
Received: from mx.socionext.com ([202.248.49.38]:48765 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232377AbhJRBjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 21:39:40 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 18 Oct 2021 10:37:29 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 663132059034;
        Mon, 18 Oct 2021 10:37:29 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 18 Oct 2021 10:37:29 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 261B8B62B7;
        Mon, 18 Oct 2021 10:37:29 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/8] phy: socionext: Introduce some features for UniPhier SoCs
Date:   Mon, 18 Oct 2021 10:37:05 +0900
Message-Id: <1634521033-17003-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes the patches to add the following features:
- Add basic support for new UniPhier NX1 SoC to USB3 and PCIe PHY.
  NX1 SoC also has the same kinds of controls as the other UniPhier SoCs.
- Add a PHY parameters to PCIe PHY
- Add dual-phy support for the SoCs that has two phys to PCIe PHY
- Add basic support for Pro4 SoC to ACHI PHY

Kunihiko Hayashi (8):
  dt-bindings: phy: uniphier-usb3: Add bindings for NX1 SoC
  phy: uniphier-usb3: Add compatible string for NX1 SoC
  dt-bindings: phy: uniphier-pcie: Add bindings for NX1 SoC
  phy: uniphier-pcie: Add compatible string and SoC-dependent data for
    NX1 SoC
  phy: uniphier-pcie: Set VCOPLL clamp mode in PHY register
  phy: uniphier-pcie: Add dual-phy support for NX1 SoC
  dt-bindings: phy: uniphier-ahci: Add bindings for Pro4 SoC
  phy: uniphier-ahci: Add support for Pro4 SoC

 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |  20 +-
 .../bindings/phy/socionext,uniphier-pcie-phy.yaml  |   1 +
 .../phy/socionext,uniphier-usb3hs-phy.yaml         |   1 +
 .../phy/socionext,uniphier-usb3ss-phy.yaml         |   1 +
 drivers/phy/socionext/Kconfig                      |   2 +-
 drivers/phy/socionext/phy-uniphier-ahci.c          | 201 ++++++++++++++++++++-
 drivers/phy/socionext/phy-uniphier-pcie.c          |  70 +++++--
 drivers/phy/socionext/phy-uniphier-usb3hs.c        |   4 +
 drivers/phy/socionext/phy-uniphier-usb3ss.c        |   4 +
 9 files changed, 282 insertions(+), 22 deletions(-)

-- 
2.7.4

