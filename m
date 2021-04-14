Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5FB35E9F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 02:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243451AbhDNAUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 20:20:01 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54406 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhDNAT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 20:19:59 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 13E0JX7i067148;
        Tue, 13 Apr 2021 19:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1618359573;
        bh=sEGInDbcMqD++Zf5TwJWUkYhc0xiMzNmlOwCydvtiDs=;
        h=From:To:CC:Subject:Date;
        b=SWvlFy6uzV8joefzEbkp1Gsw/FsSTFBlkLuqedYN7h13p0NYUtUTdFiw2ZGMlG8oQ
         QO89rl0J64rTSRvpc6PEfM5SQc1dc8SAHGa35OptO858Xu6aJEx8peuoCpw/d9ciSI
         ynJOPRwWaE0UN1vrpo6BFgeEmyl0oB1K+/ZS9SDs=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 13E0JXaJ092218
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Apr 2021 19:19:33 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 13
 Apr 2021 19:19:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 13 Apr 2021 19:19:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 13E0JX6d098322;
        Tue, 13 Apr 2021 19:19:33 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, <s-anna@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: dts: keystone-k2g: Rename message-manager node
Date:   Tue, 13 Apr 2021 19:19:26 -0500
Message-ID: <20210414001926.20002-1-nm@ti.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename message-manager instance node name to be better aligned with
current style of device tree nodes for mailboxes.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Santosh:
- This is'nt critical to queue up for 5.13-rc1 window, but just getting
  it out of the way. I noticed it as I was converting the binding to
  yaml. (patch for yaml conversion for the node follows)

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

