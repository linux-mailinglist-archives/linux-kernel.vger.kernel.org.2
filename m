Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B59F397641
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhFAPOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:14:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25391 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234501AbhFAPNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:13:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 151F6IrO038220;
        Tue, 1 Jun 2021 11:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5pjRT3mSABcZpQZ8tfpCrt68f46qsicZyGPHUwPx4fA=;
 b=IxQNyEflx7hNMdOKbj1pDwXLIrIcV9fUvCx7xcM+raB1nt84CRsDHG+BVHZSJ6zAOnNe
 CfXrqJvJqGtWmLsOo+JkECA493AH/I/dzmqe53HdsxcGmI27K+W8ICgwqIW96j/CYheW
 MWfTmZxoNztXDcbmY+pvlxY/HzRbrMJZfCoGYyR5LywhsafAxUUeb3vUuH04HFufFvQz
 mUBVXcsgaWfCHYr+oG9v/eCK7GeUL0PRZAf92Vkm1uCGLqkwjl9gAqZVXphN6G1URmw0
 GubxTlHe5NJxL57r5iVmNa7n6iw3+a2mPSqcJYzs8hQDAaAGnL/qy2iBL4PAm79bvFMS SA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38wht4k1em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 11:11:31 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 151F6ipJ040876;
        Tue, 1 Jun 2021 11:11:30 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38wht4k1d3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 11:11:30 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 151F9DRS022255;
        Tue, 1 Jun 2021 15:11:29 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 38w413rbbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 15:11:28 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 151FArtq35127682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Jun 2021 15:10:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 935025204F;
        Tue,  1 Jun 2021 15:11:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 314BC52051;
        Tue,  1 Jun 2021 15:11:26 +0000 (GMT)
From:   Julian Wiedmann <jwi@linux.ibm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH tip/sched/core] wait: use LIST_HEAD_INIT() to initialize wait_queue_head
Date:   Tue,  1 Jun 2021 17:11:20 +0200
Message-Id: <20210601151120.329223-1-jwi@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hmx-yoVeA3BIrs-9vopzSjD4tq7rAWHL
X-Proofpoint-ORIG-GUID: MY4NYtLEvOgbZbDwavrTR3x1nJTw0FSk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_07:2021-06-01,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the open-coded initialization with the right macro.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 include/linux/wait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index fe10e8570a52..99c5f05718cd 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -56,7 +56,7 @@ struct task_struct;
 
 #define __WAIT_QUEUE_HEAD_INITIALIZER(name) {					\
 	.lock		= __SPIN_LOCK_UNLOCKED(name.lock),			\
-	.head		= { &(name).head, &(name).head } }
+	.head		= LIST_HEAD_INIT(name.head) }
 
 #define DECLARE_WAIT_QUEUE_HEAD(name) \
 	struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
-- 
2.25.1

