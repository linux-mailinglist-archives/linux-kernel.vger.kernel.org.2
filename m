Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD98B33C918
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 23:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhCOWJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 18:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhCOWJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 18:09:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42EFC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 15:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lJJ6idqJmjkmTZuLjzlbTwzbXT/OGj6LBbQdQF5AIb8=; b=dma5nSwzTVdnVV37PGUPQcK/KS
        yjsxI2/XVrSEpxlyb63KIoP0VAA20dICsKbXyH1rYkrsOV/pBeDgdijMe6LZbo03K212uMnr0/Jr1
        uMQbcNFSIbbR4c7Y5TMu9lz/wq8AQ12+KvAMKyy7u6l4aR2CdWHT9AFzdLCJii1Mc3Tph15wvkNgM
        fIBYG0a1TFhbkuQhnHovZ58ziwJWvhKl0GCQDreTvz3XeJkAay4nIfKeZj6ndiZy/EEHLGU2ZkNvP
        lMbx0tIFUrscnMZc5Rf89LJWuzYDk5kFdt3gw7upeqyKAlcMvgHKTG4x4olYOgBENsHfh19MPSKc8
        n+jnj/Iw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLvOn-00H0Hq-Bg; Mon, 15 Mar 2021 22:09:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 09253303205;
        Mon, 15 Mar 2021 23:09:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8DF42C089444; Mon, 15 Mar 2021 23:09:15 +0100 (CET)
Date:   Mon, 15 Mar 2021 23:09:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [GIT pull] locking/urgent for v5.12-rc3
Message-ID: <YE/bCyJM/xGsqsd3@hirez.programming.kicks-ass.net>
References: <161573639668.27979.17827928369874291298.tglx@nanos>
 <CAHk-=wjuD2cCptSJmmHBp2c9chTPnZcSi+0vA+QJ8JNjYTJKCw@mail.gmail.com>
 <YE8b6dgsEG4OU0ay@hirez.programming.kicks-ass.net>
 <YE9AkgbqL+eVO6p1@hirez.programming.kicks-ass.net>
 <YE9EVNG4/5UMJvFp@hirez.programming.kicks-ass.net>
 <YE9OOx0za7ZH3AXe@hirez.programming.kicks-ass.net>
 <20210315170321.ndeqgjzdfupvuiak@treble>
 <CAHk-=wjE1Z2L87B_ahMMEd9E+jumMwsw=HDCgDkV4gmS=F9u6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjE1Z2L87B_ahMMEd9E+jumMwsw=HDCgDkV4gmS=F9u6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:59:12AM -0700, Linus Torvalds wrote:
> Is it only the static_call_sites entry itself that needs the
> alignment? Or do we end up depending on the static call function being
> at least 4-byte aligned too? The way it plays games with the key makes
> me worry.

The only thing that absolutely needs to be aligned is the
struct static_call_key address. We use the 2 LSB there.

The code address has no alignment requirements, due to x86 instruction
coding the actual CALL (or JMP for tail-calls) can be anywhere.

Now, static_call_site is PC32 encoded, that is:

	struct static_call_key *key =
		(void *)((unsigned long)&site->key + site->key);

And assuming &site->key is aligned, then site->key & 3 == key & 3.

Per the missing alignment for modules, the above went side-ways. The
patch in question fixed this by not relying on that and always computing
the absolute address first, then transfer the LSBs and then re-encoding
it.

Anyway, still good to also fix the alignment.
