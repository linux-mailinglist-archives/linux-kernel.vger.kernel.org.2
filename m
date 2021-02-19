Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E45631F877
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhBSLcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:32:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44093 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhBSLcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 06:32:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613734272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GU+z0uFgrvtQ2IrpGO/suiEaBjZdNGExzd1YqAtlnXE=;
        b=ZvtJkusVVlfIzSUpcBBFr8oCEmZBOIl6MjymWmj7eEIvP9B5xayMpxH5XufV7Tbg+mPTR+
        uACmssAXDnzdKgCI/eCDes+IKhqQDjm/w67xSaIeDWgB83Am0+5tPH3gdRLT6J9lehpdcF
        ZBFOC+K4tp9xxLZAYRlnllpQGEvkM6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-w0c1WPoQOiuCeG3oa3hnEw-1; Fri, 19 Feb 2021 06:31:11 -0500
X-MC-Unique: w0c1WPoQOiuCeG3oa3hnEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00054107ACC7;
        Fri, 19 Feb 2021 11:31:09 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 945BD629DA;
        Fri, 19 Feb 2021 11:31:05 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/2] x86/apic: Do not make an exception for PIC_CASCADE_IR when marking legacy irqs in irq_matrix
Date:   Fri, 19 Feb 2021 12:31:00 +0100
Message-Id: <20210219113101.967508-2-vkuznets@redhat.com>
In-Reply-To: <20210219113101.967508-1-vkuznets@redhat.com>
References: <20210219113101.967508-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to offline/online CPU0 seems to work only once:

 # echo 0 > /sys/devices/system/cpu/cpu0/online
 # echo 1 > /sys/devices/system/cpu/cpu0/online
 # echo 0 > /sys/devices/system/cpu/cpu0/online
 -bash: echo: write error: No space left on device

with the following in dmesg:

 [ ... ] CPU 0 has 4294967295 vectors, 589 available. Cannot disable CPU

Clearly, we went negative with cm->allocated in irq_matrix and think that
there are too many vectors require re-assigning.

The problem turns to be: lapic_assign_system_vectors() called from
native_init_IRQ() makes an exception for PIC_CASCADE_IR and doesn't
mark it in irq_matrix. Later, when x86_vector_alloc_irqs() called
from setup_IO_APIC() does clear_irq_vector() for all legacy entries,
it doesn't make an exception so we go negative.

CPU0 offlining still works for the first time because some other vectors
get assigned and the overall balance remains positive (it's off-by-one, but
the check passes). When we online CPU0 back, no vectors get assigned and
the overall balance remains '-1'.

The simplest solution seems to be to not make an exception for
PIC_CASCADE_IR. Nothing seems to blow up immediately.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kernel/apic/vector.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3c9c7492252f..f3aa02ced929 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -745,8 +745,7 @@ void __init lapic_assign_system_vectors(void)
 
 	/* Mark the preallocated legacy interrupts */
 	for (i = 0; i < nr_legacy_irqs(); i++) {
-		if (i != PIC_CASCADE_IR)
-			irq_matrix_assign(vector_matrix, ISA_IRQ_VECTOR(i));
+		irq_matrix_assign(vector_matrix, ISA_IRQ_VECTOR(i));
 	}
 }
 
-- 
2.29.2

