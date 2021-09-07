Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC05402722
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245545AbhIGK2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245240AbhIGK2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:28:39 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DB5C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 03:27:32 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNYKB-00CGws-1t
        for linux-kernel@vger.kernel.org; Tue, 07 Sep 2021 12:27:31 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNYK7-00CGwd-MI; Tue, 07 Sep 2021 12:27:27 +0200
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNYK6-000COX-TH; Tue, 07 Sep 2021 12:27:26 +0200
From:   Bert Vermeulen <bert@biot.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        John Crispin <john@phrozen.org>, Bert Vermeulen <bert@biot.com>
Subject: [PATCH v2 0/5] Add support for Airoha EN7523 SoC
Date:   Tue,  7 Sep 2021 12:27:17 +0200
Message-Id: <20210907102722.47543-1-bert@biot.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the Airoha EN7523 SoC, intended primarily
for xPON/xDSL routers.

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
 arch/arm/configs/multi_v7_defconfig           |   2 +
 7 files changed, 187 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/airoha.yaml
 create mode 100644 arch/arm/boot/dts/en7523-evb.dts
 create mode 100644 arch/arm/boot/dts/en7523.dtsi

-- 
2.25.1

