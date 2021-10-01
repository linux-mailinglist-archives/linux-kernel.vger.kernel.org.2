Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A79A41F332
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhJARig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:38:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:39803 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhJARif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:38:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="248074014"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="248074014"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 10:36:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="521245454"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 01 Oct 2021 10:36:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1990BB8; Fri,  1 Oct 2021 20:36:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mei: me: add Ice Lake-N device id.
Date:   Fri,  1 Oct 2021 20:36:44 +0300
Message-Id: <20211001173644.16068-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ice Lake-N device ID.

The device can be found on MacBookPro16,2 [1].

[1]: https://linux-hardware.org/?probe=f1c5cf0c43

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/mei/hw-me-regs.h | 1 +
 drivers/misc/mei/pci-me.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index cb34925e10f1..67bb6a25fd0a 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -92,6 +92,7 @@
 #define MEI_DEV_ID_CDF        0x18D3  /* Cedar Fork */
 
 #define MEI_DEV_ID_ICP_LP     0x34E0  /* Ice Lake Point LP */
+#define MEI_DEV_ID_ICP_N      0x38E0  /* Ice Lake Point N */
 
 #define MEI_DEV_ID_JSP_N      0x4DE0  /* Jasper Lake Point N */
 
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index c3393b383e59..3a45aaf002ac 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -96,6 +96,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_CMP_H_3, MEI_ME_PCH8_ITOUCH_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ICP_LP, MEI_ME_PCH12_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_ICP_N, MEI_ME_PCH12_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_TGP_LP, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_TGP_H, MEI_ME_PCH15_SPS_CFG)},
-- 
2.33.0

