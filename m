Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154F239E69D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhFGS1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhFGS1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:27:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5D6C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8uaV7xI/+irpdecqa7C0H89FvUwfwt/YmJnM9tKmEOc=; b=hyjsdw95BYy4GQny/6wGgb4lq4
        7/+mEmtVgX1PyuHCy4nUDU+R4FNsEJQuPrMI9XRPYiDSt/k04mkM4IfReWZnk1xue5I5xfFnD1UDc
        zRE49wEEI9pkS5V63sxyzsOBR3duu/wgwvVfomb79pz8oHlmf0GXs7VDzMEwvZC0QlNIcAC7kAHKU
        ouhV4dQMMeLadiuTPv2w5pKWt10I4UZ/kOu2GVcSpEelJNkYOi/XxRkVbAXTsQLv1pJXhyTmw2WoB
        it/mxTT0GKlU/+pS09jhQnPtx6sakRa2i/NK3sjJohgTkEDKpKawWQw9zM9R1mrmSDP2SFHXw6dqR
        8CPwpjKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lqJvw-00G7Ec-Ig; Mon, 07 Jun 2021 18:25:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B4766300258;
        Mon,  7 Jun 2021 20:25:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9BA942DC8FF14; Mon,  7 Jun 2021 20:25:07 +0200 (CEST)
Date:   Mon, 7 Jun 2021 20:25:07 +0200
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
Message-ID: <YL5kgx53yQeoJua3@hirez.programming.kicks-ass.net>
References: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
 <20210604205018.2238778-1-ndesaulniers@google.com>
 <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
 <20210604235046.w3hazgcpsg4oefex@google.com>
 <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
 <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com>
 <YL3RQCJGIw9835Y1@hirez.programming.kicks-ass.net>
 <YL3lQ5QdNV2qwLR/@hirez.programming.kicks-ass.net>
 <YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net>
 <20210607172311.ynnrzihgz74vdyjq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210607172311.ynnrzihgz74vdyjq@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 10:23:11AM -0700, Fāng-ruì Sòng wrote:
> On 2021-06-07, Peter Zijlstra wrote:

> > That does indeed seem to do the trick. Bit daft if you ask me, anybody
> > reading that file ought to have a handy bucket of 0s available, but
> > whatever.
> 
> Does the representation use the section index directly? (sym->sym.st_shndx)
> This can be fragile when the number of sections changes..., e.g. elf_add_section

No, things are supposed to use sym->sec, which is a pointer to our
struct section representation.

> So in llvm-objcopy's representation, the section index is represented as
> the section object.
> 
> struct Symbol {
>   ...
>   SectionBase *DefinedIn = nullptr;
>   ...
> };

Somewhat like that.

> In the writer stage, sections are assigned 32-bit indexes and the writer
> knows that an SHN_XINDEX for a symbol is needed if the index is >= 0xff00.

I think we only ever append sections, so pre-existing section numbers
stay correct. If libelf somehow does something else, we rely on it to
then keep the section numbers internally consistent.

And the only symbol write is this append of undef symbols, which are
always on section 0.
