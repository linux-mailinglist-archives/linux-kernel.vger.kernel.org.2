Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1D03940B7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbhE1KN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbhE1KNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:13:22 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C256C061761
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 03:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tDq4c1VX/bGIybAa5Df0z3WGi+MaHzacqg5gefl0XfI=; b=zLLmaq0ncVKobTElxR0hX8gx0M
        WpZEmAbmAfSiPWddEvd9XG6LdKEasu9aZ766BkIY/YggoESAwVk9njzrlcq8u9rGhYoxlS/CeIViP
        WIm7+Jw66iyhFbjHywmAPuwuKt0t/iKJm5T9x+lFwmBl61qeBZKpscM/I9YePE1+5dnB9W+Z8jZKy
        ei7roynrG6Yn3iYwQuFxPf9l6e+A0rpry0nwiLDxUUcEOVTbc70FpAr6GTlEr8gbWTTnAat+Ga6QG
        iCpR2mJPOMTyvDv5Od+3cJjsIy3egupRr29D44Ej0IGHj7iM6w9Xp7dQG8qiyvJdBAZ6RVRh5BDnd
        qLal7yQQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57314 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1lmZSw-0008Fq-8O; Fri, 28 May 2021 11:11:42 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1lmZSw-0005TI-0s; Fri, 28 May 2021 11:11:42 +0100
In-Reply-To: <20210518120633.GW12395@shell.armlinux.org.uk>
References: <20210518120633.GW12395@shell.armlinux.org.uk>
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] ARM: change vmalloc_min to vmalloc_start
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1lmZSw-0005TI-0s@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Fri, 28 May 2021 11:11:42 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the current vmalloc_min, which is supposed to be the lowest
address of vmalloc space including the VMALLOC_OFFSET, to vmalloc_start
which does not include VMALLOC_OFFSET.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/mmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index d932c46a02e0..ed2846bdb1f4 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1123,8 +1123,7 @@ void __init debug_ll_io_init(void)
 }
 #endif
 
-static unsigned long __initdata vmalloc_min =
-	VMALLOC_END - (240 << 20) - VMALLOC_OFFSET;
+static unsigned long __initdata vmalloc_start = VMALLOC_END - (240 << 20);
 
 /*
  * vmalloc=size forces the vmalloc area to be exactly 'size'
@@ -1142,14 +1141,14 @@ static int __init early_vmalloc(char *arg)
 			vmalloc_reserve >> 20);
 	}
 
-	vmalloc_max = VMALLOC_END - (PAGE_OFFSET + SZ_32M);
+	vmalloc_max = VMALLOC_END - (PAGE_OFFSET + SZ_32M + VMALLOC_OFFSET);
 	if (vmalloc_reserve > vmalloc_max) {
 		vmalloc_reserve = vmalloc_max;
 		pr_warn("vmalloc area is too big, limiting to %luMB\n",
 			vmalloc_reserve >> 20);
 	}
 
-	vmalloc_min = VMALLOC_END - vmalloc_reserve;
+	vmalloc_start = VMALLOC_END - vmalloc_reserve;
 	return 0;
 }
 early_param("vmalloc", early_vmalloc);
@@ -1169,7 +1168,8 @@ void __init adjust_lowmem_bounds(void)
 	 * and may itself be outside the valid range for which phys_addr_t
 	 * and therefore __pa() is defined.
 	 */
-	vmalloc_limit = (u64)vmalloc_min - PAGE_OFFSET + PHYS_OFFSET;
+	vmalloc_limit = (u64)vmalloc_start - VMALLOC_OFFSET -
+			PAGE_OFFSET + PHYS_OFFSET;
 
 	/*
 	 * The first usable region must be PMD aligned. Mark its start
-- 
2.20.1

