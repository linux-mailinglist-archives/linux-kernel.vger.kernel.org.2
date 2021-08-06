Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCB23E3211
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 01:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238955AbhHFXRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 19:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230280AbhHFXRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 19:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628291836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=urXKghAkbZjB19v31crqZ4VAMAydVfXFWVlADbbPtq4=;
        b=RGBKPS1U0aDq8d46VWVl/hWnxr38MRyPjyYOtWA/aKU4gcMmwAOEFp5oa5JBp8g8q5qo+c
        JyUWkBQmOSRoHOxkMpHlYSAVvGLOAFoqPWS9IZ8ozUbJmufYRpAQKcUjYlmdTOCFZGmnUO
        tXffAJxdewER8RZ8Cv3N06tc1K+gIYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-lVCxEWZHPV-E6Uy-3RROZA-1; Fri, 06 Aug 2021 19:17:16 -0400
X-MC-Unique: lVCxEWZHPV-E6Uy-3RROZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA565801AE7;
        Fri,  6 Aug 2021 23:17:14 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.9.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC2CC5D6AB;
        Fri,  6 Aug 2021 23:17:09 +0000 (UTC)
From:   Nico Pache <npache@redhat.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org, npache@redhat.com, aquini@redhat.com
Subject: [PATCH] vm_swappiness=0 should still try to avoid swapping anon memory
Date:   Fri,  6 Aug 2021 19:17:01 -0400
Message-Id: <20210806231701.106980-1-npache@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b91ac374346b ("mm: vmscan: enforce inactive:active ratio at the
reclaim root") swappiness can start prematurely swapping anon memory.
This is due to the assumption that refaulting anon should always allow
the shrinker to target anon memory. Add a check for vm_swappiness being
>0 before indiscriminately targeting Anon.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4620df62f0ff..8b932ff72e37 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2909,8 +2909,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 		refaults = lruvec_page_state(target_lruvec,
 				WORKINGSET_ACTIVATE_ANON);
-		if (refaults != target_lruvec->refaults[0] ||
-			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
+		if (vm_swappiness && (refaults != target_lruvec->refaults[0] ||
+			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON)))
 			sc->may_deactivate |= DEACTIVATE_ANON;
 		else
 			sc->may_deactivate &= ~DEACTIVATE_ANON;
-- 
2.31.1

