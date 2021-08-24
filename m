Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EC83F60F0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbhHXOvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbhHXOvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:51:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA97C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yDfaHDLoF66LI75WGELqPiTnzuG+GR/aIWZ4BGRcp4I=; b=nlLzeHvxj7WBHn8j9lkr5g+ZM7
        SAHpCvchKUq6nvaxSRCZX1G+t1hO6sGbLEpumTsMHIzm3wUAwhSXv6ff3jDbJiZ9tMk5Km+O+pk2U
        zRDG/iTQuGT/7cqJxsAYJHYmIlnmN9CBetv2gNHpYTb95lAxmLtniwtJ6zpvHGDO/MbKxLc+viGPy
        pqDRf9MJd17BzeRZzqJ2sQKngoKhAnoWOIbSwV6GJnn2FRN8OWg3KFBsAR4l8z5J5GN9RExSbJlBD
        JH6UKlM6RULIb6QuGxg+41ZgnOKBQQq8deIth4irx19y9TnMwZeCXVKdmDZqOHud6eFlez2tvWIwH
        ZRcLt4dw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIXiD-00BC1S-MW; Tue, 24 Aug 2021 14:48:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA7CF300252;
        Tue, 24 Aug 2021 16:47:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE87820C9456B; Tue, 24 Aug 2021 16:47:36 +0200 (CEST)
Date:   Tue, 24 Aug 2021 16:47:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [locking/ww_mutex]  c0afb0ffc0:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <YSUGiNL0lkxCitSQ@hirez.programming.kicks-ass.net>
References: <20210824140044.GA27667@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824140044.GA27667@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:00:44PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: c0afb0ffc06e6b4e492a3b711f1fb32074f9949c ("locking/ww_mutex: Gather mutex_waiter initialization")

Fixed by...

commit b857174e68e26f9c4f0796971e11eb63ad5a3eb6
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu Aug 19 21:30:30 2021 +0200

    locking/ww_mutex: Initialize waiter.ww_ctx properly
    
    The consolidation of the debug code for mutex waiter intialization sets
    waiter::ww_ctx to a poison value unconditionally. For regular mutexes this
    is intended to catch the case where waiter_ww_ctx is dereferenced
    accidentally.
    
    For ww_mutex the poison value has to be overwritten either with a context
    pointer or NULL for ww_mutexes without context.
    
    The rework broke this as it made the store conditional on the context
    pointer instead of the argument which signals whether ww_mutex code should
    be compiled in or optiized out. As a result waiter::ww_ctx ends up with the
    poison pointer for contextless ww_mutexes which causes a later dereference of
    the poison pointer because it is != NULL.
    
    Use the build argument instead so for ww_mutex the poison value is always
    overwritten.
    
    Fixes: c0afb0ffc06e6 ("locking/ww_mutex: Gather mutex_waiter initialization")
    Reported-by: Guenter Roeck <linux@roeck-us.net>
    Suggested-by: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Link: https://lore.kernel.org/r/20210819193030.zpwrpvvrmy7xxxiy@linutronix.de

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 3a65bf4bacfd..d456579d0952 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -618,7 +618,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 	debug_mutex_lock_common(lock, &waiter);
 	waiter.task = current;
-	if (ww_ctx)
+	if (use_ww_ctx)
 		waiter.ww_ctx = ww_ctx;
 
 	lock_contended(&lock->dep_map, ip);
