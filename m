Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC973A6B89
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhFNQXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbhFNQXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:23:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F434C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oA6G22ho2mWaE1Y5CClcG2aCh84F7uVzlOND9aVfAQQ=; b=qxrGYkd8RZTEVilAtOkdN2QnAQ
        C4MzGLnuvRyK/5ZR22dvvqeDs4yd//yuW6EPKZuwaE78jKu+vgHVXPtYQFf15BWL0UvKSalsAWejx
        yDhHHGCNUyNLN2vMyr0tIVc4BwSVfM4ebCHdDA1rgi3mN71WPghVJwRLhS4T5XabxBC5uj7QTor9+
        yYKPLOXg2wHVKwalnAxDMZFHfENALlsufYQX9OrBx4JQi/ToclxRNVMTMXgKzxavhDvBV5F3U2akd
        Txe0EFu2KWdJw5LOo8eK39o+Mr5IuPsSUUbnG/B1fQJG11CQyIwZ3IY7eJZRYa3TLmZXbhGtHMCip
        L2Q+tHBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lspJz-005buy-81; Mon, 14 Jun 2021 16:20:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE69A9831CA; Mon, 14 Jun 2021 18:20:18 +0200 (CEST)
Date:   Mon, 14 Jun 2021 18:20:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] gcov,x86: Mark GCOV broken for x86
Message-ID: <20210614162018.GD68749@worktop.programming.kicks-ass.net>
References: <YMcssV/n5IBGv4f0@hirez.programming.kicks-ass.net>
 <CAKwvOd=PYrMnNOu060T3Z26RJriNXqu3iM85Daink4-BN__2sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=PYrMnNOu060T3Z26RJriNXqu3iM85Daink4-BN__2sQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 09:05:04AM -0700, Nick Desaulniers wrote:
> On Mon, Jun 14, 2021 at 3:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >
> > As recently discovered, there is no function attribute to disable the
> > -fprofile-generate instrumentation. As such, GCOV is fundamentally
> > incompatible with architectures that rely on 'noinstr' for correctness.
> 
> Is there context for comment, or is this patch meant as a joke?

Only if you think recursion in exception entry code is funny.

noinstr *MUST* disable any and all compiler generated instrumentation,
currently it that isn't the case for -fprofile-gnerate, nor
-fprofile-arc.

Look for all the fun we had with KCOV back then. Luckily KCOV
instrumentation was trivial to patch out using objtool, so that's what
x86 is currently doing.

Luckily both compilers grew a __no_sanitize_coverage recently and we no
longer have to rely on objtool fixing up the compiler output for much
longer.

  https://lkml.kernel.org/r/20210527194448.3470080-1-elver@google.com

Now all we need is one more such attribute to kill -fprofile-* stuff.
