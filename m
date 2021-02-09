Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A073154D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhBIRO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:14:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232947AbhBIROO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:14:14 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 119HAYGh129410;
        Tue, 9 Feb 2021 12:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wJ//Omqv/AAT6eCOvqmQAss00CDe5qV9MLuhq8HpxPs=;
 b=SRlQ3Fi4uet0tJdp5LF9I9ahjNtRynvyHYERqp7dnNn17SNz9C7PqBcZ8tv4HnSuD4Z5
 d49l0VlpnwQxl7dnZswD/kTcoaHq7gr2tfSLG3reTDtH9cRu+WblbZDkTuJEx5uRTE5r
 JzsEsT1OTCH8ev8MELU/iTYK4rxRQ8NvlXBjVL7PGzBjz1MzVIwRjV8j/mNF2tk9eesj
 GEd3wSCJPDftvF6kbR40iJClaz0dV9JeUOwWcdZY/LjIDiINH8gRdGTq/h+6JTi1g4QZ
 uFPCab7KStKg9FRu3KE3fy/dtKLWVaD3LkaGrqmYEnbgqNDNW9wVScB1rq86FywV5NjB MA== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36kx5hh3ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 12:12:55 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 119GvUO8026169;
        Tue, 9 Feb 2021 17:12:53 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04wdc.us.ibm.com with ESMTP id 36hjr981uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 17:12:53 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 119HCrhZ6881972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Feb 2021 17:12:53 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23A4CAE05F;
        Tue,  9 Feb 2021 17:12:53 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDC54AE05C;
        Tue,  9 Feb 2021 17:12:51 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.163.58.95])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Feb 2021 17:12:51 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        jdelvare@suse.com, linux@roeck-us.net,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 1/4] fsi: occ: Don't accept response from un-initialized OCC
Date:   Tue,  9 Feb 2021 11:12:32 -0600
Message-Id: <20210209171235.20624-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210209171235.20624-1-eajames@linux.ibm.com>
References: <20210209171235.20624-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_05:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the OCC is not initialized and responds as such, the driver
should continue waiting for a valid response until the timeout
expires.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index 10ca2e290655..cb05b6dacc9d 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -495,6 +495,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
 			goto done;
 
 		if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
+		    resp->return_status == OCC_RESP_CRIT_INIT ||
 		    resp->seq_no != seq_no) {
 			rc = -ETIMEDOUT;
 
-- 
2.27.0

