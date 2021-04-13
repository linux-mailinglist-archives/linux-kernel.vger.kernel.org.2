Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B0E35D9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242641AbhDMIRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbhDMIRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:17:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CCFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 01:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uZZGljHI+pEQTN9kef9SQSB785V0yvmr/JmVQj1uQhM=; b=UV6GxUjHogdqfKF2OVfvAuRjBC
        vDJ17oB2J+4vrYX3Xv/8QzCHnN0OKbKnX67T77g3aaFXA9JRMw3dy/aHppYzoiD+XvmFuFRZycoHF
        isR6cC+m3F94Vu16ZZ4nYcA0bqFqvzXTIkpkjBOixQn8H6zAMjJqT/0E5jzpjgLTwkrF9k5YPoqu6
        lGCStF9w5A9T+hJWBBfzvDtXoQjLvkJMRrBotBqhGIojmG/87aNY8XrBTeWmNPtweuoECgT6EzCvE
        DvIdur/0oxBIUbMNQABWKZzfxE2uaIhWeXiJKLMz83tqW5Ydc2ylbRcRSFp2e+6FlJcewLUDwg1Jh
        IkT3nl1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWEEM-008ZRN-DN; Tue, 13 Apr 2021 08:17:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D990D3001F6;
        Tue, 13 Apr 2021 10:17:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6667E20224209; Tue, 13 Apr 2021 10:17:05 +0200 (CEST)
Date:   Tue, 13 Apr 2021 10:17:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] riscv: locks: introduce ticket-based spinlock
 implementation
Message-ID: <YHVTgfCpxpINc8sM@hirez.programming.kicks-ass.net>
References: <CAHB2gtS9J09VaY9ZxDJYVo2fTgS-u6p7e89aLCnwOHnYEOJR=g@mail.gmail.com>
 <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 10:03:01AM +0200, Peter Zijlstra wrote:

> For ticket locks you really only needs atomic_fetch_add() and
> smp_store_release() and an architectural guarantees that the
> atomic_fetch_add() has fwd progress under contention and that a sub-word
> store (through smp_store_release()) will fail the SC.
> 
> Then you can do something like:
> 
> void lock(atomic_t *lock)
> {
> 	u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
> 	u16 ticket = val >> 16;
> 
> 	for (;;) {
> 		if (ticket == (u16)val)
> 			break;
> 		cpu_relax();
> 		val = atomic_read_acquire(lock);
> 	}

A possibly better might be:

	if (ticket == (u16)val)
		return;

	atomic_cond_read_acquire(lock, ticket == (u16)VAL);

Since that allows architectures to use WFE like constructs.

> }
> 
> void unlock(atomic_t *lock)
> {
> 	u16 *ptr = (u16 *)lock + (!!__BIG_ENDIAN__);
> 	u32 val = atomic_read(lock);
> 
> 	smp_store_release(ptr, (u16)val + 1);
> }
> 
> That's _almost_ as simple as a test-and-set :-) It isn't quite optimal
> on x86 for not being allowed to use a memop on unlock, since its being
> forced into a load-store because of all the volatile, but whatever.
