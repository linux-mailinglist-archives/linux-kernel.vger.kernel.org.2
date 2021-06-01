Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300FE396D95
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhFAGx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 02:53:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40712 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229984AbhFAGxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:53:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1516irYN168573;
        Tue, 1 Jun 2021 02:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=NXsqMNBoC98BPGnpHRevq3Lw1e0YfOJOcwNnQISgXPc=;
 b=DW+u5irG2ITYH95DkrPvceVT4AzKkT1Q1q1z7WQH0fMMytP3sC4qQdnyJlCyggw55rzv
 jwq4L3M+A/cTh4xppN+K/ylpkWRNmdsGvJvQrtbYmmoQ4tk8l2NUOXbPijNuz/bBq0XE
 fkkcWOqfdrVURXuhPjQv28qAr2kMbELHUccqmRgNHuWedX529ZPA8iEWiiSDgjSKnsC3
 x8Y3ZW2dj2dFgQKOQC3ltxyW/dCSgPUyPOk8kLJnxWR/5Q8lJwe5qSpIcM/Wi1cqz1+L
 mSXAHWCAptQuZoQW+y9Cjfqf9HjK8zTg/l6cf/mbJN0Yet6znlo1DlgXnFvmAwFbjw1Z bw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38wfw8r51e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 02:52:02 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1516l4Sj020323;
        Tue, 1 Jun 2021 06:52:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 38ud889f40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 06:51:59 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1516pvwh18284922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Jun 2021 06:51:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10D7E11C052;
        Tue,  1 Jun 2021 06:51:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A494F11C04A;
        Tue,  1 Jun 2021 06:51:54 +0000 (GMT)
Received: from bharata.ibmuc.com (unknown [9.77.195.136])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Jun 2021 06:51:54 +0000 (GMT)
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, aneesh.kumar@linux.ibm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        amakhalov@vmware.com, guro@fb.com, vbabka@suse.cz,
        srikar@linux.vnet.ibm.com, psampat@linux.ibm.com,
        ego@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.ibm.com>
Subject: [RFC PATCH v0 0/3] CPU hotplug awareness in percpu allocator
Date:   Tue,  1 Jun 2021 12:21:44 +0530
Message-Id: <20210601065147.53735-1-bharata@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1nuTsGCkU2yfKAHJ1afVLZpl4yivEbPH
X-Proofpoint-GUID: 1nuTsGCkU2yfKAHJ1afVLZpl4yivEbPH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_03:2021-05-31,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 clxscore=1011 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106010045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an attempt to make the percpu allocator CPU hotplug aware.
Currently the percpu allocator allocates memory for all the possible
CPUs. This can lead to wastage of memory when possible number of CPUs
is significantly higher than the number of online CPUs. This can be
avoided if the percpu allocator were to allocate only for the online
CPUs and extend the allocation for other CPUs as and when they become
online. 

This early RFC work shows some good memory savings for a powerpc
KVM guest that is booted with 16 online and 1024 possible CPUs.
Here is the comparision of Percpu memory consumption from
/proc/meminfo before and after creating 1000 memcgs.

			W/o patch		W/ patch
Before			1441792 kB		22528 kB
After 1000 memcgs	4390912 kB		68608 kB

Note that the Percpu reporting in meminfo has been changed in
the patchset to reflect the allocation for online CPUs only.

More details about the approach are present in the patch
descriptions.

Bharata B Rao (3):
  percpu: CPU hotplug support for alloc_percpu()
  percpu: Limit percpu allocator to online cpus
  percpu: Avoid using percpu ptrs of non-existing cpus

 fs/namespace.c             |   4 +-
 include/linux/cpuhotplug.h |   2 +
 include/linux/percpu.h     |  15 +++
 kernel/cgroup/rstat.c      |  20 +++-
 kernel/sched/cpuacct.c     |  10 +-
 kernel/sched/psi.c         |  14 ++-
 lib/percpu-refcount.c      |   4 +-
 lib/percpu_counter.c       |   2 +-
 mm/percpu-internal.h       |   9 ++
 mm/percpu-vm.c             | 211 +++++++++++++++++++++++++++++++++-
 mm/percpu.c                | 229 +++++++++++++++++++++++++++++++++++--
 net/ipv4/fib_semantics.c   |   2 +-
 net/ipv6/route.c           |   6 +-
 13 files changed, 490 insertions(+), 38 deletions(-)

-- 
2.31.1

