Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9381139FD89
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhFHRY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbhFHRY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:24:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27605C061787
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vE4hpBkarbGpaIGX2OZfGd8vijIiOr69dHEEgzwDXTQ=; b=YIA8tuuS3e7S0mCJj0aUxxJC4I
        8Q8M/0s6wWU/Q8Nc1E7/5pmxI3eRyejmgagZ86c++74cIGGq/2ONq5b4aeWC+xRwctIICESnxfN2I
        JUrptVnnj+kAsy7Xs9u7oHmwX6okjEG7KnufucaTp+tFJBUMwvHGgFJSwukPHIvIlLAAydPcXWgA4
        vOPUC4Rghb8YOAXJrQgwIrSnbI/Ixw4KQU+LsH/dJnDDY4C5zHaVQmtrhFL320vxQ3X/hy3L93ayK
        K2J1SA8BGtM9BmTAuDHw14M7LRn94l13+GzVoAM4AvxmzmXPNBmEUQyUDR9GCZu5B3Zbbc2b9+RQP
        NAr7+MFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqfRB-004orn-OP; Tue, 08 Jun 2021 17:22:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1354A3001E3;
        Tue,  8 Jun 2021 19:22:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E153B201E7EE3; Tue,  8 Jun 2021 19:22:55 +0200 (CEST)
Date:   Tue, 8 Jun 2021 19:22:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, lma@semihalf.com,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>, lb@semihalf.com,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        =?utf-8?B?UmFkb3PFgmF3?= Biernacki <rad@semihalf.com>,
        upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <YL+nb235rIfEdye0@hirez.programming.kicks-ass.net>
References: <20210604205018.2238778-1-ndesaulniers@google.com>
 <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
 <20210604235046.w3hazgcpsg4oefex@google.com>
 <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
 <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com>
 <YL3RQCJGIw9835Y1@hirez.programming.kicks-ass.net>
 <YL3lQ5QdNV2qwLR/@hirez.programming.kicks-ass.net>
 <YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net>
 <CAKwvOdkuJBwZRigeqdZGevPF9WHyrC5pBAsz6_tWdXAc-wO+1A@mail.gmail.com>
 <e351ac97-4038-61b5-b373-63698a787fc1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e351ac97-4038-61b5-b373-63698a787fc1@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 09:58:03AM -0700, Nathan Chancellor wrote:
> On 6/7/2021 1:54 PM, 'Nick Desaulniers' via Clang Built Linux wrote:
> > On Mon, Jun 7, 2021 at 2:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > 
> > Thanks, the below diff resolves the linker error reported in
> > https://github.com/ClangBuiltLinux/linux/issues/1388
> > 
> > Both readelf implementations seem happy with the results, too.
> > 
> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > 
> > Nathan,
> > Can you please test the below diff and see if that resolves your boot
> > issue reported in:
> > https://github.com/ClangBuiltLinux/linux/issues/1384
> 
> Unfortunately, it does not appear to resolve that issue.
> 
> $ git log -2 --decorate=no --oneline
> eea6a9d6d277 Peter's fix
> 614124bea77e Linux 5.13-rc5
> 
> $ strings /mnt/c/Users/natec/Linux/kernel-investigation | grep microsoft
> 5.13.0-rc5-microsoft-standard-WSL2-00001-geea6a9d6d277
> (nathan@archlinux-ax161) #3 SMP Tue Jun 8 09:46:19 MST 2021
> 
> My VM still never makes it to userspace.

Since it's a VM, can you use the gdb-stub to ask it where it's stuck?
