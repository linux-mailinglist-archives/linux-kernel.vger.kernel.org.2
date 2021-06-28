Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED753B6AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 00:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhF1WSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 18:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbhF1WR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 18:17:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB63C061766
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 15:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RrwMMapLBsChLNWIDQwjvp9ZQ5kT4ynyr8JTTtlXg88=; b=Lbz5k4mROvjWp/MPv75oe+UVBT
        uH+Cf4StBw9jx0Agh+peRDS8X9pvBIR8CzWlh6FDVeIvZ/TjdwUg5Qklirh3D2vEIfEwWQWE82q8p
        iqb59Xdy4Pqv6SKKx3RsbhOwp6p0S7F9dbQh4b7n3OUDJlyV/dnwck37kVPiuE58BI4cyXHnafTNy
        d8DRBkOrht/F4F4SRZMBYOk4pYItKjuDFt+2B0jllZKbsOtPXazmOH1m9IhaUQ3eE2aWSG6PRIr7E
        D5C5A1eqgnWKqm+cHEnURm2RJNFrHuei+dxp28cItv3CppLu5UQRy1vQXp53NtLPZ2XgbCCLu/dp8
        Izmwabew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxzVw-00Ci7T-9Y; Mon, 28 Jun 2021 22:14:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9D8F4300204;
        Tue, 29 Jun 2021 00:13:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 676D92059E78F; Tue, 29 Jun 2021 00:13:51 +0200 (CEST)
Date:   Tue, 29 Jun 2021 00:13:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        will@kernel.org, boqun.feng@gmail.com, aou@eecs.berkeley.edu,
        arnd@arndb.de, bcain@codeaurora.org, benh@kernel.crashing.org,
        chris@zankel.net, dalias@libc.org, davem@davemloft.net,
        deanbo422@gmail.com, deller@gmx.de, geert@linux-m68k.org,
        gerg@linux-m68k.org, green.hu@gmail.com, guoren@kernel.org,
        ink@jurassic.park.msu.ru, James.Bottomley@hansenpartnership.com,
        jcmvbkbc@gmail.com, jonas@southpole.se, ley.foon.tan@intel.com,
        linux@armlinux.org.uk, mattst88@gmail.com, monstr@monstr.eu,
        mpe@ellerman.id.au, nickhu@andestech.com, palmerdabbelt@google.com,
        paulus@samba.org, paul.walmsley@sifive.com, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tsbogend@alpha.franken.de, vgupta@synopsys.com,
        ysato@users.sourceforge.jp
Subject: Re: [PATCH v2 00/33] locking/atomic: convert all architectures to
 ARCH_ATOMIC
Message-ID: <YNpJnzqg0yySeEE7@hirez.programming.kicks-ass.net>
References: <20210525140232.53872-1-mark.rutland@arm.com>
 <a15122e9-700d-c909-4794-d569ed1f6c61@infradead.org>
 <20210618084847.GA93984@C02TD0UTHF1T.local>
 <8a056e32-26bf-3038-984e-fcf8cac988d0@infradead.org>
 <4ec7308f-02c6-a357-eab8-63b6f2b7a5eb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ec7308f-02c6-a357-eab8-63b6f2b7a5eb@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 02:22:15PM -0700, Randy Dunlap wrote:
> However, something in arch/arc/ did look suspicious so I decided to
> try an ARC allmodconfig build, where I did see a few errors FYI:
> 
> 
>   CC      drivers/iommu/io-pgtable-arm.o
> In file included from ../include/linux/atomic.h:80,
>                  from ../drivers/iommu/io-pgtable-arm.c:12:
> ../drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_install_table':
> ../include/linux/atomic-arch-fallback.h:60:32: error: implicit declaration of function 'arch_cmpxchg64'; did you mean 'arch_cmpxchg'? [-Werror=implicit-function-declaration]
>    60 | #define arch_cmpxchg64_relaxed arch_cmpxchg64
>       |                                ^~~~~~~~~~~~~~
> ../include/asm-generic/atomic-instrumented.h:1261:2: note: in expansion of macro 'arch_cmpxchg64_relaxed'
>  1261 |  arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
>       |  ^~~~~~~~~~~~~~~~~~~~~~
> ../drivers/iommu/io-pgtable-arm.c:320:8: note: in expansion of macro 'cmpxchg64_relaxed'
>   320 |  old = cmpxchg64_relaxed(ptep, curr, new);
>       |        ^~~~~~~~~~~~~~~~~

0day also reported something like that. We found that this was a
pre-existing error, and Mark's patches only changed the error, it never
successfully build.

cmpxchg64 is an optional feature for 32bit architectures, one that ARMv7
does provide, and uses, for it's iommu bits. Building the ARM iommu
drivers on ARC seem somewhat daft but is a result of that COMPILE_TEST
config.
