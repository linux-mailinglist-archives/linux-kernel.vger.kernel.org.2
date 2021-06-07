Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF80B39D902
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFGJq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:46:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8980 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbhFGJqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:46:22 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1579YCc9139542;
        Mon, 7 Jun 2021 05:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+G1ReHGJDx5qNmm+1R5bhwKuMfO71SHYJf95Mq62KV0=;
 b=HVUzTq7WFBEAPwzzAIgLQe8MYY5eGofgKB7Ljhp70e5x5JBIPZ8bhh+BkHBq89tQH2r8
 zVbQoPQ7lxoMJ109rp9TsOMhWUFbm9cXxMqOIxYOO5rbsPlX+E2w2n+dUsm+p+uVNnI7
 yPdac13YoICVC1DPdjk18HXJPG9kPPV3LZBjVlpjqAM2VuCh+TLN7gwIFsogW169TXrC
 UTxpL+ZsacAFs5KNPjRaJo06M0x4K43ViU3+3qxgMHVglu02G+Xhjv1/4x19LWYU+q0J
 SYAx5ZXN5RHVv1vIGjURbXjq1anP8EEOVHmTZuPJtmOnSM4l1TMM5wClJcwWjKpjbz7P pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 391gd4h6pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 05:44:30 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1579YGuZ139760;
        Mon, 7 Jun 2021 05:44:30 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 391gd4h6p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 05:44:30 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1579fuAl028309;
        Mon, 7 Jun 2021 09:44:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3900w88tjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 09:44:28 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1579he4p37486966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Jun 2021 09:43:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA3F711C04C;
        Mon,  7 Jun 2021 09:44:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A67BC11C064;
        Mon,  7 Jun 2021 09:44:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Jun 2021 09:44:25 +0000 (GMT)
From:   Julian Wiedmann <jwi@linux.ibm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH wq/for-next 2/2] workqueue: let device core create the WQ_UNBOUND attributes
Date:   Mon,  7 Jun 2021 11:44:20 +0200
Message-Id: <20210607094420.2054403-2-jwi@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607094420.2054403-1-jwi@linux.ibm.com>
References: <20210607094420.2054403-1-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qM_3o7b4KxrR-oZe_1o1g3yVN17DrblS
X-Proofpoint-ORIG-GUID: mxqrzJjG6MEmgBeERhxiTz1fMzwOuFbg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-07_07:2021-06-04,2021-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106070074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the attributes for a WQ_UNBOUND workqueue in ATTRIBUTE_GROUPS(),
and wire them up in dev->groups so that the device core can manage them
for us.

As device_add() will add such attributes _prior_ to raising the KOBJ_ADD
uevent, this also makes the initial uevent suppression unnecessary.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 kernel/workqueue.c | 51 ++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 817dc2d7438a..629859ac5262 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5449,6 +5449,9 @@ static ssize_t wq_pool_ids_show(struct device *dev,
 	return written;
 }
 
+static struct device_attribute wq_sysfs_unbound_attr_pool_ids =
+	__ATTR(pool_ids, 0444, wq_pool_ids_show, NULL);
+
 static ssize_t wq_nice_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
@@ -5502,6 +5505,9 @@ static ssize_t wq_nice_store(struct device *dev, struct device_attribute *attr,
 	return ret ?: count;
 }
 
+static struct device_attribute wq_sysfs_unbound_attr_nice =
+	__ATTR(nice, 0644, wq_nice_show, wq_nice_store);
+
 static ssize_t wq_cpumask_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
@@ -5539,6 +5545,9 @@ static ssize_t wq_cpumask_store(struct device *dev,
 	return ret ?: count;
 }
 
+static struct device_attribute wq_sysfs_unbound_attr_cpumask =
+	__ATTR(cpumask, 0644, wq_cpumask_show, wq_cpumask_store);
+
 static ssize_t wq_numa_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
@@ -5578,13 +5587,17 @@ static ssize_t wq_numa_store(struct device *dev, struct device_attribute *attr,
 	return ret ?: count;
 }
 
-static struct device_attribute wq_sysfs_unbound_attrs[] = {
-	__ATTR(pool_ids, 0444, wq_pool_ids_show, NULL),
-	__ATTR(nice, 0644, wq_nice_show, wq_nice_store),
-	__ATTR(cpumask, 0644, wq_cpumask_show, wq_cpumask_store),
-	__ATTR(numa, 0644, wq_numa_show, wq_numa_store),
-	__ATTR_NULL,
+static struct device_attribute wq_sysfs_unbound_attr_numa =
+	__ATTR(numa, 0644, wq_numa_show, wq_numa_store);
+
+static struct attribute *wq_sysfs_unbound_attrs[] = {
+	&wq_sysfs_unbound_attr_pool_ids.attr,
+	&wq_sysfs_unbound_attr_nice.attr,
+	&wq_sysfs_unbound_attr_cpumask.attr,
+	&wq_sysfs_unbound_attr_numa.attr,
+	NULL,
 };
+ATTRIBUTE_GROUPS(wq_sysfs_unbound);
 
 static struct bus_type wq_subsys = {
 	.name				= "workqueue",
@@ -5679,37 +5692,17 @@ int workqueue_sysfs_register(struct workqueue_struct *wq)
 	wq_dev->wq = wq;
 	wq_dev->dev.bus = &wq_subsys;
 	wq_dev->dev.release = wq_device_release;
+	if (wq->flags & WQ_UNBOUND)
+		wq_dev->dev.groups = wq_sysfs_unbound_groups;
 	dev_set_name(&wq_dev->dev, "%s", wq->name);
 
-	/*
-	 * unbound_attrs are created separately.  Suppress uevent until
-	 * everything is ready.
-	 */
-	dev_set_uevent_suppress(&wq_dev->dev, true);
-
 	ret = device_register(&wq_dev->dev);
 	if (ret) {
 		put_device(&wq_dev->dev);
 		wq->wq_dev = NULL;
-		return ret;
-	}
-
-	if (wq->flags & WQ_UNBOUND) {
-		struct device_attribute *attr;
-
-		for (attr = wq_sysfs_unbound_attrs; attr->attr.name; attr++) {
-			ret = device_create_file(&wq_dev->dev, attr);
-			if (ret) {
-				device_unregister(&wq_dev->dev);
-				wq->wq_dev = NULL;
-				return ret;
-			}
-		}
 	}
 
-	dev_set_uevent_suppress(&wq_dev->dev, false);
-	kobject_uevent(&wq_dev->dev.kobj, KOBJ_ADD);
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.25.1

