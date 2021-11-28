Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5EE460A50
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 22:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbhK1V2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 16:28:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234974AbhK1VZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 16:25:59 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ASKpYuv003038;
        Sun, 28 Nov 2021 21:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UtOrUR9TBt31Bu1Z+hVrSYj4KiWA/A3WM0DvhSeYwy4=;
 b=cM0Uf9MW9drZDEzzUm0Y4M3p9fqzPE0zcIpQUs4+oYCRKQ8f9HyqC7dLIYVLElFVATTB
 aTu53bLs4H01fTUgX0Nt89QZVxPclp8B+U40O/UIksKjCtGeddv8t9OQXHRzyiyLqdn1
 3W5yrAabEnsHPH61DGn9SzN+3n5NqrI4UUg0FYJgpWIoUdPdRhtA8s9Mozznbndanxaa
 3UfdWd+iR4JpUrus5uz0esyMtkX0YnYGmIEOTxxJP85ku8FD+rt15X6pTz0E/illhjbz
 BHMrfbCmFebT43rtA9m8CH3czaKe9Gck/N+66YY5Qo8V9qc/BNXLH7MIDF0B9vJftBNF Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmh61ra9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 21:22:28 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ASLKM2P016982;
        Sun, 28 Nov 2021 21:22:28 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmh61ra8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 21:22:28 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ASLICPG026667;
        Sun, 28 Nov 2021 21:22:26 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3ckca8xdmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 21:22:25 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ASLMNZ229164000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Nov 2021 21:22:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46C875204F;
        Sun, 28 Nov 2021 21:22:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0177C52050;
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
Subject: [PATCH 3/3] topology/sysfs: rework book and drawer topology ifdefery
Date:   Sun, 28 Nov 2021 22:22:21 +0100
Message-Id: <20211128212221.1069726-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128212221.1069726-1-hca@linux.ibm.com>
References: <20211128212221.1069726-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tBln7zmv4ElTNBrl6tSwrhPqpqGToRTX
X-Proofpoint-ORIG-GUID: OEo6eUd0IuDRv-BOXNVcC6bU371UtZc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-28_07,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111280123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide default defines for the topology_book_[id|cpumask] and
topology_drawer_[id|cpumask] macros just like for each other topology
level.
This way all topology levels are handled in a similar way. Still the
the book and drawer levels are only used on s390, and also the sysfs
attributes are only created on s390. However other architectures may
opt in if wanted.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 Documentation/admin-guide/cputopology.rst | 36 ++++++++++-------------
 drivers/base/topology.c                   | 12 ++++----
 include/linux/topology.h                  | 16 ++++++++++
 3 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
index ad2238b41439..677ba1c2c820 100644
--- a/Documentation/admin-guide/cputopology.rst
+++ b/Documentation/admin-guide/cputopology.rst
@@ -8,14 +8,9 @@ to /proc/cpuinfo output of some architectures. They reside in
 Documentation/ABI/stable/sysfs-devices-system-cpu.
 
 Architecture-neutral, drivers/base/topology.c, exports these attributes.
-However, the book and drawer related sysfs files will only be created if
-CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are selected, respectively.
-
-The die and cluster hierarchy related sysfs files will only be created if an
-architecture provides the related macros as described below.
-
-CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are currently only used on s390,
-where they reflect the cpu and cache hierarchy.
+However the die, cluster, book, and drawer hierarchy related sysfs files will
+only be created if an architecture provides the related macros as described
+below.
 
 For an architecture to support this feature, it must define some of
 these macros in include/asm-XXX/topology.h::
@@ -42,19 +37,18 @@ To be consistent on all architectures, include/linux/topology.h
 provides default definitions for any of the above macros that are
 not defined by include/asm-XXX/topology.h:
 
