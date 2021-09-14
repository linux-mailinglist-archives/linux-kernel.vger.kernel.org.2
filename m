Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5727F40BA63
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhINVhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:37:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234883AbhINVhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:37:32 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18EL0RhP026217;
        Tue, 14 Sep 2021 17:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dGH53sxifYoEVoAJVL7uZWNIIwKbbbyk03C+3/3+mao=;
 b=Sp6Dm9s7uGw6AOoxbpQ+rUpFcYQHleD7lcw80zaxxphKSvUOgG71lalnGn4aYdwknPjh
 T2SjTXzACGI93w3nl0+H9FuloeUl6v/tNNV1ZnzQ6xXhlJ1S53MCRzp2CYhPv81Ud6J1
 OeLC5la50hqyK+an2sAmqf5Ny3aGXJxOZl/TpGX1uPskALP77SYSrWNuBGcmVVsQltDY
 GpDRUvSqhbd9RHWdbBetu53ltpXR0bHRmA9D9SxsZlpzWX/h34G4PeSZ6B92epeNkGsL
 DFpQRdt7wPkRu37D+nI2T7mRZrFeUR5tW/XPZHnJ032BW0Ljs5LopYxvtjZDvKKGaqJu lA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b3394rmyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 17:35:48 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18ELRTwW021462;
        Tue, 14 Sep 2021 21:35:47 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 3b0m3b3233-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 21:35:47 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18ELZkNU32112932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:35:46 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2159113604F;
        Tue, 14 Sep 2021 21:35:46 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1543136066;
        Tue, 14 Sep 2021 21:35:45 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.154.14])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 14 Sep 2021 21:35:45 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, linux@roeck-us.net, jdelvare@suse.com,
        alistair@popple.id.au, jk@ozlabs.org, eajames@linux.ibm.com
Subject: [PATCH 3/3] hwmon: (occ) Provide the SBEFIFO FFDC in binary sysfs
Date:   Tue, 14 Sep 2021 16:35:43 -0500
Message-Id: <20210914213543.73351-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210914213543.73351-1-eajames@linux.ibm.com>
References: <20210914213543.73351-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F2hK56a0NTRZCsFGBhcnPyn3E37B7xWk
X-Proofpoint-ORIG-GUID: F2hK56a0NTRZCsFGBhcnPyn3E37B7xWk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save any FFDC provided by the OCC driver, and provide it to userspace
through a binary sysfs entry. Do some basic state management to
ensure that userspace can always collect the data if there was an
error. Notify polling userspace when there is an error too.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/p9_sbe.c | 98 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
index 9709f2b9c052..505f489832a4 100644
--- a/drivers/hwmon/occ/p9_sbe.c
+++ b/drivers/hwmon/occ/p9_sbe.c
@@ -4,18 +4,54 @@
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
 
+enum sbe_error_state {
+	SBE_ERROR_NONE = 0,
+	SBE_ERROR_PENDING,
+	SBE_ERROR_COLLECTED
+};
+
 struct p9_sbe_occ {
 	struct occ occ;
+	int sbe_error;
+	void *ffdc;
+	size_t ffdc_len;
+	size_t ffdc_size;
+	struct mutex sbe_error_lock;	/* lock access to ffdc data */
+	u32 no_ffdc_magic;
 	struct device *sbe;
 };
 
 #define to_p9_sbe_occ(x)	container_of((x), struct p9_sbe_occ, occ)
 
