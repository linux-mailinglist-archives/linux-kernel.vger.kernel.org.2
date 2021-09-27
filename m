Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D565941985D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhI0QBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:01:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235320AbhI0QBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:01:36 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RDoOAB027311;
        Mon, 27 Sep 2021 11:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5Gh8S5FvyeFMEokeXe/PXEHPNy8luH1zsbM4fj9ZU3A=;
 b=Woc0eLj49r+BnDD2Pkq61QJsr3BUMGPSpfLZJQBHqx7d0H2xsqERajbMS+mnEdjB/OJ2
 /A7ub8n+i25pLyYzkwo6+vomCj6u0WePsI1GgD/PeOV9fJ2unmM0hzREtYu2tGAIQuxP
 RfpkvKfhPHv3xnPBXUM2wmc8/zWnVJqiKO44bttut6GnTD8sl9akzEzyzDbNwMz2xVJZ
 LEWdMNMKjlOm9WSZbqLFIn0Z+ZsWukJxasvCvwS1e8QeSVgEFfyQ3kM8sw12RAaNb8CR
 Wd2sXSy1708UGe7t4bR/jCidtRQU5a/nkJbIJ44r8anYRH+EOM3t+0jSGMczGbanVTRj bg== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bagn80gtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 11:59:36 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18RFvjJt018267;
        Mon, 27 Sep 2021 15:59:35 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 3b9uda992s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 15:59:35 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18RFxYG033489202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 15:59:34 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0842C28060;
        Mon, 27 Sep 2021 15:59:34 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF71D28058;
        Mon, 27 Sep 2021 15:59:32 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.70.165])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 27 Sep 2021 15:59:32 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        linux@roeck-us.net, jdelvare@suse.com,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v3 1/4] fsi: occ: Use a large buffer for responses
Date:   Mon, 27 Sep 2021 10:59:22 -0500
Message-Id: <20210927155925.15485-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210927155925.15485-1-eajames@linux.ibm.com>
References: <20210927155925.15485-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i_g1kRRUeyY4YG1P-LKIq8vGosK7Z4Lx
X-Proofpoint-ORIG-GUID: i_g1kRRUeyY4YG1P-LKIq8vGosK7Z4Lx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_06,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109270106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate a large buffer for each OCC to handle response data. This
removes memory allocation during an operation, and also allows for
the maximum amount of SBE FFDC.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c   | 109 ++++++++++++++++------------------------
 include/linux/fsi-occ.h |   2 +
 2 files changed, 45 insertions(+), 66 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index b0c9322078a1..ace3ec7767e5 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/miscdevice.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/fsi-occ.h>
@@ -42,13 +43,6 @@
 
 #define OCC_P10_SRAM_MODE	0x58	/* Normal mode, OCB channel 2 */
 
-/*
- * Assume we don't have much FFDC, if we do we'll overflow and
- * fail the command. This needs to be big enough for simple
- * commands as well.
- */
-#define OCC_SBE_STATUS_WORDS	32
-
 #define OCC_TIMEOUT_MS		1000
 #define OCC_CMD_IN_PRG_WAIT_MS	50
 
