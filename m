Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8654206DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 09:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhJDH6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 03:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhJDH56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 03:57:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D188C061746
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=sEM3BPdzVY3/dR2zcinwoXa/ww1WSluj3d/TakcR2J4=; b=WfWtrFvRHlsqao5fP4ENEPXYjD
        zzXOSJ5850uW0KOcDbeOdzPvIJtU9g4MGLFMVLA9SBFWlRGHmby1sKnBk05IkaP1VTtLwuAMBnEXS
        g2sFXgfSkH7WE9Xh0qQHwu6ncE9j7RmHdIK0gegMskrZQFlOivZWFr1d8ruWLPMhX6k1vSzgJjGAQ
        ZkD6H+NAbdscLMQ1feCeVth32OgFYz+uef+MG6tCnZBcqsqm6rexooHvvIKaNdZLBRq6Wlv2b9Bk+
        U0v/xTfJQPtSEGJGuWSdoPjRNuDFi/0oGCBZKFcfuH/tOrfc7g/CQdWFEIHQNeziXRRbcax5qxddf
        96v2VHew==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXIpV-005YAx-Mz; Mon, 04 Oct 2021 07:56:09 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [RFC PATCH] NIOS2: irqflags: rename a redefined register name
Date:   Mon,  4 Oct 2021 00:56:06 -0700
Message-Id: <20211004075606.6229-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both arch/nios2/ and drivers/mmc/host/tmio_mmc.c define a macro
with the name "CTL_STATUS". Change the one in arch/nios2/ to be
"CTL_FSTATUS" (flags status) to eliminate the build warning.

In file included from ../drivers/mmc/host/tmio_mmc.c:22:
drivers/mmc/host/tmio_mmc.h:31: warning: "CTL_STATUS" redefined
   31 | #define CTL_STATUS 0x1c
arch/nios2/include/asm/registers.h:14: note: this is the location of the previous definition
   14 | #define CTL_STATUS      0

Fixes: b31ebd8055ea ("nios2: Nios2 registers")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/nios2/include/asm/irqflags.h  |    4 ++--
 arch/nios2/include/asm/registers.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20211001.orig/arch/nios2/include/asm/irqflags.h
+++ linux-next-20211001/arch/nios2/include/asm/irqflags.h
@@ -9,7 +9,7 @@
 
 static inline unsigned long arch_local_save_flags(void)
 {
-	return RDCTL(CTL_STATUS);
+	return RDCTL(CTL_FSTATUS);
 }
 
 /*
@@ -18,7 +18,7 @@ static inline unsigned long arch_local_s
  */
 static inline void arch_local_irq_restore(unsigned long flags)
 {
-	WRCTL(CTL_STATUS, flags);
+	WRCTL(CTL_FSTATUS, flags);
 }
 
 static inline void arch_local_irq_disable(void)
--- linux-next-20211001.orig/arch/nios2/include/asm/registers.h
+++ linux-next-20211001/arch/nios2/include/asm/registers.h
@@ -11,7 +11,7 @@
 #endif
 
 /* control register numbers */
-#define CTL_STATUS	0
+#define CTL_FSTATUS	0
 #define CTL_ESTATUS	1
 #define CTL_BSTATUS	2
 #define CTL_IENABLE	3
