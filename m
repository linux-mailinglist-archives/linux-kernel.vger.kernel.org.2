Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689D3402AB3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240556AbhIGOXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:23:44 -0400
Received: from thoth.sbs.de ([192.35.17.2]:39500 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238085AbhIGOXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:23:40 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 187EMHeM020909
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Sep 2021 16:22:17 +0200
Received: from md1f2u6c.ad001.siemens.net ([167.87.245.242])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 187EMGGL016799;
        Tue, 7 Sep 2021 16:22:17 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH 0/3] arm64: dts: Update IOT2050 boards
Date:   Tue,  7 Sep 2021 16:22:13 +0200
Message-Id: <cover.1631024536.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enhances the DTs for the IOT2050, primarily by added support for
upcoming Production Generation 2 (PG2) and by ordering the MMC devices
consistently across variants.

Jan

Jan Kiszka (3):
  arm64: dts: ti: iot2050: Flip mmc device ordering on Advanced devices
  arm64: dts: ti: iot2050: Disable SR2.0-only PRUs
  arm64: dts: ti: iot2050: Add support for product generation 2 boards

 arch/arm64/boot/dts/ti/Makefile               |  2 +
 .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    | 46 ++++++++++++++++
 .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    | 51 ++++++++++++++++++
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 11 +---
 ...ts => k3-am6528-iot2050-basic-common.dtsi} | 12 ++---
 .../dts/ti/k3-am6528-iot2050-basic-pg2.dts    | 21 ++++++++
 .../boot/dts/ti/k3-am6528-iot2050-basic.dts   | 53 ++-----------------
 ...=> k3-am6548-iot2050-advanced-common.dtsi} | 11 ++--
 .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts | 26 +++++++++
 .../dts/ti/k3-am6548-iot2050-advanced.dts     | 47 ++--------------
 10 files changed, 165 insertions(+), 115 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
 copy arch/arm64/boot/dts/ti/{k3-am6528-iot2050-basic.dts => k3-am6528-iot2050-basic-common.dtsi} (80%)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
 copy arch/arm64/boot/dts/ti/{k3-am6548-iot2050-advanced.dts => k3-am6548-iot2050-advanced-common.dtsi} (86%)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts

-- 
2.31.1

