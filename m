Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5EB3B3AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 04:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhFYCXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 22:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45726 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232983AbhFYCXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 22:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624587660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G5bJgCIYa5q6eA6dvpCkqQm9p+AHqtupjC0ER/rY6zY=;
        b=KTxXU+BtzuAX16Tta592Ws9cn4p4KZtMSe3I46r9yAsLwr6KK6CPdmk8wNxottnJyfyazv
        Xcqe1SQ604UtKXyj+Bs+MsEyk4Dos1lJPYsC1Ees/dSBVs0A73wAA7tdtsBo3A9s8wAYR7
        oVJjGEyUnzAZAMWqcBlp+cLegO41Kn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-EtINbmwPON2veNMHjD2zNA-1; Thu, 24 Jun 2021 22:20:57 -0400
X-MC-Unique: EtINbmwPON2veNMHjD2zNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62CF3EC1A1;
        Fri, 25 Jun 2021 02:20:55 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-70.bne.redhat.com [10.64.54.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F9335C1A3;
        Fri, 25 Jun 2021 02:20:50 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        david@redhat.com, mst@redhat.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v5 1/4] mm/page_reporting: Fix code style in __page_reporting_request()
Date:   Fri, 25 Jun 2021 12:21:47 +0800
Message-Id: <20210625042150.46964-2-gshan@redhat.com>
In-Reply-To: <20210625042150.46964-1-gshan@redhat.com>
References: <20210625042150.46964-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lines of comments would be starting with one, instead two space.
This corrects the style.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
---
 mm/page_reporting.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index c50d93ffa252..df9c5054e1b4 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -31,8 +31,8 @@ __page_reporting_request(struct page_reporting_dev_info *prdev)
 		return;
 
 	/*
-	 *  If reporting is already active there is nothing we need to do.
-	 *  Test against 0 as that represents PAGE_REPORTING_IDLE.
+	 * If reporting is already active there is nothing we need to do.
+	 * Test against 0 as that represents PAGE_REPORTING_IDLE.
 	 */
 	state = atomic_xchg(&prdev->state, PAGE_REPORTING_REQUESTED);
 	if (state != PAGE_REPORTING_IDLE)
-- 
2.23.0

