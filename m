Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2B23A87F5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhFORqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:46:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57000 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhFORqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:46:07 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15FHi08a014752;
        Tue, 15 Jun 2021 12:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623779040;
        bh=QlxTDuZB0l/SSCJl0lXVKZaOlvRUTOjDkRIQ1NqXNrE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Y5cjhYjHK+acPBK+HylHuTHoU8ELX9mcXuMjhcJEM3jehrSf+WlrLvuskXctSx+/j
         UXObteQU+/B01VbpsdYW1dos/CtkLbU8w/yuaxVhCyRPwDanUlhb7ora1Pekb1oes+
         32sZyLE8tH2vr7LTwhwNsHYOo3FblhSzqQkIKHqc=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15FHi0Pf023325
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jun 2021 12:44:00 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 12:44:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 15 Jun 2021 12:44:00 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15FHhRGD009558;
        Tue, 15 Jun 2021 12:43:53 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Suman Anna <s-anna@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/3] arm64: dts: ti: k3-am64-main: Update the location of TF-A
Date:   Tue, 15 Jun 2021 23:13:25 +0530
Message-ID: <20210615174325.22853-4-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210615174325.22853-1-a-govindraju@ti.com>
References: <20210615174325.22853-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a limitation for USB DFU boot mode, SPL load address has to be less
than  or equal to 0x70001000. So, load address of SPL and TF-A have been
moved to 0x70000000 and 0x701c4000 respectively.

Therefore, update TF-A's location in the device tree node.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 6a883f4349cb..7ab3652dfdfb 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -24,8 +24,8 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x00 0x70000000 0x200000>;
 
-		tfa-sram@0 {
-			reg = <0x0 0x1c000>;
+		tfa-sram@1c4000 {
+			reg = <0x1c4000 0x1c000>;
 		};
 
 		dmsc-sram@1e0000 {
-- 
2.17.1

