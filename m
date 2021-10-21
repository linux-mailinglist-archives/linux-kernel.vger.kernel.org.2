Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB9C436C95
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 23:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhJUVWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 17:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58761 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232070AbhJUVWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 17:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634851201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bSeC1KzwZuVXGwG3+OUaXtxtSZaZ3+wpu0+4/rGgy78=;
        b=HL1kSvGA84hzIgGqEm8k7yfhXbG02PGo1rl23B9chBDWoL1yjs+O36WQCiFqdpEddsggJN
        NhG8DEKDqz+iB/8HC5g62sc4NVVPSr/j8xk4cKdmmfdQBIQe+AhRud6k8M9PrfpPAVUijX
        DAOVxr0/AF6EPoF6N5e7P7XAuJ3PWxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-Z3E_1_jSMrOnnptCPD1ycg-1; Thu, 21 Oct 2021 17:20:00 -0400
X-MC-Unique: Z3E_1_jSMrOnnptCPD1ycg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 750E219067E0;
        Thu, 21 Oct 2021 21:19:59 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3E0260CC3;
        Thu, 21 Oct 2021 21:19:58 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     thomas.lendacky@amd.com, dgilbert@redhat.com
Subject: [PATCH] KVM: x86: advertise absence of X86_BUG_NULL_SEG via CPUID
Date:   Thu, 21 Oct 2021 17:19:58 -0400
Message-Id: <20211021211958.1531754-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guests have X86_BUG_NULL_SEG if and only if the host have it.  Use
the info from static_cpu_has_bug to form the 0x80000021 CPUID leaf that
was defined for Zen3.  Userspace can then set the bit even on older
CPUs that do not have the bug, such as Zen2.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/cpuid.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2d70edb0f323..b51398e1727b 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -902,7 +902,13 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->edx = 0;
 		break;
 	case 0x80000000:
-		entry->eax = min(entry->eax, 0x8000001f);
+		entry->eax = min(entry->eax, 0x80000021);
+		/*
+		 * X86_BUG_NULL_SEG is not reported in CPUID on Zen2; in
+		 * that case, provide the CPUID leaf ourselves.
+		 */
+		if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
+			entry->eax = max(entry->eax, 0x80000021);
 		break;
 	case 0x80000001:
 		cpuid_entry_override(entry, CPUID_8000_0001_EDX);
@@ -973,6 +979,15 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 			entry->ebx &= ~GENMASK(11, 6);
 		}
 		break;
+	case 0x80000020:
+		entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+		break;
+	case 0x80000021:
+		entry->ebx = entry->ecx = entry->edx = 0;
+		entry->eax &= BIT(6);
+		if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
+			entry->eax |= BIT(6);
+		break;
 	/*Add support for Centaur's CPUID instruction*/
 	case 0xC0000000:
 		/*Just support up to 0xC0000004 now*/
-- 
2.27.0

