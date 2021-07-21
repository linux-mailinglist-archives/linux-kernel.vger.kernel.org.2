Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6133D0CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbhGUKOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 06:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbhGUKGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 06:06:16 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE8CC0610DF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:44:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cu14so1439760pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iFUwahSmjzwEO3iNL/tyqfaZAA7mIcEImQPSmKf6ov8=;
        b=Li9+WtqETLBhV/JQP66cuGPV8yJNrTiXyHeIizNhq8dWV4nVxd4XSjGkJnXDTbBpJA
         YnhMbrIYZo/Omzw/W0xqwXwLSYagTZ/FNE+hj6ZUT72g1cyMgnouieKGoAgCu2jY1rRv
         x7axV9bwZbmQNdq+CsMd1wnSIhXBlIN0wQQz+4TQXJC1cKNWdqIhlWLkdm891JnGKdTH
         FODeXsqHlrX2oDe5Kxx8K4oIfKZSgcqQ9OTe0GrNmWCLAVORUARraFefJk5QE3YPpu++
         y3ivxivbLUL8hbaURCWB65C/kHR9+5y76eczMAdSxA0AodrXv3ToleV+2p1L0oGjpreE
         yuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iFUwahSmjzwEO3iNL/tyqfaZAA7mIcEImQPSmKf6ov8=;
        b=fR0wc4rP6ybu2YI0VTYjSNIcoaIw8na6RvBIIzgvf7Sn2EpV65wuvD64Saxd7pLxE2
         TeaF+WPbM3+ItmXf39wO4ISSv42Nh2flhZPnI1D2Nw3p5Evt3yt9eGOBqfwcupmT6Pry
         66fQZ6BkXznILhgEAXU/X8euzhDPDPiLd6ZSwLauF8Bcv9awYfEhFtGECuETmXo1xY2E
         k/93OcB/0pdTC4BVxnQkFBibFnCUnkX2byGoDrNrAowPnlXVsIKGnPIxbdApMMxfehYw
         OicR4KHUS3o43On+1UZzz2wQcSp9f0QztPUFq9j4euXEGLqa6IAPLBJJ2zhSfEvfHJ6l
         w47g==
X-Gm-Message-State: AOAM530oGn8wTmaKtJGBHIVdXcXsYt9QQiien9uRRJTKnt8NAHyXr5Gb
        OSSPN69N6ygBxoemOlWh3Fc=
X-Google-Smtp-Source: ABdhPJz4f+r9jmRbY0sqHuYuIM0bdz13iA0DYKeoLSez28UkKZJTjZ8MJmq+aUu1Xc3ZCP1y7KzchA==
X-Received: by 2002:a17:90a:c095:: with SMTP id o21mr34755519pjs.53.1626864290666;
        Wed, 21 Jul 2021 03:44:50 -0700 (PDT)
Received: from localhost.localdomain ([2604:a880:1:20::1f:7001])
        by smtp.gmail.com with ESMTPSA id 85sm26965182pfz.76.2021.07.21.03.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 03:44:50 -0700 (PDT)
From:   Wende Tan <twd2.me@gmail.com>
To:     geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org
Cc:     Wende Tan <twd2.me@gmail.com>, linux-kernel@vger.kernel.org,
        lkp@intel.com
Subject: [PATCH] m68k: Remove redefinitions of `PMD_SIZE`, `PMD_MASK`, etc.
Date:   Wed, 21 Jul 2021 10:43:18 +0000
Message-Id: <20210721104318.1070133-1-twd2.me@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redefinitions of `PMD_SIZE`, `PMD_MASK`, `PTRS_PER_PMD`,
and `__PAGETABLE_PMD_FOLDED` when PGTABLE_LEVELS == 2 (i.e. SUN3 ||
COLDFIRE).  They have already been defined in
`asm-generic/pgtable-nopmd.h`.

See also https://lore.kernel.org/lkml/202107201907.lqC6B3dF-lkp@intel.com/#t

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Wende Tan <twd2.me@gmail.com>
---
 arch/m68k/include/asm/pgtable_mm.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index 143ba7de9bda..51653e8216a7 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -37,9 +37,9 @@
 /* PMD_SHIFT determines the size of the area a second-level page table can map */
 #if CONFIG_PGTABLE_LEVELS == 3
 #define PMD_SHIFT	18
-#endif
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
+#endif
 
 /* PGDIR_SHIFT determines what a third-level page table entry can map */
 #ifdef CONFIG_SUN3
@@ -58,13 +58,9 @@
  */
 #ifdef CONFIG_SUN3
 #define PTRS_PER_PTE   16
-#define __PAGETABLE_PMD_FOLDED 1
-#define PTRS_PER_PMD   1
 #define PTRS_PER_PGD   2048
 #elif defined(CONFIG_COLDFIRE)
 #define PTRS_PER_PTE	512
-#define __PAGETABLE_PMD_FOLDED 1
-#define PTRS_PER_PMD	1
 #define PTRS_PER_PGD	1024
 #else
 #define PTRS_PER_PTE	64
-- 
2.25.1

