Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8124F3957A4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhEaI7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:59:23 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:52578 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231129AbhEaI7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:59:16 -0400
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14V8rv1k005644;
        Mon, 31 May 2021 08:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id; s=pps0720;
 bh=bPMIhSMLek01PGXqMZG6ZlmOB4F0ex4Vv2y/gbAW8bQ=;
 b=Tw/3x1ALOT6KHayyi3t3M+UQH09ji704pjngFCYBUMy/it2/ttwNf7YmAvXQvgf1v2MV
 6IEO266N6W9DjZVKwe87+YztpH1Nu10aEJQ0uky83RWEifhVWjF/OZoerQK1rQj7ifqF
 tg+tC1qNjP2M1CS5yk2O3HqgiVquslSpc9NdiqZkqXNr01XWn9PvoowlyM4Laq629ecy
 IHpOtcgaoGL5kYkKIYtbmy6QMaGSyfBSX8ImeonpbLnPlcgG0SpJ8P/9LD6AhtNGOzHF
 ay55WhhEYus/pV1NOHoxtowRoM5THvEHzCXpta6I2j02JSciDrEKvPnCCs8Sl5yEKTv1 aQ== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 38vs879t0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 May 2021 08:57:34 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 885D189;
        Mon, 31 May 2021 08:57:33 +0000 (UTC)
Received: from blofly.tw.rdlabs.hpecorp.net (blofly.tw.rdlabs.hpecorp.net [15.119.208.30])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 319DE36;
        Mon, 31 May 2021 08:57:31 +0000 (UTC)
From:   matt.hsiao@hpe.com
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        Matt Hsiao <matt.hsiao@hpe.com>
Subject: [PATCH] misc: hpilo: map iLO shared memory by PCI revision id
Date:   Mon, 31 May 2021 16:55:51 +0800
Message-Id: <20210531085551.26421-1-matt.hsiao@hpe.com>
X-Mailer: git-send-email 2.16.6
X-Proofpoint-ORIG-GUID: FvfWhVMGeRBYm0UBbU0kTa6Wixgqv3Qo
X-Proofpoint-GUID: FvfWhVMGeRBYm0UBbU0kTa6Wixgqv3Qo
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-31_07:2021-05-31,2021-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105310064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Hsiao <matt.hsiao@hpe.com>

Starting from iLO ASIC 'Neches' with subsystem device id 0x00E4,
bar 5 is used for shared memory region mapping instead of bar 2
because bar 2 is made inaccessible after system POST for security
reason.

As this holds true for future iLO ASIC generations, it does not
make sense to map shared memory region according to the subsystem
device id of each following generations.

Map iLO shared memory region with PCI revision id that maps to the
iLO ASIC generation, starting from Neches (Rev 7).

Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
---
 drivers/misc/hpilo.c | 10 +++++++++-
 drivers/misc/hpilo.h |  3 +++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index fea3ae9d8686..8d00df9243c4 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -693,6 +693,8 @@ static int ilo_map_device(struct pci_dev *pdev, struct ilo_hwinfo *hw)
 {
 	int bar;
 	unsigned long off;
+	u8 pci_rev_id;
+	int rc;
 
 	/* map the memory mapped i/o registers */
 	hw->mmio_vaddr = pci_iomap(pdev, 1, 0);
@@ -702,7 +704,13 @@ static int ilo_map_device(struct pci_dev *pdev, struct ilo_hwinfo *hw)
 	}
 
 	/* map the adapter shared memory region */
-	if (pdev->subsystem_device == 0x00E4) {
+	rc = pci_read_config_byte(pdev, PCI_REVISION_ID, &pci_rev_id);
+	if (rc != 0) {
+		dev_err(&pdev->dev, "Error reading PCI rev id: %d\n", rc);
+		goto out;
+	}
+
+	if (pci_rev_id >= PCI_REV_ID_NECHES) {
 		bar = 5;
 		/* Last 8k is reserved for CCBs */
 		off = pci_resource_len(pdev, bar) - 0x2000;
diff --git a/drivers/misc/hpilo.h b/drivers/misc/hpilo.h
index f69ff645cac9..d57c34680b09 100644
--- a/drivers/misc/hpilo.h
+++ b/drivers/misc/hpilo.h
@@ -10,6 +10,9 @@
 
 #define ILO_NAME "hpilo"
 
+/* iLO ASIC PCI revision id */
+#define PCI_REV_ID_NECHES	7
+
 /* max number of open channel control blocks per device, hw limited to 32 */
 #define MAX_CCB	       24
 /* min number of open channel control blocks per device, hw limited to 32 */
-- 
2.16.6

