Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1BD39D898
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhFGJYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhFGJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:24:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD5AC061789
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 02:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=7UNlj+FWBEeACCbOEiLMCdZwBprY1+ow/vEJ/vwRuwk=; b=wUfPXZ6F9OhgnIF0VXeCQY4Nwr
        +DofzgeIpIg14E17XpuwZ38q0GgMQ49xqAT/HCoIOVB5qIsam7d3oCByMy8oDqCe2XmN+/Mpb23Qy
        8de/EwGMHzN+HVdioolFui2rYPp+O1j67XVOZWoZo+if2LaERH7wgXaZQIJmhZJAeja0XOIw72zKM
        zbifJl5+IOj/+rwBTU4JXnqMs1kb77wFZkSuaj55Dz8truCJqz3WMG0c31m4A4yvBSlw1jUfpdpV1
        Fr4ASg2Zw9Nd6XeoWxpuxySW70vLoa2QfuIOcXHGOa7fgD4B+NzETnKnHyqx2Y+6XaLkmmY1H8lHw
        EqC8OVgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lqBSW-00FZjV-Ce; Mon, 07 Jun 2021 09:22:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 468723001E3;
        Mon,  7 Jun 2021 11:22:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D0982CEABC0F; Mon,  7 Jun 2021 11:22:11 +0200 (CEST)
Date:   Mon, 7 Jun 2021 11:22:11 +0200
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
Message-ID: <YL3lQ5QdNV2qwLR/@hirez.programming.kicks-ass.net>
References: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
 <20210604205018.2238778-1-ndesaulniers@google.com>
 <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
 <20210604235046.w3hazgcpsg4oefex@google.com>
 <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
 <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com>
 <YL3RQCJGIw9835Y1@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YL3RQCJGIw9835Y1@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 09:56:48AM +0200, Peter Zijlstra wrote:
> On Sat, Jun 05, 2021 at 06:58:39PM -0700, Fāng-ruì Sòng wrote:
> > On Sat, Jun 5, 2021 at 3:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > I think you've absolutely nailed it; but would you have more information
> > > or a code reference to what you're speaking about? My complete ELF
> > > and libelf knowledge is very limited and as demonstrated here, I'm not
> > > at all sure how all that extended index stuff is supposed to work.
> > 
> > The section index field of an Elf{32,64}_Sym (st_shndx) is 16-bit, so
> > it cannot represent a section index greater than 0xffff.
> > ELF actually reserves values in 0xff00~0xff00 for other purposes, so
> > st_shndx cannot represent a section whose index is greater or equal to
> > 0xff00.
> 
> Right, that's about as far as I got, but never could find details on how
> the extension worked in detail, and I clearly muddled it :/

OK, so I'm all confused again...

So a .symtab entry has:

	st_name  -- strtab offset for the name string
	st_value -- where this symbol lives
	st_size  -- size of symbol in bytes
	st_shndx -- section index to interpret the @st_value above
	st_info  -- type+bind
	st_other -- visibility

The thing is, we're adding UNDEF symbols, for the linker to resolve.
UNDEF has:

	st_value := 0
	st_size  := 0
	st_shndx := 0
	st_info  := GLOBAL + NOTYPE
	st_other := 0

Per that, sh_shndx isn't >= SHN_LORESERVE, and I figured we all good.


Is the problem that .symtab_shndx is expected to contain the exact same
number of entries as .symtab? And I'm adding to .symtab and not to
.symtab_shndx, hence getting them out of sync?

Let me try adding 0s to .symtab_shndx. See if that makes readelf
happier.

