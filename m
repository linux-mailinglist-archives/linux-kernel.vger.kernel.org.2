Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D49E43FAE1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 12:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhJ2Kll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 06:41:41 -0400
Received: from mx.socionext.com ([202.248.49.38]:58734 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231486AbhJ2Klj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 06:41:39 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 29 Oct 2021 19:39:10 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id B24A3207616C;
        Fri, 29 Oct 2021 19:39:10 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 29 Oct 2021 19:39:10 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 680B4B62AC;
        Fri, 29 Oct 2021 19:39:10 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 0/8] phy: socionext: Introduce some features for UniPhier SoCs
Date:   Fri, 29 Oct 2021 19:38:59 +0900
Message-Id: <1635503947-18250-1-git-send-email-hayashi.kunihiko@socionext.com>
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

---
Changes since v2:
- Fix order of clock-names and reset-names in dt-bindings
- Add minItems to clocks in dt-bindings
- Add Acked-by: lines

Changes since v1:
- Fix indentation of clocks and resets in AHCI PHY binding documentation
- Fix insufficient argument issue when adding dual-phy to PCIe PHY

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

 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |  21 ++-
 .../bindings/phy/socionext,uniphier-pcie-phy.yaml  |   1 +
 .../phy/socionext,uniphier-usb3hs-phy.yaml         |   1 +
 .../phy/socionext,uniphier-usb3ss-phy.yaml         |   1 +
 drivers/phy/socionext/Kconfig                      |   2 +-
 drivers/phy/socionext/phy-uniphier-ahci.c          | 201 ++++++++++++++++++++-
 drivers/phy/socionext/phy-uniphier-pcie.c          |  70 +++++--
 drivers/phy/socionext/phy-uniphier-usb3hs.c        |   4 +
 drivers/phy/socionext/phy-uniphier-usb3ss.c        |   4 +
 9 files changed, 283 insertions(+), 22 deletions(-)

-- 
2.7.4

