Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650CF3E35AE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 15:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhHGNuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 09:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232377AbhHGNuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 09:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628344186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tVJsEvrWVodWvIKU/JUMGgTQ0my8Z8jBeHTcmW5IyBY=;
        b=Tj6GJmIBLCnO09L2X3EmYyaFQdhIC3dOUEOkblA0sOXIJXe4wQ2qnA0R+2N+vNWh1kQFLs
        HBhhnjfotwzjg4RVFvgV8s66Xou31njCNEDJRk6KMtsVPHvexFh0wVbuP5K04OPCXaXCds
        txNUThfpz46kZtc8726gfkeGHADt+lU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-tfMvn2ZpP--_I0mnsJu6SA-1; Sat, 07 Aug 2021 09:49:43 -0400
X-MC-Unique: tfMvn2ZpP--_I0mnsJu6SA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75782871803;
        Sat,  7 Aug 2021 13:49:42 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA0361700F;
        Sat,  7 Aug 2021 13:49:41 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     isaku.yamahata@intel.com, David Matlack <dmatlack@google.com>,
        seanjc@google.com, peterx@redhat.com
Subject: [PATCH 01/16] KVM: MMU: pass unadulterated gpa to direct_page_fault
Date:   Sat,  7 Aug 2021 09:49:21 -0400
Message-Id: <20210807134936.3083984-2-pbonzini@redhat.com>
In-Reply-To: <20210807134936.3083984-1-pbonzini@redhat.com>
References: <20210807134936.3083984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not bother removing the low bits of the gpa.  This masking dates back
to the very first commit of KVM but it is unnecessary---or even
problematic, because the gpa is later used to fill in the MMIO page cache.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 964c797dcc46..7477f340d318 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3950,7 +3950,7 @@ static int nonpaging_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa,
 	pgprintk("%s: gva %lx error %x\n", __func__, gpa, error_code);
 
 	/* This path builds a PAE pagetable, we can map 2mb pages at maximum. */
-	return direct_page_fault(vcpu, gpa & PAGE_MASK, error_code, prefault,
+	return direct_page_fault(vcpu, gpa, error_code, prefault,
 				 PG_LEVEL_2M, false);
 }
 
-- 
2.27.0


