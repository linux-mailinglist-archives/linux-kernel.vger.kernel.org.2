Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50460410496
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 09:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbhIRHG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 03:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbhIRHG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:06:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31382C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 00:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n+Fqt6MVFr2gieW0j4Tl0M/4nNsKqy+tKuhi2NClUw0=; b=l0IDBsJ4u24mSvVFVWKlBUjZ63
        8bVgIRNnBzrp5oryStlkITgYo2LQZ5gX30/pt2almrOgHuHDONXuSmWc8oF3ffTogH/nQn8FoTme4
        yjWDJcOglSopEP4uKbF8LHfc89neTfSq4ZE4rknMak53v/lvusaJB25YVsB6Bj1Nvjnb8hxWRHs/a
        WRWqumkEOp+6F8yEKSJK0eiBH/QDHvBxCZLRKAbdswG8qoIzQrNkgJ8YWPlDteCjgcoR/F4od1i5q
        QRxmtDVovVtx/Y+1diJ83hC5eZRsa+kQPfSvb9T6D9OMnTfl7FQ36284TKdLDbLvlcl5Wxs45LNr7
        Wp5mibWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRUPh-0042Iw-9Z; Sat, 18 Sep 2021 07:05:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F30B300047;
        Sat, 18 Sep 2021 09:05:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 835B02CEE105C; Sat, 18 Sep 2021 09:05:28 +0200 (CEST)
Date:   Sat, 18 Sep 2021 09:05:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ondrej Zary <linux@zary.sk>, Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/iopl: Fake iopl(3) CLI/STI usage
Message-ID: <YUWPuPyBxR9OVtXS@hirez.programming.kicks-ass.net>
References: <202109151423.43604.linux@zary.sk>
 <202109162227.17415.linux@zary.sk>
 <20210916210509.GG4323@worktop.programming.kicks-ass.net>
 <202109171011.31916.linux@zary.sk>
 <YURdxNpH8YNQZQT7@hirez.programming.kicks-ass.net>
 <CAHk-=wj_-bRjcJdXubdUUsTph+DH-5f77FmkbNCfFVYg=Td2zw@mail.gmail.com>
 <CAHk-=whsG4LfNJHjeprDn0iR=zRGBUBtSSgLep=MqbEb8yBuuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whsG4LfNJHjeprDn0iR=zRGBUBtSSgLep=MqbEb8yBuuA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 03:24:51PM -0700, Linus Torvalds wrote:
> On Fri, Sep 17, 2021 at 3:23 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I think the proper thing to do is perhaps something like
> 
> The alternative is to just ignore cs_abse entirely, and just use
> "regs->ip", which makes this all even easier.
> 
> If somebody uses a code segment _and_ cli/sti, maybe they should just
> get the SIGSEGV?

I did a hatched job on fixup_ump_exception() which is why it looks like
it does, that said...

our case at hand mmap()'s BIOS code from /dev/mem and executes that, I
don't think it does an LDT segment but it would be entirely in line with
the level of hack we're looking at.

Let me frob at this after breakfast and see if I can make it better.
