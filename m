Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63293338F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhCJJir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:38:47 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:57328 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232544AbhCJJiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:38:21 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 12A9bnfF025632
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 10:37:49 +0100
Received: from md1f2u6c.ad001.siemens.net ([167.87.35.81])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 12A9bmN4017567;
        Wed, 10 Mar 2021 10:37:49 +0100
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Le Jin <le.jin@siemens.com>,
        Bao Cheng Su <baocheng.su@siemens.com>
Subject: [PATCH v4 0/3] arm64: Add TI AM65x-based IOT2050 boards
Date:   Wed, 10 Mar 2021 10:37:45 +0100
Message-Id: <cover.1615369068.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
 - rebased over ti-k3-dts-next and resent completely (no changes)
 - added ack and review tags

Jan

Jan Kiszka (3):
  dt-bindings: Add Siemens vendor prefix
  dt-bindings: arm: ti: Add bindings for Siemens IOT2050 boards
  arm64: dts: ti: Add support for Siemens IOT2050 boards

 .../devicetree/bindings/arm/ti/k3.yaml        |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 661 ++++++++++++++++++
 .../boot/dts/ti/k3-am6528-iot2050-basic.dts   |  61 ++
 .../dts/ti/k3-am6548-iot2050-advanced.dts     |  60 ++
 6 files changed, 788 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts

-- 
2.26.2

