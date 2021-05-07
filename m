Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D460C376286
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbhEGJDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:03:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50372 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbhEGJDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:03:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id 5E1021F43295
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, xxm@rock-chips.com
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v4 0/6] Add IOMMU driver for rk356x
Date:   Fri,  7 May 2021 11:02:26 +0200
Message-Id: <20210507090232.233049-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the IOMMU driver for rk356x SoC.
Since a new compatible is needed to distinguish this second version of 
IOMMU hardware block from the first one, it is an opportunity to convert
the binding to DT schema.

version 4:
 - Add description for reg items
 - Remove useless interrupt-names properties
 - Add description for interrupts items
 - Remove interrupt-names properties from DST files

version 3:
 - Rename compatible with soc prefix
 - Rebase on v5.12 tag

version 2:
 - Fix iommu-cells typo in rk322x.dtsi
 - Change maintainer
 - Change reg maxItems
 - Add power-domains property
 
Benjamin Gaignard (5):
  dt-bindings: iommu: rockchip: Convert IOMMU to DT schema
  dt-bindings: iommu: rockchip: Add compatible for v2
  ARM: dts: rockchip: rk322x: Fix IOMMU nodes properties
  ARM: dts: rockchip: rk3036: Remove useless interrupt-names on IOMMU
    node
  ARM64: dts: rockchip: rk3036: Remove useless interrupt-names
    properties

Simon Xue (1):
  iommu: rockchip: Add support iommu v2

 .../bindings/iommu/rockchip,iommu.txt         |  38 --
 .../bindings/iommu/rockchip,iommu.yaml        |  85 ++++
 arch/arm/boot/dts/rk3036.dtsi                 |   1 -
 arch/arm/boot/dts/rk322x.dtsi                 |  10 +-
 arch/arm64/boot/dts/rockchip/px30.dtsi        |   2 -
 drivers/iommu/rockchip-iommu.c                | 422 +++++++++++++++++-
 6 files changed, 494 insertions(+), 64 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml

-- 
2.25.1

