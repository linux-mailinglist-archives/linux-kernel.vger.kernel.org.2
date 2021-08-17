Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705CE3EE939
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbhHQJNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:13:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59020 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbhHQJNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:13:00 -0400
Date:   Tue, 17 Aug 2021 11:12:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629191546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vna3ay+6qfC6a6U/7R3m6EAXb7rtIYGsPklTZxXUqeY=;
        b=Iwn1N4ZzjrNzw92s+RCTec9IgmEdVl7DLCla5o3/SqiTq19vJxrd5Zc/9f4+OMPo4AgEPA
        OAYD3zOKnHAxZxvUSZKaynf52bSYCeAhGlTGn1Rv9ulBGt+EijzKl5b/pqQxqKumnYD/D2
        ELS0zpsJi5XrNNKHmHM7a8xorkrffLimxaRDuJP+Z9A6udR87J2PBSZZ+aGnvJRlk8gUeS
        bLqsIoMR1OrqPWeB8L6PVDO/d+84jTRoAhsopDzqfCCMFVsEiaOA3MTahAUZOg652sHqej
        b5IETeIAE4DhCBosKePMIVXYDuXEqoMJePr1QwzGoaFTxGelEOUj6wiO6Wne7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629191546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vna3ay+6qfC6a6U/7R3m6EAXb7rtIYGsPklTZxXUqeY=;
        b=pOyfrq8aIKWTzmlthQ2kwy0IlXHm+1Ghsxpzs6vbG40odt18B9tJSkmGyg/iv7HcW5GQF5
        M3Z2Y5QSfIMRAMDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Sven Eckelmann <sven@narfation.org>, akpm@linux-foundation.org,
        brouer@redhat.com, cl@linux.com, efault@gmx.de,
        iamjoonsoo.kim@lge.com, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, penberg@kernel.org,
        rientjes@google.com, tglx@linutronix.de,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 35/35] mm, slub: convert kmem_cpu_slab protection to
 local_lock
Message-ID: <20210817091224.nqnrro34cyb67chj@linutronix.de>
References: <2666777.vCjUEy5FO1@sven-desktop>
 <7329198a-2a4e-ebc2-abf8-f7f38f00d5e1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7329198a-2a4e-ebc2-abf8-f7f38f00d5e1@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-17 10:37:48 [+0200], Vlastimil Babka wrote:
> OK reproduced. Thanks, will investigate.

With the local_lock at the top, the needed alignment gets broken for dbl
cmpxchg. On RT it was working ;)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index b5bcac29b979c..cd14aa1f9bc3c 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -42,9 +42,9 @@ enum stat_item {
 	NR_SLUB_STAT_ITEMS };
 
 struct kmem_cache_cpu {
-	local_lock_t lock;	/* Protects the fields below except stat */
 	void **freelist;	/* Pointer to next available object */
 	unsigned long tid;	/* Globally unique transaction id */
+	local_lock_t lock;	/* Protects the fields below except stat */
 	struct page *page;	/* The slab from which we are allocating */
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct page *partial;	/* Partially allocated frozen slabs */

Sebastian
