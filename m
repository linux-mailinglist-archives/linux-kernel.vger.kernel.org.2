Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8E838788B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbhERMRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245356AbhERMRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:17:13 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A70C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tXsdohr9dsfiFfYjt4EoeiJaXMMYDvnBILSMVxKeA40=; b=ntVXk9vQhlEMBA3K6nALoQffR3
        5o0C1XtG5gRZ/dgoOY1q2bKmOgyvvS+hffoJ3k8M/L9FhPE+y7BzQ/hl6uj7lic9+4/2m+/oJOKis
        pOxZyGYuNQzwqcbOGqLUvJSZRT2RxeKqr20yL2ouVjH7Z1EYn55qVRcaySvuj3uXdBDCHmOQwzgAe
        psEAd7bqPUssNGTf/22hUGiGWN63Mjy6wMN+9pAhrSwzLbMEr2phgd0eEDz9hDaI8uLFS1qZoFxWs
        LmcN7KboonS5jokv28+aGXmaIQy9nRuyc3uiPVdReRgYg1w10b/G2plrQ83mvv4KHVRjSnBAuLCRM
        qmtyXQSQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55066 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1liyda-0004H8-Sc; Tue, 18 May 2021 13:15:50 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1liyda-0005B4-Kk; Tue, 18 May 2021 13:15:50 +0100
In-Reply-To: <20210518120633.GW12395@shell.armlinux.org.uk>
References: <20210518120633.GW12395@shell.armlinux.org.uk>
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ARM: change vmalloc_min to vmalloc_start
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1liyda-0005B4-Kk@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 18 May 2021 13:15:50 +0100
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
index d932c46a02e0..457203b41ceb 100644
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
+	vmalloc_limit = (u64)vmalloc_start -
+			(PAGE_OFFSET + PHYS_OFFSET + VMALLOC_OFFSET);
 
 	/*
 	 * The first usable region must be PMD aligned. Mark its start
-- 
2.20.1

