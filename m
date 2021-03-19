Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44634341B47
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhCSLTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229821AbhCSLSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616152715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7OZOX/YIlftmA53QwiWbR6JyXFIkXe3MO91yV2zu1HA=;
        b=SBJ0SLimOum6zIn0TRNjffLweV04eGbI5HW34MJzYCd2QVz5NWqpIr6cv1WyGBOlO9hefr
        9abMRoTXQxbWayD0+E7yKo0uHknMa7+6zm0q8/P0Fhl/UiYFXyNihM8fO2uviW9LnFiGAu
        03iUU+m1+cknATUzoqcIvNUrZJY/1Eo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-TPUD3m5ONFaumC9dQMcdnw-1; Fri, 19 Mar 2021 07:18:31 -0400
X-MC-Unique: TPUD3m5ONFaumC9dQMcdnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DED8107ACCA;
        Fri, 19 Mar 2021 11:18:30 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86F145DAA5;
        Fri, 19 Mar 2021 11:18:24 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] genirq/matrix: Prevent managed_allocated/total_allocated counters getting out-of-sync
Date:   Fri, 19 Mar 2021 12:18:23 +0100
Message-Id: <20210319111823.1105248-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When irq_matrix_free() is called for an unallocated interrupt,
managed_allocated/total_allocated counters get out of sync with the real
state of the matrix. Later, when the last interrupt is freed, these
counters will go negative (overflow). While this is certainly a problem of
the calling code, we can do better in irq_matrix_free() and simplify
debugging.

An example of a problem described above:
https://lore.kernel.org/lkml/20210318192819.636943062@linutronix.de/

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 kernel/irq/matrix.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 651a4ad6d711..8e586858bcf4 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -423,7 +423,9 @@ void irq_matrix_free(struct irq_matrix *m, unsigned int cpu,
 	if (WARN_ON_ONCE(bit < m->alloc_start || bit >= m->alloc_end))
 		return;
 
-	clear_bit(bit, cm->alloc_map);
+	if (WARN_ON_ONCE(!test_and_clear_bit(bit, cm->alloc_map)))
+		return;
+
 	cm->allocated--;
 	if(managed)
 		cm->managed_allocated--;
-- 
2.30.2

