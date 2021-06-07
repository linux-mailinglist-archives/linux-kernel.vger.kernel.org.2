Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7087839D901
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhFGJqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:46:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9640 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230173AbhFGJqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:46:22 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1579YO35102019;
        Mon, 7 Jun 2021 05:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=g+KRLlL5JYdQvfU+5LyX3c3NZQweoFiXOJnDD8K2NBQ=;
 b=jBooEC5hND9RQ8oaxwUspo9aT4L30CAm1Ht1X8m7hP52NRxYIeydhO2Id9t+9TwFuVS9
 e0UOsLW5zyPX0jIL+hYE2MFdpirFPKa6pUO8o/1Lr29QkBirV5VnN9dI0SHNxGdikFS2
 KLKuq67nNkK5gF/LYktjomj/K/lXIgD140na1UfIgaIcbgzjn85VLR3oSKpiQyx2aeJN
 K3s4lVvTBGrF4Zwep5TqaD613XvsCeV3bU8WqOZZzFUIXme3o6C6i7Tf+czDmc8WLM2o
 Mhq02t4yFhTebq1hXcrfD4zk6cLi2rlNQhvpcSr5yv/E2GwG3aSsuSBaEN72Rz4Vf9IN zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 391fju2n8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 05:44:29 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1579YkBJ103304;
        Mon, 7 Jun 2021 05:44:29 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 391fju2n7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 05:44:29 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1579hYni025659;
        Mon, 7 Jun 2021 09:44:27 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3900w88enn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 09:44:27 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1579hdFe30671342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Jun 2021 09:43:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5950A11C04C;
        Mon,  7 Jun 2021 09:44:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B77311C052;
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
Subject: [PATCH wq/for-next 1/2] workqueue: let subsystem core create the cpumask attribute
Date:   Mon,  7 Jun 2021 11:44:19 +0200
Message-Id: <20210607094420.2054403-1-jwi@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tu-VgYnG7lx_a9JWvexN9nGF6fyFiG6m
X-Proofpoint-GUID: zJdTJITeL7ZMd_s-6Y_DTrMoYkh2ZTpf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-07_07:2021-06-04,2021-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106070074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the cpumask attribute in an ATTRIBUTE_GROUPS() macro, so that
subsys_virtual_register() can add it to the dev_root device for us.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 kernel/workqueue.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 104e3ef04e33..817dc2d7438a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5625,15 +5625,15 @@ static struct device_attribute wq_sysfs_cpumask_attr =
 	__ATTR(cpumask, 0644, wq_unbound_cpumask_show,
 	       wq_unbound_cpumask_store);
 
+static struct attribute *wq_sysfs_dev_root_attrs[] = {
+	&wq_sysfs_cpumask_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(wq_sysfs_dev_root);
+
 static int __init wq_sysfs_init(void)
 {
-	int err;
-
-	err = subsys_virtual_register(&wq_subsys, NULL);
-	if (err)
-		return err;
-
-	return device_create_file(wq_subsys.dev_root, &wq_sysfs_cpumask_attr);
+	return subsys_virtual_register(&wq_subsys, wq_sysfs_dev_root_groups);
 }
 core_initcall(wq_sysfs_init);
 
-- 
2.25.1

