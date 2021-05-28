Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976713940B9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbhE1KNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbhE1KNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:13:31 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF133C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 03:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G6wkOh1WLxhd+f66+CKgFtR4EGi7L3gk2cUf6TM1Sec=; b=Y6FTvAenXvqUy+4V2Y4jmyA5ib
        gU/m/lejvRbXTsgDY7jsZQMw1p+1B3bDvdXgpz3acUPQigCnDkZ6l4+IGm/tD7R/KFbOHVXiDqq+s
        w9f1JDZcT7mFiXNP7bAs7bAMOwVN2G0n4FUoeiH2HW0h0rKICSEG7ltRliIdKIYhs/l8Uh7KX1TRT
        X0O+y6xjYOhJLjRVUgd/U11yVAyOX0GFELz7v8rytAR8TCGNj7jcfcDVxGYNctqqTrTslctLCifxk
        pnbF7B9wkgsmlRPHjCG9v3uDjAhCJ+ISLRfJ77xiCE7WqzTkbdJMjiIQw7ktoACl/bqX2Oj6fGdoW
        OQl79WhQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57318 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1lmZT6-0008Gc-Ff; Fri, 28 May 2021 11:11:52 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1lmZT6-0005U2-8e; Fri, 28 May 2021 11:11:52 +0100
In-Reply-To: <20210518120633.GW12395@shell.armlinux.org.uk>
References: <20210518120633.GW12395@shell.armlinux.org.uk>
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Yanfei Xu <yanfei.xu@windriver.com>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] ARM: use "* SZ_1M" rather than "<< 20"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1lmZT6-0005U2-8e@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Fri, 28 May 2021 11:11:52 +0100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the default vmalloc size clearer by using a more natural
multiplication by SZ_1M rather than a shift left by 20 bits.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 5ae11e6f2a58..d52647b6261c 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1123,7 +1123,7 @@ void __init debug_ll_io_init(void)
 }
 #endif
 
-static unsigned long __initdata vmalloc_size = 240 << 20;
+static unsigned long __initdata vmalloc_size = 240 * SZ_1M;
 
 /*
  * vmalloc=size forces the vmalloc area to be exactly 'size'
-- 
2.20.1

