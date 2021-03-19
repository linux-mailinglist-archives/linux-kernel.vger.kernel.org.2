Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D13F34261D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhCSTW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230480AbhCSTW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616181775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yzBLyra/x1U0+SSJOrcy0pzeoO1kIL+ryJEPu6MRP8Q=;
        b=CumZjrM4G6lCj0OpBkAs0EyCtdSawTsoYpODmTHUHFAVaYLGkPa5AvmbZ5p91/oed1m6WT
        /t33wsIvKRo9mNvxJ2Wg8s080QryRQhBmf0bUDwd4ggc/givkbJhnQjXEfBoqUQzbtoW3i
        rV90XjYQQu7+Hx2TGGyODLFmC5pW6v8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-aPYvQGA2NhSCroMbXFR6fg-1; Fri, 19 Mar 2021 15:22:51 -0400
X-MC-Unique: aPYvQGA2NhSCroMbXFR6fg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7D13801817;
        Fri, 19 Mar 2021 19:22:50 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E53535D6D5;
        Fri, 19 Mar 2021 19:22:49 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slab_common: provide "slab_merge" option for !IS_ENABLED(CONFIG_SLAB_MERGE_DEFAULT) builds
Date:   Fri, 19 Mar 2021 15:22:33 -0400
Message-Id: <20210319192233.199099-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a minor addition to the allocator setup options to provide
a simple way to on demand enable back cache merging for builds
that by default run with CONFIG_SLAB_MERGE_DEFAULT not set.

Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
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
index 88e833986332..30db72269036 100644
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
+__setup("slab_merge", setup_slab_nomerge);
 
 /*
  * Determine the size of a slab object
-- 
2.26.2

