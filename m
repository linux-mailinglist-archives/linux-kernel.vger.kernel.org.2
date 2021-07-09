Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A8E3C232E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 13:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhGIL4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 07:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhGIL4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 07:56:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBE6C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 04:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=U+PS0r56p1czWmgOyRMC+O7c3al/sdChLeRO3PiTS2c=; b=dAIK2gbgu/NIr1Y6lyMBzWg7B6
        oO5Dt95GblJO0PeXKml3uKdJH0o9KIJcChxQ2AC0fY/cgKyUWwf4gJCPQ2tjEMZCwtIRGQgZXD8rD
        yx/uuGTvh9aLDxC5X27r4Uu4QUkjKsWCW//wrMDtFG3EfG5W+fH6uGgmAoO2/ZqqgzJlUiXTKuYYm
        x4W7W+kUjz8WmYEJfeQ3+LAYXF2OM402CUUynCBix9vAEedkpDF+VYtviUu9MjQD1SlQJMa2frDRr
        VYh8/pgoaenHKeWOzNdXYYCShN5O1tHKTs0xKW9B4/wD1QIqGx6wAmhZUzs3/1uOEL7qpJNXdWiK1
        dctLJuLQ==;
Received: from p4fdb05cb.dip0.t-ipconnect.de ([79.219.5.203] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1p4L-00ETAs-Fy; Fri, 09 Jul 2021 11:53:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     uclinux-h8-devel@lists.sourceforge.jp, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] h8300: remove memory.c
Date:   Fri,  9 Jul 2021 13:53:10 +0200
Message-Id: <20210709115311.3424912-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709115311.3424912-1-hch@lst.de>
References: <20210709115311.3424912-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the empty stubs defined in this file are used or even declared
in a header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/h8300/mm/Makefile |  2 +-
 arch/h8300/mm/memory.c | 53 ------------------------------------------
 2 files changed, 1 insertion(+), 54 deletions(-)
 delete mode 100644 arch/h8300/mm/memory.c

diff --git a/arch/h8300/mm/Makefile b/arch/h8300/mm/Makefile
index e85b5c91f5bc..a62be6137846 100644
--- a/arch/h8300/mm/Makefile
+++ b/arch/h8300/mm/Makefile
@@ -3,4 +3,4 @@
 # Makefile for the linux h8300-specific parts of the memory manager.
 #
 
-obj-y	 := init.o fault.o memory.o
+obj-y	 := init.o fault.o
diff --git a/arch/h8300/mm/memory.c b/arch/h8300/mm/memory.c
deleted file mode 100644
index 4a60e2b5eb96..000000000000
--- a/arch/h8300/mm/memory.c
+++ /dev/null
@@ -1,53 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  linux/arch/h8300/mm/memory.c
- *
- *  Copyright (C) 2002  Yoshinori Sato <ysato@users.sourceforge.jp>,
- *
- *  Based on:
- *
- *  linux/arch/m68knommu/mm/memory.c
- *
- *  Copyright (C) 1998  Kenneth Albanowski <kjahds@kjahds.com>,
- *  Copyright (C) 1999-2002, Greg Ungerer (gerg@snapgear.com)
- *
- *  Based on:
- *
- *  linux/arch/m68k/mm/memory.c
- *
- *  Copyright (C) 1995  Hamish Macdonald
- */
-
-#include <linux/mm.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/types.h>
-
-#include <asm/setup.h>
-#include <asm/segment.h>
-#include <asm/page.h>
-#include <asm/traps.h>
-#include <asm/io.h>
-
-void cache_clear(unsigned long paddr, int len)
-{
-}
-
-
-void cache_push(unsigned long paddr, int len)
-{
-}
-
-void cache_push_v(unsigned long vaddr, int len)
-{
-}
-
-/*
- * Map some physical address range into the kernel address space.
- */
-
-unsigned long kernel_map(unsigned long paddr, unsigned long size,
-			 int nocacheflag, unsigned long *memavailp)
-{
-	return paddr;
-}
-- 
2.30.2

