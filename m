Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A97A3FB870
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbhH3Oos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237215AbhH3Oon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630334629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNRgTRukmSm46NdTDeYat/9D1asHkUi+/ERr/zKfHVo=;
        b=NBOkh3Hm5FgJVZ3DZZJ7KUz+QuXSsUrNqulH1RdFSm9+cD5bQWlHu7Lu2atvzayZJmNiZq
        ho8bSXzmPeNGWbdalTnOKvWmon32NrgOomMqxRRKPVvLhkkfT3qVvgEQ4QVuX7B1CMYxRb
        SkEkyYKofNfGQ11D1Bo60xCdkbbfp/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-4uRi8aLzPdOG_DbYyNPdng-1; Mon, 30 Aug 2021 10:43:46 -0400
X-MC-Unique: 4uRi8aLzPdOG_DbYyNPdng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B1E1871811;
        Mon, 30 Aug 2021 14:43:45 +0000 (UTC)
Received: from fedora-t480.redhat.com (unknown [10.39.192.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC1861837F;
        Mon, 30 Aug 2021 14:43:40 +0000 (UTC)
From:   Kate Hsuan <hpa@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v3 1/1] libata: Add ATA_HORKAGE_NONCQ_ON_AMD for Samsung 860 and 870 SSD.
Date:   Mon, 30 Aug 2021 10:42:53 -0400
Message-Id: <20210830144253.289542-2-hpa@redhat.com>
In-Reply-To: <20210830144253.289542-1-hpa@redhat.com>
References: <20210830144253.289542-1-hpa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many users are reporting that the Samsung 860 and 870 SSD are having
various issues when combined with AMD SATA controllers and only
completely disabling NCQ helps to avoid these issues.

Entire disabling NCQ for Samsugn 860/870 SSD will cause I/O performance
drop. In this case, a flag ATA_HORKAGE_NONCQ_ON_AMD is introduced to
used to perform an additional check for these SSDs. If it finds it's
parent ATA controller is AMD, the NCQ will be disabled. Otherwise, the
NCQ is kept to enable.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201693
Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/ata/libata-core.c | 24 ++++++++++++++++++++++--
 include/linux/libata.h    |  1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c861c93d1e84..36c62f758b73 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2190,6 +2190,8 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 			       char *desc, size_t desc_sz)
 {
 	struct ata_port *ap = dev->link->ap;
+	struct pci_dev *pcidev = NULL;
+	struct device *parent_dev = NULL;
 	int hdepth = 0, ddepth = ata_id_queue_depth(dev->id);
 	unsigned int err_mask;
 	char *aa_desc = "";
@@ -2204,6 +2206,22 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 		snprintf(desc, desc_sz, "NCQ (not used)");
 		return 0;
 	}
+
+	if (dev->horkage & ATA_HORKAGE_NONCQ_ON_AMD) {
+		for (parent_dev = dev->tdev.parent; parent_dev != NULL;
+		    parent_dev = parent_dev->parent) {
+			if (dev_is_pci(parent_dev)) {
+				pcidev = to_pci_dev(parent_dev);
+				if (pcidev->vendor == PCI_VENDOR_ID_AMD) {
+					snprintf(desc, desc_sz,
+						 "NCQ (not used)");
+					return 0;
+				}
+			break;
+			}
+		}
+	}
+
 	if (ap->flags & ATA_FLAG_NCQ) {
 		hdepth = min(ap->scsi_host->can_queue, ATA_MAX_QUEUE);
 		dev->flags |= ATA_DFLAG_NCQ;
@@ -3971,9 +3989,11 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "Samsung SSD 850*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Samsung SSD 860*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NONCQ_ON_AMD, },
 	{ "Samsung SSD 870*",           NULL,   ATA_HORKAGE_NO_NCQ_TRIM |
-						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+						ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NONCQ_ON_AMD, },
 	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 860e63f5667b..42e16114e91f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -426,6 +426,7 @@ enum {
 	ATA_HORKAGE_NOTRIM	= (1 << 24),	/* don't use TRIM */
 	ATA_HORKAGE_MAX_SEC_1024 = (1 << 25),	/* Limit max sects to 1024 */
 	ATA_HORKAGE_MAX_TRIM_128M = (1 << 26),	/* Limit max trim size to 128M */
+	ATA_HORKAGE_NONCQ_ON_AMD = (1 << 27),	/* Disable NCQ on AMD chipset */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
-- 
2.31.1