-1) topology_physical_package_id: -1
-2) topology_die_id: -1
-3) topology_cluster_id: -1
-4) topology_core_id: 0
-5) topology_sibling_cpumask: just the given CPU
-6) topology_core_cpumask: just the given CPU
-7) topology_cluster_cpumask: just the given CPU
-8) topology_die_cpumask: just the given CPU
-
-For architectures that don't support books (CONFIG_SCHED_BOOK) there are no
-default definitions for topology_book_id() and topology_book_cpumask().
-For architectures that don't support drawers (CONFIG_SCHED_DRAWER) there are
-no default definitions for topology_drawer_id() and topology_drawer_cpumask().
+ 1) topology_physical_package_id: -1
+ 2) topology_die_id: -1
+ 3) topology_cluster_id: -1
+ 4) topology_core_id: 0
+ 5) topology_book_id: -1
+ 6) topology_drawer_id: -1
+ 7) topology_sibling_cpumask: just the given CPU
+ 8) topology_core_cpumask: just the given CPU
+ 9) topology_cluster_cpumask: just the given CPU
+10) topology_die_cpumask: just the given CPU
+11) topology_book_cpumask:  just the given CPU
+12) topology_drawer_cpumask: just the given CPU
 
 Additionally, CPU topology information is provided under
 /sys/devices/system/cpu and includes these files.  The internal
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 1a288eac2c44..a942fadd3c5b 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -86,7 +86,7 @@ define_siblings_read_func(package_cpus, core_cpumask);
 static BIN_ATTR_RO(package_cpus, 0);
 static BIN_ATTR_RO(package_cpus_list, 0);
 
-#ifdef CONFIG_SCHED_BOOK
+#ifndef topology_book_no_sysfs
 define_id_show_func(book_id);
 static DEVICE_ATTR_RO(book_id);
 define_siblings_read_func(book_siblings, book_cpumask);
@@ -94,7 +94,7 @@ static BIN_ATTR_RO(book_siblings, 0);
 static BIN_ATTR_RO(book_siblings_list, 0);
 #endif
 
-#ifdef CONFIG_SCHED_DRAWER
+#ifndef topology_drawer_no_sysfs
 define_id_show_func(drawer_id);
 static DEVICE_ATTR_RO(drawer_id);
 define_siblings_read_func(drawer_siblings, drawer_cpumask);
@@ -119,11 +119,11 @@ static struct bin_attribute *bin_attrs[] = {
 #endif
 	&bin_attr_package_cpus,
 	&bin_attr_package_cpus_list,
-#ifdef CONFIG_SCHED_BOOK
+#ifndef topology_book_no_sysfs
 	&bin_attr_book_siblings,
 	&bin_attr_book_siblings_list,
 #endif
-#ifdef CONFIG_SCHED_DRAWER
+#ifndef topology_drawer_no_sysfs
 	&bin_attr_drawer_siblings,
 	&bin_attr_drawer_siblings_list,
 #endif
@@ -139,10 +139,10 @@ static struct attribute *default_attrs[] = {
 	&dev_attr_cluster_id.attr,
 #endif
 	&dev_attr_core_id.attr,
-#ifdef CONFIG_SCHED_BOOK
+#ifndef topology_book_no_sysfs
 	&dev_attr_book_id.attr,
 #endif
-#ifdef CONFIG_SCHED_DRAWER
+#ifndef topology_drawer_no_sysfs
 	&dev_attr_drawer_id.attr,
 #endif
 	NULL
diff --git a/include/linux/topology.h b/include/linux/topology.h
index cf57413f7c28..20c1a41c1670 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -194,6 +194,14 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_core_id
 #define topology_core_id(cpu)			((void)(cpu), 0)
 #endif
+#ifndef topology_book_id
+#define topology_book_id(cpu)			((void)(cpu), -1)
+#define topology_book_no_sysfs			1
+#endif
+#ifndef topology_drawer_id
+#define topology_drawer_id(cpu)			((void)(cpu), -1)
+#define topology_drawer_no_sysfs		1
+#endif
 #ifndef topology_sibling_cpumask
 #define topology_sibling_cpumask(cpu)		cpumask_of(cpu)
 #endif
@@ -208,6 +216,14 @@ static inline int cpu_to_mem(int cpu)
 #define topology_die_cpumask(cpu)		cpumask_of(cpu)
 #define topology_die_no_sysfs			1
 #endif
+#ifndef topology_book_cpumask
+#define topology_book_cpumask(cpu)		cpumask_of(cpu)
+#define topology_book_no_sysfs			1
+#endif
+#ifndef topology_drawer_cpumask
+#define topology_drawer_cpumask(cpu)		cpumask_of(cpu)
+#define topology_drawer_no_sysfs		1
+#endif
 
 #if defined(CONFIG_SCHED_SMT) && !defined(cpu_smt_mask)
 static inline const struct cpumask *cpu_smt_mask(int cpu)
-- 
2.32.0

