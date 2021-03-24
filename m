Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E6134813A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 20:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbhCXTHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 15:07:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55588 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237730AbhCXTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 15:06:36 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12OJ4wiD000640
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:06:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=hZDBTvWEE01rM4Olmsjdj7mKlECbbT1uO9DrFO8s5zU=;
 b=jb6MOg648M9c1gAOlL8XNFA5X8dBApLRffgiFw/Je0pfWpgaljHbOHI092mmzt5EOU1G
 bah5GgnCvUUDgClckwiCJ5oRyHc+FrYC/OmyyOWIwcXkyVqjI16UZTMsIEk5TkzX67Sk
 uyEeUUHi/i+5U4ja0LYj/Pixm5LLUwACqQk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37fpjt6t8a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 12:06:35 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Mar 2021 12:06:35 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 8022657ACF28; Wed, 24 Mar 2021 12:06:33 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 0/4] percpu: partial chunk depopulation
Date:   Wed, 24 Mar 2021 12:06:22 -0700
Message-ID: <20210324190626.564297-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_13:2021-03-24,2021-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=954 lowpriorityscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103240137
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In our production experience the percpu memory allocator is sometimes str=
uggling
with returning the memory to the system. A typical example is a creation =
of
several thousands memory cgroups (each has several chunks of the percpu d=
ata
used for vmstats, vmevents, ref counters etc). Deletion and complete rele=
asing
of these cgroups doesn't always lead to a shrinkage of the percpu memory.

The underlying problem is the fragmentation: to release an underlying chu=
nk
all percpu allocations should be released first. The percpu allocator ten=
ds
to top up chunks to improve the utilization. It means new small-ish alloc=
ations
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
    $ ./percpu_test.sh
    Percpu:             7296 kB
    Percpu:           481024 kB
    Percpu:           481024 kB

  with this patchset applied:
    ./percpu_test.sh
    Percpu:             7488 kB
    Percpu:           481152 kB
    Percpu:           153920 kB

So the total size of the percpu memory was reduced by ~3 times.


Roman Gushchin (4):
  percpu: implement partial chunk depopulation
  percpu: split __pcpu_balance_workfn()
  percpu: on demand chunk depopulation
  percpu: fix a comment about the chunks ordering

 mm/percpu-internal.h |   1 +
 mm/percpu.c          | 242 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 203 insertions(+), 40 deletions(-)

--=20
2.30.2

