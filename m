Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4CF446699
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhKEQCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:02:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:15049 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233646AbhKEQCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:02:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="318126913"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="318126913"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 08:59:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="490372721"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by orsmga007.jf.intel.com with ESMTP; 05 Nov 2021 08:59:34 -0700
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
To:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>
Cc:     mr.yming81@gmail.com, chunfeng.yun@mediatek.com,
        matthias.bgg@gmail.com, nishadkamdar@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, eddie.hung@mediatek.com,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH] xhci: Fix USB 3.1 enumeration issues by increasing roothub power-on-good delay
Date:   Fri,  5 Nov 2021 18:00:36 +0200
Message-Id: <20211105160036.549516-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211105133050.GA1590803@rowland.harvard.edu>
References: <20211105133050.GA1590803@rowland.harvard.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some USB 3.1 enumeration issues were reported after the hub driver removed
the minimum 100ms limit for the power-on-good delay.

Since commit 90d28fb53d4a ("usb: core: reduce power-on-good delay time of
root hub") the hub driver sets the power-on-delay based on the
bPwrOn2PwrGood value in the hub descriptor.

xhci driver has a 20ms bPwrOn2PwrGood value for both roothubs based
on xhci spec section 5.4.8, but it's clearly not enough for the
USB 3.1 devices, causing enumeration issues.

Tests indicate full 100ms delay is needed.

Reported-by: Walt Jr. Brake <mr.yming81@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-hub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index a3f875eea751..af946c42b6f0 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -257,7 +257,6 @@ static void xhci_common_hub_descriptor(struct xhci_hcd *xhci,
 {
 	u16 temp;
 
-	desc->bPwrOn2PwrGood = 10;	/* xhci section 5.4.9 says 20ms max */
 	desc->bHubContrCurrent = 0;
 
 	desc->bNbrPorts = ports;
@@ -292,6 +291,7 @@ static void xhci_usb2_hub_descriptor(struct usb_hcd *hcd, struct xhci_hcd *xhci,
 	desc->bDescriptorType = USB_DT_HUB;
 	temp = 1 + (ports / 8);
 	desc->bDescLength = USB_DT_HUB_NONVAR_SIZE + 2 * temp;
+	desc->bPwrOn2PwrGood = 10;	/* xhci section 5.4.8 says 20ms */
 
 	/* The Device Removable bits are reported on a byte granularity.
 	 * If the port doesn't exist within that byte, the bit is set to 0.
@@ -344,6 +344,7 @@ static void xhci_usb3_hub_descriptor(struct usb_hcd *hcd, struct xhci_hcd *xhci,
 	xhci_common_hub_descriptor(xhci, desc, ports);
 	desc->bDescriptorType = USB_DT_SS_HUB;
 	desc->bDescLength = USB_DT_SS_HUB_SIZE;
+	desc->bPwrOn2PwrGood = 50;	/* usb 3.1 may fail if less than 100ms */
 
 	/* header decode latency should be zero for roothubs,
 	 * see section 4.23.5.2.
-- 
2.25.1

