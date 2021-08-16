Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7135E3EDF05
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 23:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhHPVGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 17:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbhHPVGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 17:06:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7DFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 14:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=j4FGlKHzU+9QsIeL4bCA8FwQiqDc04xmmkeiNTCnd0w=; b=VF4MsJL4BjezM3z/K+B3WN3yqT
        b2XlR3fDiLOfH4hC8cWNwRl6IpQWUZUPYbuKyaOYtelhrVCNaqrxRLHoY6Lbbv6rUTvaUzBa6TqvM
        /7X5LIuopoc6cM/Rezog8OVyad4MIfVHvoy5VmUl6ESyRzVlaYzPScoRlnMPP3SNjjTNslQc7BM1c
        VUDtU+sH1TvAb4srXew3bxc/nNqOaderKDhQisucJ3lxgBiru9A+g8/RwOQGphKZeIVHHgK1Y1LFO
        Y4pyHSDfG1nXohCC4HyTLAVpHV4S+nKEJxPmiLDMKYQpfQLbWG/fbpzyYNkIveWrd8fexXT/047Ff
        A9Qb2iRw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFjna-000IV3-OE; Mon, 16 Aug 2021 21:05:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH] ARC: export clear_user_page() for modules
Date:   Mon, 16 Aug 2021 14:05:33 -0700
Message-Id: <20210816210533.16929-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0day bot reports a build error:
  ERROR: modpost: "clear_user_page" [drivers/media/v4l2-core/videobuf-dma-sg.ko] undefined!
so export it in arch/arc/ to fix the build error.

In most ARCHes, clear_user_page() is a macro. OTOH, in a few
ARCHes it is a function and needs to be exported.
PowerPC exported it in 2004. It looks like nds32 and nios2
still need to have it exported.

Fixes: 4102b53392d63 ("ARC: [mm] Aliasing VIPT dcache support 2/4")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/mm/cache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210816.orig/arch/arc/mm/cache.c
+++ linux-next-20210816/arch/arc/mm/cache.c
@@ -1041,7 +1041,7 @@ void clear_user_page(void *to, unsigned
 	clear_page(to);
 	clear_bit(PG_dc_clean, &page->flags);
 }
-
+EXPORT_SYMBOL(clear_user_page);
 
 /**********************************************************************
  * Explicit Cache flush request from user space via syscall
