Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6604B376A26
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 20:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhEGStk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 14:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEGSti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 14:49:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9414C061574;
        Fri,  7 May 2021 11:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=nlmrWt3RdCjxd40aRkl4OMBCYBjOlN6FJnUkKCOtyzg=; b=C30Z4AOZ9HjHYWUODHEmdtm1vz
        HUNCxLCSeALzbf2821w5LxTsKsra21lnzVi2Q0HLc5wUGgrrTfUYKvgATfK6PFzsT+TQjeq65G+hn
        hY3crME0FDfqNNCJVET0G0z7QOLr9dHs/R6CGHYl+mxwY2gmQO+3EkWKZb+yOY2yezyveWGSGNQid
        aMEJjGQcYc3wY3qkPusNpsbxDPnIiIktPnj2u6HsjH++fNPldVUgifKYfuwYV14Alud/xhlWun3Un
        OEz1o31+d80VtBWP7kIUD/O9RWxrKBC0q/lWj+UxvXRsokrRexzyife8TeTTw9BFWYPmgXNjkWyEt
        2Wa8/yMw==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lf5Wf-0076tv-Qg; Fri, 07 May 2021 18:48:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH v2] ia64: headers: drop duplicated words
Date:   Fri,  7 May 2021 11:48:37 -0700
Message-Id: <20210507184837.10754-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated words "to" and "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
---
v2: combine 3 patches; drop previous perfmon patches (files have been
    removed); rebase & resend

 arch/ia64/include/asm/pal.h       |    2 +-
 arch/ia64/include/asm/spinlock.h  |    2 +-
 arch/ia64/include/asm/uv/uv_hub.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20210507.orig/arch/ia64/include/asm/pal.h
+++ linux-next-20210507/arch/ia64/include/asm/pal.h
@@ -1086,7 +1086,7 @@ static inline long ia64_pal_freq_base(un
 
 /*
  * Get the ratios for processor frequency, bus frequency and interval timer to
- * to base frequency of the platform
+ * the base frequency of the platform
  */
 static inline s64
 ia64_pal_freq_ratios (struct pal_freq_ratio *proc_ratio, struct pal_freq_ratio *bus_ratio,
--- linux-next-20210507.orig/arch/ia64/include/asm/spinlock.h
+++ linux-next-20210507/arch/ia64/include/asm/spinlock.h
@@ -26,7 +26,7 @@
  * the queue, and the other indicating the current tail. The lock is acquired
  * by atomically noting the tail and incrementing it by one (thus adding
  * ourself to the queue and noting our position), then waiting until the head
- * becomes equal to the the initial value of the tail.
+ * becomes equal to the initial value of the tail.
  * The pad bits in the middle are used to prevent the next_ticket number
  * overflowing into the now_serving number.
  *
--- linux-next-20210507.orig/arch/ia64/include/asm/uv/uv_hub.h
+++ linux-next-20210507/arch/ia64/include/asm/uv/uv_hub.h
@@ -257,7 +257,7 @@ static inline int uv_numa_blade_id(void)
 	return 0;
 }
 
-/* Convert a cpu number to the the UV blade number */
+/* Convert a cpu number to the UV blade number */
 static inline int uv_cpu_to_blade_id(int cpu)
 {
 	return 0;
