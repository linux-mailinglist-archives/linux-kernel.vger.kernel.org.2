Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628DA352595
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 05:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhDBC7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 22:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbhDBC7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 22:59:01 -0400
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DA7C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 19:59:01 -0700 (PDT)
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.43/8.16.0.43) with SMTP id 1322ruwV007166;
        Fri, 2 Apr 2021 03:58:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=jan2016.eng;
 bh=JdtGzP2RAKQcmgO2yFSRC03nWS2GpEr7tRk7vHdRX00=;
 b=Mz4TofVFkDve0qC3bmyqI8Ea3EDlJ0xO189OLnR/q2jaRAFT5ejRcG6eEkpw2fAG1j0q
 9UWj4Ogc5/PGrAVgIiK7EgD/5PinLFkDBd+ftv7FEPcTF5ZygilBTqDco0jvs8rc551z
 urvPIULJS9PmlR8zGiwnCJif9NFaQJuwFUaWhOnehurLVpyMpL7bMU2c4hyWaYhdlk+3
 W+TnKtqIHBp8W7SpJuYzvdIEnSOxe6fu8gWIQhXgymkrrFF2LsyLE4DGNj7JdhQ7Y0kw
 57sPYNexogKbPem+exyw0UfCMu1y/eAQOkoBpZyxHigUFD9f/ErjxQKb1ZFYBN7mJat8 nA== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 37n31869gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Apr 2021 03:58:54 +0100
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
        by prod-mail-ppoint6.akamai.com (8.16.0.43/8.16.0.43) with SMTP id 1322n4fa017691;
        Thu, 1 Apr 2021 22:58:53 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.33])
        by prod-mail-ppoint6.akamai.com with ESMTP id 37n2qd37nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 01 Apr 2021 22:58:53 -0400
Received: from USMA1EX-CAS2.msg.corp.akamai.com (172.27.123.31) by
 usma1ex-dag3mb5.msg.corp.akamai.com (172.27.123.55) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 1 Apr 2021 22:58:52 -0400
Received: from sjo-lpkf5.sanatclara.corp.akamai.com (172.28.3.202) by
 USMA1EX-CAS2.msg.corp.akamai.com (172.27.123.31) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 1 Apr 2021 22:58:51 -0400
Received: by sjo-lpkf5.sanatclara.corp.akamai.com (Postfix, from userid 30754)
        id A286E1608E2; Thu,  1 Apr 2021 22:58:52 -0400 (EDT)
From:   Josh Hunt <johunt@akamai.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <ebiederm@xmission.com>,
        <keescook@chromium.org>, <hannes@cmpxchg.org>
CC:     Josh Hunt <johunt@akamai.com>
Subject: [PATCH v2] psi: allow unprivileged users with CAP_SYS_RESOURCE to write psi files
Date:   Thu, 1 Apr 2021 22:58:33 -0400
Message-ID: <20210402025833.27599-1-johunt@akamai.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_14:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=928 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104020020
X-Proofpoint-GUID: -ZokyeBmT5CByyr2SpqbEMZB0GqRVYwJ
X-Proofpoint-ORIG-GUID: -ZokyeBmT5CByyr2SpqbEMZB0GqRVYwJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_14:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=915 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104020021
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 184.51.33.61)
 smtp.mailfrom=johunt@akamai.com smtp.helo=prod-mail-ppoint6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only root can write files under /proc/pressure. Relax this to
allow tasks running as unprivileged users with CAP_SYS_RESOURCE to be
able to write to these files.

Signed-off-by: Josh Hunt <johunt@akamai.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index b1b00e9bd7ed..d1212f17a898 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1061,19 +1061,27 @@ static int psi_cpu_show(struct seq_file *m, void *v)
 	return psi_show(m, &psi_system, PSI_CPU);
 }
 
+static int psi_open(struct file *file, int (*psi_show)(struct seq_file *, void *))
+{
+	if (file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESOURCE))
+		return -EPERM;
+
+	return single_open(file, psi_show, NULL);
+}
+
 static int psi_io_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, psi_io_show, NULL);
+	return psi_open(file, psi_io_show);
 }
 
 static int psi_memory_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, psi_memory_show, NULL);
+	return psi_open(file, psi_memory_show);
 }
 
 static int psi_cpu_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, psi_cpu_show, NULL);
+	return psi_open(file, psi_cpu_show);
 }
 
 struct psi_trigger *psi_trigger_create(struct psi_group *group,
@@ -1353,9 +1361,9 @@ static int __init psi_proc_init(void)
 {
 	if (psi_enable) {
 		proc_mkdir("pressure", NULL);
-		proc_create("pressure/io", 0, NULL, &psi_io_proc_ops);
-		proc_create("pressure/memory", 0, NULL, &psi_memory_proc_ops);
-		proc_create("pressure/cpu", 0, NULL, &psi_cpu_proc_ops);
+		proc_create("pressure/io", 0666, NULL, &psi_io_proc_ops);
+		proc_create("pressure/memory", 0666, NULL, &psi_memory_proc_ops);
+		proc_create("pressure/cpu", 0666, NULL, &psi_cpu_proc_ops);
 	}
 	return 0;
 }
-- 
2.17.1

