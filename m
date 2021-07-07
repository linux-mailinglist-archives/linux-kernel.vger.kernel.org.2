Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B8C3BEBDA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 18:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhGGQTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 12:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGGQTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:19:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F44C061574;
        Wed,  7 Jul 2021 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=8vx2MlWUn5LIhwKdzrV6SOg1W/EZtZtrXCT9CRbQ+0g=; b=FV3ssxZghmBYayxtp6VYSP6mZJ
        ornbpTVgIMpLa550CiIgjKoj8bx72CdZ6pYZ+ZNVQ20OhUwrGy8visAobOoNpHlSVngpCldM5SLYw
        o85Tz9QpNRBpHI4zUIBLX6RnKFyzsacv8sZ0sDjdO9nbLGQDa9MmZ53XR73AZVAc4PQ8BFMUL6kKI
        3RSLD7xjprLfKTs3bN4nCp03Jd5xgj0fOHsZRkqiRRLcK5RLCtwYeN327IVH35SFSnOiXBoxbQoAl
        LriR/x3fEMEGh6T/nxU8m68kdGPKrmaAV1U9PCZbHV8TrgOTTtgKHA6nwbTGVC+gCFR7liaLvPBdd
        jH6J6LwQ==;
Received: from [2601:1c0:6280:3f0::a22f] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1ADk-00FP2Q-8B; Wed, 07 Jul 2021 16:16:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, uclinux-dev@uclinux.org
Subject: [PATCH] mm: try_to_unmap() is now void
Date:   Wed,  7 Jul 2021 09:16:14 -0700
Message-Id: <20210707161614.13001-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the "CONFIG_MMU is not set" case of converting
try_to_unmap() from bool to void.
(as seen on m68k/coldfire)

In file included from ../mm/vmscan.c:33:
../mm/vmscan.c: In function 'shrink_page_list':
../include/linux/rmap.h:294:34: warning: statement with no effect [-Wunused-value]
  294 | #define try_to_unmap(page, refs) false
      |                                  ^~~~~
../mm/vmscan.c:1508:4: note: in expansion of macro 'try_to_unmap'
 1508 |    try_to_unmap(page, flags);
      |    ^~~~~~~~~~~~

Fixes: 1fb08ac63bee ("mm: rmap: make try_to_unmap() void function")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: uclinux-dev@uclinux.org
---
v2: add linux-mm m.l.
    add M68K/Coldfire Cc's
    change to static inline function.

 include/linux/rmap.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20210701.orig/include/linux/rmap.h
+++ linux-next-20210701/include/linux/rmap.h
@@ -291,7 +291,8 @@ static inline int page_referenced(struct
 	return 0;
 }
 
-#define try_to_unmap(page, refs) false
+static inline void try_to_unmap(struct page *page, enum ttu_flags flags)
+{}
 
 static inline int page_mkclean(struct page *page)
 {
