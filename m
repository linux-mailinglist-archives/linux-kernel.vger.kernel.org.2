Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2371359252
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhDIC7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhDIC7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:59:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE6AC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 19:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y3TQEqn5ylGWELY/as1PcKlhOh1rEwYlY0ua0D88fMM=; b=lIhCvtx83cGqIWXPDabZMC2ln1
        WOD9+8VDtbNaQl3GTpRyJm+AYmli0w30O70A8zZ1gUiQcblsGHs6qtQq7gCxbbjHTGlaUROzMGDK5
        ykY3cnt15M6y18TS9DeIIPnsK2EyMtoR/2MDUomRSCivokoWQMxH0lc1MxWwtZMXhGMM0lsg8iuUs
        FP6D0ARqEX4mKzD1PDpWaPlCD5tT32u1LptcZ+ouf5Zt0MVmqVEpIoiV6LmADDYlpX4gzurO3Iclx
        UXWXD6NeLc663L6qe8FMJ2Wt2M5FOJ0/QSiY/hTmRPzF8Tt8UKTTW0TiBJgb29Ljohi6WLYE8Ni73
        4Y4msNVw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhKR-00HGnR-KB; Fri, 09 Apr 2021 02:57:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/17] hlist_bl: Make the split_lock parameter mandatory
Date:   Fri,  9 Apr 2021 03:51:24 +0100
Message-Id: <20210409025131.4114078-11-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all users have been converted, require the split_lock parameter
be passed to hlist_bl_lock() and hlist_bl_unlock().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/list_bl.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index 1bfdb441c8bc..eb1faa4a4e8c 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -143,9 +143,9 @@ static inline void hlist_bl_del_init(struct hlist_bl_node *n)
 	}
 }
 
-static inline void hlist_bl_lock(struct hlist_bl_head *b, ...)
+static inline void hlist_bl_lock(struct hlist_bl_head *b, struct split_lock *sl)
 {
-	bit_spin_lock(0, (unsigned long *)b);
+	bit_spin_lock(0, (unsigned long *)b, sl);
 }
 
 static inline void hlist_bl_lock_nested(struct hlist_bl_head *b,
@@ -155,9 +155,9 @@ static inline void hlist_bl_lock_nested(struct hlist_bl_head *b,
 }
 
 static inline void hlist_bl_unlock(struct hlist_bl_head *b,
-					...)
+					struct split_lock *sl)
 {
-	__bit_spin_unlock(0, (unsigned long *)b);
+	__bit_spin_unlock(0, (unsigned long *)b, sl);
 }
 
 static inline bool hlist_bl_is_locked(struct hlist_bl_head *b)
-- 
2.30.2

