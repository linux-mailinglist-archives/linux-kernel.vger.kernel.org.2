Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569A439D669
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 09:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFGH7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 03:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGH67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:58:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60ECC061789
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=RI7d+MKqVAlBJe+aXBCqULwS/BkkdRxtZ0dH5H9X58I=; b=qVRE6udMS5tnbGyy8JKqrT34Iv
        1jLseDWxIPn9NMfouRnMjob0gMaJW/dxlfSCXduP45wAmm3qevrB+3pDOACbHLAZj8SKi1t+UHWUc
        97/cVu8uLcorWgQ99WNuC9q3laFroUUTe0r34Z7sZCTP+FMIKplMDNgJxmxKnl9biRm5X0BE/d1NJ
        cfrikyXZ9yRc3xGVSpWfCv9npIlH/9IEdh0ImGgI9VeIO3wtcZMDavH3t6fCX9EPtCy7SQTwbQoOZ
        70GthJWZczZ+9oHrDH3Yw5LWeo9VIhJf/21XqWm+ZDp6d6LLVLYw6TD7WZjwUeKXIKZ2rMWnzU9LW
        xR1NjBJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lqA7u-00FVF0-OO; Mon, 07 Jun 2021 07:56:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 00A803001E3;
        Mon,  7 Jun 2021 09:56:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D06CB2CEABC0E; Mon,  7 Jun 2021 09:56:48 +0200 (CEST)
Date:   Mon, 7 Jun 2021 09:56:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, lma@semihalf.com,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>, lb@semihalf.com,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        =?utf-8?B?UmFkb3PFgmF3?= Biernacki <rad@semihalf.com>,
        upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <YL3RQCJGIw9835Y1@hirez.programming.kicks-ass.net>
References: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
 <20210604205018.2238778-1-ndesaulniers@google.com>
 <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
 <20210604235046.w3hazgcpsg4oefex@google.com>
 <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
 <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 06:58:39PM -0700, Fāng-ruì Sòng wrote:
> On Sat, Jun 5, 2021 at 3:39 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > I think you've absolutely nailed it; but would you have more information
> > or a code reference to what you're speaking about? My complete ELF
> > and libelf knowledge is very limited and as demonstrated here, I'm not
> > at all sure how all that extended index stuff is supposed to work.
> 
> The section index field of an Elf{32,64}_Sym (st_shndx) is 16-bit, so
> it cannot represent a section index greater than 0xffff.
> ELF actually reserves values in 0xff00~0xff00 for other purposes, so
> st_shndx cannot represent a section whose index is greater or equal to
> 0xff00.

Right, that's about as far as I got, but never could find details on how
the extension worked in detail, and I clearly muddled it :/

> To overcome the 16-bit section index limitation, .symtab_shndx was designed.
> 
> http://www.sco.com/developers/gabi/latest/ch4.symtab.html says
> 
> > SHN_XINDEX This value is an escape value. It indicates that the
> > symbol refers to a specific location within a section, but that the
> > section header index for that section is too large to be represented
> > directly in the symbol table entry. The actual section header index
> > is found in the associated SHT_SYMTAB_SHNDX section. The entries in
> > that section correspond one to one with the entries in the symbol
> > table. Only those entries in SHT_SYMTAB_SHNDX that correspond to
> > symbol table entries with SHN_XINDEX will hold valid section header
> > indexes; all other entries will have value 0.
> 
> You may use https://github.com/llvm/llvm-project/blob/main/llvm/tools/llvm-objcopy/ELF/Object.cpp#L843
> as a reference.

Excellent, lemme go read up and attempt to fix this.
