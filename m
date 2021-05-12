Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E62D37C231
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 17:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhELPHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 11:07:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:32914 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbhELPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:02:59 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14CF1md7004871;
        Wed, 12 May 2021 10:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620831708;
        bh=WsCcrwsfJHhmpda0+kd21jCuESY8O0g3v5Ya0BM7gzw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bI4P+PMZIyzbFtvmJgfx3n+vBqGGmUNaGDq+OkQsr/BlfGh4MxcunVrxbDC/URr8l
         Nm3BUWYxhWxbhxwWHIY5AnsgA/uj57BBhMDGSkJN/waHBcBfRuKsxD+6eyM4GN8x4e
         b/EUqvs/wxe+yPPWYI4o/6SzG4O7P55qLnPo7t1I=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14CF1mO4123824
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 May 2021 10:01:48 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 12
 May 2021 10:01:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 12 May 2021 10:01:47 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14CF19FC119262;
        Wed, 12 May 2021 10:01:42 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, <a-govindraju@ti.com>
Subject: [PATCH 5/5] arm64: dts: ti: k3-am642-sk: Disable PCIe
Date:   Wed, 12 May 2021 20:31:07 +0530
Message-ID: <20210512150107.26793-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512150107.26793-1-kishon@ti.com>
References: <20210512150107.26793-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM642-SK has no PCIe slot. Disable it here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 056c1b2df559..3b7859aae074 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -371,3 +371,11 @@
 &mailbox0_cluster7 {
 	status = "disabled";
 };
+
+&pcie0_rc {
+	status = "disabled";
+};
+
+&pcie0_ep {
+	status = "disabled";
+};
-- 
2.17.1

