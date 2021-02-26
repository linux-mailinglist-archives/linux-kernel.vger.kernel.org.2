Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56ED3263CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBZOJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:09:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:55130 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230112AbhBZOFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:05:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87AABAFE2;
        Fri, 26 Feb 2021 14:03:24 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, robin.murphy@arm.com,
        ardb@kernel.org, hch@infradead.org, narmstrong@baylibre.com,
        dwmw2@infradead.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, arnd@arndb.de, will@kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [RFC 13/13] scsi: megaraid: Make use of dev_64bit_mmio_supported()
Date:   Fri, 26 Feb 2021 15:03:05 +0100
Message-Id: <20210226140305.26356-14-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226140305.26356-1-nsaenzjulienne@suse.de>
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on defines use dev_64bit_mmio_supported(), which
provides the same functionality. On top of that convert the
implementation to lo_hi_writeq(), for a cleaner end result.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 23 ++++++++++-----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 38fc9467c625..d4933a591330 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -36,6 +36,7 @@
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 #include <linux/irq_poll.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -259,19 +260,17 @@ static void
 megasas_write_64bit_req_desc(struct megasas_instance *instance,
 		union MEGASAS_REQUEST_DESCRIPTOR_UNION *req_desc)
 {
-#if defined(writeq) && defined(CONFIG_64BIT)
-	u64 req_data = (((u64)le32_to_cpu(req_desc->u.high) << 32) |
-		le32_to_cpu(req_desc->u.low));
-	writeq(req_data, &instance->reg_set->inbound_low_queue_port);
-#else
+	u64 req_data = ((u64)le32_to_cpu(req_desc->u.high) << 32) |
+		       le32_to_cpu(req_desc->u.low);
 	unsigned long flags;
-	spin_lock_irqsave(&instance->hba_lock, flags);
-	writel(le32_to_cpu(req_desc->u.low),
-		&instance->reg_set->inbound_low_queue_port);
-	writel(le32_to_cpu(req_desc->u.high),
-		&instance->reg_set->inbound_high_queue_port);
-	spin_unlock_irqrestore(&instance->hba_lock, flags);
-#endif
+
+	if (dev_64bit_mmio_supported(&instance->pdev->dev)) {
+		writeq(req_data, &instance->reg_set->inbound_low_queue_port);
+	} else {
+		spin_lock_irqsave(&instance->hba_lock, flags);
+		lo_hi_writeq(req_data, &instance->reg_set->inbound_low_queue_port);
+		spin_unlock_irqrestore(&instance->hba_lock, flags);
+	}
 }
 
 /**
-- 
2.30.1

