Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C843987D2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhFBLS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:18:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231530AbhFBLS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:18:56 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 152B4X6x102035;
        Wed, 2 Jun 2021 07:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QVghSTqa4YA5/8B2C8z6BT9DblhMAXd6BJMIPq9zyLA=;
 b=iih4CypWkduySCt6M86Fr9nauDqvZwR5G0RM/LG9K+o3Q8FDgjob91Qby4ICXRk40ZAD
 zMrKN803orrJb5hmp5/x+1AUnspTSBKr/MicrLnTXqJxbxOV6GOXjRAYAWCHOPWkpn77
 mN3658ahq7FkpAvK7inkcLrulAL6BOEint8cFW2VoAB4X/gfQCtihrMoH3QSo0PNZ06y
 1aQfs5sY5+OAl8J38IVINuTlKvvETJeM13OrwuF5jYN139606AgjX1LT5fR5QqX199ZE
 2mfJqZ39z+glCt9BXcyLlM1aSpngIclP6qxYcMvhPcFKWvr14yymej0u166YfrC0zBWq AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38x8syra9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 07:17:11 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 152B4m3b102758;
        Wed, 2 Jun 2021 07:17:11 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38x8syra92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 07:17:11 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 152BD5ei027418;
        Wed, 2 Jun 2021 11:17:09 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 38ud88a9gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 11:17:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 152BH7bJ25690606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jun 2021 11:17:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A81CA404D;
        Wed,  2 Jun 2021 11:17:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4D91A4040;
        Wed,  2 Jun 2021 11:17:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Jun 2021 11:17:06 +0000 (GMT)
From:   Julian Wiedmann <jwi@linux.ibm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH wq/for-next 2/2] workqueue: clean up for_each_pwq()'s documentation
Date:   Wed,  2 Jun 2021 13:16:55 +0200
Message-Id: <20210602111655.3808580-2-jwi@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602111655.3808580-1-jwi@linux.ibm.com>
References: <20210602111655.3808580-1-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iHQHyLKNwKfK6g4xuGFa1WIGYj5ehVry
X-Proofpoint-GUID: PNp-u_hHVVPkkHJjoHayKN0Nybz7oeZn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_06:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106020071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The if/else clause was removed with commit 5a6446626d7e
("workqueue: Convert for_each_wq to use built-in list check").

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 kernel/workqueue.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8a700ccfa313..104e3ef04e33 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -418,9 +418,6 @@ static void show_pwq(struct pool_workqueue *pwq);
  * This must be called either with wq->mutex held or RCU read locked.
  * If the pwq needs to be used beyond the locking in effect, the caller is
  * responsible for guaranteeing that the pwq stays online.
- *
- * The if/else clause exists only for the lockdep assertion and can be
- * ignored.
  */
 #define for_each_pwq(pwq, wq)						\
 	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,		\
-- 
2.25.1

