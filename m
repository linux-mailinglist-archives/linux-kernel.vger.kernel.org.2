Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261F1396D98
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhFAGyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 02:54:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231375AbhFAGxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:53:55 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1516Xqii102524;
        Tue, 1 Jun 2021 02:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KAd3p0aOLPKhFyURvvArVG71/qkCtWBr9P0L5TsxcJs=;
 b=i1uepNeenI14RVuSXZx/l81KVtNj0VYKjsc1SRWOMTDHtKJcw+npbDnnsz+2OaH9IDXi
 ZnIlaTtU2vgS4UeX/UWB9ZSJWBZLSfRU3oYUWvRGDShgZp1W7Eq9KhirmeCuW6oP/P59
 4ip8Gs8eakjsAd0GIABYbDI1gYJWeQRntp1so7dT3hCcshVfJClxTde1qQUPNqVx8IDX
 67pFYZV+ueouIgug6rPQ1BHJa/JUkAJ86IQvm0Bj8DTNSHGvxk2QI50VY8uhSKExo48X
 43r3A8Kdv95WSkYK3gM9wTok/FDhyhJT2ErHBrhik11LqVSWDEyNE7z+z+Q2s9xJWcQI yA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38wf0xhf25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 02:52:08 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1516l4d0027627;
        Tue, 1 Jun 2021 06:52:05 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 38ucvh9f29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 06:52:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1516q2eB26607930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Jun 2021 06:52:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E06311C04A;
        Tue,  1 Jun 2021 06:52:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40F6211C05C;
        Tue,  1 Jun 2021 06:52:00 +0000 (GMT)
Received: from bharata.ibmuc.com (unknown [9.77.195.136])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Jun 2021 06:52:00 +0000 (GMT)
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, aneesh.kumar@linux.ibm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        amakhalov@vmware.com, guro@fb.com, vbabka@suse.cz,
        srikar@linux.vnet.ibm.com, psampat@linux.ibm.com,
        ego@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.ibm.com>
Subject: [RFC PATCH v0 2/3] percpu: Limit percpu allocator to online cpus
Date:   Tue,  1 Jun 2021 12:21:46 +0530
Message-Id: <20210601065147.53735-3-bharata@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210601065147.53735-1-bharata@linux.ibm.com>
References: <20210601065147.53735-1-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _0KQBx0LPWwGw3Yw9YbC-43YXcFD8z5U
X-Proofpoint-ORIG-GUID: _0KQBx0LPWwGw3Yw9YbC-43YXcFD8z5U
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_03:2021-05-31,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that percpu allocator supports growing of memory
for newly coming up CPU at hotplug time, limit the allocation,
mapping and memcg charging of memory to online CPUs.

Also change the Percpu memory reporting in /proc/meminfo
to reflect the populated pages of only online CPUs.

