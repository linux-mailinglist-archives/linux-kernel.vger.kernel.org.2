Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2ACF31F878
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhBSLcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:32:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230389AbhBSLcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 06:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613734280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e0NLLJQnD1mjdZ9kK1sCMRFgwk44auieBeOGjPb7N3k=;
        b=HEo1cAWHw8Fzig2spCuZJb6Eg/7ksjUZPljEvkbFi08HfFy4Rj4qZ539MtB26piXsm5W4W
        8wbWd+oxwnc0q2wjIGYD4RsAKZnT2JBB9+lvcH3+XY3uatPQ4LOI1GUxgZDNUQC2t0ESHZ
        nKS69qiAFrNJEnnwRgmLdeOLTOpVnwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-r9Y6r0keMUGd8lrEd7wYog-1; Fri, 19 Feb 2021 06:31:17 -0500
X-MC-Unique: r9Y6r0keMUGd8lrEd7wYog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C2A7107ACE3;
        Fri, 19 Feb 2021 11:31:16 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AABA6267C;
        Fri, 19 Feb 2021 11:31:10 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/2] genirq/matrix: WARN_ON_ONCE() when cm->allocated/m->total_allocated go negative
Date:   Fri, 19 Feb 2021 12:31:01 +0100
Message-Id: <20210219113101.967508-3-vkuznets@redhat.com>
In-Reply-To: <20210219113101.967508-1-vkuznets@redhat.com>
References: <20210219113101.967508-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When irq_matrix_assign()/irq_matrix_free() calls get unsynced, weird
effects are possible, e.g. when cm->allocated goes negative CPU hotplug
may get blocked. Add WARN_ON_ONCE() to simplify detecting such situations.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 kernel/irq/matrix.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 651a4ad6d711..2438a4f9d726 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -189,7 +189,9 @@ void irq_matrix_assign_system(struct irq_matrix *m, unsigned int bit,
 	set_bit(bit, m->system_map);
 	if (replace) {
 		BUG_ON(!test_and_clear_bit(bit, cm->alloc_map));
+		WARN_ON_ONCE(!cm->allocated);
 		cm->allocated--;
+		WARN_ON_ONCE(!m->total_allocated);
 		m->total_allocated--;
 	}
 	if (bit >= m->alloc_start && bit < m->alloc_end)
@@ -424,12 +426,17 @@ void irq_matrix_free(struct irq_matrix *m, unsigned int cpu,
 		return;
 
 	clear_bit(bit, cm->alloc_map);
+	WARN_ON_ONCE(!cm->allocated);
 	cm->allocated--;
-	if(managed)
+	if (managed) {
+		WARN_ON_ONCE(!cm->managed_allocated);
 		cm->managed_allocated--;
+	}
 
-	if (cm->online)
+	if (cm->online) {
+		WARN_ON_ONCE(!m->total_allocated);
 		m->total_allocated--;
+	}
 
 	if (!managed) {
 		cm->available++;
-- 
2.29.2

