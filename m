Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC51317298
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhBJVnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:43:17 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47734 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233189AbhBJVnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:43:06 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l9xFZ-0006dd-3K; Wed, 10 Feb 2021 22:42:17 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     cmuellner@linux.com, robh+dt@kernel.org, heiko@sntech.de,
        ezequiel@collabora.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH 0/2] phy: rockchip: add Innosilicon-based CSI DPHY
Date:   Wed, 10 Feb 2021 22:42:03 +0100
Message-Id: <20210210214205.2496336-1-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer Rockchip SoCs use a different DPHY for camera operation
based on an IP block from Innosilicon.

This adds a driver for it for px30/rk3326/rk3368/rk1808.

Heiko Stuebner (2):
  dt-bindings: phy: add yaml binding for rockchip-inno-csi-dphy
  phy/rockchip: add Innosilicon-based CSI dphy

 .../bindings/phy/rockchip-inno-csi-dphy.yaml  |  79 +++
 drivers/phy/rockchip/Kconfig                  |   9 +
 drivers/phy/rockchip/Makefile                 |   1 +
 .../phy/rockchip/phy-rockchip-inno-csidphy.c  | 480 ++++++++++++++++++
 4 files changed, 569 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c

-- 
2.29.2

