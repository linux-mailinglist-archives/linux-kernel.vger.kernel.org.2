Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263E738788C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348783AbhERMRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245743AbhERMRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:17:18 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD01EC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=c2+F1zL32ImCnk7eIDJcr6c8d1xl1EJQ2Q5jtE+xhe8=; b=qqVcKxdipNAJBlgI6I2/5CndBt
        ufDfSi768Za5cfaBlc9LPPE0WmqrzTSaReiLT9mgPbEa0SxyGTOSyaNg3EDN9U0W+hfqGxoBDsGsz
        Bd4aK+9sazpX9HkKOb/UV8wUb3Z1Z0eydI9Ow9es4C44r3OrIGQHsuF8uCLib4YqC4xPwIxHtWsdP
        i7lcs6arJm/2VKYnKEQlQKKXLO0ZKTRR0ILTVIiMR4x7moY/pDts6IAOqrM6h6gaAfL7VFNGTG1Sv
        utFcmRuHGIM20OeMxQ+k+7xbN4Y5mFKswRhYBBmKrZUtVDM4Fq4oG3RyXD0EiaPNaMt7Y85plLGa6
        NCW2nBIw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55068 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1liydg-0004HU-0u; Tue, 18 May 2021 13:15:56 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1liydf-0005BQ-PY; Tue, 18 May 2021 13:15:55 +0100
In-Reply-To: <20210518120633.GW12395@shell.armlinux.org.uk>
References: <20210518120633.GW12395@shell.armlinux.org.uk>
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ARM: change vmalloc_start to vmalloc_size
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1liydf-0005BQ-PY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 18 May 2021 13:15:55 +0100
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
index 457203b41ceb..2c74f1230cc7 100644
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
-	vmalloc_limit = (u64)vmalloc_start -
+	vmalloc_limit = (u64)(VMALLOC_END - vmalloc_size) -
 			(PAGE_OFFSET + PHYS_OFFSET + VMALLOC_OFFSET);
 
 	/*
-- 
2.20.1

