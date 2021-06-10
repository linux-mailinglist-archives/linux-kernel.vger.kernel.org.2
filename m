Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F493A35E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhFJVbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:31:42 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44904 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230284AbhFJVbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:31:40 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1lrSFA-0006er-S5; Thu, 10 Jun 2021 23:29:40 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     robh+dt@kernel.org, heiko@sntech.de, ezequiel@collabora.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v2 0/2] phy: rockchip: add Innosilicon-based CSI DPHY
Date:   Thu, 10 Jun 2021 23:29:33 +0200
Message-Id: <20210610212935.3520341-1-heiko@sntech.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer Rockchip SoCs use a different DPHY for camera operation
based on an IP block from Innosilicon.

This adds a driver for it for px30/rk3326/rk3368/rk1808.

changes in v2:
- add Robs review to the binding
- adjust to Vinod's review comments from v1
  including shift -> bitfield, helpers and
  also making checkpatch --strict happy

Heiko Stuebner (2):
  dt-bindings: phy: add yaml binding for rockchip-inno-csi-dphy
  phy/rockchip: add Innosilicon-based CSI dphy

 .../bindings/phy/rockchip-inno-csi-dphy.yaml  |  79 +++
 drivers/phy/rockchip/Kconfig                  |   9 +
 drivers/phy/rockchip/Makefile                 |   1 +
 .../phy/rockchip/phy-rockchip-inno-csidphy.c  | 459 ++++++++++++++++++
 4 files changed, 548 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-inno-csidphy.c

-- 
2.29.2

