Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4737B32BA94
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357968AbhCCLha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:37:30 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.5]:29532 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242438AbhCCD0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 22:26:50 -0500
Received: from [100.112.2.115] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.us-east-1.aws.symcld.net id 41/5A-54546-2B00F306; Wed, 03 Mar 2021 03:21:22 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRWlGSWpSXmKPExsWSLveKTXcTg32
  CwZen4hZnJwRatL/eymhxedccNosnC88wObB47PzewO6xfstVFo/Pm+QCmKNYM/OS8isSWDMO
  XVnMXHCFv+LmhR+MDYzbeboYuTiEBP4zSkzom8YG4bxklDg4fztzFyMHB5uAgsSDfapdjJwcI
  gK5Ep177jOD2MwCFhLLfzxkBLGFBYwk2g9/ZAexWQRUJA7tPQZWwytgLvHgzxcWEFtCQF7i7Z
  FuNhCbE8h+dKERLC4kICfR0/OFFaJeUOLkzCcsEPMlJA6+eMEM0ask0XvoGBvIORICCRLTnmh
  MYOSfhaRjFpKOBYxMqxjNkooy0zNKchMzc3QNDQx0DQ2NdI10DY2M9RKrdJP0Sot1UxOLS3QN
  9RLLi/WKK3OTc1L08lJLNjECwzalgKl6B+OPVx/0DjFKcjApifIuu2WXIMSXlJ9SmZFYnBFfV
  JqTWnyIUYaDQ0mCd/tfoJxgUWp6akVaZg4whmDSEhw8SiK8z/8ApXmLCxJzizPTIVKnGBWlxH
  mP/QNKCIAkMkrz4NpgcXuJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjBv+H+gKTyZeSVw018
  BLWYCWjzLDWxxSSJCSqqBiWmdd6yYiOG77OIFU7dJKV++GWPS2Xy0djr7hr7ZRdNsO9onGqrZ
  mjjJ/ud8Zh8qWpWZp7/hHcOybbETVF27D1hW/y+1m2PRc4M7QzVpVc7ZzhVu35d4L3lnqXTS8
  75idx678u70tZXlZ37Zq8aXrt9ifHSvm5pvo4Z95Gb9WQGnrl1/Y7Oc+UB56bXFOu7+zk9fl0
  603KmZrF8l5L1DTnj75JdWWx40XN15dLuEvrpGoGgI68cMnblCuc6MqxNOq+v0VTwW33Ft+az
  LWn+mKM/YKvY642Z8EvuiZ+tcT2zepLg/5sbl5DV/Oc/9v1r9zX+p6MxXlQx3Xms86p7YMH1H
  TZUiw9xHFVElV3aJKbEUZyQaajEXFScCACvoqH1WAwAA
X-Env-Sender: lijq9@lenovo.com
X-Msg-Ref: server-4.tower-395.messagelabs.com!1614741679!779752!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6910 invoked from network); 3 Mar 2021 03:21:22 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-4.tower-395.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Mar 2021 03:21:22 -0000
Received: from pekwpmail03.lenovo.com (unknown [10.96.93.81])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 3B200AE80B899EAF92AE;
        Wed,  3 Mar 2021 11:21:19 +0800 (CST)
Received: from localhost.localdomain (100.67.100.178) by
 pekwpmail03.lenovo.com (10.96.93.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 3 Mar 2021 11:21:14 +0800
From:   Jiqi Li <lijq9@lenovo.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <markpearson@lenovo.com>, Jiqi Li <lijq9@lenovo.com>
Subject: [PATCH] hwmon: (nct6883) Support NCT6686D
Date:   Wed, 3 Mar 2021 11:20:37 +0800
Message-ID: <20210303032037.1891858-1-lijq9@lenovo.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <lijq9@lenovo.com>
References: <lijq9@lenovo.com>
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

