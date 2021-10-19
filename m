Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C12434006
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 22:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhJSUz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 16:55:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231597AbhJSUzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:55:46 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JK8O3k018580;
        Tue, 19 Oct 2021 16:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=7HGZE9O4AgAH80x/8SfvLgge3ODP/0HsH6Rxl8Mdey0=;
 b=NX+T5YYyDSS+Ijjpt4bKN+3tSedcX4QtGT9jkhlJLpbMhqSosLuF5XmD2NcDl7+jJ1uw
 tR98rTMnOcFET+LsKMrLCbaZGroUrS/WYGh+kK0Wpcf9QgZBfGgNHrAMhaZam8YuBsbv
 r0X6c5duoID/kpKSJeNEAwQknE5mXIuwvb2bNxhssw+vo6TMYUv9Iqh62xwpAtYpdOwf
 LiX2tXMahbP4fYDM21sdq0DUL2CKTS2GR2rnaTBBx8roblIR8irmVgQ5aAageOdMGUlz
 djC7sCo8MN8V4Mw5GFWl4d0OBT3f3hMsgj4IHoDRusTSDjtMtvE008Je2FztSzi+oFHC aw== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bt35w3c9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 16:53:12 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19JKq3Ka009334;
        Tue, 19 Oct 2021 20:53:11 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 3bqpcbqedu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 20:53:11 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19JKrAv826018054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 20:53:10 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CF6A12405A;
        Tue, 19 Oct 2021 20:53:10 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CB9B124053;
        Tue, 19 Oct 2021 20:53:09 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.36.93])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 19 Oct 2021 20:53:09 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, linux@roeck-us.net,
        jdelvare@suse.com, eajames@linux.ibm.com
