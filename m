Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05BE35A044
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhDINs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231599AbhDINsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617976122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZneTleoditFJnDvsvcmD0oLbFf5R+kuV2tQYXKjo4DA=;
        b=gL07CqQwyJe88ZFZ/xY7mxUUeHSeQh63i8Z4nutI8U5jiG2dif6QeUva0l1/P/I1Db4ae4
        Awx5lbrv7oI58zCRNZPVxQ0cetSzUlossMwlQbejzuhqq7POqf1w5ls+N8BAn+hxwf0CW9
        DazCfsQ+vrIpz1tTjH/Id8/0zHuqJwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-roXGcz9xOZO0WnT8elFszQ-1; Fri, 09 Apr 2021 09:48:38 -0400
X-MC-Unique: roXGcz9xOZO0WnT8elFszQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCEB18030BB;
        Fri,  9 Apr 2021 13:48:36 +0000 (UTC)
Received: from t14s.localdomain (ovpn-112-65.phx2.redhat.com [10.3.112.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF19F1042A46;
        Fri,  9 Apr 2021 13:48:33 +0000 (UTC)
Message-ID: <3c062f70ffef2dcd48a661f7c8162fb8fbaf6869.camel@redhat.com>
Subject: Re: static_branch/jump_label vs branch merging
From:   David Malcolm <dmalcolm@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date:   Fri, 09 Apr 2021 09:48:33 -0400
In-Reply-To: <YHBS70ZQ6gOpMk2K@hirez.programming.kicks-ass.net>
References: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
         <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com>
         <YHA2jPIaj0p23mv8@hirez.programming.kicks-ass.net>
         <5f78b7e2f9ae937271ef52ee9e999a91c2719da9.camel@redhat.com>
         <YHBCoijoopbsDn29@hirez.programming.kicks-ass.net>
         <YHBQPr8q0cx4iUfN@hirez.programming.kicks-ass.net>
         <YHBS70ZQ6gOpMk2K@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-09 at 15:13 +0200, Peter Zijlstra wrote:
> On Fri, Apr 09, 2021 at 03:01:50PM +0200, Peter Zijlstra wrote:
> > On Fri, Apr 09, 2021 at 02:03:46PM +0200, Peter Zijlstra wrote:
> > > On Fri, Apr 09, 2021 at 07:55:42AM -0400, David Malcolm wrote:
> > 
> > > > Sorry if this is a dumb question, but does the function
> > > > attribute:
> > > >   __attribute__ ((pure)) 
> > > > help here?  It's meant to allow multiple calls to a predicate
> > > > to be
> > > > merged - though I'd be nervous of using it here, the predicate
> > > > isn't
> > > > 100% pure, since AIUI the whole point of what you've built is
> > > > for
> > > > predicates that very rarely change - but can change
> > > > occasionally.
> > > 
> > > I actually tried that, but it doesn't seem to work. Given the
> > > function
> > > arguments are all compile time constants it should DTRT AFAICT,
> > > but
> > > alas.
> > 
> > FWIW, I tried the below patch and GCC-10.2.1 on current tip/master.
> 
> I also just tried __attribute__((__const__)), which is stronger still
> than __pure__ and that's also not working :/
> 
> I then also tried to replace the __buildin_types_compatible_p() magic
> in
> static_branch_unlikely() with _Generic(), but still no joy.
> 

[..snip...]

You tried __pure on arch_static_branch; did you try it on
static_branch_unlikely?

With the caveat that my knowledge of GCC's middle-end is mostly about
implementing warnings, rather than optimization, I did some
experimentation, with gcc trunk on x86_64 FWIW.

Given:

int __attribute__((pure)) foo(void);

int t(void)
{
  int a;
  if (foo())
    a++;
  if (foo())
    a++;
  if (foo())
    a++;
  return a;
}

At -O1 and above this is optimized to a single call to foo, returning 0
or 3 accordingly.

-fdump-tree-all shows that it's the "fre1" pass that eliminates the
subsequent calls to foo, replacing them with reuses of the result of
the first call.

This is in gcc/tree-ssa-sccvn.c, a value-numbering pass.

I think you want to somehow "teach" the compiler that:
  static_branch_unlikely(&sched_schedstats)
is "pure-ish", that for some portion of the surrounding code that you
want the result to be treated as pure - though I suspect compiler
maintainers with more experience than me are thinking "but which
portion? what is it safe to assume, and what will users be annoyed
about if we optimize away? what if t itself is inlined somewhere?" and
similar concerns.

Or maybe the asm stmt itself could somehow be marked as pure??? (with
similar concerns about semantics as above)

Hope this is constructive
Dave


