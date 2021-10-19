Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9256C434007
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 22:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhJSU4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 16:56:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233102AbhJSUzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:55:47 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JKlrdp030392;
        Tue, 19 Oct 2021 16:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tFo1KBMtQiRznYjKtCYYooCwWZl6fopQel0Z/6USP+0=;
 b=Vf0/NT+AuA57JEHHJuTbb7Vcl7y1QbWvhoDBdESXnwYGBSNEd45FwfzXR5hNB7XF7QbE
 s2mycsS3Q8e6j9GblgGBDhOrxwqhjvIPriFyNd5mMXAOD0Zm3l4aRKvxiLPIdZqQlZxF
 EXoB94A9YZLswzaOuRXKk6cPXFN+S6mO/9+eKNN4Mghfimt1Ni+vpuLNpHYw0hdnXF+L
 pD7oZkyUu6NnTKnyYwh37N2jyyk+dZiK0yjGderW/z9jC7HprYTD+9TKZ94tAuSrOQI3
 1UuSCwspU6zM94h8raYSCnPfhJvkV2bjjtuxaZ+YWBW+cYOwfus6mpb1hiilsyNzFiEu bQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bt5cdr3cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 16:53:14 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19JKhFjp027420;
        Tue, 19 Oct 2021 20:53:13 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02dal.us.ibm.com with ESMTP id 3bqpcbpkcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 20:53:13 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19JKrCO833030472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 20:53:12 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52A4D124054;
        Tue, 19 Oct 2021 20:53:12 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C7BD12405E;
        Tue, 19 Oct 2021 20:53:11 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.36.93])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 19 Oct 2021 20:53:11 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, linux@roeck-us.net,
        jdelvare@suse.com, eajames@linux.ibm.com
Subject: [PATCH v4 4/4] hwmon: (occ) Provide the SBEFIFO FFDC in binary sysfs
Date:   Tue, 19 Oct 2021 15:53:07 -0500
Message-Id: <20211019205307.36946-5-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211019205307.36946-1-eajames@linux.ibm.com>
References: <20211019205307.36946-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AaYh9wePxMW6CpspD13960UqLswkKEg9
X-Proofpoint-GUID: AaYh9wePxMW6CpspD13960UqLswkKEg9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-19_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110190118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save any FFDC provided by the OCC driver, and provide it to userspace
through a binary sysfs entry. Notify userspace pollers when there is an
error too.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
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

