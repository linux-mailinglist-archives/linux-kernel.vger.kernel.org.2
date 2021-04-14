Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F5F35F48E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351143AbhDNNKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351149AbhDNNKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:10:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89E7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 06:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OxdMAk1LmEqVZwUMYasw5A7Q8hQ+IixVw/lGbUnnOh0=; b=sbxUAR1Ou6zsfaam6Yge0tIitq
        WUZqtRbnE6R5XHVcG880KxETwVIsTvEHS/9EJ4RuB8KgS2NCFb74vtv7LLFOX5muyUB7y0PBtjrD+
        uOsGjA33PLJukmCX8phq1CKCbb6xtqwTQAjLuOJIZlBH/LkLwjz860+HGdcFTaSoZRVRipRLMM116
        WEpGCEz2gJGFDrrWua9F8wO1Xi5LhjVHCNviO+o4caKjdagtlFlkTQeNwVUvoobcBmCdElN4XFNvI
        71tRGEzgEL0eW4wwERVBXTFJ65qo7aNjPl0uCAx9OyoK/0Op3nxNbCgmfXo7oqleltXqtPfoIKlDO
        PKlyfuKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWfFy-0078jp-Vr; Wed, 14 Apr 2021 13:08:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8071B30015A;
        Wed, 14 Apr 2021 15:08:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AAF02065A47D; Wed, 14 Apr 2021 15:08:34 +0200 (CEST)
Date:   Wed, 14 Apr 2021 15:08:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Subject: Re: [RFC][PATCH] locking: Generic ticket-lock
Message-ID: <YHbpUtIWaaP1Qod1@hirez.programming.kicks-ass.net>
References: <mhng-03d1655e-090e-4afb-a4e3-12b4b8f0e6bf@palmerdabbelt-glaptop>
 <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
 <YHVTgfCpxpINc8sM@hirez.programming.kicks-ass.net>
 <CAJF2gTQaF8wBCp-L6vgJPcu6EnFRWmh_qZMX2PiEfj0Z70-Ykg@mail.gmail.com>
 <YHaU4uxr6emrivuu@hirez.programming.kicks-ass.net>
 <YHawVOIHmDPbTmoB@hirez.programming.kicks-ass.net>
 <YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net>
 <CAJF2gTRsQQ=RunxK6R9MfK70dULt=RJOXXGCOT9oDPEsBgvKtQ@mail.gmail.com>
 <YHbmXXvuG442ZDfN@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHbmXXvuG442ZDfN@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 02:55:57PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 14, 2021 at 08:39:33PM +0800, Guo Ren wrote:

> > > + * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
> > > + * uses atomic_fetch_add() which is SC to create an RCsc lock.
> 
> This ^^^ then vvv
> 
> > > +static __always_inline void ticket_lock(arch_spinlock_t *lock)
> > > +{
> > > +       u32 val = atomic_fetch_add(1<<16, lock); /* SC, gives us RCsc */
> > atomic_fetch_add_acquire ?
> 
> Then we must rely on the arch to implement RCsc atomics. And I for one
> can never tell wth Risc-V actually does.

Anyway, if we can mandate that atomic acquire/release is RCsc, then yes
we can do that but then we also need:

#define smp_mb__after_spinlock()	smp_mb__after_atomic()

But currently atomic acquire/release is not RCsc (at the very least
Power does RCtso -- and power gets to deal with any and all pain caused
by that).
