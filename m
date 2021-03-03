Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA8C32BDC6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhCCQfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:35:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43480 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358139AbhCCLzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:55:41 -0500
Message-Id: <20210303114728.116465616@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614772459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fyXAXFo8eCnowgRuIPCWwAQhgeXmf7C8IGgmmB3q6v4=;
        b=CneQKvWhXwpcXZgyKK3bDCZAp08rEdGX3rWxYi7apwvy9P6YnHp3FM6ZCtWXSL9LuMeshM
        u/u8k1ESsqqTYehN4fh9BlZwXviQHn5lmHpIizxR9zdVHMyKOid2Dqe9QAVtDdDw7L7lYa
        FoTNsreg6jRZcjP70R33YUXeMu8QzQ5kV2w1h8jHRgki12d4a1zBrtYIQwJxiqjz3hgevb
        f71mmT7jqfJ6+vQnh2qc95/9c91FhSqc0OeNnzUsPRSfiPT64O/IkyUPfCnC+gzcm0B3Gs
        DITLLCAU6zUOgX/GvN75r0+RAlqNPMl8Oh/G1Tct9loMxCnfFsbZRm4RU4GVNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614772459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=fyXAXFo8eCnowgRuIPCWwAQhgeXmf7C8IGgmmB3q6v4=;
        b=2cn6lCn6FIP/v1Qjqqb2r/ls62egPvoaelBViLqGUFY0qJ1D9krvWumSqaS6NfG5Y3aZEp
        jXfzujTeFFeKq+Cg==
Date:   Wed, 03 Mar 2021 12:45:13 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [patch 2/2] highmem: Remove kmap_atomic_pfn()
References: <20210303114511.927078317@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 include/linux/highmem-internal.h |   12 ------------
 1 file changed, 12 deletions(-)

--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -99,13 +99,6 @@ static inline void *kmap_atomic(struct p
 	return kmap_atomic_prot(page, kmap_prot);
 }
 
-static inline void *kmap_atomic_pfn(unsigned long pfn)
-{
-	preempt_disable();
-	pagefault_disable();
-	return __kmap_local_pfn_prot(pfn, kmap_prot);
-}
-
 static inline void __kunmap_atomic(void *addr)
 {
 	kunmap_local_indexed(addr);
@@ -193,11 +186,6 @@ static inline void *kmap_atomic_prot(str
 	return kmap_atomic(page);
 }
 
-static inline void *kmap_atomic_pfn(unsigned long pfn)
-{
-	return kmap_atomic(pfn_to_page(pfn));
-}
-
 static inline void __kunmap_atomic(void *addr)
 {
 #ifdef ARCH_HAS_FLUSH_ON_KUNMAP


