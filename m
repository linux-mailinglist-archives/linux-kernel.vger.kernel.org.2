Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D735357AF9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 05:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhDHD6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 23:58:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6418 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229735AbhDHD6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 23:58:01 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1383viwS007250
        for <linux-kernel@vger.kernel.org>; Wed, 7 Apr 2021 20:57:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=1S0iKb3KcPWfTp4X6pJq8tXj56UgxHzPrVzYK3Diahw=;
 b=mLcloA3JvLMDNz1/RIn8JVf2z+K4k+NSwBus6JviYOGr+2vzRNAVwvkoWTw3ZdEsBWTf
 IzuymoSBRoMhX7rqB/mcOpqIEOSrgxzJ8exkQAzkafWbJpcsurylVqA/rvxIdVF1X96F
 RZ5/WYvQSMvFmRJjrsbg+6Z/yHnLRTTQQIk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37sfkykkfh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 20:57:51 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 20:57:48 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 55E2C602B00A; Wed,  7 Apr 2021 20:57:41 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v3 0/6] percpu: partial chunk depopulation
Date:   Wed, 7 Apr 2021 20:57:30 -0700
Message-ID: <20210408035736.883861-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: h7KF_oIfsrvXX5YDHpzyZMaKNLxga_h-
X-Proofpoint-ORIG-GUID: h7KF_oIfsrvXX5YDHpzyZMaKNLxga_h-
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_01:2021-04-07,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104080024
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

This patchset solves this problem by implementing a partial depopulation
of percpu chunks: chunks with many empty pages are being asynchronously
depopulated and the pages are returned to the system.

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

v3:
  - introduced pcpu_check_chunk_hint()
  - fixed a bug related to the hint check
  - minor cosmetic changes
  - s/pretends/fixes (cc Vlastimil)

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


Roman Gushchin (6):
  percpu: fix a comment about the chunks ordering
  percpu: split __pcpu_balance_workfn()
  percpu: make pcpu_nr_empty_pop_pages per chunk type
  percpu: generalize pcpu_balance_populated()
  percpu: factor out pcpu_check_chunk_hint()
  percpu: implement partial chunk depopulation

 mm/percpu-internal.h |   4 +-
 mm/percpu-stats.c    |   9 +-
 mm/percpu.c          | 306 +++++++++++++++++++++++++++++++++++--------
 3 files changed, 261 insertions(+), 58 deletions(-)

--=20
2.30.2

