Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13333521CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhDAVnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:43:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65142 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234635AbhDAVnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:43:08 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 131LQvlB008113
        for <linux-kernel@vger.kernel.org>; Thu, 1 Apr 2021 14:43:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=cPdVRtjHCrwtHY9AKEXGme23byUr2ZAJdsE3h3TIrUI=;
 b=GKshCNpLtrzUttzgbAZOLlhLzuAy8LlWmzjT0e4tBnxC1wIQN+x66+BJWCy8SjjozpkR
 Xk5k0jBpZkFp14xg2mLjESuzHMU5x96X+l3+ZYv7kI0T8N92vbBxQdT8hEyARlhmqOGC
 F9OJ9XoSQfsvOhYj5WlJMCGxFid8VT/kVkw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 37n29negp1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 14:43:08 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 14:43:06 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 3B5AE5C2F8E5; Thu,  1 Apr 2021 14:43:04 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v1 0/5] percpu: partial chunk depopulation
Date:   Thu, 1 Apr 2021 14:42:56 -0700
Message-ID: <20210401214301.1689099-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9bckJOoSdWLHxpjiHTCSvPinYpb0mbyF
X-Proofpoint-ORIG-GUID: 9bckJOoSdWLHxpjiHTCSvPinYpb0mbyF
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_13:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103310000 definitions=main-2104010138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In our production experience the percpu memory allocator is sometimes strug=
gling
with returning the memory to the system. A typical example is a creation of
several thousands memory cgroups (each has several chunks of the percpu data
used for vmstats, vmevents, ref counters etc). Deletion and complete releas=
ing
of these cgroups doesn't always lead to a shrinkage of the percpu memory.

The underlying problem is the fragmentation: to release an underlying chunk
all percpu allocations should be released first. The percpu allocator tends
to top up chunks to improve the utilization. It means new small-ish allocat=
ions
(e.g. percpu ref counters) are placed onto almost filled old-ish chunks,
effectively pinning them in memory.

This patchset pretends to solve this problem by implementing a partial
depopulation of percpu chunks: chunks with many empty pages are being
asynchronously depopulated and the pages are returned to the system.

To illustrate the problem the following script can be used:

--
#!/bin/bash

cd /sys/fs/cgroup

mkdir percpu_test
echo "+memory" > percpu_test/cgroup.subtree_control

cat /proc/meminfo | grep Percpu

for i in `seq 1 1000`; do
    mkdir percpu_test/cg_"${i}"
    for j in `seq 1 10`; do
	mkdir percpu_test/cg_"${i}"_"${j}"
    done
done

cat /proc/meminfo | grep Percpu

for i in `seq 1 1000`; do
    for j in `seq 1 10`; do
	rmdir percpu_test/cg_"${i}"_"${j}"
    done
done

sleep 10

cat /proc/meminfo | grep Percpu

for i in `seq 1 1000`; do
    rmdir percpu_test/cg_"${i}"
done

rmdir percpu_test
--

It creates 11000 memory cgroups and removes every 10 out of 11.
It prints the initial size of the percpu memory, the size after
creating all cgroups and the size after deleting most of them.

Results:
  vanilla:
    ./percpu_test.sh
    Percpu:             7488 kB
    Percpu:           481152 kB
    Percpu:           481152 kB

  with this patchset applied:
    ./percpu_test.sh
    Percpu:             7488 kB
    Percpu:           481408 kB
    Percpu:           159488 kB

So the total size of the percpu memory was reduced by 3 times.

v2:
  - depopulation heuristics changed and optimized
  - chunks are put into a separate list, depopulation scan this list
  - chunk->isolated is introduced, chunk->depopulate is dropped
  - rearranged patches a bit
  - fixed a panic discovered by krobot
  - made pcpu_nr_empty_pop_pages per chunk type
  - minor fixes

rfc:
  https://lwn.net/Articles/850508/


Roman Gushchin (5):
  percpu: split __pcpu_balance_workfn()
  percpu: make pcpu_nr_empty_pop_pages per chunk type
  percpu: generalize pcpu_balance_populated()
  percpu: fix a comment about the chunks ordering
  percpu: implement partial chunk depopulation

 mm/percpu-internal.h |   3 +-
 mm/percpu-stats.c    |   9 +-
 mm/percpu.c          | 219 ++++++++++++++++++++++++++++++++++---------
 3 files changed, 182 insertions(+), 49 deletions(-)

--=20
2.30.2

