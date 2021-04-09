Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E65F359241
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhDICz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhDICzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:55:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03A0C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 19:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jkep815rQsW7lf6ktk7SzgrJdETDPXjHvjlpMlUGaXo=; b=Et8v/+dQLuobdQ6C173h7lvFsy
        GRW0JyW7IeYHkZrztUEPjVARj191fZsZlZ8HwjAtMUVH128gcHRuIE/fjSVQHMIU/3DL12KNv8mu6
        ZK0ZfOV2l2dCBbRonXJkH5RJQxS6nOynoNGmqkEKei6XtQriqU/krDrmFmppO5lRIIwet/zIB5lIg
        oakhBRz2WMGHt2Q8XVCma7O62NWBmkgaH6rW7Ife0JIcmTKqvkhFFAYtOx383eqw+HECh542lyb2x
        Axua61f5b1+swiR4EsHcXiH1RsD5ib1+TZZROlVYcwSWTdpNqKCIK57l0a7JSAFjeFwvuqaGZuPBM
        Xg0vJ95A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhHC-00HGXD-8J; Fri, 09 Apr 2021 02:53:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/17] hlist_bl: Prepare for split_locks
Date:   Fri,  9 Apr 2021 03:51:18 +0100
Message-Id: <20210409025131.4114078-5-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make hlist_bl_lock() and hlist_bl_unlock() variadic to help with the
transition.  Also add hlist_bl_lock_nested().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/list_bl.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index ae1b541446c9..1bfdb441c8bc 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -143,12 +143,19 @@ static inline void hlist_bl_del_init(struct hlist_bl_node *n)
 	}
 }
 
-static inline void hlist_bl_lock(struct hlist_bl_head *b)
+static inline void hlist_bl_lock(struct hlist_bl_head *b, ...)
 {
 	bit_spin_lock(0, (unsigned long *)b);
 }
 
-static inline void hlist_bl_unlock(struct hlist_bl_head *b)
+static inline void hlist_bl_lock_nested(struct hlist_bl_head *b,
+		struct split_lock *sl, unsigned int subclass)
+{
+	bit_spin_lock_nested(0, (unsigned long *)b, sl, subclass);
+}
+
+static inline void hlist_bl_unlock(struct hlist_bl_head *b,
+					...)
 {
 	__bit_spin_unlock(0, (unsigned long *)b);
 }
-- 
2.30.2

