Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBAF41985E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhI0QBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:01:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235327AbhI0QBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:01:36 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18REhv0V029119;
        Mon, 27 Sep 2021 11:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fVKRgBL7Nfa5hrO57qTN+wnsTyv1U3Jwd7KAZ8VjRqs=;
 b=L0fgC5bGgXW04/J5/+DMaElY8u5Q6YMBkaocPIL3Y3gAP4vZ1+LsVm15HuMLgBjWKhvj
 itZ3H64gKaUFMPURn9xPuERPRBa3C/5FELcwcZd6kDSzVQ5X1aDO6CricOSt5P6cbiZZ
 D+TCINFuqEGnXF5HgGuH4wFK1lJUIm0PnXwBjwGeGRe7J5eJG2ubFZ4RCX78Jir4hNG7
 LYdgzkyEXT/lqdiqOwZt5/Jel7Wdh3J1jutgrDeBG0fd/hRh73WFCGIw/eojGnpFW5AY
 1uObIhPAFMoiy14r5ibxF4ObhQUkfNliVX793NGCFhendw44TsEjHx7xEKJaF7e1K7EJ BQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bagrg0bjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 11:59:37 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18RFvjgE018276;
        Mon, 27 Sep 2021 15:59:36 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 3b9uda993t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 15:59:36 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18RFxZcK39977268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Sep 2021 15:59:35 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70F702805C;
        Mon, 27 Sep 2021 15:59:35 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BF6528060;
        Mon, 27 Sep 2021 15:59:34 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.70.165])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 27 Sep 2021 15:59:34 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        linux@roeck-us.net, jdelvare@suse.com,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v3 2/4] fsi: occ: Store the SBEFIFO FFDC in the user response buffer
Date:   Mon, 27 Sep 2021 10:59:23 -0500
Message-Id: <20210927155925.15485-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210927155925.15485-1-eajames@linux.ibm.com>
References: <20210927155925.15485-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G9NF2DeaPsLZXU7g__48zdJ_iudI-XDe
X-Proofpoint-ORIG-GUID: G9NF2DeaPsLZXU7g__48zdJ_iudI-XDe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_06,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109270106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the SBEFIFO response indicates an error, store the response in the
user buffer and return an error. Previously, the user had no way of
obtaining the SBEFIFO FFDC.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - Don't store any magic value; only return non-zero resp_len in the error
   case if there is FFDC

 drivers/fsi/fsi-occ.c | 66 ++++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index ace3ec7767e5..1d5f6fdc2a34 100644
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
@@ -217,6 +220,20 @@ static const struct file_operations occ_fops = {
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
 static int occ_verify_checksum(struct occ *occ, struct occ_response *resp,
 			       u16 data_length)
 {
@@ -245,7 +262,7 @@ static int occ_verify_checksum(struct occ *occ, struct occ_response *resp,
 static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
 {
 	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
-	size_t cmd_len, resp_data_len;
+	size_t cmd_len, parsed_len, resp_data_len;
 	size_t resp_len = OCC_MAX_RESP_WORDS;
 	__be32 *resp = occ->buffer;
 	__be32 cmd[6];
@@ -280,16 +297,17 @@ static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
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
@@ -305,7 +323,7 @@ static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
 		       u8 seq_no, u16 checksum)
 {
 	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
-	size_t cmd_len, resp_data_len;
+	size_t cmd_len, parsed_len, resp_data_len;
 	size_t resp_len = OCC_MAX_RESP_WORDS;
 	__be32 *buf = occ->buffer;
 	u8 *byte_buf;
@@ -366,18 +384,19 @@ static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
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
@@ -395,7 +414,7 @@ static int occ_putsram(struct occ *occ, const void *data, ssize_t len,
 static int occ_trigger_attn(struct occ *occ)
 {
 	__be32 *buf = occ->buffer;
-	size_t cmd_len, resp_data_len;
+	size_t cmd_len, parsed_len, resp_data_len;
 	size_t resp_len = OCC_MAX_RESP_WORDS;
 	int idx = 0, rc;
 
@@ -426,18 +445,19 @@ static int occ_trigger_attn(struct occ *occ)
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
@@ -460,6 +480,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 		msecs_to_jiffies(OCC_CMD_IN_PRG_WAIT_MS);
 	struct occ *occ = dev_get_drvdata(dev);
 	struct occ_response *resp = response;
+	size_t user_resp_len = *resp_len;
 	u8 seq_no;
 	u16 checksum = 0;
 	u16 resp_data_length;
@@ -468,11 +489,13 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
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
 
@@ -482,6 +505,10 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 
 	mutex_lock(&occ->occ_lock);
 
+	occ->client_buffer = response;
+	occ->client_buffer_size = user_resp_len;
+	occ->client_response_size = 0;
+
 	/*
 	 * Get a sequence number and update the counter. Avoid a sequence
 	 * number of 0 which would pass the response check below even if the
@@ -532,7 +559,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 	resp_data_length = get_unaligned_be16(&resp->data_length);
 
 	/* Message size is data length + 5 bytes header + 2 bytes checksum */
-	if ((resp_data_length + 7) > *resp_len) {
+	if ((resp_data_length + 7) > user_resp_len) {
 		rc = -EMSGSIZE;
 		goto done;
 	}
@@ -548,7 +575,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 			goto done;
 	}
 
-	*resp_len = resp_data_length + 7;
+	occ->client_response_size = resp_data_length + 7;
 
 	{
 		DEFINE_DYNAMIC_DEBUG_METADATA(ddm_occ_rsp,
@@ -560,7 +587,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 		    DYNAMIC_DEBUG_BRANCH(ddm_occ_rsp)) {
 			char prefix[64];
 			size_t l = DYNAMIC_DEBUG_BRANCH(ddm_occ_full_rsp) ?
-				*resp_len : 16;
+				occ->client_response_size : 16;
 
 			snprintf(prefix, sizeof(prefix), "%s %s: rsp ",
 				 dev_driver_string(occ->dev),
@@ -573,6 +600,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 	rc = occ_verify_checksum(occ, resp, resp_data_length);
 
  done:
+	*resp_len = occ->client_response_size;
 	mutex_unlock(&occ->occ_lock);
 
 	return rc;
-- 
2.27.0