+static ssize_t sbe_error_read(struct file *filp, struct kobject *kobj,
+			      struct bin_attribute *battr, char *buf,
+			      loff_t pos, size_t count)
+{
+	ssize_t rc = 0;
+	struct occ *occ = dev_get_drvdata(kobj_to_dev(kobj));
+	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
+
+	mutex_lock(&ctx->sbe_error_lock);
+	if (ctx->sbe_error == SBE_ERROR_PENDING) {
+		rc = memory_read_from_buffer(buf, count, &pos, ctx->ffdc,
+					     ctx->ffdc_len);
+		ctx->sbe_error = SBE_ERROR_COLLECTED;
+	}
+	mutex_unlock(&ctx->sbe_error_lock);
+
+	return rc;
+}
+static BIN_ATTR_RO(sbe_error, OCC_MAX_RESP_WORDS * 4);
+
 static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
 {
 	struct occ_response *resp = &occ->resp;
@@ -24,8 +60,47 @@ static int p9_sbe_occ_send_cmd(struct occ *occ, u8 *cmd, size_t len)
 	int rc;
 
 	rc = fsi_occ_submit(ctx->sbe, cmd, len, resp, &resp_len);
-	if (rc < 0)
+	if (rc < 0) {
+		if (resp_len) {
+			bool notify = false;
+
+			mutex_lock(&ctx->sbe_error_lock);
+			if (ctx->sbe_error != SBE_ERROR_PENDING)
+				notify = true;
+			ctx->sbe_error = SBE_ERROR_PENDING;
+
+			if (resp_len > ctx->ffdc_size) {
+				if (ctx->ffdc_size)
+					kvfree(ctx->ffdc);
+				ctx->ffdc = kvmalloc(resp_len, GFP_KERNEL);
+				if (!ctx->ffdc) {
+					ctx->ffdc_size = 0;
+					ctx->ffdc_len = sizeof(u32);
+					ctx->ffdc = &ctx->no_ffdc_magic;
+					goto unlock;
+				}
+
+				ctx->ffdc_size = resp_len;
+			}
+
+			ctx->ffdc_len = resp_len;
+			memcpy(ctx->ffdc, resp, resp_len);
+
+unlock:
+			mutex_unlock(&ctx->sbe_error_lock);
+
+			if (notify)
+				sysfs_notify(&occ->bus_dev->kobj, NULL,
+					     bin_attr_sbe_error.attr.name);
+		}
+
 		return rc;
+	}
+
+	mutex_lock(&ctx->sbe_error_lock);
+	if (ctx->sbe_error == SBE_ERROR_COLLECTED)
+		ctx->sbe_error = SBE_ERROR_NONE;
+	mutex_unlock(&ctx->sbe_error_lock);
 
 	switch (resp->return_status) {
 	case OCC_RESP_CMD_IN_PRG:
@@ -65,6 +140,13 @@ static int p9_sbe_occ_probe(struct platform_device *pdev)
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->no_ffdc_magic = OCC_NO_FFDC_MAGIC;
+	ctx->sbe_error = SBE_ERROR_NONE;
+	ctx->ffdc = &ctx->no_ffdc_magic;
+	ctx->ffdc_len = sizeof(u32);
+	ctx->ffdc_size = 0;
+	mutex_init(&ctx->sbe_error_lock);
+
 	ctx->sbe = pdev->dev.parent;
 	occ = &ctx->occ;
 	occ->bus_dev = &pdev->dev;
@@ -78,6 +160,15 @@ static int p9_sbe_occ_probe(struct platform_device *pdev)
 	if (rc == -ESHUTDOWN)
 		rc = -ENODEV;	/* Host is shutdown, don't spew errors */
 
+	if (!rc) {
+		rc = device_create_bin_file(occ->bus_dev, &bin_attr_sbe_error);
+		if (rc) {
+			dev_warn(occ->bus_dev,
+				 "failed to create SBE error ffdc file\n");
+			rc = 0;
+		}
+	}
+
 	return rc;
 }
 
@@ -86,9 +177,14 @@ static int p9_sbe_occ_remove(struct platform_device *pdev)
 	struct occ *occ = platform_get_drvdata(pdev);
 	struct p9_sbe_occ *ctx = to_p9_sbe_occ(occ);
 
+	device_remove_bin_file(occ->bus_dev, &bin_attr_sbe_error);
+
 	ctx->sbe = NULL;
 	occ_shutdown(occ);
 
+	if (ctx->ffdc_size)
+		kvfree(ctx->ffdc);
+
 	return 0;
 }
 
-- 
2.27.0