@@ -60,6 +54,7 @@ struct occ {
 	char name[32];
 	int idx;
 	u8 sequence_number;
+	void *buffer;
 	enum versions version;
 	struct miscdevice mdev;
 	struct mutex occ_lock;
@@ -250,8 +245,10 @@ static int occ_verify_checksum(struct occ *occ, struct occ_response *resp,
 static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
 {
 	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
-	size_t cmd_len, resp_len, resp_data_len;
-	__be32 *resp, cmd[6];
+	size_t cmd_len, resp_data_len;
+	size_t resp_len = OCC_MAX_RESP_WORDS;
+	__be32 *resp = occ->buffer;
+	__be32 cmd[6];
 	int idx = 0, rc;
 
 	/*
@@ -278,19 +275,19 @@ static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
 	cmd[1] = cpu_to_be32(SBEFIFO_CMD_GET_OCC_SRAM);
 	cmd[4 + idx] = cpu_to_be32(data_len);
 
-	resp_len = (data_len >> 2) + OCC_SBE_STATUS_WORDS;
-	resp = kzalloc(resp_len << 2, GFP_KERNEL);
-	if (!resp)
-		return -ENOMEM;
-
 	rc = sbefifo_submit(occ->sbefifo, cmd, cmd_len, resp, &resp_len);
 	if (rc)
-		goto free;
+		return rc;
 
 	rc = sbefifo_parse_status(occ->sbefifo, SBEFIFO_CMD_GET_OCC_SRAM,
 				  resp, resp_len, &resp_len);
-	if (rc)
-		goto free;
+	if (rc > 0) {
+		dev_err(occ->dev, "SRAM read returned failure status: %08x\n",
+			rc);
+		return -EBADMSG;
+	} else if (rc) {
+		return rc;
+	}
 
 	resp_data_len = be32_to_cpu(resp[resp_len - 1]);
 	if (resp_data_len != data_len) {
@@ -301,39 +298,21 @@ static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
 		memcpy(data, resp, len);
 	}
 
-free:
-	/* Convert positive SBEI status */
-	if (rc > 0) {
-		dev_err(occ->dev, "SRAM read returned failure status: %08x\n",
-			rc);
-		rc = -EBADMSG;
-	}
-
-	kfree(resp);
 	return rc;
 }
 
 static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
 		       u8 seq_no, u16 checksum)
 {
-	size_t cmd_len, buf_len, resp_len, resp_data_len;
 	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
-	__be32 *buf;
+	size_t cmd_len, resp_data_len;
+	size_t resp_len = OCC_MAX_RESP_WORDS;
+	__be32 *buf = occ->buffer;
 	u8 *byte_buf;
 	int idx = 0, rc;
 
 	cmd_len = (occ->version == occ_p10) ? 6 : 5;
-
-	/*
-	 * We use the same buffer for command and response, make
-	 * sure it's big enough
-	 */
-	resp_len = OCC_SBE_STATUS_WORDS;
 	cmd_len += data_len >> 2;
-	buf_len = max(cmd_len, resp_len);
-	buf = kzalloc(buf_len << 2, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
 
 	/*
 	 * Magic sequence to do SBE putsram command. SBE will transfer
@@ -384,12 +363,17 @@ static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
 
 	rc = sbefifo_submit(occ->sbefifo, buf, cmd_len, buf, &resp_len);
 	if (rc)
-		goto free;
+		return rc;
 
 	rc = sbefifo_parse_status(occ->sbefifo, SBEFIFO_CMD_PUT_OCC_SRAM,
 				  buf, resp_len, &resp_len);
-	if (rc)
-		goto free;
+	if (rc > 0) {
+		dev_err(occ->dev, "SRAM write returned failure status: %08x\n",
+			rc);
+		return -EBADMSG;
+	} else if (rc) {
+		return rc;
+	}
 
 	if (resp_len != 1) {
 		dev_err(occ->dev, "SRAM write response length invalid: %zd\n",
@@ -405,27 +389,16 @@ static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
 		}
 	}
 
-free:
-	/* Convert positive SBEI status */
-	if (rc > 0) {
-		dev_err(occ->dev, "SRAM write returned failure status: %08x\n",
-			rc);
-		rc = -EBADMSG;
-	}
-
-	kfree(buf);
 	return rc;
 }
 
 static int occ_trigger_attn(struct occ *occ)
 {
-	__be32 buf[OCC_SBE_STATUS_WORDS];
-	size_t cmd_len, resp_len, resp_data_len;
+	__be32 *buf = occ->buffer;
+	size_t cmd_len, resp_data_len;
+	size_t resp_len = OCC_MAX_RESP_WORDS;
 	int idx = 0, rc;
 
-	BUILD_BUG_ON(OCC_SBE_STATUS_WORDS < 8);
-	resp_len = OCC_SBE_STATUS_WORDS;
-
 	switch (occ->version) {
 	default:
 	case occ_p9:
@@ -450,12 +423,17 @@ static int occ_trigger_attn(struct occ *occ)
 
 	rc = sbefifo_submit(occ->sbefifo, buf, cmd_len, buf, &resp_len);
 	if (rc)
-		goto error;
+		return rc;
 
 	rc = sbefifo_parse_status(occ->sbefifo, SBEFIFO_CMD_PUT_OCC_SRAM,
 				  buf, resp_len, &resp_len);
-	if (rc)
-		goto error;
+	if (rc > 0) {
+		dev_err(occ->dev, "SRAM attn returned failure status: %08x\n",
+			rc);
+		return -EBADMSG;
+	} else if (rc) {
+		return rc;
+	}
 
 	if (resp_len != 1) {
 		dev_err(occ->dev, "SRAM attn response length invalid: %zd\n",
@@ -471,14 +449,6 @@ static int occ_trigger_attn(struct occ *occ)
 		}
 	}
 
- error:
-	/* Convert positive SBEI status */
-	if (rc > 0) {
-		dev_err(occ->dev, "SRAM attn returned failure status: %08x\n",
-			rc);
-		rc = -EBADMSG;
-	}
-
 	return rc;
 }
 
@@ -635,6 +605,10 @@ static int occ_probe(struct platform_device *pdev)
 	if (!occ)
 		return -ENOMEM;
 
+	occ->buffer = kvmalloc(OCC_MAX_RESP_WORDS * 4, GFP_KERNEL);
+	if (!occ->buffer)
+		return -ENOMEM;
+
 	occ->version = (enum versions)md;
 	occ->dev = dev;
 	occ->sbefifo = dev->parent;
@@ -670,6 +644,7 @@ static int occ_probe(struct platform_device *pdev)
 	if (rc) {
 		dev_err(dev, "failed to register miscdevice: %d\n", rc);
 		ida_simple_remove(&occ_ida, occ->idx);
+		kvfree(occ->buffer);
 		return rc;
 	}
 
@@ -685,6 +660,8 @@ static int occ_remove(struct platform_device *pdev)
 {
 	struct occ *occ = platform_get_drvdata(pdev);
 
+	kvfree(occ->buffer);
+
 	misc_deregister(&occ->mdev);
 
 	device_for_each_child(&pdev->dev, NULL, occ_unregister_child);
diff --git a/include/linux/fsi-occ.h b/include/linux/fsi-occ.h
index d4cdc2aa6e33..7ee3dbd7f4b3 100644
--- a/include/linux/fsi-occ.h
+++ b/include/linux/fsi-occ.h
@@ -19,6 +19,8 @@ struct device;
 #define OCC_RESP_CRIT_OCB		0xE3
 #define OCC_RESP_CRIT_HW		0xE4
 
+#define OCC_MAX_RESP_WORDS		2048
+
 int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 		   void *response, size_t *resp_len);
 
-- 
2.27.0

