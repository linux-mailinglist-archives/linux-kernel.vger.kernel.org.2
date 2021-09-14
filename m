Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315D740BA61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhINVhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:37:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234911AbhINVhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:37:32 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18EL0d4Q026895;
        Tue, 14 Sep 2021 17:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IE3gxtKmIb8raCWDJMJkGEi0VuJ0w9PNCyVhB+iI1/g=;
 b=ronLSG035hWlW1+yZjNEc64lBd6ZptUNAl84mLXypGoECTJMCwmcH+QhqQ2wWOtIraPf
 QXKoShH5OnK47pA5QyewffeEtaw087k5xxg262R1RnlrvFBsnU26yTAZMNsQSkXeGnUw
 XEkBULwcDaeho4fcg454AW7M+/M+6y9M9mo4l+h5mdgPt/4iIKv7BT4dlpueGoEK9D8z
 UidqlKCq4aKlK+mNs4s2Ed8UJuaJEpVOtIlO/e6kwm1A6KESOHOsymfdBr6mqwmAgg9/
 hiznEuLLVCZWG6gBIh20nABOEt5c3OGGMyC8XS1INdp7qIGmM/6+ieE2YfEZADzLK75Q ew== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b3394rmyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 17:35:48 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18ELRoHM010933;
        Tue, 14 Sep 2021 21:35:46 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 3b0m3bb97q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 21:35:46 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18ELZjF052625714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:35:45 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D58D136055;
        Tue, 14 Sep 2021 21:35:45 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C53113605D;
        Tue, 14 Sep 2021 21:35:45 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.154.14])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 14 Sep 2021 21:35:45 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, linux@roeck-us.net, jdelvare@suse.com,
        alistair@popple.id.au, jk@ozlabs.org, eajames@linux.ibm.com
Subject: [PATCH 2/3] fsi: occ: Store the SBEFIFO FFDC in the user response buffer
Date:   Tue, 14 Sep 2021 16:35:42 -0500
Message-Id: <20210914213543.73351-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210914213543.73351-1-eajames@linux.ibm.com>
References: <20210914213543.73351-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ltn8aGy8VnmXWBUFzZPT1sSiq8QfeDUk
X-Proofpoint-ORIG-GUID: Ltn8aGy8VnmXWBUFzZPT1sSiq8QfeDUk
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

