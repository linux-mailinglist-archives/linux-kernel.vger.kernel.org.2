Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730F53F5C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhHXKyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:54:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59784 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbhHXKyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:54:08 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17OArK2d066459;
        Tue, 24 Aug 2021 05:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629802400;
        bh=JyBRZzPMPceCiPja5vAcH+yb/sDFtlnhdvvXkZdKMEo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=akzbfYVRe3KX5A8KI5FYRh0Rre9pHTUHmjm1Th71MmzbCVJ0Hy2N+fU0kTqYmIKe8
         QY7jUIGtZ4IvCBou4O+HOsjZb4nauRR9uCbyICtY+0jv9v2l5gYMfwEZjcthfcCfKb
         GUW9jOa+APNbj+DygCtr1rUaGiBIbWhL+yGmq8zY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17OArK8Z072615
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Aug 2021 05:53:20 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 24
 Aug 2021 05:53:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 24 Aug 2021 05:53:20 -0500
Received: from a0393678-lt.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17OAr3Dh129176;
        Tue, 24 Aug 2021 05:53:18 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chris.chiu@canonical.com>
Subject: [RFC PATCH 5/5] xhci-pci: Use flag to not register roothub while adding primary HCD
Date:   Tue, 24 Aug 2021 16:23:02 +0530
Message-ID: <20210824105302.25382-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824105302.25382-1-kishon@ti.com>
References: <20210824105302.25382-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invoke __usb_hcd_pci_probe() without setting "register_hub" so that
primary roothub is not registered here. Instead it will be registered
along with secondary roothub. This is required for cold plugged USB
devices to be detected in certain PCIe USB cards (like Inateck USB
card).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/host/xhci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 1c9a7957c45c..7734ff13aea9 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -397,7 +397,7 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	 * to say USB 2.0, but I'm not sure what the implications would be in
 	 * the other parts of the HCD code.
 	 */
-	retval = usb_hcd_pci_probe(dev, id, &xhci_pci_hc_driver);
+	retval = __usb_hcd_pci_probe(dev, id, &xhci_pci_hc_driver, 0);
 
 	if (retval)
 		goto put_runtime_pm;
-- 
2.17.1

