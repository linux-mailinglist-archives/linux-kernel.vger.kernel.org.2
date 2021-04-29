Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B0736ED29
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbhD2POr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:14:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232556AbhD2POq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:14:46 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13TF4bvH185599;
        Thu, 29 Apr 2021 11:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=O+NDx1kHdSTfNDvnWPwrTTsSLoLVKaBXhAWAiTx9P5A=;
 b=YlM07Bs8BWSZ0VxFpie3HcYbRcXd58J3XEIT05xiNvswZpGHn4hUTmWhInnmhM3X/dLK
 q9GyPn3vJrPjCdGvRXXu8wv1W49XWAh84FJToyJ1Pj++J/ingF+21qUSbYOsT6v5NXum
 6PjqrMqcEAxDBybchrjpjRwL+XlBBLYoJBbLBhQ/y91tra4cuZUvdiueWhySefnyMj7f
 obaJ17uhR/ND43afpnlhr024QeIEyL+c/RoZ1GSkuefIlD2l3Aj2Rxp4Wg7Vq5bi0TQv
 C+DJmgQfef9otSx/0zAenBivrGqjtAke0DCvNVa7b5fRwz8Rp8dCyCk74L3/ms6eLN2h XA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 387x5gasgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 11:13:44 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13TEw50x004085;
        Thu, 29 Apr 2021 15:13:43 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 384ay9pdqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 15:13:43 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13TFDgD237159296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 15:13:42 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B159112064;
        Thu, 29 Apr 2021 15:13:42 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0FF3112062;
        Thu, 29 Apr 2021 15:13:41 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.73.43])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 29 Apr 2021 15:13:41 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        jdelvare@suse.com, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] hwmon: (occ) Fix poll rate limiting
Date:   Thu, 29 Apr 2021 10:13:36 -0500
Message-Id: <20210429151336.18980-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vyXyzLcftirXLkRxUEcHGVnmv4xh-jis
X-Proofpoint-GUID: vyXyzLcftirXLkRxUEcHGVnmv4xh-jis
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_07:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The poll rate limiter time was initialized at zero. This breaks the
comparison in time_after if jiffies is large. Switch to storing the
next update time rather than the previous time, and initialize the
time when the device is probed.

Fixes: c10e753d43eb ("hwmon (occ): Add sensor types and versions")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/common.c | 5 +++--
 drivers/hwmon/occ/common.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index f1ac153d0b56..967532afb1c0 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -217,9 +217,9 @@ int occ_update_response(struct occ *occ)
 		return rc;
 
 	/* limit the maximum rate of polling the OCC */
-	if (time_after(jiffies, occ->last_update + OCC_UPDATE_FREQUENCY)) {
+	if (time_after(jiffies, occ->next_update)) {
 		rc = occ_poll(occ);
-		occ->last_update = jiffies;
+		occ->next_update = jiffies + OCC_UPDATE_FREQUENCY;
 	} else {
 		rc = occ->last_error;
 	}
@@ -1165,6 +1165,7 @@ int occ_setup(struct occ *occ, const char *name)
 		return rc;
 	}
 
+	occ->next_update = jiffies + OCC_UPDATE_FREQUENCY;
 	occ_parse_poll_response(occ);
 
 	rc = occ_setup_sensor_attrs(occ);
diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
index 67e6968b8978..e6df719770e8 100644
--- a/drivers/hwmon/occ/common.h
+++ b/drivers/hwmon/occ/common.h
@@ -99,7 +99,7 @@ struct occ {
 	u8 poll_cmd_data;		/* to perform OCC poll command */
 	int (*send_cmd)(struct occ *occ, u8 *cmd);
 
-	unsigned long last_update;
+	unsigned long next_update;
 	struct mutex lock;		/* lock OCC access */
 
 	struct device *hwmon;
-- 
2.27.0

