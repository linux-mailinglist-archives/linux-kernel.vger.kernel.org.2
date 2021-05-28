Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6EB3940B8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbhE1KNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236521AbhE1KN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:13:27 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E5BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 03:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ponfgRV4n6RGAITg3IztDQFPFc6M7q62uMq7kDRp4bw=; b=fMwB+VxKd5obpQ+OpPP1IeG0VF
        lys+pt+BzV4oyhqVdlpi5ghFh93i6yThDl5FvNCLVgnVpTombZQyuTjvFetkq9rfgRK7NUX233Pag
        /CXv1Ulbzks4/0JNk8jLfjofktOi/BK6t0JGzzBIE2+9NwK6C89VhJrKcXoqQwukT+9EQzdpT5wJg
        EqrmW1kwig/nFxENb6Jbiluxes0NzDwao4YdRPpO6BXv+qN59+g4cmKPuNdcQ5bYDCNKVLdWJDRYR
        V58VglX0wKWWxxQd5tx3dw4ooL6s6I3eKcH3rTm7qWYtMw53HKGNFm4lbIdyim3dXI1qeuqkUpX42
        F/31942A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57316 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1lmZT1-0008GE-By; Fri, 28 May 2021 11:11:47 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1lmZT1-0005Te-4i; Fri, 28 May 2021 11:11:47 +0100
In-Reply-To: <20210518120633.GW12395@shell.armlinux.org.uk>
References: <20210518120633.GW12395@shell.armlinux.org.uk>
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] ARM: change vmalloc_start to vmalloc_size
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1lmZT1-0005Te-4i@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Fri, 28 May 2021 11:11:47 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than storing the start of vmalloc space, store the size, and
move the calculation into adjust_lowmem_limit(). We now have one single
place where this calculation takes place.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index ed2846bdb1f4..5ae11e6f2a58 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1123,7 +1123,7 @@ void __init debug_ll_io_init(void)
 }
 #endif
 
-static unsigned long __initdata vmalloc_start = VMALLOC_END - (240 << 20);
+static unsigned long __initdata vmalloc_size = 240 << 20;
 
 /*
  * vmalloc=size forces the vmalloc area to be exactly 'size'
@@ -1148,7 +1148,7 @@ static int __init early_vmalloc(char *arg)
 			vmalloc_reserve >> 20);
 	}
 
-	vmalloc_start = VMALLOC_END - vmalloc_reserve;
+	vmalloc_size = vmalloc_reserve;
 	return 0;
 }
 early_param("vmalloc", early_vmalloc);
@@ -1168,7 +1168,7 @@ void __init adjust_lowmem_bounds(void)
 	 * and may itself be outside the valid range for which phys_addr_t
 	 * and therefore __pa() is defined.
 	 */
-	vmalloc_limit = (u64)vmalloc_start - VMALLOC_OFFSET -
+	vmalloc_limit = (u64)VMALLOC_END - vmalloc_size - VMALLOC_OFFSET -
 			PAGE_OFFSET + PHYS_OFFSET;
 
 	/*
-- 
2.20.1