Subject: [PATCH v4 2/4] fsi: occ: Store the SBEFIFO FFDC in the user response buffer
Date:   Tue, 19 Oct 2021 15:53:05 -0500
Message-Id: <20211019205307.36946-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211019205307.36946-1-eajames@linux.ibm.com>
References: <20211019205307.36946-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hP65jyXrm9icJV4ldT-C2mDDI7ngEqfT
X-Proofpoint-ORIG-GUID: hP65jyXrm9icJV4ldT-C2mDDI7ngEqfT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-19_02,2021-10-19_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110190118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the SBEFIFO response indicates an error, store the response in the
user buffer and return an error. Previously, the user had no way of
obtaining the SBEFIFO FFDC.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c | 66 +++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index b4302776026d..7eaab1be0aa4 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -46,6 +46,9 @@ struct occ {
 	int idx;
 	u8 sequence_number;
 	void *buffer;
+	void *client_buffer;
+	size_t client_buffer_size;
+	size_t client_response_size;
 	enum versions version;
 	struct miscdevice mdev;
 	struct mutex occ_lock;
@@ -208,6 +211,22 @@ static const struct file_operations occ_fops = {
 	.release = occ_release,
 };
 
+static void occ_save_ffdc(struct occ *occ, __be32 *resp, size_t parsed_len,
+			  size_t resp_len)
+{
+	if (resp_len > parsed_len) {
+		size_t dh = resp_len - parsed_len;
+		size_t ffdc_len = (dh - 1) * 4; /* SBE words are four bytes */
+		__be32 *ffdc = &resp[parsed_len];
+
+		if (ffdc_len > occ->client_buffer_size)
+			ffdc_len = occ->client_buffer_size;
+
+		memcpy(occ->client_buffer, ffdc, ffdc_len);
+		occ->client_response_size = ffdc_len;
+	}
+}
+
 static int occ_verify_checksum(struct occ *occ, struct occ_response *resp,
 			       u16 data_length)
 {
@@ -236,7 +255,7 @@ static int occ_verify_checksum(struct occ *occ, struct occ_response *resp,
 static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
 {
 	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
-	size_t cmd_len, resp_data_len;
+	size_t cmd_len, parsed_len, resp_data_len;
 	size_t resp_len = OCC_MAX_RESP_WORDS;
 	__be32 *resp = occ->buffer;
 	__be32 cmd[6];
@@ -271,16 +290,17 @@ static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
 		return rc;
 
 	rc = sbefifo_parse_status(occ->sbefifo, SBEFIFO_CMD_GET_OCC_SRAM,
-				  resp, resp_len, &resp_len);
+				  resp, resp_len, &parsed_len);
 	if (rc > 0) {
 		dev_err(occ->dev, "SRAM read returned failure status: %08x\n",
 			rc);
-		return -EBADMSG;
+		occ_save_ffdc(occ, resp, parsed_len, resp_len);
+		return -ECOMM;
 	} else if (rc) {
 		return rc;
 	}
 
-	resp_data_len = be32_to_cpu(resp[resp_len - 1]);
+	resp_data_len = be32_to_cpu(resp[parsed_len - 1]);
 	if (resp_data_len != data_len) {
 		dev_err(occ->dev, "SRAM read expected %d bytes got %zd\n",
 			data_len, resp_data_len);
@@ -296,7 +316,7 @@ static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
 		       u8 seq_no, u16 checksum)
 {
 	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
-	size_t cmd_len, resp_data_len;
+	size_t cmd_len, parsed_len, resp_data_len;
 	size_t resp_len = OCC_MAX_RESP_WORDS;
 	__be32 *buf = occ->buffer;
 	u8 *byte_buf;
@@ -343,18 +363,19 @@ static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
 		return rc;
 
 	rc = sbefifo_parse_status(occ->sbefifo, SBEFIFO_CMD_PUT_OCC_SRAM,
-				  buf, resp_len, &resp_len);
+				  buf, resp_len, &parsed_len);
 	if (rc > 0) {
 		dev_err(occ->dev, "SRAM write returned failure status: %08x\n",
 			rc);
-		return -EBADMSG;
+		occ_save_ffdc(occ, buf, parsed_len, resp_len);
+		return -ECOMM;
 	} else if (rc) {
 		return rc;
 	}
 
-	if (resp_len != 1) {
+	if (parsed_len != 1) {
 		dev_err(occ->dev, "SRAM write response length invalid: %zd\n",
-			resp_len);
+			parsed_len);
 		rc = -EBADMSG;
 	} else {
 		resp_data_len = be32_to_cpu(buf[0]);
@@ -372,7 +393,7 @@ static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
 static int occ_trigger_attn(struct occ *occ)
 {
 	__be32 *buf = occ->buffer;
-	size_t cmd_len, resp_data_len;
+	size_t cmd_len, parsed_len, resp_data_len;
 	size_t resp_len = OCC_MAX_RESP_WORDS;
 	int idx = 0, rc;
 
@@ -403,18 +424,19 @@ static int occ_trigger_attn(struct occ *occ)
 		return rc;
 
 	rc = sbefifo_parse_status(occ->sbefifo, SBEFIFO_CMD_PUT_OCC_SRAM,
-				  buf, resp_len, &resp_len);
+				  buf, resp_len, &parsed_len);
 	if (rc > 0) {
 		dev_err(occ->dev, "SRAM attn returned failure status: %08x\n",
 			rc);
-		return -EBADMSG;
+		occ_save_ffdc(occ, buf, parsed_len, resp_len);
+		return -ECOMM;
 	} else if (rc) {
 		return rc;
 	}
 
-	if (resp_len != 1) {
+	if (parsed_len != 1) {
 		dev_err(occ->dev, "SRAM attn response length invalid: %zd\n",
-			resp_len);
+			parsed_len);
 		rc = -EBADMSG;
 	} else {
 		resp_data_len = be32_to_cpu(buf[0]);
@@ -437,6 +459,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 		msecs_to_jiffies(OCC_CMD_IN_PRG_WAIT_MS);
 	struct occ *occ = dev_get_drvdata(dev);
 	struct occ_response *resp = response;
+	size_t user_resp_len = *resp_len;
 	u8 seq_no;
 	u16 checksum = 0;
 	u16 resp_data_length;
@@ -445,11 +468,13 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 	int rc;
 	size_t i;
 
+	*resp_len = 0;
+
 	if (!occ)
 		return -ENODEV;
 
-	if (*resp_len < 7) {
-		dev_dbg(dev, "Bad resplen %zd\n", *resp_len);
+	if (user_resp_len < 7) {
+		dev_dbg(dev, "Bad resplen %zd\n", user_resp_len);
 		return -EINVAL;
 	}
 
@@ -459,6 +484,10 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 
 	mutex_lock(&occ->occ_lock);
 
+	occ->client_buffer = response;
+	occ->client_buffer_size = user_resp_len;
+	occ->client_response_size = 0;
+
 	/*
 	 * Get a sequence number and update the counter. Avoid a sequence
 	 * number of 0 which would pass the response check below even if the
@@ -509,7 +538,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 	resp_data_length = get_unaligned_be16(&resp->data_length);
 
 	/* Message size is data length + 5 bytes header + 2 bytes checksum */
-	if ((resp_data_length + 7) > *resp_len) {
+	if ((resp_data_length + 7) > user_resp_len) {
 		rc = -EMSGSIZE;
 		goto done;
 	}
@@ -525,10 +554,11 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 			goto done;
 	}
 
-	*resp_len = resp_data_length + 7;
+	occ->client_response_size = resp_data_length + 7;
 	rc = occ_verify_checksum(occ, resp, resp_data_length);
 
  done:
+	*resp_len = occ->client_response_size;
 	mutex_unlock(&occ->occ_lock);
 
 	return rc;
-- 
2.27.0

