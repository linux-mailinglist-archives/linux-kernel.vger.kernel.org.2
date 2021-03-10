Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2630B333C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhCJMJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:09:10 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44456 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhCJMI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:08:59 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AC8qYh031727;
        Wed, 10 Mar 2021 06:08:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615378133;
        bh=aPZhKkrmpVrH4rdknlkaSt+wXkZ6Xm/lEzN/7YS7+4A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Hj/n0ue8O0juFqFcd8lpGrbxuwpFYZVvIJqaPobNn5/1JRpAelAwbkhcpavfHJMB0
         gQQoR55HZaFeC/GnTECHFOp7ZP+F4XRaHpVWC178IKzEydmTXxa9e4xvmY6D7llLSl
         HJ8iBAEtk5MB50CAe7mod/eeUjQ+7XgyKUW9Ba5Y=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AC8qc7110907
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 06:08:52 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 06:08:52 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 06:08:52 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AC8ghd017368;
        Wed, 10 Mar 2021 06:08:50 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 2/6] phy: ti: j721e-wiz: Delete "clk_div_sel" clk provider during cleanup
Date:   Wed, 10 Mar 2021 17:38:36 +0530
Message-ID: <20210310120840.16447-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310120840.16447-1-kishon@ti.com>
References: <20210310120840.16447-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 091876cc355d ("phy: ti: j721e-wiz: Add support for WIZ module
present in TI J721E SoC") modeled both MUX clocks and DIVIDER clocks in
wiz. However during cleanup, it removed only the MUX clock provider.
Remove the DIVIDER clock provider here.

Fixes: 091876cc355d ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 956a93d96d9b..1a4e09a394a8 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -608,6 +608,12 @@ static void wiz_clock_cleanup(struct wiz *wiz, struct device_node *node)
 		of_clk_del_provider(clk_node);
 		of_node_put(clk_node);
 	}
+
+	for (i = 0; i < wiz->clk_div_sel_num; i++) {
+		clk_node = of_get_child_by_name(node, clk_div_sel[i].node_name);
+		of_clk_del_provider(clk_node);
+		of_node_put(clk_node);
+	}
 }
 
 static int wiz_clock_init(struct wiz *wiz, struct device_node *node)
-- 
2.17.1

