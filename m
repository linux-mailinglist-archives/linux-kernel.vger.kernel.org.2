Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F305A30B208
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 22:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhBAVX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 16:23:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47796 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229525AbhBAVXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:23:24 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111L1nk4039147;
        Mon, 1 Feb 2021 16:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=yXHwoFJ6cSVhOhJaD9SvEkh5t8ZwGYQwBFAtjaTyZ8A=;
 b=FY49bZMtqKYsgQOD7wsjWEW+qQxslwJYid4cIftYeLo0UIzjhobXhMqUpCqcZJ21FwUm
 /Oh7L0Z5BvBetegpEvIO7rxw+9gZ7pmb71of1VfJMPJ6RLpL3+oWvd1g0YmXqXkkHpl0
 vSEoOuDFjyDKyMuS08mtcqthM3isJ5cLrSIxBjD2n+fPh/KPzq7VJJMQOA/+wXFn7nKc
 y6O3tg+9wL29Z4DK3p86dASFkVF3zTtBoPgiYbIrs1aZ2xUik9SLXWCbo+8tAucu6K1/
 rJX9j4wWwGcxzlKPpkWBKipmSjehU5Mt8D/nbBcGAKumreoo5vsrzTRuvD4fjoN7ySh6 pQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36eqnuttrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 16:22:24 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 111L5n54011325;
        Mon, 1 Feb 2021 21:22:23 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 36ep9996ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 21:22:23 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 111LMLnx41681404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 21:22:21 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDC46AE062;
        Mon,  1 Feb 2021 21:22:21 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B4A4AE05F;
        Mon,  1 Feb 2021 21:22:20 +0000 (GMT)
Received: from MSBARTH-P50.aus.stglabs.ibm.com (unknown [9.163.45.205])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Feb 2021 21:22:20 +0000 (GMT)
From:   Matthew Barth <msbarth@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, jdelvare@suse.com
Cc:     Matthew Barth <msbarth@linux.ibm.com>, joel@jms.id.au,
        andrew@aj.id.au
Subject: [PATCH v2] pmbus:max31785: Support revision "B"
Date:   Mon,  1 Feb 2021 15:22:17 -0600
Message-Id: <20210201212217.73721-1-msbarth@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_08:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010112
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
ChangeLog v1->v2:
- Check for expected "max31785b" when MAX31785 single tach only found
---
 drivers/hwmon/pmbus/max31785.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/max31785.c b/drivers/hwmon/pmbus/max31785.c
index e5a9f4019cd5..30954c89e312 100644
--- a/drivers/hwmon/pmbus/max31785.c
+++ b/drivers/hwmon/pmbus/max31785.c
@@ -17,6 +17,7 @@ enum max31785_regs {
 
 #define MAX31785			0x3030
 #define MAX31785A			0x3040
+#define MAX31785B			0x3061
 
 #define MFR_FAN_CONFIG_DUAL_TACH	BIT(12)
 
@@ -350,12 +351,14 @@ static int max31785_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	if (ret == MAX31785A) {
+	if (ret == MAX31785A || ret == MAX31785B) {
 		dual_tach = true;
 	} else if (ret == MAX31785) {
-		if (!strcmp("max31785a", client->name))
-			dev_warn(dev, "Expected max3175a, found max31785: cannot provide secondary tachometer readings\n");
+		if (!strcmp("max31785a", client->name) ||
+		    !strcmp("max31785b", client->name))
+			dev_warn(dev, "Expected max31785a/b, found max31785: cannot provide secondary tachometer readings\n");
 	} else {
+		dev_err(dev, "Unrecognized MAX31785 revision: %x\n", ret);
 		return -ENODEV;
 	}
 
@@ -371,6 +374,7 @@ static int max31785_probe(struct i2c_client *client)
 static const struct i2c_device_id max31785_id[] = {
 	{ "max31785", 0 },
 	{ "max31785a", 0 },
+	{ "max31785b", 0 },
 	{ },
 };
 
@@ -379,6 +383,7 @@ MODULE_DEVICE_TABLE(i2c, max31785_id);
 static const struct of_device_id max31785_of_match[] = {
 	{ .compatible = "maxim,max31785" },
 	{ .compatible = "maxim,max31785a" },
+	{ .compatible = "maxim,max31785b" },
 	{ },
 };
 
-- 
2.29.2