If the SBEFIFO response indicates an error, store the response in the
user buffer and return an error. Previously, the user had no way of
obtaining the SBEFIFO FFDC. In case of an error with the SBE or SBEFIFO
itself, in which case there is no FFDC, set the FFDC data to a magic
value to indicate this kind of error.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c   | 87 ++++++++++++++++++++++++++++++-----------
 include/linux/fsi-occ.h |  1 +
 2 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index ace3ec7767e5..e4ef96e41747 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -55,6 +55,9 @@ struct occ {
 	int idx;
 	u8 sequence_number;
 	void *buffer;
+	void *client_buffer;
+	size_t client_buffer_size;
+	size_t client_response_size;
 	enum versions version;
 	struct miscdevice mdev;
 	struct mutex occ_lock;
@@ -217,6 +220,28 @@ static const struct file_operations occ_fops = {
 	.release = occ_release,
 };
 
+static void occ_save_ffdc(struct occ *occ, __be32 *resp, size_t parsed_len,
+			  size_t resp_len)
+{
+	size_t dh = resp_len - parsed_len;
+	size_t ffdc_len = (dh - 1) * 4;
+	__be32 *ffdc = &resp[resp_len - dh];
+
+	if (ffdc_len > occ->client_buffer_size)
+		ffdc_len = occ->client_buffer_size;
+
+	memcpy(occ->client_buffer, ffdc, ffdc_len);
+	occ->client_response_size = ffdc_len;
+}
+
+static void occ_save_sbefifo_error(struct occ *occ)
+{
+	u32 no_ffdc_magic = OCC_NO_FFDC_MAGIC;
+
+	memcpy(occ->client_buffer, &no_ffdc_magic, sizeof(u32));
+	occ->client_response_size = sizeof(u32);
+}
+
 static int occ_verify_checksum(struct occ *occ, struct occ_response *resp,
 			       u16 data_length)
 {
@@ -245,7 +270,7 @@ static int occ_verify_checksum(struct occ *occ, struct occ_response *resp,
 static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
 {
 	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
-	size_t cmd_len, resp_data_len;
+	size_t cmd_len, parsed_len, resp_data_len;
 	size_t resp_len = OCC_MAX_RESP_WORDS;
 	__be32 *resp = occ->buffer;
 	__be32 cmd[6];
@@ -276,20 +301,23 @@ static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
 	cmd[4 + idx] = cpu_to_be32(data_len);
 
 	rc = sbefifo_submit(occ->sbefifo, cmd, cmd_len, resp, &resp_len);
-	if (rc)
+	if (rc) {
+		occ_save_sbefifo_error(occ);
 		return rc;
+	}
 
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
@@ -305,7 +333,7 @@ static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
 		       u8 seq_no, u16 checksum)
 {
 	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
-	size_t cmd_len, resp_data_len;
+	size_t cmd_len, parsed_len, resp_data_len;
 	size_t resp_len = OCC_MAX_RESP_WORDS;
 	__be32 *buf = occ->buffer;
 	u8 *byte_buf;
@@ -362,22 +390,25 @@ static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
 	}
 
 	rc = sbefifo_submit(occ->sbefifo, buf, cmd_len, buf, &resp_len);
-	if (rc)
+	if (rc) {
+		occ_save_sbefifo_error(occ);
 		return rc;
+	}
 
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
@@ -395,7 +426,7 @@ static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
 static int occ_trigger_attn(struct occ *occ)
 {
 	__be32 *buf = occ->buffer;
-	size_t cmd_len, resp_data_len;
+	size_t cmd_len, parsed_len, resp_data_len;
 	size_t resp_len = OCC_MAX_RESP_WORDS;
 	int idx = 0, rc;
 
@@ -422,22 +453,25 @@ static int occ_trigger_attn(struct occ *occ)
 	buf[6 + idx] = 0;
 
 	rc = sbefifo_submit(occ->sbefifo, buf, cmd_len, buf, &resp_len);
-	if (rc)
+	if (rc) {
+		occ_save_sbefifo_error(occ);
 		return rc;
+	}
 
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
@@ -460,6 +494,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 		msecs_to_jiffies(OCC_CMD_IN_PRG_WAIT_MS);
 	struct occ *occ = dev_get_drvdata(dev);
 	struct occ_response *resp = response;
+	size_t user_resp_len = *resp_len;
 	u8 seq_no;
 	u16 checksum = 0;
 	u16 resp_data_length;
@@ -468,11 +503,13 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
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
 
@@ -482,6 +519,11 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 
 	mutex_lock(&occ->occ_lock);
 
+	occ->client_buffer = response;
+	occ->client_buffer_size = user_resp_len;
+	occ->client_response_size = 0;
+	memset(occ->client_buffer, 0, 8);
+
 	/*
 	 * Get a sequence number and update the counter. Avoid a sequence
 	 * number of 0 which would pass the response check below even if the
@@ -532,7 +574,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 	resp_data_length = get_unaligned_be16(&resp->data_length);
 
 	/* Message size is data length + 5 bytes header + 2 bytes checksum */
-	if ((resp_data_length + 7) > *resp_len) {
+	if ((resp_data_length + 7) > user_resp_len) {
 		rc = -EMSGSIZE;
 		goto done;
 	}
@@ -548,7 +590,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 			goto done;
 	}
 
-	*resp_len = resp_data_length + 7;
+	occ->client_response_size = resp_data_length + 7;
 
 	{
 		DEFINE_DYNAMIC_DEBUG_METADATA(ddm_occ_rsp,
@@ -560,7 +602,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 		    DYNAMIC_DEBUG_BRANCH(ddm_occ_rsp)) {
 			char prefix[64];
 			size_t l = DYNAMIC_DEBUG_BRANCH(ddm_occ_full_rsp) ?
-				*resp_len : 16;
+				occ->client_response_size : 16;
 
 			snprintf(prefix, sizeof(prefix), "%s %s: rsp ",
 				 dev_driver_string(occ->dev),
@@ -573,6 +615,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 	rc = occ_verify_checksum(occ, resp, resp_data_length);
 
  done:
+	*resp_len = occ->client_response_size;
 	mutex_unlock(&occ->occ_lock);
 
 	return rc;
diff --git a/include/linux/fsi-occ.h b/include/linux/fsi-occ.h
index 7ee3dbd7f4b3..1d584b2acba5 100644
--- a/include/linux/fsi-occ.h
+++ b/include/linux/fsi-occ.h
@@ -20,6 +20,7 @@ struct device;
 #define OCC_RESP_CRIT_HW		0xE4
 
 #define OCC_MAX_RESP_WORDS		2048
+#define OCC_NO_FFDC_MAGIC		0x4f434346	/* "OCCF" */
 
 int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 		   void *response, size_t *resp_len);
-- 
2.27.0

