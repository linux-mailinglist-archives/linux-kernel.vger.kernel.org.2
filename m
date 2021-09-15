Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A3B40C539
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbhIOM2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:28:46 -0400
Received: from david.siemens.de ([192.35.17.14]:35094 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231689AbhIOM2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:28:44 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 18FCRCSW030305
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 14:27:12 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.79.72])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18FCRAr2006124;
        Wed, 15 Sep 2021 14:27:11 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH v4 0/6] arm64: dts: Update IOT2050 boards
Date:   Wed, 15 Sep 2021 14:27:04 +0200
Message-Id: <cover.1631708830.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enhances the DTs for the IOT2050, primarily by added support for
upcoming Production Generation 2 (PG2) and by ordering the MMC devices
consistently across variants.

Changes in v4:
 - update dtbinding with new board names
 - fix review comments on commit messages and style

Changes in v3:
 - move mmc alias back into board DTs
 - add patch to enable R5F cores for rproc

Changes in v2:
 - move mmc alias to SoC level
 - split up into PG2 preparation and addition patch
 - add link to product homepage

Jan

Jan Kiszka (6):
  arm64: dts: ti: iot2050: Flip mmc device ordering on Advanced devices
  arm64: dts: ti: iot2050: Disable SR2.0-only PRUs
  arm64: dts: ti: iot2050: Add/enabled mailboxes and carve-outs for R5F
    cores
  dt-bindings: arm: ti: Add bindings for Siemens IOT2050 PG2 boards
  arm64: dts: ti: iot2050: Prepare for adding 2nd-generation boards
  arm64: dts: ti: iot2050: Add support for product generation 2 boards

 .../devicetree/bindings/arm/ti/k3.yaml        |  2 +
 arch/arm64/boot/dts/ti/Makefile               |  2 +
 .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    | 46 +++++++++++++++
 .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    | 51 +++++++++++++++++
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 39 +++++++++----
 ...ts => k3-am6528-iot2050-basic-common.dtsi} | 12 +---
 .../dts/ti/k3-am6528-iot2050-basic-pg2.dts    | 24 ++++++++
 .../boot/dts/ti/k3-am6528-iot2050-basic.dts   | 56 +++----------------
 ...=> k3-am6548-iot2050-advanced-common.dtsi} |  8 +--
 .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts | 29 ++++++++++
 .../dts/ti/k3-am6548-iot2050-advanced.dts     | 50 +++--------------
 11 files changed, 201 insertions(+), 118 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
 copy arch/arm64/boot/dts/ti/{k3-am6528-iot2050-basic.dts => k3-am6528-iot2050-basic-common.dtsi} (80%)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
 copy arch/arm64/boot/dts/ti/{k3-am6548-iot2050-advanced.dts => k3-am6548-iot2050-advanced-common.dtsi} (85%)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts

-- 
2.31.1

