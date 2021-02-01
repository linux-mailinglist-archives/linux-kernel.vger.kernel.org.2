Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AC330AD14
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhBAQvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:51:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229849AbhBAQvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:51:50 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111GgbN5002264;
        Mon, 1 Feb 2021 11:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=TkOpFdIQz3xH8BT8vy6qDaHUbR6vxX+2jYK302kDU2Y=;
 b=P5Ke3A5GGmdQclrkadPOSQ2XVMXcZJTMBWMEU8sxH5QY63YKCr7zdxNOzTkALB5HRShk
 BL4uXD/Xv+eS2OdySGAzHtejzEP2oowx91MvvwemxReJ4f7m3dQeBX2ThaVMStrNpFMn
 mnVv7FIMX4LfXa2SVzwwK3iAo2f/d2iY9MYv6ih8ZWSHy5OyisF+kf+H64JLz4IqQ7HM
 5X1anj80XqAk7xzOLXyCjWejPwNbSvhEmH5Vq0sS87UW+M3/VmE/sGC2ulaNSxIp3D4Y
 m0y5oyW/XzWhxVWnHk/D2w0rtZo1dwrwbma0KYRSu4kPT+/d9JLgvuFnShJicNDT8c1/ Fg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36em9j2jg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 11:50:50 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 111Gg2Q4002453;
        Mon, 1 Feb 2021 16:50:49 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 36cy393v6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 16:50:49 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 111GomPt5898716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 16:50:49 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F388B124052;
        Mon,  1 Feb 2021 16:50:47 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B60F312405C;
        Mon,  1 Feb 2021 16:50:46 +0000 (GMT)
Received: from MSBARTH-P50.aus.stglabs.ibm.com (unknown [9.163.45.205])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Feb 2021 16:50:46 +0000 (GMT)
From:   Matthew Barth <msbarth@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, jdelvare@suse.com
Cc:     Matthew Barth <msbarth@linux.ibm.com>, joel@jms.id.au,
        andrew@aj.id.au
Subject: [PATCH] pmbus:max31785: Support revision "B"
Date:   Mon,  1 Feb 2021 10:50:43 -0600
Message-Id: <20210201165043.36751-1-msbarth@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_06:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was an issue in how the tach feedbacks of dual rotor fans were
reported during any change in fan speeds with revision "A" of the
MAX31785. When the fan speeds would transition to a new target speed,
the rotor not wired to the TACH input when TACHSEL = 0 would report a
speed of 0 until the new target was reached. This has been fixed,
resulting in a revision "B" update where the MFR_REVISION of "B" is
0x3061.

Signed-off-by: Matthew Barth <msbarth@linux.ibm.com>
---
 drivers/hwmon/pmbus/max31785.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/max31785.c b/drivers/hwmon/pmbus/max31785.c
index e5a9f4019cd5..e636a65061df 100644
--- a/drivers/hwmon/pmbus/max31785.c
+++ b/drivers/hwmon/pmbus/max31785.c
@@ -17,6 +17,7 @@ enum max31785_regs {
 
 #define MAX31785			0x3030
 #define MAX31785A			0x3040
+#define MAX31785B			0x3061
 
 #define MFR_FAN_CONFIG_DUAL_TACH	BIT(12)
 
@@ -350,12 +351,13 @@ static int max31785_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	if (ret == MAX31785A) {
+	if (ret == MAX31785A || ret == MAX31785B) {
 		dual_tach = true;
 	} else if (ret == MAX31785) {
 		if (!strcmp("max31785a", client->name))
 			dev_warn(dev, "Expected max3175a, found max31785: cannot provide secondary tachometer readings\n");
 	} else {
+		dev_err(dev, "Unrecognized MAX31785 revision: %x\n", ret);
 		return -ENODEV;
 	}
 
@@ -371,6 +373,7 @@ static int max31785_probe(struct i2c_client *client)
 static const struct i2c_device_id max31785_id[] = {
 	{ "max31785", 0 },
 	{ "max31785a", 0 },
+	{ "max31785b", 0 },
 	{ },
 };
 
@@ -379,6 +382,7 @@ MODULE_DEVICE_TABLE(i2c, max31785_id);
 static const struct of_device_id max31785_of_match[] = {
 	{ .compatible = "maxim,max31785" },
 	{ .compatible = "maxim,max31785a" },
+	{ .compatible = "maxim,max31785b" },
 	{ },
 };
 
-- 
2.29.2

