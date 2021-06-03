Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E2A399762
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 03:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhFCBL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 21:11:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21796 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229736AbhFCBLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 21:11:25 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15315cTX009470
        for <linux-kernel@vger.kernel.org>; Wed, 2 Jun 2021 18:09:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3MmMITvsDJqzOtppii3pb1p4qWk7gOuagZYy/UljbZk=;
 b=P+D+QmlORztjqeRt+nakU/0dqKMUUESzj2heogjDC+/wv/ep67qGh+UC0zUm3IpqnlQH
 IhIzdAWeS8NXWthAHNgLjbguruky+8J7dXrBt+YNQ3oTqlKJGq+V6Jo3COfqANMPwl3/
 rNH4jQBjtrzBsj2oO1Klb7X4tV0Xzg53d0U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38xcnm3cpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 18:09:41 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 18:09:40 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id C9DE97F1B341; Wed,  2 Jun 2021 18:09:32 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 1/3] mm, memcg: mark cgroup_memory_nosocket, nokmem and noswap as __ro_after_init
Date:   Wed, 2 Jun 2021 18:09:29 -0700
Message-ID: <20210603010931.1472512-2-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603010931.1472512-1-guro@fb.com>
References: <20210603010931.1472512-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ft-aQOdemKFQhWZ4OUki9LdXAsi9tpcH
X-Proofpoint-GUID: ft-aQOdemKFQhWZ4OUki9LdXAsi9tpcH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_11:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=919 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106030006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgroup_memory_nosocket, cgroup_memory_nokmem and cgroup_memory_noswap
are initialized during the kernel initialization and never change
their value afterwards.

cgroup_memory_nosocket, cgroup_memory_nokmem are written only from
cgroup_memory(), which is marked as __init.

cgroup_memory_noswap is written from setup_swap_account() and
mem_cgroup_swap_init(), both are marked as __init.

Mark all three variables as __ro_after_init.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/memcontrol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e064ac0d850a..e6203ee24a11 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -80,14 +80,14 @@ struct mem_cgroup *root_mem_cgroup __read_mostly;
 DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
=20
 /* Socket memory accounting disabled? */
-static bool cgroup_memory_nosocket;
+static bool cgroup_memory_nosocket __ro_after_init;
=20
 /* Kernel memory accounting disabled? */
-static bool cgroup_memory_nokmem;
+static bool cgroup_memory_nokmem __ro_after_init;
=20
 /* Whether the swap controller is active */
 #ifdef CONFIG_MEMCG_SWAP
-bool cgroup_memory_noswap __read_mostly;
+bool cgroup_memory_noswap __ro_after_init;
 #else
 #define cgroup_memory_noswap		1
 #endif
--=20
2.31.1

