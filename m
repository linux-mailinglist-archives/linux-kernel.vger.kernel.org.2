Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE986352EA8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbhDBRns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:43:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:26096 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235554AbhDBRna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:43:30 -0400
IronPort-SDR: 5IKgucP4iS8OW8U2x5zQpkqoZ/IJbwlnusFjctpCmnTyWNePaaOP1pIXPMZhMhyR1B0TKL08Hr
 wdIzc/UK2ihw==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="172543163"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="172543163"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 10:43:28 -0700
IronPort-SDR: QWu2A/LVar8jJM1v8L/EGBZTF2lNGrJ3G0jcapr9cEaZIQp/BgPSGAKPUnlzqfYpJOhw1Im3Rh
 Aw44mO3zt4jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="413277895"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Apr 2021 10:43:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BE95C60B; Fri,  2 Apr 2021 20:43:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v2 07/10] ipmi_si: Get rid of ->addr_source_cleanup()
Date:   Fri,  2 Apr 2021 20:43:31 +0300
Message-Id: <20210402174334.13466-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
References: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
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
index 9492c53eba86..0a4c69539f24 100644
--- a/drivers/char/ipmi/ipmi_si.h
+++ b/drivers/char/ipmi/ipmi_si.h
@@ -52,8 +52,6 @@ struct si_sm_io {
 	enum ipmi_addr_space addr_space;
 	unsigned long addr_data;
 	enum ipmi_addr_src addr_source; /* ACPI, PCI, SMBIOS, hardcode, etc. */
-	void (*addr_source_cleanup)(struct si_sm_io *io);
-	void *addr_source_data;
 	union ipmi_smi_info_union addr_info;
 
 	int (*io_setup)(struct si_sm_io *info);
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index d6ecf88636c4..5bf0ab61261f 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2206,10 +2206,6 @@ static void shutdown_smi(void *send_info)
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

