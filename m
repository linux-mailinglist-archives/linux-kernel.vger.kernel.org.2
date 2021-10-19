Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE59434005
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 22:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhJSUzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 16:55:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230454AbhJSUzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:55:45 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JJqGqu015740;
        Tue, 19 Oct 2021 16:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wnwrsiBSJRdAigf/caWL6172P/Bbo//AB28ukbT+GHo=;
 b=ciqU758He3BjNhYR+M1ZhQv20ThORR9VH+wypVWIbhFXjdLSNPDFO3eSff+7kqfxvDLz
 WAEx5SSxDlep/mvdqu5s6rwRzHidtGviPWvw5ZfXrmaQPARiBlhMp3+ljHqFtXhEK1SI
 BD+KcxwgSnOfJcC5ghCURSk5zt+Qs2dbwaEgPxEW6sEyPE4JmYq/wIo3T+hMF6Zf8wrM
 tki7DbVeNNp2AKJimbaIVvolAQLn3L/lYTpHIi7UHLvaCeN+Dww8YFA1qKw3km6SCHgt
 3O9PYpQJmzmXA9beE94QkvGmrgCc6Gau3WBmrhp2seJeJGAppBPjSURaW7i1p5KPfo3F /w== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bt4jbhcdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 16:53:11 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19JKhTFp006422;
        Tue, 19 Oct 2021 20:53:10 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 3bqpcc6jp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 20:53:10 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19JKr9rZ39059756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 20:53:09 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65CC6124058;
        Tue, 19 Oct 2021 20:53:09 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9410F124052;
        Tue, 19 Oct 2021 20:53:08 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.36.93])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 19 Oct 2021 20:53:08 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, linux@roeck-us.net,
        jdelvare@suse.com, eajames@linux.ibm.com
Subject: [PATCH v4 1/4] fsi: occ: Use a large buffer for responses
Date:   Tue, 19 Oct 2021 15:53:04 -0500
Message-Id: <20211019205307.36946-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211019205307.36946-1-eajames@linux.ibm.com>
References: <20211019205307.36946-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3nC4TCFG_p283Z-LWCuKy18_Ru6FeE_8
X-Proofpoint-ORIG-GUID: 3nC4TCFG_p283Z-LWCuKy18_Ru6FeE_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-19_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110190118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate a large buffer for each OCC to handle response data. This
removes memory allocation during an operation, and also allows for
the maximum amount of SBE FFDC. Previously the driver would have been
limited to 32 words of FFDC in the responses to PutSRAM and ATTN
commands.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c   | 110 ++++++++++++++++------------------------
 include/linux/fsi-occ.h |   2 +
 2 files changed, 46 insertions(+), 66 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index ecf738411fe2..b4302776026d 100644
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
@@ -33,13 +34,6 @@
 
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
 
@@ -51,6 +45,7 @@ struct occ {
 	char name[32];
 	int idx;
 	u8 sequence_number;
+	void *buffer;
 	enum versions version;
 	struct miscdevice mdev;
 	struct mutex occ_lock;
@@ -241,8 +236,10 @@ static int occ_verify_checksum(struct occ *occ, struct occ_response *resp,
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
@@ -269,19 +266,19 @@ static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
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
@@ -292,39 +289,21 @@ static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
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
@@ -361,12 +340,17 @@ static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
 
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
@@ -382,27 +366,16 @@ static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
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
@@ -427,12 +400,17 @@ static int occ_trigger_attn(struct occ *occ)
 
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
@@ -448,14 +426,6 @@ static int occ_trigger_attn(struct occ *occ)
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
 
@@ -590,6 +560,11 @@ static int occ_probe(struct platform_device *pdev)
 	if (!occ)
 		return -ENOMEM;
 
+	/* SBE words are always four bytes */
+	occ->buffer = kvmalloc(OCC_MAX_RESP_WORDS * 4, GFP_KERNEL);
+	if (!occ->buffer)
+		return -ENOMEM;
+
 	occ->version = (uintptr_t)of_device_get_match_data(dev);
 	occ->dev = dev;
 	occ->sbefifo = dev->parent;
@@ -625,6 +600,7 @@ static int occ_probe(struct platform_device *pdev)
 	if (rc) {
 		dev_err(dev, "failed to register miscdevice: %d\n", rc);
 		ida_simple_remove(&occ_ida, occ->idx);
+		kvfree(occ->buffer);
 		return rc;
 	}
 
@@ -640,6 +616,8 @@ static int occ_remove(struct platform_device *pdev)
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

