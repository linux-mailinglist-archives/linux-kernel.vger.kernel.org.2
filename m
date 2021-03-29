Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A250434D37F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhC2PO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:14:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhC2POB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:14:01 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12TF4BtS115546;
        Mon, 29 Mar 2021 11:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=XGTNU9FxbYfquQDFBTIKYBOYaGE5VvL/e/xPpeX00WQ=;
 b=jOAdOSeJKyWcbhBBaTpwHaAkKAnvy/8Uj23xacWtf57Wpslsrojj8wH1+JzLXly+FJld
 pTwd0JzEii2EOP3cKWpgBsyrstcwx6IEtJwIF5+717B1i6jja/Fy3E8jZX+vglu0Zefd
 fRnnKvf1LTYKBBqmlKPtf/oonr6cC8Qu1KqYgsgW51tlBUVhm0ys19AGEkcbVNvJrqDQ
 VK0c9IS5ziclVv2sJu42/b+tSX8kOa9704/HjZBAIuK4j8nJePiz2MSY1wRFLoyZOopa
 hVjWYdNGuCrowi+4Q7rMyz96p9nssPemI2LI29F8pKqT3fMB9xL+nxkqilhXFbquEVEO Cw== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37jhnkkfya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 11:13:54 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12TFCv6p010683;
        Mon, 29 Mar 2021 15:13:53 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 37jtub0327-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 15:13:53 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12TFDqp525100612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Mar 2021 15:13:52 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F06AAC6057;
        Mon, 29 Mar 2021 15:13:51 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7218C605B;
        Mon, 29 Mar 2021 15:13:51 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.163.3.96])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 29 Mar 2021 15:13:51 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     joel@jms.id.au
Cc:     jk@ozlabs.org, alistair@popple.id.au, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] fsi: scom: Reset the FSI2PIB engine for any error
Date:   Mon, 29 Mar 2021 10:13:44 -0500
Message-Id: <20210329151344.14246-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AReOFunNlgNZlDZuWjDoK5eAzYpfvmVX
X-Proofpoint-ORIG-GUID: AReOFunNlgNZlDZuWjDoK5eAzYpfvmVX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_10:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 mlxscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103290114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error bits in the FSI2PIB status are only cleared by a reset. So
the driver needs to perform a reset after seeing any of the FSI2PIB
errors, otherwise subsequent operations will also look like failures.

Fixes: 6b293258cded ("fsi: scom: Major overhaul")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-scom.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index b45bfab7b7f5..75d1389e2626 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -38,9 +38,10 @@
 #define SCOM_STATUS_PIB_RESP_MASK	0x00007000
 #define SCOM_STATUS_PIB_RESP_SHIFT	12
 
-#define SCOM_STATUS_ANY_ERR		(SCOM_STATUS_PROTECTION | \
-					 SCOM_STATUS_PARITY |	  \
-					 SCOM_STATUS_PIB_ABORT | \
+#define SCOM_STATUS_FSI2PIB_ERROR	(SCOM_STATUS_PROTECTION |	\
+					 SCOM_STATUS_PARITY |		\
+					 SCOM_STATUS_PIB_ABORT)
+#define SCOM_STATUS_ANY_ERR		(SCOM_STATUS_FSI2PIB_ERROR |	\
 					 SCOM_STATUS_PIB_RESP_MASK)
 /* SCOM address encodings */
 #define XSCOM_ADDR_IND_FLAG		BIT_ULL(63)
@@ -240,13 +241,14 @@ static int handle_fsi2pib_status(struct scom_device *scom, uint32_t status)
 {
 	uint32_t dummy = -1;
 
-	if (status & SCOM_STATUS_PROTECTION)
-		return -EPERM;
-	if (status & SCOM_STATUS_PARITY) {
+	if (status & SCOM_STATUS_FSI2PIB_ERROR)
 		fsi_device_write(scom->fsi_dev, SCOM_FSI2PIB_RESET_REG, &dummy,
 				 sizeof(uint32_t));
+
+	if (status & SCOM_STATUS_PROTECTION)
+		return -EPERM;
+	if (status & SCOM_STATUS_PARITY)
 		return -EIO;
-	}
 	/* Return -EBUSY on PIB abort to force a retry */
 	if (status & SCOM_STATUS_PIB_ABORT)
 		return -EBUSY;
-- 
2.27.0

