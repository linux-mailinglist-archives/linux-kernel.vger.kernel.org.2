Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E07359253
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhDIC74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhDIC7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:59:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C713BC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 19:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=J+A/vhImP4f76pYJ5z4mHb4pk35cglXNtUbl+b2SAbw=; b=WOtgx/VF7VM7CECPt0Pk+teR16
        HVXwlwG6w/ula5RMhiL0lLdJDdzd2WiDmk4U0r5O5KZ2aIkrTbbiPi6tQzh1PUJ8i3fSmMfpdyg/7
        YwdsUEuEiQ+qIBgiVK+9OC8yn5G7UtWWfNOBXmjRPyiqkcHVfWurTdsKrsAXI7elM8kz3A+44y7N+
        VRm6yvHax4v4GgMxNX3rHR/6h5tF1JqiqCGw+83uiugl+sdR8i3J+S/9ulGkOq+ywSTbCs3ZgSVEG
        G9T2skEt2TGt5zaU6ef8xnqc3PcGywTEsRVyIW3sEZive203g3hHBTrvpv4Q4mDb5aZfZSh5vSB4c
        5wko/WFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhKv-00HGp7-Mi; Fri, 09 Apr 2021 02:57:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] s390: Add airq_iv_lock
Date:   Fri,  9 Apr 2021 03:51:25 +0100
Message-Id: <20210409025131.4114078-12-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow lockdep to track the airq bit spin locks.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/s390/include/asm/airq.h | 5 +++--
 drivers/s390/cio/airq.c      | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/airq.h b/arch/s390/include/asm/airq.h
index 01936fdfaddb..d281340de14a 100644
--- a/arch/s390/include/asm/airq.h
+++ b/arch/s390/include/asm/airq.h
@@ -26,6 +26,7 @@ struct airq_struct {
 
 int register_adapter_interrupt(struct airq_struct *airq);
 void unregister_adapter_interrupt(struct airq_struct *airq);
+extern struct iv_lock airq_iv_lock;
 
 /* Adapter interrupt bit vector */
 struct airq_iv {
@@ -72,13 +73,13 @@ static inline unsigned long airq_iv_end(struct airq_iv *iv)
 static inline void airq_iv_lock(struct airq_iv *iv, unsigned long bit)
 {
 	const unsigned long be_to_le = BITS_PER_LONG - 1;
-	bit_spin_lock(bit ^ be_to_le, iv->bitlock);
+	bit_spin_lock(bit ^ be_to_le, iv->bitlock, &airq_iv_lock);
 }
 
 static inline void airq_iv_unlock(struct airq_iv *iv, unsigned long bit)
 {
 	const unsigned long be_to_le = BITS_PER_LONG - 1;
-	bit_spin_unlock(bit ^ be_to_le, iv->bitlock);
+	bit_spin_unlock(bit ^ be_to_le, iv->bitlock, &airq_iv_lock);
 }
 
 static inline void airq_iv_set_data(struct airq_iv *iv, unsigned long bit,
diff --git a/drivers/s390/cio/airq.c b/drivers/s390/cio/airq.c
index cb466ed7eb5e..6e850661957c 100644
--- a/drivers/s390/cio/airq.c
+++ b/drivers/s390/cio/airq.c
@@ -31,6 +31,9 @@ static struct hlist_head airq_lists[MAX_ISC+1];
 
 static struct dma_pool *airq_iv_cache;
 
+DEFINE_SPLIT_LOCK(airq_iv_lock);
+EXPORT_SYMBOL(airq_iv_lock);
+
 /**
  * register_adapter_interrupt() - register adapter interrupt handler
  * @airq: pointer to adapter interrupt descriptor
-- 
2.30.2

