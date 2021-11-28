Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3AF460A4F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 22:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbhK1V17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 16:27:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233546AbhK1VZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 16:25:58 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ASLGqb1000753;
        Sun, 28 Nov 2021 21:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qpo+Ahc/fno2pLtBdz32KH7YrnbZnFfsZVIvCAdiUQg=;
 b=QE5qIj7/ujyAt1wEIb4m/o076Hi2z2kKCqLBEPxUXcF1MGGkFtyQqchAZgdp+7/LMp+E
 O55vavZrlNYXGHnonjUq6nqRzpiBc6+EVd6Ls8oDTptT/+00w7FClLw1cl+tIRgNdYnm
 hlW6BpKTmY/2pV4VUJhRihHjFyEYa7LnUbkIgrJTmLrtYS6t8TD0BV4cAbA4cQQfsE+b
 Yg8+KIfg/iccD7ZMCMh4bz0Xyc0cpwzkJ0AQwC6ZSu71So6k8pbJONUbeBSN6GRgoJg5
 srpOM0o5W/wu8qLi7Dx0w9sODhCW5Kr3o+vRTRFF6aC7NF+GzK4ij0G/CxeWlqrr2wEU mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmhhxg1en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 21:22:28 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ASLLI9e011660;
        Sun, 28 Nov 2021 21:22:27 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmhhxg1e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 21:22:27 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ASLIecs029733;
        Sun, 28 Nov 2021 21:22:25 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3ckca8xunf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 21:22:25 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ASLMNlG29491624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Nov 2021 21:22:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00B9A5204F;
        Sun, 28 Nov 2021 21:22:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AF40952051;
        Sun, 28 Nov 2021 21:22:22 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <len.brown@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 2/3] topology/sysfs: export cluster attributes only if an architectures has support
Date:   Sun, 28 Nov 2021 22:22:20 +0100
Message-Id: <20211128212221.1069726-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128212221.1069726-1-hca@linux.ibm.com>
References: <20211128212221.1069726-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IOV052scKb6Ethajn_8MSCZLW3NUv-1p
X-Proofpoint-ORIG-GUID: ahiyP_yEPp51i9Avq-2JYpqf6oeHNU0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-28_07,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111280123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cluster_id and cluster_cpus topology sysfs attributes have been
added with c5e22feffdd7 ("topology: Represent clusters of CPUs within
a die").

They are currently only used for x86, arm64, and riscv (via generic
arch topology), however they are still present with bogus default
values for all other architectures. Instead of enforcing such new
sysfs attributes to all architectures, make them only optional visible
if an architecture opts in by defining both the topology_cluster_id
and topology_cluster_cpumask attributes.

This is similar to what was done when the book and drawer topology
levels were introduced: avoid useless and therefore confusing sysfs
attributes for architectures which cannot make use of them.

This should not break any existing applications, since this is a
new interface introduced with the v5.16 merge window.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 Documentation/admin-guide/cputopology.rst | 4 ++--
 drivers/base/topology.c                   | 8 ++++++++
 include/linux/topology.h                  | 2 ++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
index c68d07533c45..ad2238b41439 100644
--- a/Documentation/admin-guide/cputopology.rst
+++ b/Documentation/admin-guide/cputopology.rst
@@ -11,8 +11,8 @@ Architecture-neutral, drivers/base/topology.c, exports these attributes.
 However, the book and drawer related sysfs files will only be created if
 CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are selected, respectively.
 
-The die hierarchy related sysfs files will only be created if an architecture
-provides the related macros as described below.
+The die and cluster hierarchy related sysfs files will only be created if an
+architecture provides the related macros as described below.
 
 CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are currently only used on s390,
 where they reflect the cpu and cache hierarchy.
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 7fa5a7fbef25..1a288eac2c44 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -50,8 +50,10 @@ define_id_show_func(die_id);
 static DEVICE_ATTR_RO(die_id);
 #endif
 
+#ifndef topology_cluster_no_sysfs
 define_id_show_func(cluster_id);
 static DEVICE_ATTR_RO(cluster_id);
+#endif
 
 define_id_show_func(core_id);
 static DEVICE_ATTR_RO(core_id);
@@ -68,9 +70,11 @@ define_siblings_read_func(core_siblings, core_cpumask);
 static BIN_ATTR_RO(core_siblings, 0);
 static BIN_ATTR_RO(core_siblings_list, 0);
 
+#ifndef topology_cluster_no_sysfs
 define_siblings_read_func(cluster_cpus, cluster_cpumask);
 static BIN_ATTR_RO(cluster_cpus, 0);
 static BIN_ATTR_RO(cluster_cpus_list, 0);
+#endif
 
 #ifndef topology_die_no_sysfs
 define_siblings_read_func(die_cpus, die_cpumask);
@@ -105,8 +109,10 @@ static struct bin_attribute *bin_attrs[] = {
 	&bin_attr_thread_siblings_list,
 	&bin_attr_core_siblings,
 	&bin_attr_core_siblings_list,
+#ifndef topology_cluster_no_sysfs
 	&bin_attr_cluster_cpus,
 	&bin_attr_cluster_cpus_list,
+#endif
 #ifndef topology_die_no_sysfs
 	&bin_attr_die_cpus,
 	&bin_attr_die_cpus_list,
@@ -129,7 +135,9 @@ static struct attribute *default_attrs[] = {
 #ifndef topology_die_no_sysfs
 	&dev_attr_die_id.attr,
 #endif
+#ifndef topology_cluster_no_sysfs
 	&dev_attr_cluster_id.attr,
+#endif
 	&dev_attr_core_id.attr,
 #ifdef CONFIG_SCHED_BOOK
 	&dev_attr_book_id.attr,
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 1541d210be24..cf57413f7c28 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -189,6 +189,7 @@ static inline int cpu_to_mem(int cpu)
 #endif
 #ifndef topology_cluster_id
 #define topology_cluster_id(cpu)		((void)(cpu), -1)
+#define topology_cluster_no_sysfs		1
 #endif
 #ifndef topology_core_id
 #define topology_core_id(cpu)			((void)(cpu), 0)
@@ -201,6 +202,7 @@ static inline int cpu_to_mem(int cpu)
 #endif
 #ifndef topology_cluster_cpumask
 #define topology_cluster_cpumask(cpu)		cpumask_of(cpu)
+#define topology_cluster_no_sysfs		1
 #endif
 #ifndef topology_die_cpumask
 #define topology_die_cpumask(cpu)		cpumask_of(cpu)
-- 
2.32.0

