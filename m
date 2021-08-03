Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C0A3DF6E4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 23:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhHCVav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 17:30:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28418 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232094AbhHCVau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 17:30:50 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173L3ils110835;
        Tue, 3 Aug 2021 17:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7UmKY+Qdz0QXWZBZv2ZUan3xXdaK27R5Vh398T8rDS4=;
 b=TDaIHexvQTu/tOM3hSt2saM1DOydN+yZiYLlKj2AmMZciVrclnKNl2NOKFa12Jt7QBEm
 j5bIPSiCU9Bd6B2mwx2lzf+FJLYE9UjLJbEnL+l/KoAsEkkEvIsJHgEUvstZHcITLpdT
 4C6tYR5zoTHFaJ/QkjRCuORC9C3bR9QfjCy9UIDaV8qLGdYpctMOo6HasBwtMtg/0A/w
 ZkRp8V1gR9Ibgt6QgLjnhHtT1J+LHY4peiS76PKj+ycYXythpKNY0RFEaV1vKjgSiIC7
 gN/RvGOIO2l47WoHSvAOWsd9h5X8gaiCxjPSQK/as28Ampc/+VEek4+nQawh3mN9Nftg pA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a7b77kybh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 17:30:26 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 173LHV4k010764;
        Tue, 3 Aug 2021 21:30:25 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 3a4x5dj32x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 21:30:25 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 173LUMOF10355292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Aug 2021 21:30:22 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AA53AE073;
        Tue,  3 Aug 2021 21:30:22 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD9B6AE060;
        Tue,  3 Aug 2021 21:30:21 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.111.223])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Aug 2021 21:30:21 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     joel@jms.id.au
Cc:     jk@ozlabs.org, alistair@popple.id.au, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] fsi: sbefifo: Use interruptible mutex locking
Date:   Tue,  3 Aug 2021 16:30:16 -0500
Message-Id: <20210803213016.44739-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0hv1Ol6lLyWebvFo5pkm-BVpMW3u2DT_
X-Proofpoint-ORIG-GUID: 0hv1Ol6lLyWebvFo5pkm-BVpMW3u2DT_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_05:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SBE operations have extremely large responses and can require
several minutes to process the response. During this time, the device
lock must be held. If another process attempts an operation, it will
wait for the mutex for longer than the kernel hung task watchdog
allows. Therefore, use the interruptible function to lock the mutex.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-sbefifo.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 84cb965bfed5..a8d8e47e6fb2 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -740,7 +740,9 @@ int sbefifo_submit(struct device *dev, const __be32 *command, size_t cmd_len,
         iov_iter_kvec(&resp_iter, WRITE, &resp_iov, 1, rbytes);
 
 	/* Perform the command */
-	mutex_lock(&sbefifo->lock);
+	rc = mutex_lock_interruptible(&sbefifo->lock);
+	if (rc)
+		return rc;
 	rc = __sbefifo_submit(sbefifo, command, cmd_len, &resp_iter);
 	mutex_unlock(&sbefifo->lock);
 
@@ -820,7 +822,9 @@ static ssize_t sbefifo_user_read(struct file *file, char __user *buf,
 	iov_iter_init(&resp_iter, WRITE, &resp_iov, 1, len);
 
 	/* Perform the command */
-	mutex_lock(&sbefifo->lock);
+	rc = mutex_lock_interruptible(&sbefifo->lock);
+	if (rc)
+		goto bail;
 	rc = __sbefifo_submit(sbefifo, user->pending_cmd, cmd_len, &resp_iter);
 	mutex_unlock(&sbefifo->lock);
 	if (rc < 0)
@@ -875,7 +879,9 @@ static ssize_t sbefifo_user_write(struct file *file, const char __user *buf,
 		user->pending_len = 0;
 
 		/* Trigger reset request */
-		mutex_lock(&sbefifo->lock);
+		rc = mutex_lock_interruptible(&sbefifo->lock);
+		if (rc)
+			goto bail;
 		rc = sbefifo_request_reset(user->sbefifo);
 		mutex_unlock(&sbefifo->lock);
 		if (rc == 0)
-- 
2.27.0

