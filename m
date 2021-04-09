Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC688359FB5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhDINWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDINWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:22:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0839CC061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/chgEg4vkbYUpoj4VosuonneX2qHK/OetkyDV/bGmho=; b=FmObb3bhd0CVkB5cxv37RlZ+aw
        xTa5YgJiV+pg6nA0ynFk7QXwyodW7ZRw1jZ2PcjDBP8cwxaVDmvXgC3neI5JxZKD56oqcblVv/mxR
        VmyQ8NTCMd156+WTnoa67ahUBqjUnreygI1C58lyw83/d77mlKI8ULLJfAVN0CKBgHqcuAJr15fBk
        mFTimRqXvEbi8P8ILO+5h6Ae+S8VNNRl4nT9EkzV0dwMHlZe0dWZLkIn02/EIMZk/0IUMfgdnxlt7
        RS8EfBkXSy7piXRK4H+FcmKLWBm2GCIfbeDTFAiltTmeTFkBhhAkkT590gi/kLSmx60335IKpeaX9
        4lYQk3/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUr4E-000Q7Q-P5; Fri, 09 Apr 2021 13:21:03 +0000
Date:   Fri, 9 Apr 2021 14:20:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/17] s390: Add airq_iv_lock
Message-ID: <20210409132058.GU2531743@casper.infradead.org>
References: <20210409025131.4114078-12-willy@infradead.org>
 <202104091435.4GhAON03-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104091435.4GhAON03-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 02:18:16PM +0800, kernel test robot wrote:
> Hi "Matthew,
> 
> Thank you for the patch! Yet something to improve:

Thanks.  I'll fold in this patch to fix it.


diff --git a/arch/s390/include/asm/airq.h b/arch/s390/include/asm/airq.h
index d281340de14a..26030b7c1b88 100644
--- a/arch/s390/include/asm/airq.h
+++ b/arch/s390/include/asm/airq.h
@@ -26,7 +26,7 @@ struct airq_struct {
 
 int register_adapter_interrupt(struct airq_struct *airq);
 void unregister_adapter_interrupt(struct airq_struct *airq);
-extern struct iv_lock airq_iv_lock;
+extern struct split_lock airq_split_lock;
 
 /* Adapter interrupt bit vector */
 struct airq_iv {
@@ -73,13 +73,13 @@ static inline unsigned long airq_iv_end(struct airq_iv *iv)
 static inline void airq_iv_lock(struct airq_iv *iv, unsigned long bit)
 {
 	const unsigned long be_to_le = BITS_PER_LONG - 1;
-	bit_spin_lock(bit ^ be_to_le, iv->bitlock, &airq_iv_lock);
+	bit_spin_lock(bit ^ be_to_le, iv->bitlock, &airq_split_lock);
 }
 
 static inline void airq_iv_unlock(struct airq_iv *iv, unsigned long bit)
 {
 	const unsigned long be_to_le = BITS_PER_LONG - 1;
-	bit_spin_unlock(bit ^ be_to_le, iv->bitlock, &airq_iv_lock);
+	bit_spin_unlock(bit ^ be_to_le, iv->bitlock, &airq_split_lock);
 }
 
 static inline void airq_iv_set_data(struct airq_iv *iv, unsigned long bit,
diff --git a/drivers/s390/cio/airq.c b/drivers/s390/cio/airq.c
index 6e850661957c..08bb47200f12 100644
--- a/drivers/s390/cio/airq.c
+++ b/drivers/s390/cio/airq.c
@@ -31,8 +31,8 @@ static struct hlist_head airq_lists[MAX_ISC+1];
 
 static struct dma_pool *airq_iv_cache;
 
-DEFINE_SPLIT_LOCK(airq_iv_lock);
-EXPORT_SYMBOL(airq_iv_lock);
+DEFINE_SPLIT_LOCK(airq_split_lock);
+EXPORT_SYMBOL(airq_split_lock);
 
 /**
  * register_adapter_interrupt() - register adapter interrupt handler


