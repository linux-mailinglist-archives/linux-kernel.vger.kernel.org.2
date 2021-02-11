Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0861031932F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhBKTee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:34:34 -0500
Received: from gecko.sbs.de ([194.138.37.40]:32770 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230140AbhBKTd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:33:56 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 11BJWveU027063
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 20:32:57 +0100
Received: from md1f2u6c.ad001.siemens.net ([139.22.42.110])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 11BJWuhd031206;
        Thu, 11 Feb 2021 20:32:57 +0100
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Le Jin <le.jin@siemens.com>,
        Bao Cheng Su <baocheng.su@siemens.com>
Subject: [PATCH v2 0/4] arm64: Add TI AM65x-based IOT2050 boards
Date:   Thu, 11 Feb 2021 20:32:52 +0100
Message-Id: <cover.1613071976.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - address board-specific issues found by kernel_verify_patch
 - remove dead l2-cache node from iot2050-basic DT
 - add binding for Siemens vendor prefix
 - factor out board bindings into separate patch
 - add missing device_type to common ti,am654-pcie-rc nodes

Jan

Jan Kiszka (4):
  dt-bindings: Add Siemens vendor prefix
  dt-bindings: arm: ti: Add bindings for Siemens IOT2050 boards
  arm64: dts: ti: Add support for Siemens IOT2050 boards
  arm64: dts: ti: k3-am65-main: Add device_type to pcie*_rc nodes

 .../devicetree/bindings/arm/ti/k3.yaml        |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 679 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |   2 +
 .../boot/dts/ti/k3-am6528-iot2050-basic.dts   |  61 ++
 .../dts/ti/k3-am6548-iot2050-advanced.dts     |  60 ++
 7 files changed, 808 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts

-- 
2.26.2

