Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493F032A1FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349374AbhCBHPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:15:47 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.1]:51557 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1835868AbhCBGYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:02 -0500
Received: from [100.112.128.20] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.us-west-2.aws.symcld.net id D0/1D-57987-8E8DD306; Tue, 02 Mar 2021 06:19:20 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRWlGSWpSXmKPExsWSLveKXffFDds
  Eg3t/WSzOTgi0aH+9ldHi8q45bBZPFp5hcmDx2Pm9gd1j/ZarLB6fN8kFMEexZuYl5VcksGbM
  ef+NrWADb8XK2c/YGxjPcnUxcnEICfxnlDg8fx07hPMSyPmygLGLkYODTUBB4sE+1S5GTg4Rg
  VyJzj33mUFsZgELieU/HjKC2MICRhL3pu5iB7FZBFQk1h6dxQpi8wqYS1za8Q8sLiEgL/H2SD
  cbiM0JZD+60MgCYgsJyEn09HyBqheUODnzCQvEfAmJgy9eMEP0Kkn0LLjCAnKOhECCxLQnGhM
  Y+Wch6ZiFpGMBI9MqRoukosz0jJLcxMwcXUMDA11DQyNdQ2MDXSNTI73EKt1EvdJi3fLU4hJd
  ILe8WK+4Mjc5J0UvL7VkEyMwdFMKmv7sYPz76oPeIUZJDiYlUd4tx2wThPiS8lMqMxKLM+KLS
  nNSiw8xynBwKEnwKl4HygkWpaanVqRl5gDjCCYtwcGjJMIrfh4ozVtckJhbnJkOkTrFqCglzl
  sF0icAksgozYNrg8XuJUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvBIgU3gy80rgpr8CWsw
  EtHh7oBXI4pJEhJRUAxO7YnH9Z+vgx/L8vKzVFltM6p/9URCvtmla6iF56miL3oZDumuv/eHI
  b318oeuKnU2VTsfc8vbP/ypXH+i4fdhWOUZiflTx0/uH9zPrNFQ9aY7gNChr6Z69n83Rs0S2s
  vHi6xVHfl8V8a4r8mXKmpfOa7T2VV/ThE8OW2L+Mv26etj/hX7W8ru7pRj29VU+YBFymPTw4b
  ZPxxy5o1/k2tWKPvj37qDZ0almW948uXLe+NymS2w23/Rmu0pNnuknue2V06c7E1f931A80d7
  VgFv32OxHn20r94k71YuG6fxzPnH9Sf1CFoPnukKtiy7+D5UzDdI7yzlNbKKaVPb02/1pWiWi
  jga1R34uZv3zTkqJpTgj0VCLuag4EQAW5QSXWAMAAA==
X-Env-Sender: lijq9@lenovo.com
X-Msg-Ref: server-17.tower-326.messagelabs.com!1614665957!71754!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27960 invoked from network); 2 Mar 2021 06:19:19 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-17.tower-326.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Mar 2021 06:19:19 -0000
Received: from pekwpmail03.lenovo.com (unknown [10.96.93.81])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 4A47398D6DC8A83A44C4;
        Tue,  2 Mar 2021 14:19:17 +0800 (CST)
Received: from localhost.localdomain (100.67.100.104) by
 pekwpmail03.lenovo.com (10.96.93.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 2 Mar 2021 14:19:12 +0800
From:   Jiqi Li <lijq9@lenovo.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <markpearson@lenovo.com>, Jiqi Li <lijq9@lenovo.com>
Subject: [PATCH] hwmon: (nct6883) Support NCT6686d
Date:   Tue, 2 Mar 2021 14:18:49 +0800
Message-ID: <20210302061849.1825806-1-lijq9@lenovo.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <lijq9@lenovo.com>
References: <lijq9@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.67.100.104]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 pekwpmail03.lenovo.com (10.96.93.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for NCT6686d chip used in the Lenovo P620.

Signed-off-by: Jiqi Li <lijq9@lenovo.com>
Reviewed-by: Mark Pearson <markpearson@lenovo.com>
---
 drivers/hwmon/nct6683.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index a23047a3bfe2..3de7bd146965 100644
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
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

