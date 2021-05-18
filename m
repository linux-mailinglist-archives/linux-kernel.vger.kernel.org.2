Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE11B387889
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245395AbhERMRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbhERMRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:17:05 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF75C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EVyVWL3Bw3em1SB7guIWDG8Dh2TRp8K8vFAoLmQuXg0=; b=dK1razk150t4Tfj9gcVwpAGT5B
        AhGa2Peh9q7nPF9Z8/VTi/wqCEACgq7gerlbNloPcsbVqJemGywd5klfOMz8jwi/QuANCChnGD+Et
        8yEYkc0SPRURXT0dCSqbBFKtHqp0mrP0ujlIB7Izx6ey8ZDH+EF36xuDq6v2Suc1dkSWL79Vy8V/r
        2bzipjqOo+oHFCMuaO7mNNq8DVlhfhecerI4+7lcFaonA8rWIIqBVUDssssOgQzwH2sxeSG9tulCm
        aaT2PMROkDNkxT2Uj8VTZH37APoa47Yox3tFOnD4PmYWJPSMU6gep9dM4nP42U6wq/cT2eJTKR1fX
        ehUyzWBw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55062 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1liydQ-0004GM-Jo; Tue, 18 May 2021 13:15:40 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1liydQ-0004Po-2c; Tue, 18 May 2021 13:15:40 +0100
In-Reply-To: <20210518120633.GW12395@shell.armlinux.org.uk>
References: <20210518120633.GW12395@shell.armlinux.org.uk>
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ARM: change vmalloc_min to be unsigned long
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1liydQ-0004Po-2c@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 18 May 2021 13:15:40 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmalloc_min is currently a void pointer, but everywhere its used
contains a cast - either to a void pointer when setting or back to
an integer type when being used. Eliminate these casts by changing
its type to unsigned long.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/mmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index c06ebfbc48c4..206c345f063e 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1123,8 +1123,8 @@ void __init debug_ll_io_init(void)
 }
 #endif
 
-static void * __initdata vmalloc_min =
-	(void *)(VMALLOC_END - (240 << 20) - VMALLOC_OFFSET);
+static unsigned long __initdata vmalloc_min =
+	VMALLOC_END - (240 << 20) - VMALLOC_OFFSET;
 
 /*
  * vmalloc=size forces the vmalloc area to be exactly 'size'
@@ -1147,7 +1147,7 @@ static int __init early_vmalloc(char *arg)
 			vmalloc_reserve >> 20);
 	}
 
-	vmalloc_min = (void *)(VMALLOC_END - vmalloc_reserve);
+	vmalloc_min = VMALLOC_END - vmalloc_reserve;
 	return 0;
 }
 early_param("vmalloc", early_vmalloc);
@@ -1167,7 +1167,7 @@ void __init adjust_lowmem_bounds(void)
 	 * and may itself be outside the valid range for which phys_addr_t
 	 * and therefore __pa() is defined.
 	 */
-	vmalloc_limit = (u64)(uintptr_t)vmalloc_min - PAGE_OFFSET + PHYS_OFFSET;
+	vmalloc_limit = (u64)vmalloc_min - PAGE_OFFSET + PHYS_OFFSET;
 
 	/*
 	 * The first usable region must be PMD aligned. Mark its start
-- 
2.20.1

