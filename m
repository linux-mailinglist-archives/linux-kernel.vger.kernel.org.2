Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E99A403B4B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351825AbhIHORe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 10:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351804AbhIHORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:17:32 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1776C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 07:16:24 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNyNC-00CSWy-QH
        for linux-kernel@vger.kernel.org; Wed, 08 Sep 2021 16:16:22 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNyN8-00CSWF-JL; Wed, 08 Sep 2021 16:16:18 +0200
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNyN7-000ZbI-Q3; Wed, 08 Sep 2021 16:16:17 +0200
From:   Bert Vermeulen <bert@biot.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        John Crispin <john@phrozen.org>, Bert Vermeulen <bert@biot.com>
Subject: [PATCH v3 0/5] Add support for Airoha EN7523 SoC
Date:   Wed,  8 Sep 2021 16:16:01 +0200
Message-Id: <20210908141606.136792-1-bert@biot.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the Airoha EN7523 SoC, intended primarily
for xPON/xDSL routers.

v3:
- s/armv7/armv8 in commit message
- Fixed dt-bindings vendor ordering
- Removed CONFIG_COMMON_CLK_EN7523 reference for now

v2:
- The company changed name from EcoNet to Airoha.
- Removed Makefile text offset in lieu of /memreserve/ DTS node (see
  https://lists.infradead.org/pipermail/linux-arm-kernel/2021-September/681898.html)
- DTS: Moved /memory node, fixed CPU compatible, removed GIC_CPU_MASK_SIMPLE
  from timer interrupts node, changed timer compatible, and minor fixes.

John Crispin (5):
  dt-bindings: Add vendor prefix for Airoha
  dt-bindings: arm: airoha: Add binding for EN7523 SoC and EVB
  ARM: dts: Add basic support for Airoha EN7523
  ARM: Add basic support for Airoha EN7523 SoC
  ARM: multi_v7_defconfig: Add support for Airoha EN7523 SoC

 .../devicetree/bindings/arm/airoha.yaml       |  27 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/Kconfig                              |  14 +++
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/en7523-evb.dts              |  26 ++++
 arch/arm/boot/dts/en7523.dtsi                 | 114 ++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig           |   1 +
 7 files changed, 186 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/airoha.yaml
 create mode 100644 arch/arm/boot/dts/en7523-evb.dts
 create mode 100644 arch/arm/boot/dts/en7523.dtsi

-- 
2.25.1

