Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D168A39C77B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 12:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhFEKlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 06:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhFEKlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 06:41:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A9AC061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 03:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O6C1Dmxriqyn/gQ4Qn4heBEyEwp43YQhQLI8PrkD0ms=; b=ukIzKO2qVLmkl/NFZYhV+MOrTh
        HIVhSFPZkApiUcFk5wHytCHeB+SuKzOvjKboXfYDqkKkj7Oq9YP10eGm0mUIzaxJJ5sMH0VaFZXWq
        XO3LFeWdQmgAyClqJhzX4gyJW+iDwf2PvNNMpnqPzrqsiOq3vKixOk6zmiS9orlUQ0Xz6NPF5SPMJ
        dOhyP4ePt7+BwLFGV8lE4KmgcgwCj6xmU7Vc15XUKZkCsYxPq5XZsm2A0imPJdd1Skaq1VPs8qdeD
        QLNmsgICCXS75P64uK7VyLn9C17CQfD+z5HU5rDL1i0YCQWUZrJNq9pmoCtRkmVQHq8ENCDZ0cTQ8
        p9GQOsKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lpThe-00E1tM-Tb; Sat, 05 Jun 2021 10:38:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E231E300091;
        Sat,  5 Jun 2021 12:38:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD59A2CEABC01; Sat,  5 Jun 2021 12:38:51 +0200 (CEST)
Date:   Sat, 5 Jun 2021 12:38:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, lma@semihalf.com,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>, lb@semihalf.com,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        rad@semihalf.com, upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
References: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
 <20210604205018.2238778-1-ndesaulniers@google.com>
 <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
 <20210604235046.w3hazgcpsg4oefex@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604235046.w3hazgcpsg4oefex@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 04:50:46PM -0700, Fangrui Song wrote:
> On 2021-06-04, 'Nick Desaulniers' via Clang Built Linux wrote:

> > is producing the linker error:
> > 
> > ld.lld: error: drivers/gpu/drm/amd/amdgpu/amdgpu.lto.o:
> > SHT_SYMTAB_SHNDX has 79581 entries, but the symbol table associated
> > has 79582
> > 
> > Readelf having issues with the output:
> > $ readelf -s amdgpu.lto.o.orig
> > <works fine>
> > $ readelf -s amdgpu.lto.o
> > readelf: Error: Reading 73014451695 bytes extends past end of file for
> > string table
> > $ llvm-readelf -s amdgpu.lto.o
> > llvm-readelf: error: 'amdgpu.lto.o': unable to continue dumping, the
> > file is corrupt: section table goes past the end of file
> > 

> tools/objtool/elf.c:elf_add_symbol may not update .symtab_shndx .
> Speaking of llvm-objcopy, it finalizes the content of .symtab_shndx when .symtab
> is finalized. objtool may want to adopt a similar approach.
> 
> read_symbols searches for the section ".symtab_shndx". It'd be better to
> use the section type SHT_SYMTAB_SHNDX.

I think you've absolutely nailed it; but would you have more information
or a code reference to what you're speaking about? My complete ELF
and libelf knowledge is very limited and as demonstrated here, I'm not
at all sure how all that extended index stuff is supposed to work.
