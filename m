Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE4935F632
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349674AbhDNOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:30:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:30328 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347823AbhDNOaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:30:10 -0400
IronPort-SDR: FsQhGcBYftdAmD0xXby7spk4Lov85PyEf73hxEkiA0A/MCNjDYRfAuSM4UC/FSw4rlU0hhRaXp
 dtWTlOkgIZiA==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="279962451"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="279962451"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 07:29:45 -0700
IronPort-SDR: pWBUzdSKPknPiKMPu7DkLjiIVD7lsAAMbFIHudy6f0rJLo2wQgS45Mw3/Xn+aW978mw8iLZ1kF
 zD27JXpGX8FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="421339290"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 14 Apr 2021 07:29:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 121AC147; Wed, 14 Apr 2021 17:30:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] mfd: intel-lpss: Add Intel Alder Lake-M PCI IDs
Date:   Wed, 14 Apr 2021 17:29:43 +0300
Message-Id: <20210414142943.60563-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Intel Alder Lake-M LPSS PCI IDs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 1522c8afc540..dc0292aa2e6e 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -290,6 +290,19 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x51ea), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x51eb), (kernel_ulong_t)&bxt_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x51fb), (kernel_ulong_t)&bxt_info },
+	/* ADL-M */
+	{ PCI_VDEVICE(INTEL, 0x54a8), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x54a9), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x54aa), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x54ab), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x54c5), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x54c6), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x54c7), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x54e8), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x54e9), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x54ea), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x54eb), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x54fb), (kernel_ulong_t)&bxt_info },
 	/* APL */
 	{ PCI_VDEVICE(INTEL, 0x5aac), (kernel_ulong_t)&apl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x5aae), (kernel_ulong_t)&apl_i2c_info },
-- 
2.30.2

