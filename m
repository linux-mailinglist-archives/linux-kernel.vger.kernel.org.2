Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E0A402CF6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344310AbhIGQjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:39:32 -0400
Received: from goliath.siemens.de ([192.35.17.28]:48753 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbhIGQj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:39:26 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 187Gc3rP017690
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Sep 2021 18:38:04 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.245.242])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 187Gc3Gf021975;
        Tue, 7 Sep 2021 18:38:03 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH v2 0/4] arm64: dts: Update IOT2050 boards
Date:   Tue,  7 Sep 2021 18:37:58 +0200
Message-Id: <cover.1631032682.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enhances the DTs for the IOT2050, primarily by added support for
upcoming Production Generation 2 (PG2) and by ordering the MMC devices
consistently across variants.

Changes in v2:
 - move mmc alias to SoC level
 - split up into PG2 preparation and addition patch
 - add link to product homepage

Jan

Jan Kiszka (4):
  arm64: dts: ti: k3-am65: Flip mmc device ordering
  arm64: dts: ti: iot2050: Disable SR2.0-only PRUs
  arm64: dts: ti: iot2050: Prepare for adding 2nd-generation boards
  arm64: dts: ti: iot2050: Add support for product generation 2 boards

 arch/arm64/boot/dts/ti/Makefile               |  2 +
 .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    | 46 +++++++++++++++
 .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    | 51 +++++++++++++++++
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 11 +---
 arch/arm64/boot/dts/ti/k3-am65.dtsi           |  2 +
 ...ts => k3-am6528-iot2050-basic-common.dtsi} | 12 +---
 .../dts/ti/k3-am6528-iot2050-basic-pg2.dts    | 24 ++++++++
 .../boot/dts/ti/k3-am6528-iot2050-basic.dts   | 56 +++----------------
 ...=> k3-am6548-iot2050-advanced-common.dtsi} |  8 +--
 .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts | 29 ++++++++++
 .../dts/ti/k3-am6548-iot2050-advanced.dts     | 50 +++--------------
 11 files changed, 175 insertions(+), 116 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
 copy arch/arm64/boot/dts/ti/{k3-am6528-iot2050-basic.dts => k3-am6528-iot2050-basic-common.dtsi} (80%)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
 copy arch/arm64/boot/dts/ti/{k3-am6548-iot2050-advanced.dts => k3-am6548-iot2050-advanced-common.dtsi} (85%)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts

-- 
2.31.1

