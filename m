Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04083B7E66
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhF3H7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbhF3H7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:59:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C01C061766
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 00:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MO9wOENG6cq+VnqNYgZme5a0lTewntqK4HBGcPdZUiY=; b=lIWRAVHTQ3xznZUDbIo50fwumi
        45EQzWG4KdtBWHr/VcvRGif8aR6SRJotfAdbPNIsU5RH4aJ4WllmKRSuWtmURf9fREM+OQzM2m26B
        AsctFyPAYJE0aSqm0t46ZLsC1yhDAebqKF8SlckeCwZznwXZI8mTi9r0mKvcv7WT7i7uzBcJe+Swj
        58TWoSJblAp9bIqdk3q/JsSQYsPmrIdqcCFfs33fhkUFZNwjPAC3oskjQbB4n5aRRhp8XwaOXrAa1
        G4zGKa7wIa/pvvP4NO/nxJ4LgZDg+VRuPkIo6vODD2Lut4ZUPjfy+zcKcIQ1SgLBwvqZqLSDpEfDW
        k0H1pujg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyV4i-00D7N5-Gl; Wed, 30 Jun 2021 07:56:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F464300204;
        Wed, 30 Jun 2021 09:55:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16F1E286BAB98; Wed, 30 Jun 2021 09:55:55 +0200 (CEST)
Date:   Wed, 30 Jun 2021 09:55:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Brian Cain <bcain@codeaurora.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>, Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Henderson <rth@twiddle.net>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v2 00/33] locking/atomic: convert all architectures to
 ARCH_ATOMIC
Message-ID: <YNwji8yPUfQp/ErQ@hirez.programming.kicks-ass.net>
References: <20210525140232.53872-1-mark.rutland@arm.com>
 <a15122e9-700d-c909-4794-d569ed1f6c61@infradead.org>
 <20210618084847.GA93984@C02TD0UTHF1T.local>
 <8a056e32-26bf-3038-984e-fcf8cac988d0@infradead.org>
 <4ec7308f-02c6-a357-eab8-63b6f2b7a5eb@infradead.org>
 <YNpJnzqg0yySeEE7@hirez.programming.kicks-ass.net>
 <a38e3284-62ee-4894-0475-2668733c5903@infradead.org>
 <CAK8P3a2yH+dSWrS=1E0UbwcRhYJEThgrk2i9=omCQvcMMQZcww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2yH+dSWrS=1E0UbwcRhYJEThgrk2i9=omCQvcMMQZcww@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 09:36:23AM +0200, Arnd Bergmann wrote:
> For the specific case of cmpxchg64(), I do think it would make sense to either
> have a Kconfig symbol that controls the few users, or to provide a spinlock
> based fallback for those that don't have a native implementation.

My preference goes to a Kconfig based solution; I so detest spinlock
based atomics. I dream of the day we can kill the lot of 'em
(sparc32-smp, parisc-smp are always the ones that come to mind).

This is doubly true for the xchg/cmpxchg/cmpxchg64 family of functions
that are supposed to work together with READ_ONCE/WRITE_ONCE but don't
(when 'emulated', we'd need WRITE_ONCE to also be spinlock based in
that case).

That is, at least for atomic64_*() the whole API is self contained so we
can (and do) frob atomic64_set() to behave sanely vs atomic64_cmpxchg().


