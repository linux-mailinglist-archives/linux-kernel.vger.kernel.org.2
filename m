Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD27360594
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhDOJZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhDOJZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:25:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEE7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jh/Z5CsbLDJ2dUT0D1FkWWjNfW/phW/5c5MUZ/JUzbg=; b=cDY0sm51fhBJRR6G9i2mGcml2O
        W2RDobY5wE7VwT8Ddao16wlAOeiErRp7CTi5iDFWw5AGIGtnehByPJCJMhEGbFnnPE1dpCo7NrrXb
        rdAyfEZGhmMjpasWmKKEn9yRGxoR7Yh/Kc3K5yvwFrEGbGpc60KKjKscKowfaFuJ2RrQ3LerXXldL
        c72etaYasPgMqKXHWJrXg80p2QuNb7IU8FnAt26OeyNAbCdP107hkuyUT8SH24vCeaPHGi2nQgX0B
        KDOC4/6xrL/Tji8+5ZjIpVIiGIMzAHqfmBIkVEydHzj3LYCYKnZVeJVoDfBV371SUmwUYqzCAhNGV
        /WPX/Atg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWyEs-00FVmx-VT; Thu, 15 Apr 2021 09:24:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 344C2300209;
        Thu, 15 Apr 2021 11:24:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6C982022421A; Thu, 15 Apr 2021 11:24:41 +0200 (CEST)
Date:   Thu, 15 Apr 2021 11:24:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Stafford Horne <shorne@gmail.com>, Guo Ren <guoren@kernel.org>,
        Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi
Subject: Re: [RFC][PATCH] locking: Generic ticket-lock
Message-ID: <YHgGWT6eJOAofVaA@hirez.programming.kicks-ass.net>
References: <CAHB2gtS6x25Oquf6W4Hhh-diUuZk1GJHTD2DjrffHo93nWbUYw@mail.gmail.com>
 <YHVQNSfblP6G0Kgl@hirez.programming.kicks-ass.net>
 <YHVTgfCpxpINc8sM@hirez.programming.kicks-ass.net>
 <CAJF2gTQaF8wBCp-L6vgJPcu6EnFRWmh_qZMX2PiEfj0Z70-Ykg@mail.gmail.com>
 <YHaU4uxr6emrivuu@hirez.programming.kicks-ass.net>
 <YHawVOIHmDPbTmoB@hirez.programming.kicks-ass.net>
 <YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net>
 <20210414204734.GJ3288043@lianli.shorne-pla.net>
 <YHf00hgpB5C20tH3@hirez.programming.kicks-ass.net>
 <20210415090215.GA1015@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415090215.GA1015@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 10:02:18AM +0100, Catalin Marinas wrote:
> IIRC, one issue we had with ticket spinlocks on arm64 was on big.LITTLE
> systems where the little CPUs were always last to get a ticket when
> racing with the big cores. That was with load/store exclusives (LR/SC
> style) and would have probably got better with atomics but we moved to
> qspinlocks eventually (the Juno board didn't have atomics).

That sounds like a fundamental LL/SC fail, and I'm not sure qspinlock
will help with that at all. The big cores can still hog the lock word
and starve the little ones.

And those things not having AMOs there's really not much you can do. You
want the big cores to back off, but they're having success, not failure.
I suppose you can add a delay after a successful LL/SC, but that sucks.

I suppose modern big.little things will have AMOs, so maybe nobody still
cares about those systems.
