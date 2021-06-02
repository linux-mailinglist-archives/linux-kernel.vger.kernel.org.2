Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6893987CE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhFBLSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:18:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64138 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229825AbhFBLSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:18:54 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 152B3ZMU112664;
        Wed, 2 Jun 2021 07:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=QtgxRA8gC+M8FY9gSrUuVfrLs5MKyCyevXxvJ0hvpjo=;
 b=IEVf+v4S8ygNaH/WmpPhxNlWi1P6xSKzYq2fHcSVQMRTjYOH0SQcbqZKPITrFt4dfxMp
 68vmbP9h8CEFpUm+k8UTDeLuWVoFgWVTSIOMdilh5AL4d2n9YWZUOBQd4Lu3akilxg1e
 1VcQUpt2QBk9acCIjN17otujE3E9dVpZNz2e6+2WPEuikFHEFJ0QKDQr/iPbsRdvh1IU
 hs4ImEdLPZvdJbPzGusMb7Zky+TJUzjc+EUXLIqx7gbssAzArz2LpiNDQg6gMbZNX2LU
 AuDNnGh81Kv2WsHdRAvZBKY9gW4ulzCe5AWxPlPbKYEBRtYoWbedCxZlSGCRKtor9+bx AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38x6bnm9ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 07:17:10 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 152B3uVd114578;
        Wed, 2 Jun 2021 07:17:09 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38x6bnm9ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 07:17:09 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 152BFEw4015693;
        Wed, 2 Jun 2021 11:17:08 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 38ud8818n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 11:17:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 152BH5Nm28180752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jun 2021 11:17:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC348A4040;
        Wed,  2 Jun 2021 11:17:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81E96A4055;
        Wed,  2 Jun 2021 11:17:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Jun 2021 11:17:05 +0000 (GMT)
From:   Julian Wiedmann <jwi@linux.ibm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH wq/for-next 1/2] workqueue: replace open-coded work_pending()
Date:   Wed,  2 Jun 2021 13:16:54 +0200
Message-Id: <20210602111655.3808580-1-jwi@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bxN5KlYATNxJXV3NhmtR4_JsNEkfwH7f
X-Proofpoint-ORIG-GUID: 5YQxgCzzI-uFNjGKJhEUy26bnX_qXwD2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_05:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=795
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106020071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the right helper to check whether a work item is currently pending.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 50142fc08902..8a700ccfa313 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3209,7 +3209,7 @@ EXPORT_SYMBOL(flush_delayed_work);
  */
 bool flush_rcu_work(struct rcu_work *rwork)
 {
-	if (test_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&rwork->work))) {
+	if (work_pending(&rwork->work)) {
 		rcu_barrier();
 		flush_work(&rwork->work);
 		return true;
-- 
2.25.1

