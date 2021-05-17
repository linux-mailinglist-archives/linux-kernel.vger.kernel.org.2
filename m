Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC79382421
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbhEQGUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:20:07 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55444 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbhEQGUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:20:06 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14H6ImDx041016;
        Mon, 17 May 2021 01:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621232328;
        bh=V2SYb6iVrzLpJErT4w9okAsZWhph98sXEr/gFZPp6LA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SbFPw4pSsgNePHi6AI5JWc7wk7GrjyS913heZVwEDBNTqQRcktR30fM4gpJz0hJzi
         EMTYkQz2PUSY/m2tbKNhG4BJUWqFOsqs7MxTfNBZli72714AiTCIK9BFPwjiCWN/U8
         J6LZk6OXl++lpcow0gGjUSDb6Rse9VrtgmPP0ZpE=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14H6Ilvt021522
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 May 2021 01:18:47 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 17
 May 2021 01:18:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 17 May 2021 01:18:47 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14H6Hpl6003911;
        Mon, 17 May 2021 01:18:43 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, <a-govindraju@ti.com>
Subject: [PATCH v2 6/6] arm64: dts: ti: k3-am642-sk: Disable PCIe
Date:   Mon, 17 May 2021 11:47:39 +0530
Message-ID: <20210517061739.5762-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210517061739.5762-1-kishon@ti.com>
References: <20210517061739.5762-1-kishon@ti.com>
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
index 077b87656fbc..40124007259d 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -367,3 +367,11 @@
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

