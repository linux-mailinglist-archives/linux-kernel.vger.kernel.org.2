Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54494379157
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbhEJOwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:52:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38026 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbhEJOvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:51:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14AEoYD3061470;
        Mon, 10 May 2021 09:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620658234;
        bh=nzesDeuLiJixG5nW/SILn4MvUfWa8zDneota5YnCgLQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UKrUpXIwtkXWgi12hluTmtgwsebRMFNge2NzkgTmcMyBlQzDFEgrJItX6pQ8AC78Y
         VAZu75hH+5CuKQdhy6Lgh+vsDoEuJdVvfqIvO5UIR07hxC901CStoeQsp0uZLTLg+u
         6cv40zFoVlA4mdylzy1CVfD+UUe48AfCguyq7zog=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14AEoYdH083199
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 09:50:34 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 09:50:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 09:50:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14AEoYHt111334;
        Mon, 10 May 2021 09:50:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/4] arm64: dts: ti: k3-am65-wakeup: Drop un-necessary properties from dmsc node
Date:   Mon, 10 May 2021 09:50:32 -0500
Message-ID: <20210510145033.7426-4-nm@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210510145033.7426-1-nm@ti.com>
References: <20210510145033.7426-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMSC node does'nt require any of "#address-cells", "#size-cells"
or "ranges" property as the child nodes are representations of SoC's
system controller itself, so align it with the bindings.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index 444842a2d556..80d4df775f43 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -9,9 +9,6 @@ &cbass_wakeup {
 	dmsc: dmsc@44083000 {
 		compatible = "ti,am654-sci";
 		ti,host-id = <12>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
 
 		mbox-names = "rx", "tx";
 
-- 
2.31.0

