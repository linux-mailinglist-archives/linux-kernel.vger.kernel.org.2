Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEB232A1EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836447AbhCBHCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:02:39 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.2]:19524 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235324AbhCBGTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:19:10 -0500
Received: from [100.112.1.13] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.us-east-1.aws.symcld.net id 9E/EE-00973-C67DD306; Tue, 02 Mar 2021 06:13:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRWlGSWpSXmKPExsWS8eIhj272dds
  Eg0/fdS3OTgi0aH+9ldHi8q45bBZPFp5hcmDx2Pm9gd1j/ZarLB6fN8kFMEexZuYl5VcksGZc
  mPKZuWADb8Xp1WtYGhjPcnUxcnEICfxnlOhZ+pO5i5ETyHnJKLHsjVAXIwcHm4CCxIN9qiBhE
  YFcic4998FKmAUsJJb/eMgIYgsLGElc+3WQCcRmEVCR+N8zASzOK2Au0bi7gxXElhCQl3h7pJ
  sNxOYEsh9daGSBWCUn0dPzhRWiXlDi5MwnLBDzJSQOvnjBDNGrJNGz4AoLyDkSAgkS055oTGD
  kn4WkYxaSjgWMTKsYTZOKMtMzSnITM3N0DQ0MdA0NjXQNdU0M9BKrdJP0Sot1UxOLS3QN9RLL
  i/WKK3OTc1L08lJLNjECQzalgFFjB2Pnmw96hxglOZiURHm3HLNNEOJLyk+pzEgszogvKs1JL
  T7EKMPBoSTB+/8qUE6wKDU9tSItMwcYPzBpCQ4eJRFe8fNAad7igsTc4sx0iNQpRkUpcd60a0
  AJAZBERmkeXBssZi8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEuZ9ArKdJzOvBG76K6DFTEC
  LtwdagSwuSURISTUwLfp0J0DkhNn6Bz6BwllXtx95/kdp+YHpM6TcWvNEXUyeL37MdKbB7L5H
  /kYHCeknRTvq57PHrbgxL0Jp+kL+vrWmy4vMy9gTT+bvtJH9LTAhiP3mVw3/TMtDe+eyJv77b
  9b+x6SnrWnm5emPd9rwXzjede3V2XoJ+6Dp7D9rApkvlqc/r+bQ5AsVXb30e9/mx22MjhkzX9
  zccuOdWzKLxyc+jYQfRrvyt4s1vpoz2e+VQLvIvkiGMMG/m4KX1uW9lvp2x0Kh/PH+iQXPmv2
  L5n9+Fsdh9DUw4u/vavsDsebP7P/+7FVeevuCIGfapGXzn8Qo9jHXVK6xrJa9evyOnJl8W/TF
  Gbfvnn2WYHHKSImlOCPRUIu5qDgRAE+8CbpUAwAA
X-Env-Sender: lijq9@lenovo.com
X-Msg-Ref: server-24.tower-386.messagelabs.com!1614665579!432228!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13553 invoked from network); 2 Mar 2021 06:12:59 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
  by server-24.tower-386.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Mar 2021 06:12:59 -0000
Received: from pekwpmail03.lenovo.com (unknown [10.96.93.81])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 68109B9BFEDE79D64B14;
        Tue,  2 Mar 2021 01:12:58 -0500 (EST)
Received: from localhost.localdomain (100.67.100.104) by
 pekwpmail03.lenovo.com (10.96.93.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 2 Mar 2021 14:12:53 +0800
From:   Jiqi Li <lijq9@lenovo.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <markpearson@lenovo.com>, Jiqi Li <lijq9@lenovo.com>
Subject: [PATCH] hwmon: (nct6883) Support NCT6886d
Date:   Tue, 2 Mar 2021 14:12:05 +0800
Message-ID: <20210302061205.1825664-1-lijq9@lenovo.com>
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

Add support for NCT6886d chip used in the Lenovo P620.

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

