Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED4C3AE1D0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 05:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhFUDN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 23:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47413 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230316AbhFUDN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 23:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624245103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E6hTJAwE1ThQJZthX/koVPnKeQXaG7vgSbRZcgpc+Oo=;
        b=W/rLHGL7ZgySs2WaKMY5UxGPE4JwVFvSbvBRo5fKQDHQHhRbRWZXsiyV3KKnNd1ieAvyaG
        Q5yXUkccM/QFecsdc7BEQifxf75KVGTpOgP3l3dtoIT7q1K4os5vwSvJ81QrVoKZVSd/Wf
        pGdA4BDWMuzvlcSfm/A3924ctwgBBhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-vUu3RFF5PXaJKh8IqliPfg-1; Sun, 20 Jun 2021 23:11:42 -0400
X-MC-Unique: vUu3RFF5PXaJKh8IqliPfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF467100B3AC;
        Mon, 21 Jun 2021 03:11:40 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-84.bne.redhat.com [10.64.54.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7258460C9D;
        Mon, 21 Jun 2021 03:11:31 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        akpm@linux-foundation.org, david@redhat.com,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH 3/3] arm64: mm: Specify smaller page reporting order
Date:   Mon, 21 Jun 2021 13:11:52 +0800
Message-Id: <20210621051152.305224-4-gshan@redhat.com>
In-Reply-To: <20210621051152.305224-1-gshan@redhat.com>
References: <20210621051152.305224-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page reporting order is stick to @pageblock_order and its size
is 512MB when 64KB base page size is chosen. It also means the
page reporting won't be started if current freeing page can't come
up with a 512MB free area. It's hard when the system memory becomes
fragmented.

This specifies the page reporting order to 5 when the 64KB base page
size is chosen, corresponding to huge page size with 4KB base page
size, so that page reporting has more chance to work.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/page.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 012cffc574e8..b8386e7d7d47 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -18,6 +18,19 @@
 struct page;
 struct vm_area_struct;
 
+/*
+ * The page reporting won't be started if the freeing page can't come up
+ * with a huge page, which is 512MB with 64KB base page size. It's hard
+ * to have 512MB free area when the memory becomes fragmented, stop page
+ * reporting from working properly. So we choose smaller page reporting
+ * order, which is same to the huge page size (2MB) with 4KB base page
+ * size. However, more overheads will be introduced because page reporting
+ * will be running more frequently.
+ */
+#if defined(CONFIG_PAGE_REPORTING) && defined(CONFIG_ARM64_64K_PAGES)
+#define PAGE_REPORTING_ORDER 5
+#endif
+
 extern void copy_page(void *to, const void *from);
 extern void clear_page(void *to);
 
-- 
2.23.0

