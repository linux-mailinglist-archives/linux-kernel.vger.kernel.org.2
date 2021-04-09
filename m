Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84112359D16
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbhDILS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbhDILSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:18:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B93C061760;
        Fri,  9 Apr 2021 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NZ0GUoV5NUz8hE+Uk6t9Fqrda/6popJtIxpTk8vMhZY=; b=utWGGGSPJgLFv3o84RnoQNMr/R
        BCVG26RMz5SxbkQfQ5IrP4xFaDAEAf5ASKP1uzLJwjH1x7HK6BJ+Exk6BXSTPNV4yh3Z8lx8SM38S
        ruxp0ryDzBqKWTodmz/kDjE3W1mn+jbR011JcRQ9KeZs7FlgrzICl/FQFl84Q47JKdLs5FwSsou3f
        e97K75J5yjER6rkUtS6vJaZodNi+BOJzt/m/4bSENEOWmQxmh50PMKkyOoKgyLyI99E0oLxsEV6BV
        4y7BGWwLpd+jEkJfmVWHvXd7CGbxhD5Ug5IXrHGA4EOGfMhhiwo9Sef174deyitwc8FOMBFnKOm4u
        nZpu3syQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUp7h-000Ggy-7u; Fri, 09 Apr 2021 11:16:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF6213001E3;
        Fri,  9 Apr 2021 13:16:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5C6E23CDCDDD; Fri,  9 Apr 2021 13:16:24 +0200 (CEST)
Date:   Fri, 9 Apr 2021 13:16:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: static_branch/jump_label vs branch merging
Message-ID: <YHA3iGyT5dMq7/06@hirez.programming.kicks-ass.net>
References: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
 <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
 <877dlbzq09.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dlbzq09.fsf@oldenburg.str.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 12:55:18PM +0200, Florian Weimer wrote:
> * Ard Biesheuvel:
> 
> > Wouldn't that require the compiler to interpret the contents of the
> > asm() block?
> 
> Yes and no.  It would require proper toolchain support, so in this case
> a new ELF relocation type, with compiler, assembler, and linker support
> to generate those relocations and process them.  As far as I understand
> it, the kernel doesn't do things this way.

I don't think that all is needed. All we need is for the compiler to
recognise that:

	if (cond) {
		stmt-A;
	}
	if (cond) {
		stmt-B;
	}

both cond are equivalent and hence can merge the blocks like:

	if (cond) {
		stmt-A;
		stmt-B;
	}

But because @cond is some super opaque asm crap, the compiler throws up
it's imaginry hands and says it cannot possibly tell and leaves them as
is.
