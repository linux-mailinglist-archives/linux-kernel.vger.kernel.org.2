Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0933FE16F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346899AbhIARvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:51:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:16284 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347526AbhIARvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:51:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="215694364"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="215694364"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 10:49:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="499022416"
Received: from silpixa00400294.ir.intel.com ([10.237.222.100])
  by fmsmga008.fm.intel.com with ESMTP; 01 Sep 2021 10:49:48 -0700
From:   Wojciech Ziemba <wojciech.ziemba@intel.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [PATCH 2/4] crypto: qat - remove unmatched CPU affinity to cluster IRQ
Date:   Wed,  1 Sep 2021 18:36:06 +0100
Message-Id: <20210901173608.16777-3-wojciech.ziemba@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210901173608.16777-1-wojciech.ziemba@intel.com>
References: <20210901173608.16777-1-wojciech.ziemba@intel.com>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes redundant CPU affinity to AE cluster IRQ.

Signed-off-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_common/adf_isr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/qat/qat_common/adf_isr.c b/drivers/crypto/qat/qat_common/adf_isr.c
index a2ab16651a56..26b546d3f821 100644
--- a/drivers/crypto/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_isr.c
@@ -203,7 +203,6 @@ static void adf_free_irqs(struct adf_accel_dev *accel_dev)
 	}
 
 	irq = pci_irq_vector(pci_dev_info->pci_dev, clust_irq);
-	irq_set_affinity_hint(irq, NULL);
 	free_irq(irq, accel_dev);
 }
 
-- 
2.29.2

--------------------------------------------------------------
Intel Research and Development Ireland Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263


This e-mail and any attachments may contain confidential material for the sole
use of the intended recipient(s). Any review or distribution by others is
strictly prohibited. If you are not the intended recipient, please contact the
sender and delete all copies.

