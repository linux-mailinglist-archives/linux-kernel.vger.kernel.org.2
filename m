Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3313AFCBE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 07:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhFVFvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 01:51:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23209 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230101AbhFVFvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 01:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624340932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mhbh0wpowIvcYAuBM9Ue5w8qGBOZHKFPCOAK8MS+MSA=;
        b=Gozxsr0cQbjkjI2p3T6yPVwz8CusTNO5zpeMWNM0VvN70NHjMt6siBX8k0yxAB9qv2kyYI
        nYimlWrk2Ff8VCElu/wig5jXbiZw7bldE+KwJRjU/Veby38V4NoatFsv/RsGj04slPreh6
        szwfSdlgxqQOd031ojcO5rb7lhsLqWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-IChUog-jMqyLI2XZMr7dfw-1; Tue, 22 Jun 2021 01:48:48 -0400
X-MC-Unique: IChUog-jMqyLI2XZMr7dfw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52FDA9F92B;
        Tue, 22 Jun 2021 05:48:47 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-84.bne.redhat.com [10.64.54.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA43A5D9DE;
        Tue, 22 Jun 2021 05:48:43 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        david@redhat.com, mst@redhat.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 1/3] mm/page_reporting: Fix code style in __page_reporting_request()
Date:   Tue, 22 Jun 2021 15:49:24 +0800
Message-Id: <20210622074926.333223-2-gshan@redhat.com>
In-Reply-To: <20210622074926.333223-1-gshan@redhat.com>
References: <20210622074926.333223-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lines of comments would be starting with one, instead two space.
This corrects the style.

Signed-off-by: Gavin Shan <gshan@redhat.com>
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

