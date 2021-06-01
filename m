Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4F4396A9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 03:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhFABe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 21:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231714AbhFABe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 21:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622511166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XKyYJx9YieU8ulaBq4SlFZLz0hyHCdkp8RQ+G8AysWM=;
        b=XfDjydr1vt6NyCVUHMVQ8OTOdH7LN/euBQldSJXHhq1mkfqvDLb2yIYL+J+0bSWAab6XCR
        9BQ0xZ9qZGwrRcMWi/LorqS+Wg6ZZ+BXodm+OT7RSGnDflverV1HKmBMbT+l/LEgfulcri
        AJZwuCxbvjW5Vl1jfHNBMdR4FPlaj9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-TR3kc_W9OPGkI8nRAzBngA-1; Mon, 31 May 2021 21:32:44 -0400
X-MC-Unique: TR3kc_W9OPGkI8nRAzBngA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CA09107ACE4;
        Tue,  1 Jun 2021 01:32:43 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-23.bne.redhat.com [10.64.54.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E690460936;
        Tue,  1 Jun 2021 01:32:37 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, alexander.h.duyck@linux.intel.com,
        david@redhat.com, akpm@linux-foundation.org, shan.gavin@gmail.com
Subject: [RFC PATCH] mm/page_reporting: Adjust threshold according to MAX_ORDER
Date:   Tue,  1 Jun 2021 11:33:19 +0800
Message-Id: <20210601033319.100737-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PAGE_REPORTING_MIN_ORDER is equal to @pageblock_order, taken as
minimal order (threshold) to trigger page reporting. The page reporting
is never triggered with the following configurations and settings on
aarch64. In the particular scenario, the page reporting won't be triggered
until the largest (2 ^ (MAX_ORDER-1)) free area is achieved from the
page freeing. The condition is very hard, or even impossible to be met.

  CONFIG_ARM64_PAGE_SHIFT:              16
  CONFIG_HUGETLB_PAGE:                  Y
  CONFIG_HUGETLB_PAGE_SIZE_VARIABLE:    N
  pageblock_order:                      13
  CONFIG_FORCE_MAX_ZONEORDER:           14
  MAX_ORDER:                            14

The issue can be reproduced in VM, running kernel with above configurations
and settings. The 'memhog' is used inside the VM to access 512MB anonymous
area. The QEMU's RSS doesn't drop accordingly after 'memhog' exits.

  /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64          \
  -accel kvm -machine virt,gic-version=host                        \
  -cpu host -smp 8,sockets=2,cores=4,threads=1 -m 4096M,maxmem=64G \
  -object memory-backend-ram,id=mem0,size=2048M                    \
  -object memory-backend-ram,id=mem1,size=2048M                    \
  -numa node,nodeid=0,cpus=0-3,memdev=mem0                         \
  -numa node,nodeid=1,cpus=4-7,memdev=mem1                         \
    :                                                              \
  -device virtio-balloon-pci,id=balloon0,free-page-reporting=yes

This tries to fix the issue by adjusting the threshold to the smaller value
of @pageblock_order and (MAX_ORDER/2). With this applied, the QEMU's RSS
drops after 'memhog' exits.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/page_reporting.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/page_reporting.h b/mm/page_reporting.h
index 2c385dd4ddbd..5dae3d171004 100644
--- a/mm/page_reporting.h
+++ b/mm/page_reporting.h
@@ -10,9 +10,10 @@
 #include <linux/pgtable.h>
 #include <linux/scatterlist.h>
 
-#define PAGE_REPORTING_MIN_ORDER	pageblock_order
-
 #ifdef CONFIG_PAGE_REPORTING
+#define PAGE_REPORTING_MIN_ORDER	\
+	min_t(unsigned int, pageblock_order, (MAX_ORDER / 2))
+
 DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
 void __page_reporting_notify(void);
 
-- 
2.23.0

