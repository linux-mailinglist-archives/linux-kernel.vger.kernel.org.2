Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9C6342034
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhCSOyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:54:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57932 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhCSOxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:53:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JEZZt3123864;
        Fri, 19 Mar 2021 14:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=BWXto+UUvr3DdgDjFvv39n0TvZFBcOJ4PNd9Bj9/zpE=;
 b=M32wRX1Ri44Oq4GFGs5mLOhdc4FNIoeHR3pDXA/QazweGOvoJWAR1N1Qd6FA4R6ggNRu
 7XODqNG8BeBK+rPi8qSVOGsoOGnwBs9JcRBI5HyHs9nTPpFUREiYAp9r7c5C9hngeixK
 4hiqSBiejWREwG7Tir8vFSWBg24gR94sGtkKjS59RTULhVWIPKq3aLfDLL5R3qL0L8dY
 DxjM4w3ASOIZB3s1PiInXd41tB8vgUWBUuuVgMLd14FFXnSy6i8Y5oiE6zhaRrpX64lo
 D4vQQdixup3hrWuQ0gCAVj6fNeHZ/vXzriYcezOM9jk7qvofNf68kQVMF/EaGsHBZYXR 5w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 378nbmka4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 14:53:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JEZhLP174294;
        Fri, 19 Mar 2021 14:53:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 37cf2bv6qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 14:53:41 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 12JErde7014309;
        Fri, 19 Mar 2021 14:53:39 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Mar 2021 14:53:38 +0000
Date:   Fri, 19 Mar 2021 17:53:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     Hyunchul Lee <hyc.lee@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Fredrik Ternerot <fredrikt@axis.com>,
        Marios Makassikis <mmakassikis@freebox.fr>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] cifsd: fix error handling in ksmbd_server_init()
Message-ID: <YFS66J9CjCQYR0xi@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190106
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error handling in ksmbd_server_init() uses "one function to free
everything style" which is impossible to audit and leads to several
canonical bugs.  When we free something that wasn't allocated it may be
uninitialized, an error pointer, freed in a different function or we
try freeing "foo->bar" when "foo" is a NULL pointer.  And since the
code is impossible to audit then it leads to memory leaks.

In the ksmbd_server_init() function, every goto will lead to a crash
because we have not allocated the work queue but we call
ksmbd_workqueue_destroy() which tries to flush a NULL work queue.
Another bug is if ksmbd_init_buffer_pools() fails then it leads to a
double free because we free "work_cache" twice.  A third type of bug is
that we forgot to call ksmbd_release_inode_hash() so that is a resource
leak.

A better way to write error handling is for every function to clean up
after itself and never leave things partially allocated.  Then we can
use "free the last successfully allocated resource" style.  That way
when someone is reading the code they can just track the last resource
in their head and verify that the goto matches what they expect.

In this patch I modified ksmbd_ipc_init() to clean up after itself and
then I converted ksmbd_server_init() to use gotos to clean up.

Fixes: cabcebc31de4 ("cifsd: introduce SMB3 kernel server")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/cifsd/server.c        | 33 +++++++++++++++++++++++----------
 fs/cifsd/transport_ipc.c | 14 +++++++++++---
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/fs/cifsd/server.c b/fs/cifsd/server.c
index b9e114f8a5d2..aea7b6788cac 100644
--- a/fs/cifsd/server.c
+++ b/fs/cifsd/server.c
@@ -569,39 +569,52 @@ static int __init ksmbd_server_init(void)
 
 	ret = server_conf_init();
 	if (ret)
-		return ret;
+		goto err_unregister;
 
 	ret = ksmbd_init_buffer_pools();
 	if (ret)
-		return ret;
+		goto err_unregister;
 
 	ret = ksmbd_init_session_table();
 	if (ret)
-		goto error;
+		goto err_destroy_pools;
 
 	ret = ksmbd_ipc_init();
 	if (ret)
-		goto error;
+		goto err_free_session_table;
 
 	ret = ksmbd_init_global_file_table();
 	if (ret)
-		goto error;
+		goto err_ipc_release;
 
 	ret = ksmbd_inode_hash_init();
 	if (ret)
-		goto error;
+		goto err_destroy_file_table;
 
 	ret = ksmbd_crypto_create();
 	if (ret)
-		goto error;
+		goto err_release_inode_hash;
 
 	ret = ksmbd_workqueue_init();
 	if (ret)
-		goto error;
+		goto err_crypto_destroy;
 	return 0;
 
-error:
-	ksmbd_server_shutdown();
+err_crypto_destroy:
+	ksmbd_crypto_destroy();
+err_release_inode_hash:
+	ksmbd_release_inode_hash();
+err_destroy_file_table:
+	ksmbd_free_global_file_table();
+err_ipc_release:
+	ksmbd_ipc_release();
+err_free_session_table:
+	ksmbd_free_session_table();
+err_destroy_pools:
+	ksmbd_destroy_buffer_pools();
+err_unregister:
+	class_unregister(&ksmbd_control_class);
+
 	return ret;
 }
 
diff --git a/fs/cifsd/transport_ipc.c b/fs/cifsd/transport_ipc.c
index b91fa265f85d..d2432f656635 100644
--- a/fs/cifsd/transport_ipc.c
+++ b/fs/cifsd/transport_ipc.c
@@ -890,11 +890,19 @@ int ksmbd_ipc_init(void)
 	if (ret) {
 		ksmbd_err("Failed to register KSMBD netlink interface %d\n",
 				ret);
-		return ret;
+		goto cancel_work;
 	}
 
 	ida = ksmbd_ida_alloc();
-	if (!ida)
-		return -ENOMEM;
+	if (!ida) {
+		ret = -ENOMEM;
+		goto unregister;
+	}
 	return 0;
+
+unregister:
+	genl_unregister_family(&ksmbd_genl_family);
+cancel_work:
+	cancel_delayed_work_sync(&ipc_timer_work);
+	return ret;
 }
-- 
2.30.2

