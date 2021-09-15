Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867A140BF76
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbhIOFzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:55:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52554 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbhIOFzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:55:38 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18F5sH6g060589;
        Wed, 15 Sep 2021 00:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631685257;
        bh=y4gBJKOzkhmS6fQ4wFfxCso/F/LxHsOlNBqrEXSAF7Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wfskEiFFy5j2fHvtOmIfs15BqXgOQR6CvhDFIBRWvuS/08EUVe5TdCKJmDZ1La47k
         Ogkda/CIafco4i1wHd8AYuCIiVsf5DKOSFVoJDZpR5vQGgZXSKspEmonUR6LaoM38J
         4k23a67h2mGwQhYmgfOje/p3AwiXZRLLGYaq4FAY=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18F5sHNC011069
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 00:54:17 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Sep 2021 00:54:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Sep 2021 00:54:17 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18F5rwsd023333;
        Wed, 15 Sep 2021 00:54:13 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 4/6] arm64: dts: ti: j7200-main: Fix "bus-range" upto 256 bus number for PCIe
Date:   Wed, 15 Sep 2021 11:23:56 +0530
Message-ID: <20210915055358.19997-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210915055358.19997-1-kishon@ti.com>
References: <20210915055358.19997-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 3276d9f53cf6 ("arm64: dts: ti: k3-j7200-main: Add PCIe device
tree node") incorrectly added PCIe bus numbers from 0 to 15 (copy-paste
from J721E node). Enable all the supported bus numbers from 0 to 255
defined in PCIe spec here.

Fixes: 3276d9f53cf6 ("arm64: dts: ti: k3-j7200-main: Add PCIe device tree node")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 521a56316fa5..874cba75e9a5 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -606,7 +606,7 @@
 		clock-names = "fck";
 		#address-cells = <3>;
 		#size-cells = <2>;
-		bus-range = <0x0 0xf>;
+		bus-range = <0x0 0xff>;
 		cdns,no-bar-match-nbits = <64>;
 		vendor-id = <0x104c>;
 		device-id = <0xb00f>;
-- 
2.17.1

