Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAFF3D11DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbhGUOXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:23:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:37977 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239500AbhGUOVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:21:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="198721500"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="198721500"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 08:01:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="415588677"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2021 08:01:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A008984; Wed, 21 Jul 2021 18:02:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        gregkh@linuxfoundation.org
Subject: [PATCH v1 2/2] parport: serial: Retrieve IRQ vector with help of special getter
Date:   Wed, 21 Jul 2021 18:02:16 +0300
Message-Id: <20210721150216.64823-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721150216.64823-1-andriy.shevchenko@linux.intel.com>
References: <20210721150216.64823-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_irq_vector() may be used to retrieve IRQ vector for a PCI device.
Use it instead of direct access.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/parport_serial.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 14e2427676f0..9f5d784cd95d 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -606,7 +606,9 @@ static int parport_register(struct pci_dev *dev, const struct pci_device_id *id)
                                         "hi" as an offset (see SYBA
                                         def.) */
 		/* TODO: test if sharing interrupts works */
-		irq = dev->irq;
+		irq = pci_irq_vector(dev, 0);
+		if (irq < 0)
+			return irq;
 		if (irq == 0)
 			irq = PARPORT_IRQ_NONE;
 		if (irq == PARPORT_IRQ_NONE) {
-- 
2.30.2

