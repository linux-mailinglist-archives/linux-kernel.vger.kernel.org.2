Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E85F33327D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 01:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhCJAcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 19:32:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231506AbhCJAce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 19:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615336354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YhePKM8Sy+l5ltuBR15N4s2HKvcbnW1LaOGThF3WvIY=;
        b=RCcf+0Xb9qyaTfVigwgi7TECtkZ2ij5WKd+u0d+lOz15S4TxC0S8xfgP7fQ3hwTkr4oRXp
        d0nS8XYi3UMk/sbxNrNhaypmqSpFU02/pdJ994Y2LLPOP13HVfbNIPLjPgPntgHx6qKZ8c
        mzZOtCPpm3f5ni2mAjpQdOTFIZMyXsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35--OVjvQAePC-cn28t_oD2Qg-1; Tue, 09 Mar 2021 19:32:31 -0500
X-MC-Unique: -OVjvQAePC-cn28t_oD2Qg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0047E83DD27;
        Wed, 10 Mar 2021 00:32:30 +0000 (UTC)
Received: from trippy.localdomain (ovpn-114-179.rdu2.redhat.com [10.10.114.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C6525D9DB;
        Wed, 10 Mar 2021 00:32:29 +0000 (UTC)
From:   Mark Salter <msalter@redhat.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] arm64: mm: fix runtime fallback to 48-bt VA when 52-bit VA is enabled
Date:   Tue,  9 Mar 2021 19:32:16 -0500
Message-Id: <20210310003216.410037-1-msalter@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into an early boot soft lockup on a Qualcomm Amberwing using a v5.11
kernel configured for 52-bit VA. This turned into a panic with a v5.12-rc2
kernel.

The problem is that when we fall back to 48-bit VA, idmap_t0sz is not
updated. Later, the kvm hypervisor uses idmap_t0sz to set its tcr_el2 and
hangs (v5.11). After commit 1401bef703a4 ("arm64: mm: Always update TCR_EL1
from __cpu_set_tcr_t0sz()"), the kernel panics when trying to use the idmap
to call idmap_cpu_replace_ttbr1().

Oddly, other systems (thunderX2 and Ampere eMag) which don't support 52-bit
VA seem to handle the setting of an unsupported t0sz without any apparent
problems. Indeed, if one reads back the tcr written with t0sz==12, the
value read has t0sz==16. Not so with Amberwing.

Fixes: 90ec95cda91a ("arm64: mm: Introduce VA_BITS_MIN")
Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/arm64/kernel/head.S | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 66b0e0b66e31..2bcbbb26292e 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -291,6 +291,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	 */
 	adrp	x0, idmap_pg_dir
 	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
+	mov	x4, TCR_T0SZ(VA_BITS)
 
 #ifdef CONFIG_ARM64_VA_BITS_52
 	mrs_s	x6, SYS_ID_AA64MMFR2_EL1
@@ -299,6 +300,13 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	cbnz	x6, 1f
 #endif
 	mov	x5, #VA_BITS_MIN
+#ifdef CONFIG_ARM64_VA_BITS_52
+	mov	x4, TCR_T0SZ(VA_BITS_MIN)
+	adr_l	x6, idmap_t0sz
+	str	x4, [x6]
+	dmb	sy
+	dc	ivac, x6		// Invalidate potentially stale cache line
+#endif
 1:
 	adr_l	x6, vabits_actual
 	str	x5, [x6]
@@ -319,7 +327,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
 	 */
 	adrp	x5, __idmap_text_end
 	clz	x5, x5
-	cmp	x5, TCR_T0SZ(VA_BITS)	// default T0SZ small enough?
+	cmp	x5, x4			// default T0SZ small enough?
 	b.ge	1f			// .. then skip VA range extension
 
 	adr_l	x6, idmap_t0sz
-- 
2.27.0

