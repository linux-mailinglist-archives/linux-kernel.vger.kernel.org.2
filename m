Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6313836A911
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 21:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhDYTzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 15:55:50 -0400
Received: from mailfilter02-out40.webhostingserver.nl ([195.211.72.22]:27964
        "EHLO mailfilter02-out40.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231265AbhDYTzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 15:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exalondelft.nl; s=whs1;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=89+H5rCRk92mV8YEGLrI/q3ZeBEsPhsRhzx51JBwkfg=;
        b=f+kJWoMWLD/LuRe/dkY4Fhhtebv9AVaWrEipdOhWbda1oZSt0qFDB45dHLefE8U7d3GP3DuXnaM9Q
         Z0LWf4VOdvfels9iTyizpHa+Vj188EMXC6blufcxdwf4FPRVnI9wRKMUy9Ry9ch+R/+vWxtei9RqDL
         0EgGBhsjo5RivsNCtne3SDNWQLHxGyhahenoYZCxiQ+kun81jRULc2sfbg4tPOpjsbsEZv1qJopa/L
         Q83kGJdTtZdMGMZRJLJY8hyUcoOjAiprW/lGTE8gb6YIqe+EoKHgjZbO1lJBb+Zv/svCqO4GdEQthC
         rP5JtrzQC5Ro457vsndP4iDaDif8cLA==
X-Halon-ID: 219f4f46-a600-11eb-8288-001a4a4cb922
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
        by mailfilter02.webhostingserver.nl (Halon) with ESMTPSA
        id 219f4f46-a600-11eb-8288-001a4a4cb922;
        Sun, 25 Apr 2021 21:55:05 +0200 (CEST)
Received: from [2001:981:6fec:1:1853:1ae5:69c6:8aab] (helo=delfion.fritz.box)
        by s198.webhostingserver.nl with esmtpa (Exim 4.94)
        (envelope-from <ftoth@exalondelft.nl>)
        id 1lakqP-008RrJ-Lw; Sun, 25 Apr 2021 21:55:05 +0200
From:   Ferry Toth <ftoth@exalondelft.nl>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ferry Toth <ftoth@exalondelft.nl>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 1/1] usb: dwc3: pci: Enable usb2-gadget-lpm-disable for Intel Merrifield
Date:   Sun, 25 Apr 2021 21:54:52 +0200
Message-Id: <20210425195452.94143-1-ftoth@exalondelft.nl>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel Merrifield LPM is causing the host to reset port after a timeout.
By disabling LPM entirely this is prevented.

Fixes: 066c09593454 ("usb: dwc3: pci: Enable extcon driver for Intel Merrifield")
Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

