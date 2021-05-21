Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A2338CE73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhEUUAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 16:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhEUUAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 16:00:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8626C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PlWT/h/uFlRbuF6+X3hEtWq9PabKtBmphm+LVJuqNQk=; b=mumXUlDrNRn9c9v9ouEjIXw0o1
        xf4CMIfuWVLlKf3dE7YR5RC4Q8pdRXyYILl+uyGZe2aHLImdsqeC3OsUcybEuwRZPDJ/4Bgq6Bv+T
        BGJahU7pUTHDy7waI3PIBUXg/xmEg3Eoqp0xyMjt5w15uukc+F6bXVPhaEfjVgAsFW3C2u81PL4rJ
        rVJlIfBBCjKaC7n0RhWVN7hWBC2vRtfsMaINu7xFf7LUQ7mWtb3tB/gHLeGRYY53IpHDKz31ppLoP
        mSFSYNIaXgNNYC3J1pIRNKwswQ16If/a5/Hutq7TN+W8uanGH7XSrPB32ADneHGrC9SLYFnCDufmD
        KYbrPpeA==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkBIl-00HOY7-M2; Fri, 21 May 2021 19:59:19 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH] x86: fixmap: use CONFIG_NR_CPUS instead of NR_CPUS
Date:   Fri, 21 May 2021 12:59:18 -0700
Message-Id: <20210521195918.2183-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use CONFIG_NR_CPUS instead of NR_CPUS for an enum entry item.
(Alternatively, #include <linux/threads.h> unconditionally instead of
conditionally.)

This fixes 100+ build errors like so:

In file included from ../include/asm-generic/early_ioremap.h:6:0,
                 from ./arch/x86/include/generated/asm/early_ioremap.h:1,
                 from ../arch/x86/include/asm/io.h:44,
                 from ../include/linux/io.h:13,
                 from ../mm/early_ioremap.c:13:
../arch/x86/include/asm/fixmap.h:103:48: error: ‘NR_CPUS’ undeclared here (not in a function); did you mean ‘NR_OPEN’?
  FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,

Fixes: e972c2511967 ("mm/early_ioremap: add prototype for early_memremap_pgprot_adjust")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Mel Gorman <mgorman@techsingularity.net>
---
 arch/x86/include/asm/fixmap.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210521.orig/arch/x86/include/asm/fixmap.h
+++ linux-next-20210521/arch/x86/include/asm/fixmap.h
@@ -100,7 +100,7 @@ enum fixed_addresses {
 #endif
 #ifdef CONFIG_KMAP_LOCAL
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
-	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
+	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * CONFIG_NR_CPUS) - 1,
 #ifdef CONFIG_PCI_MMCONFIG
 	FIX_PCIE_MCFG,
 #endif
