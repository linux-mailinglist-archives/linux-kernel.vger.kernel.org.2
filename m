Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE0642E012
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 19:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhJNRcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 13:32:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44328 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232236AbhJNRcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 13:32:33 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19EGXcNv019427;
        Thu, 14 Oct 2021 13:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=TQBkWUbYrtzJsOVdkCbGRsfXjsL5n6HsAcn9dCwyb+4=;
 b=XFx2xfLX+yTjTRWMCpya5xRTp795SekWEWZVEziGuxIBTyFU4ZGQrb7i89frkhQNW3oZ
 LJUztW73Of0F9bbf7tAmi5cejUizXNCL/C32BuzGucI1QeKHXUJ7ol528fx7qgjFJ59L
 us5OyioKXhxrXlDUScd89q/n8hFK4ueMTON3gbhTjv6GYsw7GWRbRK7n6fVAGT1J1GC6
 UJamrVcyKigsb1rBE8r0JnlYl070kd1+RUgAYzV5uypmsqukCcGwiNYjQyH4dnWB0GAH
 E4XiJ++/0nhiNgBKdNQnS7XAvCc+runziKWSV6DPzHQw5QXSuSUTVcEpjm4Sv2hVNUeM uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnnvh1j0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 13:30:26 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19EHNbO6020109;
        Thu, 14 Oct 2021 13:30:26 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnnvh1j0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 13:30:26 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19EHBgeo025984;
        Thu, 14 Oct 2021 17:30:25 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 3bk2qbw8qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 17:30:25 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19EHUOjD15467060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Oct 2021 17:30:24 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66710BE053;
        Thu, 14 Oct 2021 17:30:24 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3610EBE05B;
        Thu, 14 Oct 2021 17:30:24 +0000 (GMT)
Received: from localhost (unknown [9.211.53.229])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 14 Oct 2021 17:30:24 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, frowand.list@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] of: kobj: make of_node_is_(initialized|attached) parameters const
Date:   Thu, 14 Oct 2021 12:30:23 -0500
Message-Id: <20211014173023.2117799-1-nathanl@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TISEUv1-Z6imd1MWiDONhgh6GCr_5RgW
X-Proofpoint-ORIG-GUID: dPtRkMyEQt0wuHffTKOFgZ5RkRe8C5TR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-14_09,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=819
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110140097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_node_is_initialized() and of_node_is_attached() don't modify the node
objects passed to them, so those parameters should be const.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
 drivers/of/kobj.c       | 4 ++--
 drivers/of/of_private.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index 6675b5e56960..7d3853a5a09a 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -5,13 +5,13 @@
 #include "of_private.h"
 
 /* true when node is initialized */
-static int of_node_is_initialized(struct device_node *node)
+static int of_node_is_initialized(const struct device_node *node)
 {
 	return node && node->kobj.state_initialized;
 }
 
 /* true when node is attached (i.e. present on sysfs) */
-int of_node_is_attached(struct device_node *node)
+int of_node_is_attached(const struct device_node *node)
 {
 	return node && node->kobj.state_in_sysfs;
 }
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 75e67b8bb826..9324483397f6 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -60,7 +60,7 @@ static inline int of_property_notify(int action, struct device_node *np,
 #endif /* CONFIG_OF_DYNAMIC */
 
 #if defined(CONFIG_OF_KOBJ)
-int of_node_is_attached(struct device_node *node);
+int of_node_is_attached(const struct device_node *node);
 int __of_add_property_sysfs(struct device_node *np, struct property *pp);
 void __of_remove_property_sysfs(struct device_node *np, struct property *prop);
 void __of_update_property_sysfs(struct device_node *np, struct property *newprop,
-- 
2.31.1

