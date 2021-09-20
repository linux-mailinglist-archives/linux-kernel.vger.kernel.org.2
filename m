Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36BA4125B1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345322AbhITSrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:47:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349414AbhITSnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:43:41 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KHT7Jt012980;
        Mon, 20 Sep 2021 14:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=a9ufpbxwEB93Rn+evVK2qSH25LhjJC8Oxp/tJUbJp5A=;
 b=lPwL+tWm12iM21ZhKZWS0738Sbd8trqqbfA2qsJYdLr4QTroxVVpXvbL3Q1VhwTll9Bc
 8J6BkFQt/Ps4/nIxQTIBxACxXpHzV1so7NmIytK9lzkmfX3C8PkpSK9S0bHf0IuwlKbb
 Z0HDr0kKBiM59qkSG230aklulGwT+rGQG374M+ShZc4pL607ot0OIwYhaI5GfLZSRhpy
 yFQwhNcEnEkuqBGM101QqNpAPf7PMYB7i7lm6bP8BfTqb8BjjOBpgVkvS1Z2zwSGmUa3
 VjC7G3CFXejo3DSwgT/IgnJGMfB8w7IZYvSnwvHvuOLQE4h4V7on3uwvA2CEaS8V6uQg zw== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b5w3g3asf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Sep 2021 14:41:50 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18KIb7vY012356;
        Mon, 20 Sep 2021 18:41:49 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 3b57ra7qsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Sep 2021 18:41:49 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18KIfmXB23790018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 18:41:48 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8514E12405C;
        Mon, 20 Sep 2021 18:41:48 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28751124054;
        Mon, 20 Sep 2021 18:41:47 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.87.144])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 20 Sep 2021 18:41:46 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        linux@roeck-us.net, jdelvare@suse.com, eajames@linux.ibm.com
Subject: [PATCH v2 3/3] hwmon: (occ) Provide the SBEFIFO FFDC in binary sysfs
Date:   Mon, 20 Sep 2021 13:41:41 -0500
Message-Id: <20210920184141.21358-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210920184141.21358-1-eajames@linux.ibm.com>
References: <20210920184141.21358-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nvoHkBTVQorBoBWdQaKi26XSQ-NLmFya
X-Proofpoint-GUID: nvoHkBTVQorBoBWdQaKi26XSQ-NLmFya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109200109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save any FFDC provided by the OCC driver, and provide it to userspace
through a binary sysfs entry. Notify userspace pollers when there is an
error too.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - Remove "collected" error state in favor of a boolean
 - Clear the error flag once the FFDC has been completely read once
 - Only store FFDC if there is no FFDC waiting to be retrieved

 drivers/hwmon/occ/p9_sbe.c | 86 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
index 9709f2b9c052..e50243580269 100644
--- a/drivers/hwmon/occ/p9_sbe.c
+++ b/drivers/hwmon/occ/p9_sbe.c
@@ -4,18 +4,79 @@
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/fsi-occ.h>
+#include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
 
 #include "common.h"
 
 struct p9_sbe_occ {
 	struct occ occ;
+	bool sbe_error;
+	void *ffdc;
+	size_t ffdc_len;
+	size_t ffdc_size;
+	struct mutex sbe_error_lock;	/* lock access to ffdc data */
 	struct device *sbe;
 };
 
 #define to_p9_sbe_occ(x)	container_of((x), struct p9_sbe_occ, occ)
 
+static ssize_t ffdc_read(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *battr, char *buf, loff_t pos,
+			 size_t count)
+{
+	ssize_t rc = 0;
+	struct occ *occ = dev_get_drvdata(kobj_to_dev(kobj));
+	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
+
+	mutex_lock(&ctx->sbe_error_lock);
+	if (ctx->sbe_error) {
+		rc = memory_read_from_buffer(buf, count, &pos, ctx->ffdc,
+					     ctx->ffdc_len);
+		if (pos >= ctx->ffdc_len)
+			ctx->sbe_error = false;
+	}
+	mutex_unlock(&ctx->sbe_error_lock);
+
+	return rc;
+}
+static BIN_ATTR_RO(ffdc, OCC_MAX_RESP_WORDS * 4);
+
+static bool p9_sbe_occ_save_ffdc(struct p9_sbe_occ *ctx, const void *resp,
+				 size_t resp_len)
+{
+	bool notify = false;
+
+	mutex_lock(&ctx->sbe_error_lock);
+	if (!ctx->sbe_error) {
+		if (resp_len > ctx->ffdc_size) {
+			if (ctx->ffdc)
+				kvfree(ctx->ffdc);
+			ctx->ffdc = kvmalloc(resp_len, GFP_KERNEL);
+			if (!ctx->ffdc) {
+				ctx->ffdc_len = 0;
+				ctx->ffdc_size = 0;
+				goto done;
+			}
+
+			ctx->ffdc_size = resp_len;
+		}
+
+		notify = true;
+		ctx->sbe_error = true;
+		ctx->ffdc_len = resp_len;
+		memcpy(ctx->ffdc, resp, resp_len);
+	}
+
+done:
+	mutex_unlock(&ctx->sbe_error_lock);
+	return notify;
+}
+
 static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
 {
 	struct occ_response *resp = &occ->resp;
@@ -24,8 +85,15 @@ static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
 	int rc;
 
 	rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
-	if (rc < 0)
+	if (rc < 0) {
+		if (resp_len) {
+			if (p9_sbe_occ_save_ffdc(ctx, resp, resp_len))
+				sysfs_notify(&occ->bus_dev->kobj, NULL,
+					     bin_attr_ffdc.attr.name);
+		}
+
 		return rc;
+	}
 
 	switch (resp->return_status) {
 	case OCC_RESP_CMD_IN_PRG:
@@ -65,6 +133,8 @@ static int p9_sbe_occ_probe(struct platform_device *pdev)
 	if (!ctx)
 		return -ENOMEM;
 
+	mutex_init(&ctx->sbe_error_lock);
+
 	ctx->sbe = pdev->dev.parent;
 	occ = &ctx->occ;
 	occ->bus_dev = &pdev->dev;
@@ -78,6 +148,15 @@ static int p9_sbe_occ_probe(struct platform_device *pdev)
 	if (rc == -ESHUTDOWN)
 		rc = -ENODEV;	/* Host is shutdown, don't spew errors */
 
+	if (!rc) {
+		rc = device_create_bin_file(occ->bus_dev, &bin_attr_ffdc);
+		if (rc) {
+			dev_warn(occ->bus_dev,
+				 "failed to create SBE error ffdc file\n");
+			rc = 0;
+		}
+	}
+
 	return rc;
 }
 
@@ -86,9 +165,14 @@ static int p9_sbe_occ_remove(struct platform_device *pdev)
 	struct occ *occ = platform_get_drvdata(pdev);
 	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
 
+	device_remove_bin_file(occ->bus_dev, &bin_attr_ffdc);
+
 	ctx->sbe = NULL;
 	occ_shutdown(occ);
 
+	if (ctx->ffdc)
+		kvfree(ctx->ffdc);
+
 	return 0;
 }
 
-- 
2.27.0

