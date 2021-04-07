Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5491235743A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355239AbhDGS0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:26:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2048 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1348515AbhDGS0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:26:45 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 137IIVCC007432
        for <linux-kernel@vger.kernel.org>; Wed, 7 Apr 2021 11:26:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=oMW5JogOXep/VirxdgVme2c1Ex6L6GNCHF/YUMUglV4=;
 b=aV3qe27q6yIkjjtd32S5vP07Dq+VWLm9+vrvYRI46oFpWtviJLvM1kwrBkOd8udn81Xt
 zXWHY/YXYvPXMw0rj/edLw0B2VA5y8mdbOfgofLPKPr7xpMtNVHg9WE07nC4t1V+uOtO
 tYW/HLhiZtGLRC4pMKjrRBPfa/rhNmRRcjg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 37rvd4ee4x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 11:26:34 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 11:26:25 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 345295FEBBFF; Wed,  7 Apr 2021 11:26:19 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 0/5] percpu: partial chunk depopulation
Date:   Wed, 7 Apr 2021 11:26:13 -0700
Message-ID: <20210407182618.2728388-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9-EPPU-D7K2wMmpN9Px9S9ZP9EP3A4NM
X-Proofpoint-GUID: 9-EPPU-D7K2wMmpN9Px9S9ZP9EP3A4NM
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_09:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070126
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
of these cgroups doesn't always lead to a shrinkage of the percpu memory,
so that sometimes there are several GB's of memory wasted.

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
    Percpu:           135552 kB

So the total size of the percpu memory was reduced by more than 3.5 times.


v2:
  - depopulated chunks are sidelined
  - depopulation happens in the reverse order
  - depopulate list made per-chunk type
  - better results due to better heuristics

v1:
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
  percpu: fix a comment about the chunks ordering
  percpu: split __pcpu_balance_workfn()
  percpu: make pcpu_nr_empty_pop_pages per chunk type
  percpu: generalize pcpu_balance_populated()
  percpu: implement partial chunk depopulation

 mm/percpu-internal.h |   4 +-
 mm/percpu-stats.c    |   9 +-
 mm/percpu.c          | 282 ++++++++++++++++++++++++++++++++++++-------
 3 files changed, 246 insertions(+), 49 deletions(-)

--=20
2.30.2

