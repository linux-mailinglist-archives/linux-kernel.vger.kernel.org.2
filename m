Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D42732D124
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbhCDKtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:49:39 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.3]:54273 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238976AbhCDKtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:49:24 -0500
Received: from [100.112.2.115] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.us-east-1.aws.symcld.net id 0E/E5-29643-B1AB0406; Thu, 04 Mar 2021 10:44:43 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRWlGSWpSXmKPExsWSLveKXVd6l0O
  CwcQ+JouzEwIt2l9vZbS4vGsOm8WThWeYHFg8dn5vYPdYv+Uqi8fnTXIBzFGsmXlJ+RUJrBn3
  Ji1kK5ggUDGvTaWB8SVPFyMXh5DAf0aJlx87mCGcF4wS3+5OYeti5OBgE1CQeLBPtYuRk0NEI
  Feic899ZhCbWcBCYvmPh4wgJcICphJLtvGBhFkEVCR+L97KBmLzCphLbDvWywRiSwjIS7w90g
  0VF5Q4OfMJC8QYCYmDL14wg4yREFCUmLjBEMJMkJj2RGMCI+8sJA2zkDQsYGRaxWiWVJSZnlG
  Sm5iZo2toYKBraGikC4SmxnqJVbpJeqXFuqmJxSW6hnqJ5cV6xZW5yTkpenmpJZsYgQGYUsD0
  dwfjudcf9A4xSnIwKYnyqm90SBDiS8pPqcxILM6ILyrNSS0+xCjDwaEkwVu1AygnWJSanlqRl
  pkDjAaYtAQHj5II75vtQGne4oLE3OLMdIjUKUZFKXHezp1ACQGQREZpHlwbLAIvMcpKCfMyMj
  AwCPEUpBblZpagyr9iFOdgVBLmvQ+ynSczrwRu+iugxUxAi2e52YEsLklESEk1MM3nbw9assT
  Ym++LpfZOFTYG77XWfWuuB+2b7LmFc03RQ9OTn/46LO3bNXEjt2me9t6wpPirV1jOPs8sCFXf
  cZArYbuZfMCnVU/9jNTWmp9+kdt0rmTNo4/Bz7hq+1f9OX0+LUC7RnROum9EQU+NkWazf7Gv8
  trPLzK4VKLX39q5Snmj8yGVT4c3Vi/0Dnh3e1Xn1ak+e4/HrV06IXrTmjcXeEsOvTGT9t9o0n
  moJnSxYmjvJIF33rKNyX5Ovxo/cwWfTHy5MOM+S/T85Nfsx97UTfs2m9/gQMyiNXP8D3bvnNj
  gG7ZP8sOPgClBU5YGzLy1OW/v92Xl/h9Fy25HpEp8OumrNnX9K7+yVQfv+n1VYinOSDTUYi4q
  TgQAGTU6TjsDAAA=
X-Env-Sender: lijq9@lenovo.com
X-Msg-Ref: server-15.tower-396.messagelabs.com!1614854681!876990!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30237 invoked from network); 4 Mar 2021 10:44:42 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-15.tower-396.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Mar 2021 10:44:42 -0000
Received: from pekwpmail03.lenovo.com (unknown [10.96.93.81])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id A932FE70EC940082EEAA;
        Thu,  4 Mar 2021 18:44:40 +0800 (CST)
Received: from localhost.localdomain (100.67.100.45) by pekwpmail03.lenovo.com
 (10.96.93.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2106.2; Thu, 4 Mar 2021
 18:44:27 +0800
From:   Jiqi Li <lijq9@lenovo.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <markpearson@lenovo.com>, Jiqi Li <lijq9@lenovo.com>
Subject: [PATCH v2] hwmon: (nct6883) Support NCT6686D
Date:   Thu, 4 Mar 2021 18:44:21 +0800
Message-ID: <20210304104421.1912934-1-lijq9@lenovo.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.67.100.45]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 pekwpmail03.lenovo.com (10.96.93.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for NCT6686D chip used in the Lenovo P620.

Signed-off-by: Jiqi Li <lijq9@lenovo.com>
Reviewed-by: Mark Pearson <markpearson@lenovo.com>
---
Changes in v2: Corrected typo from NCT6886D to NCT6686D
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

