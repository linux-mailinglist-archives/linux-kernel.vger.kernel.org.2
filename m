Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBE934F0C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 20:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhC3SRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 14:17:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:15276 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232628AbhC3SQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:16:55 -0400
IronPort-SDR: HI0h/q9Xjjyvma6af7gfqon/6N/NJkyFqp8IlJv1jB8s3Jje5NCaiVrNlE1qsuX8IanQtF75DX
 rMQxb6DdY8WQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179369076"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="179369076"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 11:16:55 -0700
IronPort-SDR: /U98T0bXoXWTgWd4r78jQ4YNa2EJTBOZ4w3Uy+NzccgQpqvj275R6zUg+nUvT835RgZL10MaRF
 kN+pdnlR+UnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="455135167"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Mar 2021 11:16:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5A59734E; Tue, 30 Mar 2021 21:17:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v1 07/10] ipmi_si: Get rid of ->addr_source_cleanup()
Date:   Tue, 30 Mar 2021 21:16:46 +0300
Message-Id: <20210330181649.66496-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
References: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ->addr_source_cleanup() callback is solely used by PCI driver
and only for one purpose, i.e. to disable device. Get rid of
->addr_source_cleanup() by switching to PCI managed API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/ipmi/ipmi_si.h      |  2 --
 drivers/char/ipmi/ipmi_si_intf.c |  4 ----
 drivers/char/ipmi/ipmi_si_pci.c  | 18 ++----------------
 3 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si.h b/drivers/char/ipmi/ipmi_si.h
index fd3167d1e1e9..53463f7762e0 100644
--- a/drivers/char/ipmi/ipmi_si.h
+++ b/drivers/char/ipmi/ipmi_si.h
@@ -51,8 +51,6 @@ struct si_sm_io {
 	enum ipmi_addr_space addr_space;
 	unsigned long addr_data;
 	enum ipmi_addr_src addr_source; /* ACPI, PCI, SMBIOS, hardcode, etc. */
-	void (*addr_source_cleanup)(struct si_sm_io *io);
-	void *addr_source_data;
 	union ipmi_smi_info_union addr_info;
 
 	int (*io_setup)(struct si_sm_io *info);
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index ff448098f185..1f568cc88b39 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2203,10 +2203,6 @@ static void shutdown_smi(void *send_info)
 	if (smi_info->handlers)
 		smi_info->handlers->cleanup(smi_info->si_sm);
 
-	if (smi_info->io.addr_source_cleanup) {
-		smi_info->io.addr_source_cleanup(&smi_info->io);
-		smi_info->io.addr_source_cleanup = NULL;
-	}
 	if (smi_info->io.io_cleanup) {
 		smi_info->io.io_cleanup(&smi_info->io);
 		smi_info->io.io_cleanup = NULL;
diff --git a/drivers/char/ipmi/ipmi_si_pci.c b/drivers/char/ipmi/ipmi_si_pci.c
index 95bbcfba5408..0bc7efb6902c 100644
--- a/drivers/char/ipmi/ipmi_si_pci.c
+++ b/drivers/char/ipmi/ipmi_si_pci.c
@@ -21,13 +21,6 @@ MODULE_PARM_DESC(trypci, "Setting this to zero will disable the"
 
 #define PCI_DEVICE_ID_HP_MMC 0x121A
 
-static void ipmi_pci_cleanup(struct si_sm_io *io)
-{
-	struct pci_dev *pdev = io->addr_source_data;
-
-	pci_disable_device(pdev);
-}
-
 static int ipmi_pci_probe_regspacing(struct si_sm_io *io)
 {
 	if (io->si_type == SI_KCS) {
@@ -97,15 +90,12 @@ static int ipmi_pci_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 	}
 
-	rv = pci_enable_device(pdev);
+	rv = pcim_enable_device(pdev);
 	if (rv) {
 		dev_err(&pdev->dev, "couldn't enable PCI device\n");
 		return rv;
 	}
 
-	io.addr_source_cleanup = ipmi_pci_cleanup;
-	io.addr_source_data = pdev;
-
 	if (pci_resource_flags(pdev, 0) & IORESOURCE_IO) {
 		io.addr_space = IPMI_IO_ADDR_SPACE;
 		io.io_setup = ipmi_si_port_setup;
@@ -128,11 +118,7 @@ static int ipmi_pci_probe(struct pci_dev *pdev,
 	dev_info(&pdev->dev, "%pR regsize %d spacing %d irq %d\n",
 		 &pdev->resource[0], io.regsize, io.regspacing, io.irq);
 
-	rv = ipmi_si_add_smi(&io);
-	if (rv)
-		pci_disable_device(pdev);
-
-	return rv;
+	return ipmi_si_add_smi(&io);
 }
 
 static void ipmi_pci_remove(struct pci_dev *pdev)
-- 
2.30.2

