Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A125D399760
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 03:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhFCBLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 21:11:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43708 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229695AbhFCBLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 21:11:24 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 153187Sv001014
        for <linux-kernel@vger.kernel.org>; Wed, 2 Jun 2021 18:09:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=VGE3XvVtAmy0e1JQRfOD/4PDu+ZUMPRb3rQTAYyclu8=;
 b=Q1KIJsAoSk9u/0gB8890ljVNE3X7vBxSgZhknI5+ofp2XsleMo9X3oYL/14jUAgIkpAV
 ESKy/kMWd79YfauNzsE2KcwYsHLyllEgjL9tv+FNfg6bp755M2UcI1gheLmaL9FhBACc
 0pNvwkJ4DxpenZ0EmHidot/gJeYSHb52vr0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38xeyqjc19-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 18:09:40 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 18:09:38 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id CE6497F1B349; Wed,  2 Jun 2021 18:09:32 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 2/3] mm, memcg: introduce mem_cgroup_kmem_disabled()
Date:   Wed, 2 Jun 2021 18:09:30 -0700
Message-ID: <20210603010931.1472512-3-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603010931.1472512-1-guro@fb.com>
References: <20210603010931.1472512-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: NL98cRcWhmyz4_lRSMKiqj2Wvj8VPe3Y
X-Proofpoint-ORIG-GUID: NL98cRcWhmyz4_lRSMKiqj2Wvj8VPe3Y
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_11:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=814 spamscore=0
 impostorscore=0 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106030006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new mem_cgroup_kmem_disabled() helper, similar to
mem_cgroup_disabled(), to check whether the kernel memory accounting
is off. A user could disable it using a boot option to eliminate
some associated costs.

The helper can be used outside of memcontrol.c to dynamically disable
the kmem-related code. The returned value is stable after the kernel
initialization is finished.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 5 +++++
 mm/memcontrol.c            | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c04d39a7967..8ef51c58f470 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1583,6 +1583,7 @@ static inline void memcg_set_shrinker_bit(struct me=
m_cgroup *memcg,
 #endif
=20
 #ifdef CONFIG_MEMCG_KMEM
+bool mem_cgroup_kmem_disabled(void);
 int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
 void __memcg_kmem_uncharge_page(struct page *page, int order);
=20
@@ -1636,6 +1637,10 @@ static inline int memcg_cache_id(struct mem_cgroup=
 *memcg)
 struct mem_cgroup *mem_cgroup_from_obj(void *p);
=20
 #else
+static inline bool mem_cgroup_kmem_disabled(void)
+{
+	return true;
+}
=20
 static inline int memcg_kmem_charge_page(struct page *page, gfp_t gfp,
 					 int order)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e6203ee24a11..1fa9b00ec71d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -255,6 +255,11 @@ struct cgroup_subsys_state *vmpressure_to_css(struct=
 vmpressure *vmpr)
 #ifdef CONFIG_MEMCG_KMEM
 extern spinlock_t css_set_lock;
=20
+bool mem_cgroup_kmem_disabled(void)
+{
+	return cgroup_memory_nokmem;
+}
+
 static int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
 			       unsigned int nr_pages);
 static void __memcg_kmem_uncharge(struct mem_cgroup *memcg,
--=20
2.31.1

