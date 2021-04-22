Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62564367D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbhDVJRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:17:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53422 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbhDVJRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:17:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13M9F7p5031432;
        Thu, 22 Apr 2021 09:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=D/UxE1J0KwRNGKLRTnqyWyQysEO9MzOtstRUB6POFxI=;
 b=DKoET6OTkZlGPSVHKqJ+4JCCag3tka3Wyu04x14Lhjyq0+TYTfcIp1P5wjPGXOKruHWC
 9miuMzJIx2S7EnFF7RS1+HmyCQKSJmNnYKOXNYMIiejsXCcn+hyCn9Y+8zeKhJXa5jeV
 rAHf+5xHsfoohwVKN8djcua1hIbDVIbv8rfqgG8ldhdk5qAwJKglmTj4BlIe3iTePq8Q
 BDoBO3zmsIJBsGRDHTrQKqf7MQhVsyCLufEVe0Eej8GOJjef01MlOvAf4lObC1TCuePN
 iB3+KFhvlAM0ZZllhaQDVKnGunwOrPE0fl7Epddfxti8VMkyL7t0WYvlBvfib/GkFJ2c PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37yqmnmsq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 09:16:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13M9GEBu101531;
        Thu, 22 Apr 2021 09:16:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3809k36v07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 09:16:55 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13M9GtER106543;
        Thu, 22 Apr 2021 09:16:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3809k36uys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 09:16:55 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13M9GrlB006626;
        Thu, 22 Apr 2021 09:16:53 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Apr 2021 09:16:52 +0000
Date:   Thu, 22 Apr 2021 12:16:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Stefani Seibold <stefani@seibold.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] kfifo: fix ternary sign extension bugs
Message-ID: <YIE+/cK1tBzSuQPU@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: GWdabAS1ETM8ZGVTShNYtPnjvcPT4c_Q
X-Proofpoint-GUID: GWdabAS1ETM8ZGVTShNYtPnjvcPT4c_Q
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9961 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220078
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intent with this code was to return negative error codes but instead
it returns positives.

The problem is how type promotion works with ternary operations.  These
functions return long, "ret" is an int and "copied" is a u32.  The
negative error code is first cast to u32 so it becomes a high positive
and then cast to long where it's still a positive.

We could fix this by declaring "ret" as a ssize_t but let's just get
rid of the ternaries instead.

Fixes: 5bf2b19320ec ("kfifo: add example files to the kernel sample directory")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 samples/kfifo/bytestream-example.c | 8 ++++++--
 samples/kfifo/inttype-example.c    | 8 ++++++--
 samples/kfifo/record-example.c     | 8 ++++++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/samples/kfifo/bytestream-example.c b/samples/kfifo/bytestream-example.c
index c406f03ee551..5a90aa527877 100644
--- a/samples/kfifo/bytestream-example.c
+++ b/samples/kfifo/bytestream-example.c
@@ -122,8 +122,10 @@ static ssize_t fifo_write(struct file *file, const char __user *buf,
 	ret = kfifo_from_user(&test, buf, count, &copied);
 
 	mutex_unlock(&write_lock);
+	if (ret)
+		return ret;
 
-	return ret ? ret : copied;
+	return copied;
 }
 
 static ssize_t fifo_read(struct file *file, char __user *buf,
@@ -138,8 +140,10 @@ static ssize_t fifo_read(struct file *file, char __user *buf,
 	ret = kfifo_to_user(&test, buf, count, &copied);
 
 	mutex_unlock(&read_lock);
+	if (ret)
+		return ret;
 
-	return ret ? ret : copied;
+	return copied;
 }
 
 static const struct proc_ops fifo_proc_ops = {
diff --git a/samples/kfifo/inttype-example.c b/samples/kfifo/inttype-example.c
index 78977fc4a23f..e5403d8c971a 100644
--- a/samples/kfifo/inttype-example.c
+++ b/samples/kfifo/inttype-example.c
@@ -115,8 +115,10 @@ static ssize_t fifo_write(struct file *file, const char __user *buf,
 	ret = kfifo_from_user(&test, buf, count, &copied);
 
 	mutex_unlock(&write_lock);
+	if (ret)
+		return ret;
 
-	return ret ? ret : copied;
+	return copied;
 }
 
 static ssize_t fifo_read(struct file *file, char __user *buf,
@@ -131,8 +133,10 @@ static ssize_t fifo_read(struct file *file, char __user *buf,
 	ret = kfifo_to_user(&test, buf, count, &copied);
 
 	mutex_unlock(&read_lock);
+	if (ret)
+		return ret;
 
-	return ret ? ret : copied;
+	return copied;
 }
 
 static const struct proc_ops fifo_proc_ops = {
diff --git a/samples/kfifo/record-example.c b/samples/kfifo/record-example.c
index c507998a2617..f64f3d62d6c2 100644
--- a/samples/kfifo/record-example.c
+++ b/samples/kfifo/record-example.c
@@ -129,8 +129,10 @@ static ssize_t fifo_write(struct file *file, const char __user *buf,
 	ret = kfifo_from_user(&test, buf, count, &copied);
 
 	mutex_unlock(&write_lock);
+	if (ret)
+		return ret;
 
-	return ret ? ret : copied;
+	return copied;
 }
 
 static ssize_t fifo_read(struct file *file, char __user *buf,
@@ -145,8 +147,10 @@ static ssize_t fifo_read(struct file *file, char __user *buf,
 	ret = kfifo_to_user(&test, buf, count, &copied);
 
 	mutex_unlock(&read_lock);
+	if (ret)
+		return ret;
 
-	return ret ? ret : copied;
+	return copied;
 }
 
 static const struct proc_ops fifo_proc_ops = {
-- 
2.30.2