TODO: Address percpu memcg charging and uncharging from
CPU hotplug callback.

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 mm/percpu-vm.c | 12 ++++++------
 mm/percpu.c    | 20 +++++++++++++-------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index 3250e1c9aeaf..79ce104c963a 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -118,7 +118,7 @@ static void pcpu_free_pages(struct pcpu_chunk *chunk,
 	unsigned int cpu;
 	int i;
 
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		for (i = page_start; i < page_end; i++) {
 			struct page *page = pages[pcpu_page_idx(cpu, i)];
 
@@ -149,7 +149,7 @@ static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
 
 	gfp |= __GFP_HIGHMEM;
 
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		for (i = page_start; i < page_end; i++) {
 			struct page **pagep = &pages[pcpu_page_idx(cpu, i)];
 
@@ -164,7 +164,7 @@ static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
 	while (--i >= page_start)
 		__free_page(pages[pcpu_page_idx(cpu, i)]);
 
-	for_each_possible_cpu(tcpu) {
+	for_each_online_cpu(tcpu) {
 		if (tcpu == cpu)
 			break;
 		for (i = page_start; i < page_end; i++)
@@ -248,7 +248,7 @@ static void pcpu_unmap_pages(struct pcpu_chunk *chunk,
 	unsigned int cpu;
 	int i;
 
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		for (i = page_start; i < page_end; i++) {
 			struct page *page;
 
@@ -344,7 +344,7 @@ static int pcpu_map_pages(struct pcpu_chunk *chunk,
 	unsigned int cpu, tcpu;
 	int i, err;
 
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		err = __pcpu_map_pages(pcpu_chunk_addr(chunk, cpu, page_start),
 				       &pages[pcpu_page_idx(cpu, page_start)],
 				       page_end - page_start);
@@ -357,7 +357,7 @@ static int pcpu_map_pages(struct pcpu_chunk *chunk,
 	}
 	return 0;
 err:
-	for_each_possible_cpu(tcpu) {
+	for_each_online_cpu(tcpu) {
 		if (tcpu == cpu)
 			break;
 		__pcpu_unmap_pages(pcpu_chunk_addr(chunk, tcpu, page_start),
diff --git a/mm/percpu.c b/mm/percpu.c
index ca8ca541bede..83b6bcfcfa80 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1594,7 +1594,7 @@ static enum pcpu_chunk_type pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
 	if (!objcg)
 		return PCPU_CHUNK_ROOT;
 
-	if (obj_cgroup_charge(objcg, gfp, size * num_possible_cpus())) {
+	if (obj_cgroup_charge(objcg, gfp, size * num_online_cpus())) {
 		obj_cgroup_put(objcg);
 		return PCPU_FAIL_ALLOC;
 	}
@@ -1615,10 +1615,10 @@ static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
 
 		rcu_read_lock();
 		mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
-				size * num_possible_cpus());
+				size * num_online_cpus());
 		rcu_read_unlock();
 	} else {
-		obj_cgroup_uncharge(objcg, size * num_possible_cpus());
+		obj_cgroup_uncharge(objcg, size * num_online_cpus());
 		obj_cgroup_put(objcg);
 	}
 }
@@ -1633,11 +1633,11 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 	objcg = chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT];
 	chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = NULL;
 
-	obj_cgroup_uncharge(objcg, size * num_possible_cpus());
+	obj_cgroup_uncharge(objcg, size * num_online_cpus());
 
 	rcu_read_lock();
 	mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
-			-(size * num_possible_cpus()));
+			-(size * num_online_cpus()));
 	rcu_read_unlock();
 
 	obj_cgroup_put(objcg);
@@ -1680,6 +1680,9 @@ static void pcpu_cpuhp_deregister(struct pcpu_chunk *chunk,
 		}
 }
 
+/*
+ * TODO: Grow the memcg charge
+ */
 static void __pcpu_cpuhp_setup(enum pcpu_chunk_type type, unsigned int cpu)
 {
 	int slot;
@@ -1720,6 +1723,9 @@ static int percpu_cpuhp_setup(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * TODO: Reduce the memcg charge
+ */
 static void __pcpu_cpuhp_destroy(enum pcpu_chunk_type type, unsigned int cpu)
 {
 	int slot;
@@ -2000,7 +2006,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 		pcpu_schedule_balance_work();
 
 	/* clear the areas and return address relative to base address */
-	for_each_possible_cpu(cpu)
+	for_each_online_cpu(cpu)
 		memset((void *)pcpu_chunk_addr(chunk, cpu, 0) + off, 0, size);
 
 	ptr = __addr_to_pcpu_ptr(chunk->base_addr + off);
@@ -3372,7 +3378,7 @@ void __init setup_per_cpu_areas(void)
  */
 unsigned long pcpu_nr_pages(void)
 {
-	return pcpu_nr_populated * pcpu_nr_units;
+	return pcpu_nr_populated * num_online_cpus();
 }
 
 /*
-- 
2.31.1

