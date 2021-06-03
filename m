Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E02A39975F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 03:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFCBLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 21:11:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20346 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhFCBLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 21:11:22 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15318oqP000784
        for <linux-kernel@vger.kernel.org>; Wed, 2 Jun 2021 18:09:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=KO8JkSHCwG7e23QxvM9nsBY5zrZc1fBJQC4hthtjNKw=;
 b=SKkbCx1cf6nS3LtRHiK3SBdlJJmlNS2/HeIRjHwdrw/bz3GeBdUtxOl6F4qe4vdMZ9jW
 5iLDD7KFg+2mTJfws2cc/gMy4G5W8M/vbPP9AankLAaDBMFMzKlCcZPKvDYNZGOrJ61i
 6r8XeOUsbJHSfsx0xpleQTTdDz/x4BfxOd8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38x34w6px1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 18:09:38 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 18:09:36 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id C6D1A7F1B33E; Wed,  2 Jun 2021 18:09:32 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 0/3] percpu: memcg memory accounting rework
Date:   Wed, 2 Jun 2021 18:09:28 -0700
Message-ID: <20210603010931.1472512-1-guro@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 39a3u_naadGRTkycNKeDj4ppF9_Fx1B3
X-Proofpoint-ORIG-GUID: 39a3u_naadGRTkycNKeDj4ppF9_Fx1B3
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_11:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=480
 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset reworks memcg-based accounting of the percpu memory:
instead of using two types of chunks (memcg-aware and non-memcg-aware)
it treats all chunks as memcg-aware. An extra memory used for objcg
arrays will is compensated by a better chunks utilization, so the
total memory footprint should be the same or smaller.

First two patches are preparational changes and cleanups on the memcg side.
The third one is percpu accounting rework.

v2:
  - make all chunks memcg-aware instead of on-demand objcg allocation, by D=
ennis

v1:
  https://lkml.org/lkml/2021/5/11/1343


Roman Gushchin (3):
  mm, memcg: mark cgroup_memory_nosocket, nokmem and noswap as
    __ro_after_init
  mm, memcg: introduce mem_cgroup_kmem_disabled()
  percpu: rework memcg accounting

 include/linux/memcontrol.h |   5 ++
 mm/memcontrol.c            |  11 ++-
 mm/percpu-internal.h       |  52 +--------------
 mm/percpu-km.c             |   5 +-
 mm/percpu-stats.c          |  46 +++++--------
 mm/percpu-vm.c             |  11 ++-
 mm/percpu.c                | 133 +++++++++++++++----------------------
 7 files changed, 88 insertions(+), 175 deletions(-)

--=20
2.31.1

