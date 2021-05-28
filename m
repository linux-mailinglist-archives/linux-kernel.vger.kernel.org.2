Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D2E3940B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbhE1KNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbhE1KNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:13:17 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E63C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 03:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=maqY7sl4+rx4yI425J6cw483xpTMvyHoIpT/o1r9mzc=; b=OHPLV1MSGJ4eOs7gSpumRLfx+s
        3kXQoQKUf/2sLnU45Bd5H2ZdCIXbUX43G5OQO7q01WpQt50HRpIJyW/xrdLAcXjU+ChwEBGYXu3/8
        azgdV5oU/rDGTjvbBso8Ovy5eMdGdWDADN6yJTTsjslVAEnNXwr3Mj0A2WxCY1dmn1HLQTeeFv7bl
        WNmt9tQWwNVEkxzBTSdb/3jsp8qfBI7qT0GZJNNaSPeF450bhBDA1zrpNjnuTw6S9R1zWrUgr+oLE
        lAh6z+hBVDjt4ILp2drA3B0JuVONCPdIzWsmuq+vgmdx8vmpxj4kWMAIcPWr6UjH+6nldzhu4v9Lf
        b2AL6dbw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57312 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1lmZSr-0008FN-4J; Fri, 28 May 2021 11:11:37 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1lmZSq-0005Sv-TB; Fri, 28 May 2021 11:11:36 +0100
In-Reply-To: <20210518120633.GW12395@shell.armlinux.org.uk>
References: <20210518120633.GW12395@shell.armlinux.org.uk>
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] ARM: use a temporary variable to hold maximum vmalloc
 size
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1lmZSq-0005Sv-TB@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Fri, 28 May 2021 11:11:36 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We calculate the maximum size of the vmalloc space twice in
early_vmalloc(). Use a temporary variable to hold this value.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 206c345f063e..d932c46a02e0 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1134,6 +1134,7 @@ static unsigned long __initdata vmalloc_min =
 static int __init early_vmalloc(char *arg)
 {
 	unsigned long vmalloc_reserve = memparse(arg, NULL);
+	unsigned long vmalloc_max;
 
 	if (vmalloc_reserve < SZ_16M) {
 		vmalloc_reserve = SZ_16M;
@@ -1141,8 +1142,9 @@ static int __init early_vmalloc(char *arg)
 			vmalloc_reserve >> 20);
 	}
 
-	if (vmalloc_reserve > VMALLOC_END - (PAGE_OFFSET + SZ_32M)) {
-		vmalloc_reserve = VMALLOC_END - (PAGE_OFFSET + SZ_32M);
+	vmalloc_max = VMALLOC_END - (PAGE_OFFSET + SZ_32M);
+	if (vmalloc_reserve > vmalloc_max) {
+		vmalloc_reserve = vmalloc_max;
 		pr_warn("vmalloc area is too big, limiting to %luMB\n",
 			vmalloc_reserve >> 20);
 	}
-- 
2.20.1

