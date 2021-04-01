Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F432350D8E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 06:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhDAESR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 00:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhDAERy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 00:17:54 -0400
X-Greylist: delayed 2728 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Mar 2021 21:17:53 PDT
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D6FC0613E6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 21:17:53 -0700 (PDT)
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.43/8.16.0.43) with SMTP id 1313SmVC001047;
        Thu, 1 Apr 2021 04:32:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=jan2016.eng;
 bh=z3JH9GtrbWmDHVkPQqloZjRKOV4P3FD9Ih3u4Xkk08E=;
 b=NCroEzYdVVcnAI760NJXBe2oY4FuLN/WY5uahCaXuGrB34bcXsnVYk16tMe8Sm8ZGKrk
 8FyO0Vej5Ql29xC3Fw1eLPN1+v/IrWUIGjQcXH+RJZokh4oCOEWmBF77xBLdgT0NDWYH
 Bb38FVsgdyu27mue1GnQ5W00R5taZvkgcn9VNs+EYubNNFyVEAuKiM6T0xMLXnUrlmU4
 Y4QGlqmrruQx5EykpUs4V+KBU5+qIX0L+Xg72J9O8b1OIJSleIumEXlQB2HsFYgf81FT
 LHHwtrm0qxFerEh/Ib+Lio9U+/JMUJd1HCERBA8JSiIy8ZS74oPhF5mhiT/QdwNYg5rW Dg== 
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 37n2jytc38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Apr 2021 04:32:08 +0100
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.16.0.43/8.16.0.43) with SMTP id 1313L2Pj007100;
        Wed, 31 Mar 2021 20:32:07 -0700
Received: from email.msg.corp.akamai.com ([172.27.123.57])
        by prod-mail-ppoint5.akamai.com with ESMTP id 37n2jmrhfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 20:32:07 -0700
Received: from usma1ex-cas4.msg.corp.akamai.com (172.27.123.57) by
 usma1ex-dag3mb1.msg.corp.akamai.com (172.27.123.60) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 31 Mar 2021 23:32:06 -0400
Received: from sjo-lpkf5.sanatclara.corp.akamai.com (172.28.3.202) by
 usma1ex-cas4.msg.corp.akamai.com (172.27.123.57) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 31 Mar 2021 23:32:06 -0400
Received: by sjo-lpkf5.sanatclara.corp.akamai.com (Postfix, from userid 30754)
        id D02B41608E1; Wed, 31 Mar 2021 23:32:06 -0400 (EDT)
From:   Josh Hunt <johunt@akamai.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Josh Hunt <johunt@akamai.com>
Subject: [PATCH] psi: allow unprivileged users with CAP_SYS_RESOURCE to write psi files
Date:   Wed, 31 Mar 2021 23:31:56 -0400
Message-ID: <20210401033156.7262-1-johunt@akamai.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_02:2021-03-31,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010021
X-Proofpoint-GUID: hZvmu9nMXPkfYlGOc87SYPpw62wCKEo8
X-Proofpoint-ORIG-GUID: hZvmu9nMXPkfYlGOc87SYPpw62wCKEo8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_11:2021-03-31,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010023
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 184.51.33.60)
 smtp.mailfrom=johunt@akamai.com smtp.helo=prod-mail-ppoint5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only root can write files under /proc/pressure. Relax this to
allow tasks running as unprivileged users with CAP_SYS_RESOURCE to be
able to write to these files.

Signed-off-by: Josh Hunt <johunt@akamai.com>
---
 kernel/sched/psi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index b1b00e9bd7ed..98ff7baf1ba8 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1270,6 +1270,9 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 	if (!nbytes)
 		return -EINVAL;
 
+	if (!capable(CAP_SYS_RESOURCE))
+		return -EPERM;
+
 	buf_size = min(nbytes, sizeof(buf));
 	if (copy_from_user(buf, user_buf, buf_size))
 		return -EFAULT;
@@ -1353,9 +1356,9 @@ static int __init psi_proc_init(void)
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

