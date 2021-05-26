Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6CF391126
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 09:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhEZHFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 03:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhEZHFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 03:05:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C16AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 00:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=4iv36n1K6MkUcVxqFCU/Xv1eTROW3KyDKpH9X4TSDgY=; b=Mv2RrmZkwaLn5FLQ/RcI8aBTCB
        F5NdpjO8spEm6t7fHjpD5JYngWF3cumsRMY1eSh8eIvDJTiMG8d3kLnLvaRreVJ31OF8JK3V9NfXm
        UQfdfJ8K4ktXlVvrh/eq6wK+zTMaFXlOICdGUeXYV1EZg+rzvmN97PL29CJzr58judGExfde2PXsg
        cmN3s62Y96x6a4DCWbTOg4Wy4y56M1UqkFBkqA14+rewXitFMxq0fHiy/juueTyO/Y/U+UBTV/JhU
        BYYp9Ppf6QLxISdzodJ2bi0HCgvfVYIqeeO6PqR5HXv7bKLqnwf2zXy1JHYHtDm/9gLp7ZFlwZiia
        vA3Pqz1A==;
Received: from [2601:1c0:6280:3f0::1c1d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1llnZq-00Brtx-9P; Wed, 26 May 2021 07:03:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org
Subject: [PATCH] xtensa: fix kconfig unmet dependency warning for HAVE_FUTEX_CMPXCHG
Date:   Wed, 26 May 2021 00:03:37 -0700
Message-Id: <20210526070337.28130-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XTENSA should only select HAVE_FUTEX_CMPXCHG when FUTEX is
set/enabled. This prevents a kconfig warning.

WARNING: unmet direct dependencies detected for HAVE_FUTEX_CMPXCHG
  Depends on [n]: FUTEX [=n]
  Selected by [y]:
  - XTENSA [=y] && !MMU [=n]

Fixes: d951ba21b959 ("xtensa: nommu: select HAVE_FUTEX_CMPXCHG")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: linux-xtensa@linux-xtensa.org
---
 arch/xtensa/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210525.orig/arch/xtensa/Kconfig
+++ linux-next-20210525/arch/xtensa/Kconfig
@@ -30,7 +30,7 @@ config XTENSA
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_EXIT_THREAD
 	select HAVE_FUNCTION_TRACER
-	select HAVE_FUTEX_CMPXCHG if !MMU
+	select HAVE_FUTEX_CMPXCHG if !MMU && FUTEX
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_PCI
