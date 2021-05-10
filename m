Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF974379132
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbhEJOpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:45:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36264 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245728AbhEJOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:44:24 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14AEhDtD058745;
        Mon, 10 May 2021 09:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620657793;
        bh=LByeS5V0ctmvd1SKLhaKsmpFM4lcPCTjcn74ZgOJBBU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Qfeg5Fga+v/12pbwGlMV5xsQIanlmqlVVmSA+jresCitOiFyIW+5O38G1pIqEB9cA
         lyOj/35mmrpkhpl80Zct1PTax0HCyW+aUuxhpNSyn7XsQcUQHTwfffUqlqWi4m/qi7
         94fcqxtRqoRt+cRWTasilYNuQ5vF7auP6odoU9sw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14AEhDnY057870
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 May 2021 09:43:13 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 10
 May 2021 09:43:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 10 May 2021 09:43:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14AEhCTQ104817;
        Mon, 10 May 2021 09:43:12 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/4 RESEND] ARM: dts: keystone: k2g: Rename message-manager node
Date:   Mon, 10 May 2021 09:43:09 -0500
Message-ID: <20210510144312.986-2-nm@ti.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210510144312.986-1-nm@ti.com>
References: <20210510144312.986-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename message-manager instance node name to be better aligned with
current style of device tree nodes for mailboxes.

Acked-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Original patch:
https://lore.kernel.org/linux-arm-kernel/20210414001926.20002-1-nm@ti.com/
Change since original patch (subject line update keystone: k2g instead of
keystone-k2g)

Schema update:
https://lore.kernel.org/linux-arm-kernel/20210415213502.GA1921174@robh.at.kernel.org/

 arch/arm/boot/dts/keystone-k2g.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 05a75019275e..e5c813b5556d 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -242,7 +242,7 @@ dsp0: dsp@10800000 {
 			status = "disabled";
 		};
 
-		msgmgr: msgmgr@2a00000 {
+		msgmgr: mailbox@2a00000 {
 			compatible = "ti,k2g-message-manager";
 			#mbox-cells = <2>;
 			reg-names = "queue_proxy_region",
-- 
2.31.0

