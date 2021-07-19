Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3984E3CD4D1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbhGSLxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:53:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34086 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbhGSLxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:53:03 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16J8s7hL130070;
        Mon, 19 Jul 2021 03:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626684847;
        bh=n3sfBOvf77OpFyulNksMC+n1Rc/gP2a9CY/yRohildo=;
        h=From:To:CC:Subject:Date;
        b=YrIXMPbGYx3fHJsQ39vfu9F7w+ISQGsQ9FTRmTLUiewpF38fuf2danHOmWaMjaJZq
         rRlOfCPyEXXzni4jjCvOrs4fQzfsMifH8VyRKUD8w9bOVNMxBmlrJEF3UJtNRHuPyc
         EcBnNcLuFqeXbRaOFGv82wa+Z1h6PGhhApnoA7nU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16J8s6XW120617
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Jul 2021 03:54:07 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 19
 Jul 2021 03:54:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 19 Jul 2021 03:54:06 -0500
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16J8s3hB047822;
        Mon, 19 Jul 2021 03:54:04 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Nishanth Menon <nm@ti.com>, <kristo@kernel.org>
CC:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 0/4] arm64: dts: ti: k3-am64: Add PWM nodes
Date:   Mon, 19 Jul 2021 14:23:58 +0530
Message-ID: <20210719085402.28569-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add epwm and ecap nodes for AM64 boards.

Lokesh Vutla (4):
  arm64: dts: ti: k3-am64-main: Add epwm nodes
  arm64: dts: ti: k3-am64-main: Add ecap pwm nodes
  arm64: dts: ti: k3-am642-sk: Add ecap0 node
  arm64: dts: ti: k3-am642-evm: Add ecap0 node

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 114 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  12 +++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  12 +++
 3 files changed, 138 insertions(+)

-- 
2.30.0

