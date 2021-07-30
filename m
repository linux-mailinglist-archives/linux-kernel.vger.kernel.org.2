Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A569C3DB9B0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbhG3Nxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhG3Nxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:53:53 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF038C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:53:48 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1m9Spt-006bTF-EP
        for linux-kernel@vger.kernel.org; Fri, 30 Jul 2021 15:46:01 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1m9Spp-006bSo-4C; Fri, 30 Jul 2021 15:45:57 +0200
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1m9Spo-003a0f-9I; Fri, 30 Jul 2021 15:45:56 +0200
From:   Bert Vermeulen <bert@biot.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Bert Vermeulen <bert@biot.com>, John Crispin <john@phrozen.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 0/4] Add support for EcoNet EN7523 SoC
Date:   Fri, 30 Jul 2021 15:45:47 +0200
Message-Id: <20210730134552.853350-1-bert@biot.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the EcoNet EN7523 SoC, intended primarily
for xPON/xDSL routers.

John Crispin (4):
  dt-bindings: Add vendor prefix for EcoNet
  dt-bindings: arm: econet: Add binding for EN7523 SoC and EVB
  ARM: dts: Add basic support for EcoNet EN7523
  ARM: Add basic support for EcoNet EN7523 SoC

 .../devicetree/bindings/arm/econet.yaml       |  27 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/Kconfig                              |  14 ++
 arch/arm/Makefile                             |   1 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/en7523-evb.dts              |  17 +++
 arch/arm/boot/dts/en7523.dtsi                 | 128 ++++++++++++++++++
 7 files changed, 191 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/econet.yaml
 create mode 100644 arch/arm/boot/dts/en7523-evb.dts
 create mode 100644 arch/arm/boot/dts/en7523.dtsi

-- 
2.25.1

