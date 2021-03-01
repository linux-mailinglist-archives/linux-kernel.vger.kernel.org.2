Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4695327D8B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbhCALuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:50:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57599 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234169AbhCALt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614599281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uKNEfvMGS8/7Pghwx2da+Euw6cfO6beInGssap82mg4=;
        b=SXybfIZY7x6vsHMfs30oXMs7sjO/CabF2xPOgVGWCxaEil94WAeQa0u6xN64k3zfqBoHAF
        aIWWAjBMD7bdCTEUjlsJvL1H7PAveMpTp/rSafl4J3ceryTbeXXFSbalU8t0tynB71ImRm
        z9W+tDlOPj/8moo8CreSI2LTPHKCkvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-94CxkQcQOqyDT_d_dbCfNw-1; Mon, 01 Mar 2021 06:47:58 -0500
X-MC-Unique: 94CxkQcQOqyDT_d_dbCfNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 801AB107ACFB;
        Mon,  1 Mar 2021 11:47:56 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-87.ams2.redhat.com [10.36.114.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E855310013C1;
        Mon,  1 Mar 2021 11:47:49 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ira Weiny <ira.weiny@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v1] microblaze: tag highmem_setup() with __meminit
Date:   Mon,  1 Mar 2021 12:47:49 +0100
Message-Id: <20210301114749.47914-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit a0cd7a7c4bc0 ("mm: simplify free_highmem_page() and
free_reserved_page()") the kernel test robot complains about a warning:

WARNING: modpost: vmlinux.o(.text.unlikely+0x23ac): Section mismatch in
  reference from the function highmem_setup() to the function
  .meminit.text:memblock_is_reserved()

This has been broken ever since microblaze added highmem support,
because memblock_is_reserved() was already tagged with "__init" back then -
most probably the function always got inlined, so we never stumbled over
it.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 2f2f371f8907 ("microblaze: Highmem support")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/microblaze/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 181e48782e6c..05cf1fb3f5ff 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -52,7 +52,7 @@ static void __init highmem_init(void)
 	pkmap_page_table = virt_to_kpte(PKMAP_BASE);
 }
 
-static void highmem_setup(void)
+static void __meminit highmem_setup(void)
 {
 	unsigned long pfn;
 
-- 
2.29.2

