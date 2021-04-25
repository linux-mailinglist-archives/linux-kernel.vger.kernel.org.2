Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E9E36A7F5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 17:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhDYP1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 11:27:01 -0400
Received: from mailfilter04-out40.webhostingserver.nl ([195.211.73.157]:63380
        "EHLO mailfilter04-out40.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhDYP07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 11:26:59 -0400
X-Greylist: delayed 963 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Apr 2021 11:26:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exalondelft.nl; s=whs1;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=4a48TYfBo5B9adFJqH22Pg3azQUJIkJpWK6/sSAJwaM=;
        b=rdubIhu+dwTpKbXd5IlddbvsVX0dfqdhdLJi1IEceCfpkwMDxhehC1fWyySwKfvj3t2s976ENDVe9
         jn3w9Qvs2FG42YJw+FiWk/Npf/nfEcBUL2XhV309mF4gPETHghsEMWqQO7RjUQfZb3kejsm4G0T/s6
         o/IUhCIAqz7IVbQE2LmDAOgDNGyGfOKiAOCHkOWWvAqzo5wPmxQIWbi2OiMfYYicQ2COt8Ikw65FXi
         efutlJ0zVlyWkjIfSidPl1DGOOxDtQNHwREKSAEEZWSKJulSsW16S2zqBKRE/E1xtqC5pxTbpJ1VH1
         iiXznuzmwiv+8P5VTdn1nAUP//wQQTw==
X-Halon-ID: 5601aa54-a5d8-11eb-9c68-001a4a4cb95f
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
        by mailfilter04.webhostingserver.nl (Halon) with ESMTPSA
        id 5601aa54-a5d8-11eb-9c68-001a4a4cb95f;
        Sun, 25 Apr 2021 17:10:13 +0200 (CEST)
Received: from [2001:981:6fec:1:1853:1ae5:69c6:8aab] (helo=delfion.fritz.box)
        by s198.webhostingserver.nl with esmtpa (Exim 4.94)
        (envelope-from <ftoth@exalondelft.nl>)
        id 1lagOi-00Aq10-Nt; Sun, 25 Apr 2021 17:10:12 +0200
From:   Ferry Toth <ftoth@exalondelft.nl>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 1/1] usb: dwc3: pci: Enable usb2-gadget-lpm-disable for Intel Merrifield
Date:   Sun, 25 Apr 2021 17:09:47 +0200
Message-Id: <20210425150947.5862-1-ftoth@exalondelft.nl>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel Merrifield LPM is causing host to reset port after a timeout.
By disabling LPM entirely this is prevented.

Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
Fixes: 066c09593454 ("usb: dwc3: pci: Enable extcon driver for Intel Merrifield")
---
 drivers/usb/dwc3/dwc3-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 4c5c6972124a..e5d7eed2e60c 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -122,6 +122,7 @@ static const struct property_entry dwc3_pci_mrfld_properties[] = {
 	PROPERTY_ENTRY_STRING("linux,extcon-name", "mrfld_bcove_pwrsrc"),
 	PROPERTY_ENTRY_BOOL("snps,dis_u3_susphy_quirk"),
 	PROPERTY_ENTRY_BOOL("snps,dis_u2_susphy_quirk"),
+	PROPERTY_ENTRY_BOOL("snps,usb2-gadget-lpm-disable"),
 	PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
 	{}
 };
-- 
2.27.0

