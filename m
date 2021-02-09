Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50E53154D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhBIRPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:15:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233004AbhBIROO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:14:14 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 119HC08c061102;
        Tue, 9 Feb 2021 12:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NjepnYGkFLCS0yBjbhZKkDmHLSmYEpAER93JT+rKT/g=;
 b=eaMV2arZ6y95OY0Pz6aKFFvm6gegCZtTYxUQM2vMWUv4s3rkedhqJ5iTV6k63jR2uKmX
 yKV+E/q6IFmGQNa7ZGEt5MWGIUNwXqCqvM87Q+bhZRzPegzNN449r8WmkmniNn8gQFFo
 8byMCfvE/SgwH8u39BFHGCQfdHdvt0h6Ur/tmWhKwRPbTS2B9mvSvaH8avqCRDs15NSm
 Yl/gCLJ1YXpyRdC5kpZQEZZ2/DASHsRI06VaABjb+8ZM0528rasoEeATiUEmvuMh2L63
 +LddnS9MDp4ANkVR7NRvZ4kb4vPALkfwozlGzy17HpdFUs0CawQmULRXHRW2BKiWOgtN TA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36kxk101wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 12:13:02 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 119Gwdl4018392;
        Tue, 9 Feb 2021 17:13:02 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 36hjr9e25j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 17:13:02 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 119HD1Ou31392200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Feb 2021 17:13:01 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EC4AAE060;
        Tue,  9 Feb 2021 17:13:01 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FD48AE05C;
        Tue,  9 Feb 2021 17:13:00 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.163.58.95])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Feb 2021 17:12:59 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        jdelvare@suse.com, linux@roeck-us.net,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 3/4] hwmon: (occ) Start sequence number at one
Date:   Tue,  9 Feb 2021 11:12:34 -0600
Message-Id: <20210209171235.20624-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210209171235.20624-1-eajames@linux.ibm.com>
References: <20210209171235.20624-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_05:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the sequence number at one, rather than zero, in order
to prevent false matches with the zero-initialized OCC SRAM
buffer before the OCC is fully initialized.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/occ/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 7a5e539b567b..ee0c5d12dfdf 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -1150,6 +1150,8 @@ int occ_setup(struct occ *occ, const char *name)
 {
 	int rc;
 
+	/* start with 1 to avoid false match with zero-initialized SRAM buffer */
+	occ->seq_no = 1;
 	mutex_init(&occ->lock);
 	occ->groups[0] = &occ->group;
 
-- 
2.27.0

