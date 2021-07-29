Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630503DAC63
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 22:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhG2UFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 16:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhG2UF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 16:05:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E124FC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dd8JzduH9hxHBnbjFnGofLElCDIcMgnxT3piASBgVac=; b=Eu+JXMHC0Kdk3tklE2H6hw/O4D
        VjwMmH90+/bdv3m5bR6zoOtIImkkyxUawMw/XneLP7+wVjChhc9CxejN4JbYFKmP1OxuNGp4QqIkz
        yZ/wtTeeH+cZFwP4moEwKkV2xpVuyjwL1+S1laKUuSLAiJeEADwnVSp5HGTr2a/1oNSnSdn9yctmi
        YMXg0zQspv0P9Ih3Tq43+aLhxStH4O89ZtCOsmvVNB0+0QfB0eb0AEKXpAQzpHS8pjwamfCDeCJxN
        O916PXBOlJ6N58PQY0sjFdd73m3tQWfrvUZSuB8ResKCIuc0GvHPdyzF4wIWGu8X/+csBr9yfKUW1
        8BLE6Wbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9CFe-00HVxv-Qw; Thu, 29 Jul 2021 20:03:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 400D498631F; Thu, 29 Jul 2021 22:03:29 +0200 (CEST)
Date:   Thu, 29 Jul 2021 22:03:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     hev <r@hev.cc>
Cc:     Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        huacai chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, geert@linux-m68k.org,
        Huacai Chen <chenhuacai@loongson.cn>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        wangrui <wangrui@loongson.cn>, lixuefeng <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] Documentation/atomic_t: Document forward progress
 expectations
Message-ID: <20210729200329.GC82583@worktop.programming.kicks-ass.net>
References: <YQK9ziyogxTH0m9H@hirez.programming.kicks-ass.net>
 <CAHirt9hsN9cy16TKSn7Bb+HG5M52FR1Ct8=7xDiM14+5K_S8eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHirt9hsN9cy16TKSn7Bb+HG5M52FR1Ct8=7xDiM14+5K_S8eg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 12:24:14AM +0800, hev wrote:
> We may need new APIs to help LL/SC to implement atomic operations, but
> this is obviously incompatible with native CAS. and many and many
> common functions are CAS friendly. Let's more functions that implement
> atomic semantics can be overridden by architecture may be a way. ;-)
> 
> In the above example, the correct implementation on LL/SC may be like:
> 
> do {
>     old = LL(&v);
>     new = func(old, &skip);
>     if (skip) {
>         break;
>     }
> } while (!SC(&v, new);
> 
> However, the success of SC may be affected by the inconstant
> complexity of func. :-(

Right, so you can't really do that because the architecture constraints
on what is allowed between LL and SC vary. Also, you couldn't compile
that code on a CAS architecture because you simply cannot implement the
LL/SC semantics using CAS.

One thing that can be done is having the compiler transform a CAS loop
into a LL/SC loop, and clang actually tries that, but GCC is absolutely
failing there:

  https://godbolt.org/z/1MK6ceq46

(note; clang only does this for arm64, and the code it does generate is
pretty horrific)

And this is another thing where C11 is utter crap; because as far as
it's concerned this is equivalent, while obviously it is not, per the
parent argument.

Also, ideally there would be a variant where you'd mandate the
forward progress or a compiler error when not possible.
