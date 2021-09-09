Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19204405DA4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 21:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344051AbhIITmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 15:42:44 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:37208 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245698AbhIITmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 15:42:43 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 189JfJNH013890
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Sep 2021 21:41:20 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.244.119])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 189JfIcS001594;
        Thu, 9 Sep 2021 21:41:19 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH v3 0/5] arm64: dts: Update IOT2050 boards
Date:   Thu,  9 Sep 2021 21:41:13 +0200
Message-Id: <cover.1631216478.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enhances the DTs for the IOT2050, primarily by added support for
upcoming Production Generation 2 (PG2) and by ordering the MMC devices
consistently across variants.

Changes in 3:
 - move mmc alias back into board DTs
 - add patch to enable R5F cores for rproc

Changes in v2:
 - move mmc alias to SoC level
 - split up into PG2 preparation and addition patch
 - add link to product homepage

Jan

Jan Kiszka (5):
  arm64: dts: ti: iot2050: Flip mmc device ordering on Advanced devices
  arm64: dts: ti: iot2050: Disable SR2.0-only PRUs
  arm64: dts: ti: iot2050: Add/enabled mailboxes and carve-outs for R5F
    cores
  arm64: dts: ti: iot2050: Prepare for adding 2nd-generation boards
  arm64: dts: ti: iot2050: Add support for product generation 2 boards

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
 10 files changed, 199 insertions(+), 118 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
 copy arch/arm64/boot/dts/ti/{k3-am6528-iot2050-basic.dts => k3-am6528-iot2050-basic-common.dtsi} (80%)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
 copy arch/arm64/boot/dts/ti/{k3-am6548-iot2050-advanced.dts => k3-am6548-iot2050-advanced-common.dtsi} (85%)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts

-- 
2.31.1

