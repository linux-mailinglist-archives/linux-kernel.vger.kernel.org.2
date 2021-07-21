Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0E43D0E18
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239558AbhGULFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:05:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44918 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbhGUK4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:56:01 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16LBaUxc113532;
        Wed, 21 Jul 2021 06:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626867390;
        bh=2s2bXdv9TLjhc1ejdWbmRITXCQDwa1YJVHNps0Uqx2g=;
        h=From:To:CC:Subject:Date;
        b=FWZbGFDJsF47S1JRf1jcZv0wgtHsEHXX0TEyh1FtSp/WQIeTAMcKAXNUOdPuWQCQo
         msNUqujXJbGLyvXYn6IvGZ5uxPo9sSvtN/sYWfu6QAZIP/9h1t9FUsLFUkdlDSre3u
         6x+kFcxb+ADfMHVA9LOJlJvUVeNaMpw3awb7DMsg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16LBaU24089732
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Jul 2021 06:36:30 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 21
 Jul 2021 06:36:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 21 Jul 2021 06:36:29 -0500
Received: from lokesh-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16LBaQBl115096;
        Wed, 21 Jul 2021 06:36:27 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Nishanth Menon <nm@ti.com>, <kristo@kernel.org>
CC:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 0/4] arm64: dts: ti: k3-am64: Add PWM nodes
Date:   Wed, 21 Jul 2021 17:06:21 +0530
Message-ID: <20210721113625.17299-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add epwm and ecap nodes for AM64 boards.

Changes since v1:
- Mark all un-used pwm nodes as disabled.

Lokesh Vutla (4):
  arm64: dts: ti: k3-am64-main: Add epwm nodes
  arm64: dts: ti: k3-am64-main: Add ecap pwm nodes
  arm64: dts: ti: k3-am642-evm: Add pwm nodes
  arm64: dts: ti: k3-am642-sk: Add pwm nodes

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 114 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  56 +++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  64 +++++++++++++
 3 files changed, 234 insertions(+)

-- 
2.31.1

