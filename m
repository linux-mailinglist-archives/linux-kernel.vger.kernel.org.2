Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7703134266C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhCSTpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230297AbhCSTpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616183129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/KdonTuSFjSMSOYRBj5KwLuZSZ8C3R0H74LqotwgAk=;
        b=brZsffYrR2iPnaBiEb7jtap9FHiYsV+1TfgA4oQYvvWFxWTrXiPpsFacHwk6uvH9iKc5C6
        Gl74hfeJFQ39zzpaU2Ekh3fz7Xr9vixS94S9QxxHJx7l06YL7FJO3R6tf7Uc/eAIq1NUFK
        LSSBMYk8GoVzLANHzKJMN3H1XhKnwlQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-zdH_h7_yO-SOsIKbD4QekA-1; Fri, 19 Mar 2021 15:45:25 -0400
X-MC-Unique: zdH_h7_yO-SOsIKbD4QekA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C274E107ACCA;
        Fri, 19 Mar 2021 19:45:22 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 400B45D9E3;
        Fri, 19 Mar 2021 19:45:18 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-mm@kvack.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/slab_common: provide "slab_merge" option for !IS_ENABLED(CONFIG_SLAB_MERGE_DEFAULT) builds
Date:   Fri, 19 Mar 2021 15:45:03 -0400
Message-Id: <20210319194506.200159-1-aquini@redhat.com>
In-Reply-To: <20210319192233.199099-1-aquini@redhat.com>
References: <20210319192233.199099-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a minor addition to the allocator setup options to provide
a simple way to on demand enable back cache merging for builds
that by default run with CONFIG_SLAB_MERGE_DEFAULT not set.

Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
v2 changelog:
* fix __setup("slab_merge", setup_slab_nomerge); typo

 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 mm/slab_common.c                                | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..06519eecbfec 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4877,6 +4877,10 @@
 
 	slram=		[HW,MTD]
 
+	slab_merge	[MM]
+			Enable merging of slabs with similar size when the
+			kernel is built without CONFIG_SLAB_MERGE_DEFAULT.
+
 	slab_nomerge	[MM]
 			Disable merging of slabs with similar size. May be
 			necessary if there is some reason to distinguish
@@ -4924,6 +4928,9 @@
 			lower than slub_max_order.
 			For more information see Documentation/vm/slub.rst.
 
+	slub_merge	[MM, SLUB]
+			Same with slab_merge.
+
 	slub_nomerge	[MM, SLUB]
 			Same with slab_nomerge. This is supported for legacy.
 			See slab_nomerge for more information.
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 88e833986332..b84dd734b75f 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -71,11 +71,19 @@ static int __init setup_slab_nomerge(char *str)
 	return 1;
 }
 
+static int __init setup_slab_merge(char *str)
+{
+	slab_nomerge = false;
+	return 1;
+}
+
 #ifdef CONFIG_SLUB
 __setup_param("slub_nomerge", slub_nomerge, setup_slab_nomerge, 0);
+__setup_param("slub_merge", slub_merge, setup_slab_merge, 0);
 #endif
 
 __setup("slab_nomerge", setup_slab_nomerge);
+__setup("slab_merge", setup_slab_merge);
 
 /*
  * Determine the size of a slab object
-- 
2.26.2

