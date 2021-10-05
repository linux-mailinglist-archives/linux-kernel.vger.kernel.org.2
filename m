Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FEC42261B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbhJEMSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20463 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233672AbhJEMSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633436176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m/50e74I6mK0ds4X9rX72a/33EthQOH3jN2qPda+wXk=;
        b=WhIY/ADUaAxjlpq6UbqCLTBis1bEuupekqkuieq++DcAJthI1VQjizdvC44zHWOVgGeZ+s
        LHUEsyHmOOCiDZMdy2XFhvi9oHJRgbfprtbjl/PBQftdpcafx99ZICankCPU+S8yV3kflp
        2Qjdd5P2ErkHr8jLvR+ZICJEggRh0HQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-B14qeA0YO_ehUZiZU6OrOQ-1; Tue, 05 Oct 2021 08:16:15 -0400
X-MC-Unique: B14qeA0YO_ehUZiZU6OrOQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC5411006AA2;
        Tue,  5 Oct 2021 12:16:12 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E602A1F6;
        Tue,  5 Oct 2021 12:15:44 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 2/9] x86/xen: simplify xen_oldmem_pfn_is_ram()
Date:   Tue,  5 Oct 2021 14:14:23 +0200
Message-Id: <20211005121430.30136-3-david@redhat.com>
In-Reply-To: <20211005121430.30136-1-david@redhat.com>
References: <20211005121430.30136-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's simplify return handling.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/xen/mmu_hvm.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/x86/xen/mmu_hvm.c b/arch/x86/xen/mmu_hvm.c
index b242d1f4b426..d1b38c77352b 100644
--- a/arch/x86/xen/mmu_hvm.c
+++ b/arch/x86/xen/mmu_hvm.c
@@ -21,23 +21,10 @@ static int xen_oldmem_pfn_is_ram(unsigned long pfn)
 		.domid = DOMID_SELF,
 		.pfn = pfn,
 	};
-	int ram;
 
 	if (HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a))
 		return -ENXIO;
-
-	switch (a.mem_type) {
-	case HVMMEM_mmio_dm:
-		ram = 0;
-		break;
-	case HVMMEM_ram_rw:
-	case HVMMEM_ram_ro:
-	default:
-		ram = 1;
-		break;
-	}
-
-	return ram;
+	return a.mem_type != HVMMEM_mmio_dm;
 }
 #endif
 
-- 
2.31.1

