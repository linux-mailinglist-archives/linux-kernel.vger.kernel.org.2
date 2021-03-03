Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1D332BB61
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445224AbhCCMXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:23:21 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.114]:37624 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1842312AbhCCHEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 02:04:48 -0500
Received: from [100.112.4.31] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-c.us-east-1.aws.symcld.net id DD/43-45036-8C33F306; Wed, 03 Mar 2021 06:59:20 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRWlGSWpSXmKPExsWS8eIhj+4JY/s
  Eg18rRSzOTgi0aH+9ldHi8q45bBZPFp5hcmDx2Pm9gd1j/ZarLB6fN8kFMEexZuYl5VcksGYc
  urKYueAKf8XNCz8YGxi383QxcnEICfxnlNh/qJO9i5ETyHnJKHHigmgXIwcHm4CCxIN9qiBhE
  YFcic4995lBbGYBC4nlPx4ygtjCAqYSVzq/sIHYLAIqEovuXGMCaeUVMJf4tFobJCwhIC/x9k
  g3WAmvgKDEyZlPWCDGSEgcfPGCGaJGSaL30DE2kFYJgQSJaU80JjDyzkLSMQtJxwJGplWMJkl
  FmekZJbmJmTm6hgYGuoaGRrqmuhZ6iVW6yXqlxbqpicUluoZ6ieXFesWVuck5KXp5qSWbGIHh
  l1LAyrGD8fvrD3qHGCU5mJREeZfdsksQ4kvKT6nMSCzOiC8qzUktPsQow8GhJMHLZWifICRYl
  JqeWpGWmQOMBZi0BAePkgjvCZA0b3FBYm5xZjpE6hSjopQ4r7MRUEIAJJFRmgfXBou/S4yyUs
  K8jAwMDEI8BalFuZklqPKvGMU5GJWEee+ATOHJzCuBm/4KaDET0OJZbnYgi0sSEVJSDUx7vLr
  2OnoeFIp13iS7o93PZ9OGB00BZin3IsqeHJ9h8JSDs5tl+5uGvmmZro3XJpWuLkmzfbjk1rsf
  evWTpdOX1WnIV/x2jU1QPr2g4pl+1GmJjbE8kZLb1/pc3rG8aLeblsp6GYejfH8maLK6Hp7F5
  zA5bbn1Q8ML01ekMvRNKTHeve7Eg4YLPaYc67PjDKdcPmWQ7p9m58n9648Wy9WQftFfTa5ij4
  WUrC4Y+Que2nzh5cfpHypOz/JRUJ0/weDUPIkPR/QsjU++cjAXyH6v0et7/kJ45J1qvmUMt4t
  6v6Z8Fl7678SCySZJp918JqyfOvfz/38685635b/8cePVopDv2tHTkjlvXI6KXmWmxFKckWio
  xVxUnAgA8C8ITjoDAAA=
X-Env-Sender: lijq9@lenovo.com
X-Msg-Ref: server-10.tower-415.messagelabs.com!1614754760!772214!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13378 invoked from network); 3 Mar 2021 06:59:20 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
  by server-10.tower-415.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Mar 2021 06:59:20 -0000
Received: from pekwpmail03.lenovo.com (unknown [10.96.93.81])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 0368836A2547AD5372CC;
        Wed,  3 Mar 2021 01:59:18 -0500 (EST)
Received: from localhost.localdomain (100.67.100.178) by
 pekwpmail03.lenovo.com (10.96.93.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 3 Mar 2021 14:59:12 +0800
From:   Jiqi Li <lijq9@lenovo.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <markpearson@lenovo.com>, Jiqi Li <lijq9@lenovo.com>
Subject: [PATCH v1] hwmon: (nct6883) Support NCT6686D
Date:   Wed, 3 Mar 2021 14:58:53 +0800
Message-ID: <20210303065853.1894677-1-lijq9@lenovo.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.67.100.178]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 pekwpmail03.lenovo.com (10.96.93.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for NCT6686D chip used in the Lenovo P620.

Signed-off-by: Jiqi Li <lijq9@lenovo.com>
Reviewed-by: Mark Pearson <markpearson@lenovo.com>
---
 drivers/hwmon/nct6683.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index a23047a3bfe2..256e8d62f858 100644
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * nct6683 - Driver for the hardware monitoring functionality of
- *	     Nuvoton NCT6683D/NCT6687D eSIO
+ *	     Nuvoton NCT6683D/NCT6686D/NCT6687D eSIO
  *
  * Copyright (C) 2013  Guenter Roeck <linux@roeck-us.net>
  *
@@ -12,6 +12,7 @@
  *
  * Chip        #vin    #fan    #pwm    #temp  chip ID
  * nct6683d     21(1)   16      8       32(1) 0xc730
+ * nct6686d     21(1)   16      8       32(1) 0xd440
  * nct6687d     21(1)   16      8       32(1) 0xd590
  *
  * Notes:
@@ -33,7 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-enum kinds { nct6683, nct6687 };
+enum kinds { nct6683, nct6686, nct6687 };
 
 static bool force;
 module_param(force, bool, 0);
@@ -41,11 +42,13 @@ MODULE_PARM_DESC(force, "Set to one to enable support for unknown vendors");
 
 static const char * const nct6683_device_names[] = {
 	"nct6683",
+	"nct6686",
 	"nct6687",
 };
 
 static const char * const nct6683_chip_names[] = {
 	"NCT6683D",
+	"NCT6686D",
 	"NCT6687D",
 };
 
@@ -66,6 +69,7 @@ static const char * const nct6683_chip_names[] = {
 
 #define SIO_NCT6681_ID		0xb270	/* for later */
 #define SIO_NCT6683_ID		0xc730
+#define SIO_NCT6686_ID		0xd440
 #define SIO_NCT6687_ID		0xd590
 #define SIO_ID_MASK		0xFFF0
 
@@ -1362,6 +1366,9 @@ static int __init nct6683_find(int sioaddr, struct nct6683_sio_data *sio_data)
 	case SIO_NCT6683_ID:
 		sio_data->kind = nct6683;
 		break;
+	case SIO_NCT6686_ID:
+		sio_data->kind = nct6686;
+		break;
 	case SIO_NCT6687_ID:
 		sio_data->kind = nct6687;
 		break;
-- 
2.18.2

