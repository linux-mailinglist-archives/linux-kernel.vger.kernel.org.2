Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD4638061A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 11:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhENJXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 05:23:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232196AbhENJXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 05:23:15 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14E942w4023930
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Lw53QcKAhXAqL73o7z+2CqmqyU/QfBSa29MxlZ3YVWk=;
 b=JvauBU3iLHfAhpc50BvbuEil56u3lGqDgiZ3YFKKR3OmjJ+HCyTfgTZwBAnYZ0H+xuyg
 CNC03LL7kN37Z4Ck5sIj0V9gazm9fWoJRgnS/cVNABni64AEDvTc6UsFP7uEM6rMThtp
 lHWhlSSXHLPUVtra5PADX8mEaIr9Kbb/CH2o+wYLrJUtbGkKWyU+NekXqTBDKG7yLmBM
 DMF0mGCN+tbSwRMQmsY/PCcI7pgKBTJ2l9uqEQ5H4pRTpEj1Zu6ahrtIc909LdiiRaK1
 /3Mb80fnlo31omx0LnbxbP/V5LUa0l4l/ieLsn7jJmSXNaQhc9KbO7R6G3A8I/8OG00t gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38hjet5fxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:22:04 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14E9DUPA059741
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:22:04 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38hjet5fww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 05:22:04 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14E9CbYk004461;
        Fri, 14 May 2021 09:22:02 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 38hc77g6rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 May 2021 09:22:02 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14E9Lxs816187682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 09:21:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25699A4065;
        Fri, 14 May 2021 09:21:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C3CFA405F;
        Fri, 14 May 2021 09:21:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 14 May 2021 09:21:59 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id D1787E05BC; Fri, 14 May 2021 11:21:58 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 2/2] kfence: only handle kernel mode faults
Date:   Fri, 14 May 2021 11:21:39 +0200
Message-Id: <20210514092139.3225509-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514092139.3225509-1-svens@linux.ibm.com>
References: <20210514092139.3225509-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: chwnlh6K2NWARONykIlWrooc2c2I2uX2
X-Proofpoint-ORIG-GUID: yb_aH7aRGvem5Y9aOKY9lX60fUh3Y1Nc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-14_04:2021-05-12,2021-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxlogscore=843 malwarescore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 mm/kfence/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index bc15e3cb71d5..161df492750c 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -813,6 +813,9 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
 	enum kfence_error_type error_type;
 	unsigned long flags;
 
+	if (user_mode(regs))
+		return false;
+
 	if (!is_kfence_address((void *)addr))
 		return false;
 
-- 
2.25.1

