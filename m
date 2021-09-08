Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFC9403752
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 11:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351402AbhIHJyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 05:54:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44938 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244785AbhIHJyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:54:35 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1889rOiv105402;
        Wed, 8 Sep 2021 04:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631094804;
        bh=i/T5CHFI9h8ioTxwA6pnqpLsVdrGp6tVpLfy8pMU8Zo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yzeLAr3gXwepE/IgpfyL1KCmgzDVLg16fmRAPY98DRyU3F5satsx+PW4MDTFXzTrb
         hbnasD8GeBgDcyYb8se1GevsUopVJ4pGTDBZ27OCRVV8WNudalhjdc1g9ttsyl9Oo3
         pJXowCZsYzFxwT15kxQw6Mpl1VqI7Wq6E4b1DxWw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1889rOun094189
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Sep 2021 04:53:24 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 8
 Sep 2021 04:53:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 8 Sep 2021 04:53:23 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1889rC4D019690;
        Wed, 8 Sep 2021 04:53:20 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH v3 2/3] xhci: Set HCD flag to defer primary roothub registration
Date:   Wed, 8 Sep 2021 15:23:11 +0530
Message-ID: <20210908095312.985-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908095312.985-1-kishon@ti.com>
References: <20210908095312.985-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set "HCD_FLAG_DEFER_RH_REGISTER" to hcd->flags in xhci_run() to defer
registering primary roothub in usb_add_hcd(). This will make sure both
primary roothub and secondary roothub will be registered along with the
second HCD. This is required for cold plugged USB devices to be detected
in certain PCIe USB cards (like Inateck USB card connected to AM64 EVM
or J7200 EVM).

CC: stable@vger.kernel.org # 5.4+
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Tested-by: Chris Chiu <chris.chiu@canonical.com>
---
 drivers/usb/host/xhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 3618070eba78..7176058c7f3e 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -692,6 +692,7 @@ int xhci_run(struct usb_hcd *hcd)
 		if (ret)
 			xhci_free_command(xhci, command);
 	}
+	set_bit(HCD_FLAG_DEFER_RH_REGISTER, &hcd->flags);
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"Finished xhci_run for USB2 roothub");
 
-- 
2.17.1

