Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD95359262
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhDIDCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhDIDCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:02:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE39FC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 20:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=byDjZSIxNauly9aoLpQzt14Js28JNwt3koY8qFYLlj4=; b=LAAKnOaA3ygZn6bdBSy3KIc7Jn
        OA2EH/tQNzmSGFIp0Rkh2k6fA0n4Kkfg3jobvn/UIkmUMbrDInkJlKCzXbczdDLnGse8i+VjOZjNz
        DHgqhHxnaItJTbTRdmnXQbZa3fyVqRQgXkgF2yDoFQMxDlinLLUOZcaCkIkULoJ85E3XY1ygN+gZd
        gQ4uX9vFW0WoFkVs94kUXi4xRhS1m02spgQRyd1j0CKUnWh/eYcFmT7klpenupsKIy2g2wiRqeXRs
        L0fm18+mIFjF+2sdkSauJbxUNuZVdg/lJ4bylkt/eNi1HLUkrSTq4twaMZAqV/qqyOs9hpqj02izi
        3DEQ2jHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhNl-00HH3s-3t; Fri, 09 Apr 2021 03:00:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/17] zsmalloc: Add zs_pin_lock
Date:   Fri,  9 Apr 2021 03:51:29 +0100
Message-Id: <20210409025131.4114078-16-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow lockdep to track zsmalloc's pin bit spin lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/zsmalloc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 9a7c91c14b84..9d89a1857901 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -874,6 +874,8 @@ static unsigned long obj_to_head(struct page *page, void *obj)
 		return *(unsigned long *)obj;
 }
 
+static DEFINE_SPLIT_LOCK(zs_pin_lock);
+
 static inline int testpin_tag(unsigned long handle)
 {
 	return bit_spin_is_locked(HANDLE_PIN_BIT, (unsigned long *)handle);
@@ -881,17 +883,20 @@ static inline int testpin_tag(unsigned long handle)
 
 static inline int trypin_tag(unsigned long handle)
 {
-	return bit_spin_trylock(HANDLE_PIN_BIT, (unsigned long *)handle);
+	return bit_spin_trylock(HANDLE_PIN_BIT, (unsigned long *)handle,
+				&zs_pin_lock);
 }
 
 static void pin_tag(unsigned long handle) __acquires(bitlock)
 {
-	bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle);
+	bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle,
+			&zs_pin_lock);
 }
 
 static void unpin_tag(unsigned long handle) __releases(bitlock)
 {
-	bit_spin_unlock(HANDLE_PIN_BIT, (unsigned long *)handle);
+	bit_spin_unlock(HANDLE_PIN_BIT, (unsigned long *)handle,
+			&zs_pin_lock);
 }
 
 static void reset_page(struct page *page)
-- 
2.30.2

