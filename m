Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C164637A833
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 15:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhEKNz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 09:55:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44100 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbhEKNzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 09:55:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14BDj4gn147896;
        Tue, 11 May 2021 13:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=jDeQisHV5eJ4djdXX1wmkmp8ulHDhbp0k1CxqmYYk78=;
 b=cNizvRr4NInK6ZRQpGSItahz75bO67G/h1cVuK2m/PO1R6cWvkeUaKRQEsFKgXpNOqk9
 4gjqnb5DT5wbIHUlLGVfKAz1vSK47ZR8V9cliAc1HYGDSWIVfn/9D5mxRL0nSnRlU7Jp
 sbNsBwLwN7LWQxixAECSlU4DCYjpEdaHBxbkZfFIPXAWLwAAgdZiqfNNZkdRNtgQr3XJ
 ZI0yX/xm71DStAGBFdeA1O29nrvD40Trn4Kb8xcjZtFCXRQLS4Y8y88EYZrH9wwe8RIQ
 XyhGdq5dQd0U70cxBk2tCGT/HJnOGzAhqfGs7FVVGQTZeNsbN7IO6PGL+I4J8GEYa9A/ fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38dk9nernp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 13:54:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14BDpbNb018275;
        Tue, 11 May 2021 13:53:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38dfrxa3mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 13:53:59 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14BDrxQC028423;
        Tue, 11 May 2021 13:53:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 38dfrxa3ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 13:53:59 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14BDrw1Y004638;
        Tue, 11 May 2021 13:53:58 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 May 2021 06:53:57 -0700
Date:   Tue, 11 May 2021 16:53:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Fasheh <mark@fasheh.com>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gang He <ghe@suse.com>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] ocfs2: fix snprintf() checking
Message-ID: <20210511135350.GV1955@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd7ddc22-11c4-3e88-120a-d68f153f573d@linux.alibaba.com>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: efFoIHRT_ml8Agg4yGbMP-uJov8FiyN_
X-Proofpoint-GUID: efFoIHRT_ml8Agg4yGbMP-uJov8FiyN_
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The snprintf() function returns the number of bytes which would have
been printed if the buffer was large enough.  In other words it can
return ">= remain" but this code assumes it returns "== remain".

The run time impact of this bug is not very severe.  The next iteration
through the loop would trigger a WARN() when we pass a negative limit
to snprintf().  We would then return success instead of -E2BIG.

The kernel implementation of snprintf() will never return negatives so
there is no need to check and I have deleted that dead code.

Fixes: a860f6eb4c6a ("ocfs2: sysfile interfaces for online file check")
Fixes: 74ae4e104dfc ("ocfs2: Create stack glue sysfs files.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
v2: update the Fixes tag, add Joseph's R-b tag.

 fs/ocfs2/filecheck.c | 6 +-----
 fs/ocfs2/stackglue.c | 8 ++------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/ocfs2/filecheck.c b/fs/ocfs2/filecheck.c
index 90b8d300c1ee..de56e6231af8 100644
--- a/fs/ocfs2/filecheck.c
+++ b/fs/ocfs2/filecheck.c
@@ -326,11 +326,7 @@ static ssize_t ocfs2_filecheck_attr_show(struct kobject *kobj,
 		ret = snprintf(buf + total, remain, "%lu\t\t%u\t%s\n",
 			       p->fe_ino, p->fe_done,
 			       ocfs2_filecheck_error(p->fe_status));
-		if (ret < 0) {
-			total = ret;
-			break;
-		}
-		if (ret == remain) {
+		if (ret >= remain) {
 			/* snprintf() didn't fit */
 			total = -E2BIG;
 			break;
diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
index d50e8b8dfea4..16f1bfc407f2 100644
--- a/fs/ocfs2/stackglue.c
+++ b/fs/ocfs2/stackglue.c
@@ -500,11 +500,7 @@ static ssize_t ocfs2_loaded_cluster_plugins_show(struct kobject *kobj,
 	list_for_each_entry(p, &ocfs2_stack_list, sp_list) {
 		ret = snprintf(buf, remain, "%s\n",
 			       p->sp_name);
-		if (ret < 0) {
-			total = ret;
-			break;
-		}
-		if (ret == remain) {
+		if (ret >= remain) {
 			/* snprintf() didn't fit */
 			total = -E2BIG;
 			break;
@@ -531,7 +527,7 @@ static ssize_t ocfs2_active_cluster_plugin_show(struct kobject *kobj,
 	if (active_stack) {
 		ret = snprintf(buf, PAGE_SIZE, "%s\n",
 			       active_stack->sp_name);
-		if (ret == PAGE_SIZE)
+		if (ret >= PAGE_SIZE)
 			ret = -E2BIG;
 	}
 	spin_unlock(&ocfs2_stack_lock);
-- 
2.30.2
