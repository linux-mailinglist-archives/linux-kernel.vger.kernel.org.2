Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2A841C88E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345318AbhI2PiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:38:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345157AbhI2PiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:38:07 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TFISb4012258;
        Wed, 29 Sep 2021 11:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8y8HFu3P9T/ieEDDDn+jonJUF4zXuLC4cmPBiCu8V7I=;
 b=MyPtMixPvK/aFhHNOZgIIODljKk/mm1pwf5ShAnhxXi9cRCglUuSOj4+A4tNON11vdCU
 HDIVC2kNjkzk9UT4pEHcYCHZg/2LFRRMzC7VTV9fUTcmGuHQV2q5jcUhpUAAwkI+e1r2
 nZZWRSr4Y6dNtfVUgDQ1dx+pMDYWAtq5IdHCOCcgbRzH42WJTypEObcAf9BTdOfk+7TD
 fdVLSPEL3KGCnrBMN/84ckwHJUJczNqUTYd8OXV3nJw9aASgX8KO/gMC8buf+oN32Hdc
 VkGp430HBxZY5O+At4mVYvoeeU7KHKcEkJox/KM9zyPwTNkCRCKFHHYm404rt2OgZPGI PQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bcshj2ng8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Sep 2021 11:36:10 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18TFHwEG015056;
        Wed, 29 Sep 2021 15:36:09 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04wdc.us.ibm.com with ESMTP id 3b9udbkxmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Sep 2021 15:36:09 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18TFa8La5112660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 15:36:08 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C6CDAC060;
        Wed, 29 Sep 2021 15:36:08 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE2F1AC06B;
        Wed, 29 Sep 2021 15:36:07 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.163.24.144])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Sep 2021 15:36:07 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] hwmon: (occ) Fix P10 VRM temp sensors
Date:   Wed, 29 Sep 2021 10:36:04 -0500
Message-Id: <20210929153604.14968-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d63kv8mGayhE17DdKepbvsjve20gDAI0
X-Proofpoint-ORIG-GUID: d63kv8mGayhE17DdKepbvsjve20gDAI0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_06,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The P10 (temp sensor version 0x10) doesn't do the same VRM status
reporting that was used on P9. It just reports the temperature, so
drop the check for VRM fru type in the sysfs show function, and don't
set the name to "alarm".

Fixes: db4919ec86 ("hwmon: (occ) Add new temperature sensor type")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/common.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 0d68a78be980..ae664613289c 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -340,18 +340,11 @@ static ssize_t occ_show_temp_10(struct device *dev,
 		if (val == OCC_TEMP_SENSOR_FAULT)
 			return -EREMOTEIO;
 
-		/*
-		 * VRM doesn't return temperature, only alarm bit. This
-		 * attribute maps to tempX_alarm instead of tempX_input for
-		 * VRM
-		 */
-		if (temp->fru_type != OCC_FRU_TYPE_VRM) {
-			/* sensor not ready */
-			if (val == 0)
-				return -EAGAIN;
+		/* sensor not ready */
+		if (val == 0)
+			return -EAGAIN;
 
-			val *= 1000;
-		}
+		val *= 1000;
 		break;
 	case 2:
 		val = temp->fru_type;
@@ -886,7 +879,7 @@ static int occ_setup_sensor_attrs(struct occ *occ)
 					     0, i);
 		attr++;
 
-		if (sensors->temp.version > 1 &&
+		if (sensors->temp.version == 2 &&
 		    temp->fru_type == OCC_FRU_TYPE_VRM) {
 			snprintf(attr->name, sizeof(attr->name),
 				 "temp%d_alarm", s);
-- 
2.27.0

