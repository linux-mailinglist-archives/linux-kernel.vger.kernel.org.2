Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0046A460A51
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 22:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240649AbhK1V2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 16:28:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64626 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235837AbhK1VZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 16:25:59 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ASLHYBV015875;
        Sun, 28 Nov 2021 21:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SFY7UEkfZXa6AvUVNmb88RfLbM34YRQBy//LuGAF7HY=;
 b=ZuLaHO7yizU9mISXh8cQ1RK8f0UcugyIWB7P8PfvpHhoh4vTjc2fZK+15q4fXx8F9lUr
 iVBTvzFdGs/UiBYkiL39PCTKlydMTBuqR9BCz3h/+fxbLuTTgXpaa8K5HHocZZV5nChF
 VT58zxBRFIX7Q081V8Zu+RrEZTPJN3Zf6pktvrul/S19zbUQ39MJOiFMeSE5/JusbmY7
 W3oS4mXadJCD9fD6aHK3X2LOYRRBifCItFr6FACynLb0tVNH5l0RSwKtYxULsVTMLCjZ
 ijIL4f0lX2XMzyar/fSn1qwJ6VefWNhJbfMVAlumMxAoHcpf2o+Wcddwhr2aXvxlL95C uA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmhj301en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 21:22:27 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ASLHxgo016511;
        Sun, 28 Nov 2021 21:22:27 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmhj301eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 21:22:27 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ASLIvjI003666;
        Sun, 28 Nov 2021 21:22:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3ckca96eh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 21:22:25 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ASLMMb056164684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Nov 2021 21:22:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE98C52050;
        Sun, 28 Nov 2021 21:22:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6938252059;
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
Subject: [PATCH 1/3] topology/sysfs: export die attributes only if an architectures has support
Date:   Sun, 28 Nov 2021 22:22:19 +0100
Message-Id: <20211128212221.1069726-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128212221.1069726-1-hca@linux.ibm.com>
References: <20211128212221.1069726-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Sod1OA_s12typjMACEIcdMFes8FMlFfv
X-Proofpoint-ORIG-GUID: LTcY36TWtP0EKNbhyNSn3jlQ52tP8zox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-28_07,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111280123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The die_id and die_cpus topology sysfs attributes have been added with
commit 0e344d8c709f ("cpu/topology: Export die_id") and commit
2e4c54dac7b3 ("topology: Create core_cpus and die_cpus sysfs attributes").

While they are currently only used and useful for x86 they are still
present with bogus default values for all architectures. Instead of
enforcing such new sysfs attributes to all architectures, make them
only optional visible if an architecture opts in by defining both the
topology_die_id and topology_die_cpumask attributes.

This is similar to what was done when the book and drawer topology
levels were introduced: avoid useless and therefore confusing sysfs
attributes for architectures which cannot make use of them.

This should not break any existing applications, since this is a
rather new interface and applications should be able to handle also
older kernel versions without such attributes - besides that they
contain only useful information for x86.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 Documentation/admin-guide/cputopology.rst | 3 +++
 drivers/base/topology.c                   | 8 ++++++++
 include/linux/topology.h                  | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
index 6b62e182baf4..c68d07533c45 100644
--- a/Documentation/admin-guide/cputopology.rst
+++ b/Documentation/admin-guide/cputopology.rst
@@ -11,6 +11,9 @@ Architecture-neutral, drivers/base/topology.c, exports these attributes.
 However, the book and drawer related sysfs files will only be created if
 CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are selected, respectively.
 
+The die hierarchy related sysfs files will only be created if an architecture
+provides the related macros as described below.
+
 CONFIG_SCHED_BOOK and CONFIG_SCHED_DRAWER are currently only used on s390,
 where they reflect the cpu and cache hierarchy.
 
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 8f2b641d0b8c..7fa5a7fbef25 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -45,8 +45,10 @@ static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
 define_id_show_func(physical_package_id);
 static DEVICE_ATTR_RO(physical_package_id);
 
+#ifndef topology_die_no_sysfs
 define_id_show_func(die_id);
 static DEVICE_ATTR_RO(die_id);
+#endif
 
 define_id_show_func(cluster_id);
 static DEVICE_ATTR_RO(cluster_id);
@@ -70,9 +72,11 @@ define_siblings_read_func(cluster_cpus, cluster_cpumask);
 static BIN_ATTR_RO(cluster_cpus, 0);
 static BIN_ATTR_RO(cluster_cpus_list, 0);
 
+#ifndef topology_die_no_sysfs
 define_siblings_read_func(die_cpus, die_cpumask);
 static BIN_ATTR_RO(die_cpus, 0);
 static BIN_ATTR_RO(die_cpus_list, 0);
+#endif
 
 define_siblings_read_func(package_cpus, core_cpumask);
 static BIN_ATTR_RO(package_cpus, 0);
@@ -103,8 +107,10 @@ static struct bin_attribute *bin_attrs[] = {
 	&bin_attr_core_siblings_list,
 	&bin_attr_cluster_cpus,
 	&bin_attr_cluster_cpus_list,
+#ifndef topology_die_no_sysfs
 	&bin_attr_die_cpus,
 	&bin_attr_die_cpus_list,
+#endif
 	&bin_attr_package_cpus,
 	&bin_attr_package_cpus_list,
 #ifdef CONFIG_SCHED_BOOK
@@ -120,7 +126,9 @@ static struct bin_attribute *bin_attrs[] = {
 
 static struct attribute *default_attrs[] = {
 	&dev_attr_physical_package_id.attr,
+#ifndef topology_die_no_sysfs
 	&dev_attr_die_id.attr,
+#endif
 	&dev_attr_cluster_id.attr,
 	&dev_attr_core_id.attr,
 #ifdef CONFIG_SCHED_BOOK
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 0b3704ad13c8..1541d210be24 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -185,6 +185,7 @@ static inline int cpu_to_mem(int cpu)
 #endif
 #ifndef topology_die_id
 #define topology_die_id(cpu)			((void)(cpu), -1)
+#define topology_die_no_sysfs			1
 #endif
 #ifndef topology_cluster_id
 #define topology_cluster_id(cpu)		((void)(cpu), -1)
@@ -203,6 +204,7 @@ static inline int cpu_to_mem(int cpu)
 #endif
 #ifndef topology_die_cpumask
 #define topology_die_cpumask(cpu)		cpumask_of(cpu)
+#define topology_die_no_sysfs			1
 #endif
 
 #if defined(CONFIG_SCHED_SMT) && !defined(cpu_smt_mask)
-- 
2.32.0

