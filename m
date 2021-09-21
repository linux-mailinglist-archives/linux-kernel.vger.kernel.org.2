Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966C1412F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhIUHMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhIUHMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:12:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7A8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zj/GFoSMQz8sn7CsnxniTcTWZHfPlBP4UVX5tHlobmk=; b=LEYzG6RMtthcacgKpDHkVEipqE
        mhYTo5dJabv69szHK6qKojnmxOsHuRzWRZBeuFnFFJWHlUM4SP0T7nvmjxSwLxK55FiiGU0Rjss67
        R5msZZ3YE4szz1ZWbuSwBXI5Wj9aDjAGz3kn9M+7/qZInfZ21Ic4ib0pJ+YgEePskLE3G8LPafdGK
        fQpfu8obfxv/fJJaQUIkWVB0qsqRa1s7aMr+OOaHuLqITJ7WTZNj+0a8fkovhOYkqAqs4wn0at3kT
        7PtIsHzTaHNilx+32vDA5hWVwLg7/7C/KYoc4OdiAJasJfVm1RKUpm/zSDwiHIZZpGQAG0nZsu+hN
        G3e46bfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSZtv-003aWM-3u; Tue, 21 Sep 2021 07:09:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A6EB3004B2;
        Tue, 21 Sep 2021 09:09:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5279F2C3EE3ED; Tue, 21 Sep 2021 09:09:10 +0200 (CEST)
Date:   Tue, 21 Sep 2021 09:09:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        christophe.leroy@csgroup.eu
Subject: Re: [PATCH 2/4] arm64: implement support for static call trampolines
Message-ID: <YUmFFvZCb2yXn3os@hirez.programming.kicks-ass.net>
References: <20210920233237.90463-1-frederic@kernel.org>
 <20210920233237.90463-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920233237.90463-3-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 01:32:35AM +0200, Frederic Weisbecker wrote:

> +#define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, target)			    \
> +	asm("	.pushsection	.static_call.text, \"ax\"		\n" \
> +	    "	.align		3					\n" \
> +	    "	.globl		" STATIC_CALL_TRAMP_STR(name) "		\n" \
> +	    STATIC_CALL_TRAMP_STR(name) ":				\n" \
> +	    "	hint 	34	/* BTI C */				\n" \
> +	    "	adrp	x16, 1f						\n" \
> +	    "	ldr	x16, [x16, :lo12:1f]				\n" \
> +	    "	cbz	x16, 0f						\n" \
> +	    "	br	x16						\n" \
> +	    "0:	ret							\n" \
> +	    "	.popsection						\n" \
> +	    "	.pushsection	.rodata, \"a\"				\n" \
> +	    "	.align		3					\n" \
> +	    "1:	.quad		" target "				\n" \
> +	    "	.popsection						\n")

So I like what Christophe did for PPC32:

  https://lkml.kernel.org/r/6ec2a7865ed6a5ec54ab46d026785bafe1d837ea.1630484892.git.christophe.leroy@csgroup.eu

Where he starts with an unconditional jmp and uses that IFF the offset
fits and only does the data load when it doesn't. Ard, woulnd't that
also make sense on ARM64? I'm thinking most in-kernel function pointers
would actually fit, it's just the module muck that gets to have too
large pointers, no?

> +#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
> +	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, #func)
> +
> +#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
> +	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "0x0")
