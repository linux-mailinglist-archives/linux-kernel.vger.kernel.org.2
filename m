Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624113D1688
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbhGUSBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 14:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbhGUSBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 14:01:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19102C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QAFE3m3sGfm0XHof4+1aoQntJ/lWm+TZn6x1+h/OpC0=; b=Ph89ZAA4aD3d30oY3o18nv8iGb
        /7JEcnDFcyBJhO9jTARxkPybXEPs2dWWC5OAr4/6chaGfOkkSuaRxlyq/TEf4RemeTrrx4lRL9kpT
        KbJLI8mUEVSkmB8c2zR5FjkP1/fVj5xHjbcuByyI9ZSCyiPEBsoBS5t0N6EzTNFMmBPR+w1stoFX3
        EIUAc16GkvjBNREPmf8f7LyjYxyA2+FsJKYCW9Rou6Re74Cvw2atNTPqTizJhwnqB61uGV1k/tjVr
        3EclEYaqmlZhdhZkaCIVN8QWbeqS8BcjIhmZ3nIa9+iDwq5OajjWiiC/feamQb5Wxukiy7x2DPUwg
        sMtWidJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6H9z-009V5o-23; Wed, 21 Jul 2021 18:41:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Qualys Security Advisory <qsa@qualys.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH] mm: Make kvmalloc refuse to allocate more than 2GB
Date:   Wed, 21 Jul 2021 19:41:31 +0100
Message-Id: <20210721184131.2264356-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's generally dangerous to allocate such large quantities of memory
within the kernel owing to our propensity to use 'int' to represent
a length.  If somebody really needs it, we can add a kvmalloc_large()
later, but let's default to "You can't allocate that much memory".

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/seq_file.c                                     | 3 ---
 mm/util.c                                         | 7 +++++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 4a2cda04d3e2..b117b212ef28 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -32,9 +32,6 @@ static void seq_set_overflow(struct seq_file *m)
 
 static void *seq_buf_alloc(unsigned long size)
 {
-	if (unlikely(size > MAX_RW_COUNT))
-		return NULL;
-
 	return kvmalloc(size, GFP_KERNEL_ACCOUNT);
 }
 
diff --git a/mm/util.c b/mm/util.c
index 9043d03750a7..8ff2a8924d5f 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -593,6 +593,13 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 	if (ret || size <= PAGE_SIZE)
 		return ret;
 
+	/*
+	 * Succeeding for sizes above 2GiB can lead to truncation if
+	 * someone casts the size to an int.
+	 */
+	if (size > INT_MAX)
+		return NULL;
+
 	return __vmalloc_node(size, 1, flags, node,
 			__builtin_return_address(0));
 }
-- 
2.30.2

