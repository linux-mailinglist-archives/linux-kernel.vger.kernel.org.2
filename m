Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCCD3CBE23
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 23:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbhGPVHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 17:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232896AbhGPVG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 17:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626469442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=g49/KyQBA3eOY1MbjSChZGxyqJEiIAVE2IDAbe+zWxU=;
        b=AoonXhXJSmk0u9O3p7s59o5mVxCydsUZ8hJYgpL+8jVFfJYhLlbnhfI5sx/Pe+s+JTGhgc
        E/2V06WPQ7alZPyWNVV6LlL7DDWI9j8zVTGPk2TCdD0vtLwaZW0h2HzGNSjZsy/R3D9kKg
        iinWfGA/rP4Y/6huX+9Pz39eNki/N00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-YiEPTyHiN8W-0bgFWdGPLQ-1; Fri, 16 Jul 2021 17:03:47 -0400
X-MC-Unique: YiEPTyHiN8W-0bgFWdGPLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37C021804877;
        Fri, 16 Jul 2021 21:03:46 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-107.rdu2.redhat.com [10.10.116.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F9CB60C05;
        Fri, 16 Jul 2021 21:03:42 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     rppt@kernel.org, akpm@linux-foundation.org, npache@redhat.com,
        aquini@redhat.com
Subject: [PATCH] Fix 'zone_id' may be used uninitialized in this function warning
Date:   Fri, 16 Jul 2021 17:03:36 -0400
Message-Id: <20210716210336.1114114-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with -Werror, cc1 will warn that
'zone_id' may be used uninitialized in this function warning.

Initialize the zone_id as 0.

Its safe to assume that if the code reaches this point it has at least
one numa node with memory, so no need for an assertion before
init_unavilable_range.

Fixes: 122e093c1734 ("mm/page_alloc: fix memory map initialization for descending nodes")
Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3e97e68aef7a..3f3116f52fd8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6719,7 +6719,7 @@ static void __init memmap_init(void)
 {
 	unsigned long start_pfn, end_pfn;
 	unsigned long hole_pfn = 0;
-	int i, j, zone_id, nid;
+	int i, j, zone_id = 0, nid;
 
 	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
 		struct pglist_data *node = NODE_DATA(nid);
-- 
2.31.1

