Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B189E3A85AD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhFOP6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:58:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55640 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbhFOPya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:54:30 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15FFpcBU096892;
        Tue, 15 Jun 2021 10:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623772298;
        bh=dN/IldJMCljVtxYSJcvhsYvFDAnfQgPNmlWqjXmXHds=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dUensyOgfIo5GR/aschKyJ+mTPEB92MZDGr3U8nt8mGiJSz0smJLrx0XOBCXRIrbX
         DYYeMKORuKJiDS1ikL5KC/gogv3ovrEHuYJwD32we4u00gvhfwFzoHURfPUukQlHKA
         Mjn4KtYxdDVXa6wnDyKFM3GOZEboyf7eojjftwRA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15FFpcks005028
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jun 2021 10:51:38 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 10:51:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 15 Jun 2021 10:51:38 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15FFpIZC031828;
        Tue, 15 Jun 2021 10:51:30 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Suman Anna <s-anna@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] dts: ti: k3-am64-main: Update TF-A's maximum size and node name
Date:   Tue, 15 Jun 2021 21:21:13 +0530
Message-ID: <20210615155115.28902-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210615155115.28902-1-a-govindraju@ti.com>
References: <20210615155115.28902-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum size of TF-A 2.5 has been increased to 0x1c000 [1]. Therefore,
update this accordingly in the device tree node.

Also, update the node name to "tfa-sram".

[1] - https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=2fb5312f61a7de8b7a70e1639199c4f14a10b6f9

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Reviewed-by: Suman Anna <s-anna@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index dec54243f454..693fe24e7f7a 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -24,8 +24,8 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x00 0x70000000 0x200000>;
 
-		atf-sram@0 {
-			reg = <0x0 0x1a000>;
+		tfa-sram@0 {
+			reg = <0x0 0x1c000>;
 		};
 	};
 
-- 
2.17.1

