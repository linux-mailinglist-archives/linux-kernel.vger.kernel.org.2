Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776C23940BA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhE1KNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbhE1KNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:13:38 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2A2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CPXS1CZLh6h02odPz5k132SgjYx3UjKf90rsJb71X7w=; b=YcAsKzKRKWlE5q0ZFiwsFFYSSP
        klpuJ7Y27LDuUHo8UDk6eA0fkNPeOd2wT8fOdZloNb88qtFcKnS1+044Sa8U70lGfrp8P1sgd+GFx
        EX7PS0SmBOD5UIfAWx8JLqVj5ABXhH2u1WCf/NKwgq+YK5Od/e98O3jfHjBMRnOaXzNFuPWKf3dsZ
        Pty21wd8ABX94Z8JuOkTs6yxvZnVfKKqEHAxKGjYjsXkl8lYwGcvljciu1DRFXpEuwX8+zNHQNJF9
        4sBm7M+QZae/mF7XEIFWXgaffLfg6ZXPH/7H1htW7Ryqt2LmwvVrP86RrSYyz5aXbFKnlvtxzFTq9
        luxrAmnw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57320 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1lmZTB-0008Gy-Jh; Fri, 28 May 2021 11:11:57 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1lmZTB-0005UP-C9; Fri, 28 May 2021 11:11:57 +0100
In-Reply-To: <20210518120633.GW12395@shell.armlinux.org.uk>
References: <20210518120633.GW12395@shell.armlinux.org.uk>
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] ARM: use MiB for vmalloc sizes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1lmZTB-0005UP-C9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Fri, 28 May 2021 11:11:57 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than using "m" (which is the unit of metres, or milli), and
"MB" in the printk statements, use MiB to make it clear that we are
talking about the power-of-2 megabytes, aka mebibytes.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index d52647b6261c..a96e9420ec2a 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1128,7 +1128,7 @@ static unsigned long __initdata vmalloc_size = 240 * SZ_1M;
 /*
  * vmalloc=size forces the vmalloc area to be exactly 'size'
  * bytes. This can be used to increase (or decrease) the vmalloc
- * area - the default is 240m.
+ * area - the default is 240MiB.
  */
 static int __init early_vmalloc(char *arg)
 {
@@ -1137,14 +1137,14 @@ static int __init early_vmalloc(char *arg)
 
 	if (vmalloc_reserve < SZ_16M) {
 		vmalloc_reserve = SZ_16M;
-		pr_warn("vmalloc area too small, limiting to %luMB\n",
+		pr_warn("vmalloc area is too small, limiting to %luMiB\n",
 			vmalloc_reserve >> 20);
 	}
 
 	vmalloc_max = VMALLOC_END - (PAGE_OFFSET + SZ_32M + VMALLOC_OFFSET);
 	if (vmalloc_reserve > vmalloc_max) {
 		vmalloc_reserve = vmalloc_max;
-		pr_warn("vmalloc area is too big, limiting to %luMB\n",
+		pr_warn("vmalloc area is too big, limiting to %luMiB\n",
 			vmalloc_reserve >> 20);
 	}
 
-- 
2.20.1

