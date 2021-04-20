Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E312A36550E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 11:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhDTJOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 05:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhDTJOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:14:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31EAC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w+ryTxnd465LRAIj85wzoxUZIv++pjCiJNJW6XXQUww=; b=ACklhU4cX7y1UGNvi88oa2pGFG
        bilEoAC4YYnn6hG82kxjYz78y83Lq0BZpkL51KXeuHGI4haf9WUULoEscdWL+F9Jy6vbjI2yfylLT
        vTYpw/sfktqabBtFakl2r/kYaEX/cg8CRFxglTGgByZFbKxzOXzO3Asr8WA+wAswKy7kjdFSXFJrd
        GIWnosxZS5Pqi//Fwkb3I3P1Q9AaMPapAF8TUty4OUszCAp1vs+nA0h9340w5PqvjdEw1GRws2mXT
        g6foSfhlZzjBddpG9QyzkU+EcF54DmE1Sxq9rq7LaxKMsvq6LdQMvL9c1sY3elvpFjW9S1EVktdO/
        VRVX6MHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYmSG-00Bgqh-6V; Tue, 20 Apr 2021 09:14:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 84EB130013E;
        Tue, 20 Apr 2021 11:13:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 602302BDD7C7F; Tue, 20 Apr 2021 11:13:59 +0200 (CEST)
Date:   Tue, 20 Apr 2021 11:13:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, axboe@kernel.dk,
        paulmck@kernel.org
Subject: Re: [PATCH] smp: add a best_effort version of
 smp_call_function_many()
Message-ID: <YH6bV9W4lgIl4Fry@hirez.programming.kicks-ass.net>
References: <20210419184455.2987243-1-lrizzo@google.com>
 <20210419191712.GB26214@worktop.programming.kicks-ass.net>
 <CAMOZA0JxwQFfA=acfr255xcR85ztv-URwaQQFHR6RrLk-cPbvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMOZA0JxwQFfA=acfr255xcR85ztv-URwaQQFHR6RrLk-cPbvg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 11:07:08PM +0200, Luigi Rizzo wrote:
> On Mon, Apr 19, 2021 at 9:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Apr 19, 2021 at 11:44:55AM -0700, Luigi Rizzo wrote:
> > > Regardless of the 'wait' argument, smp_call_function_many() must spin
> > > if any of the target CPUs have their csd busy waiting to be processed
> > > for a previous call. This may cause high tail latencies e.g. when some
> > > of the target CPUs are running functions that disable interrupts for a
> > > long time; getrusage() is one possible culprit.
> > >
> > > Here we introduce a variant, __smp_call_function_many(), that adds
> > > a third 'best_effort' mode to the two existing ones (nowait, wait).
> > > In best effort mode, the call will skip CPUs whose csd is busy, and if
> > > any CPU is skipped it returns -EBUSY and the set of busy in the mask.
> > > This allows the caller to decide how to proceed, e.g. it might retry at
> > > a later time, or use a private csd, etc..
> > >
> > > The new function is a compromise to avoid touching existing callers of
> > > smp_call_function_many(). If the feature is considered interesting, we
> > > could even replace the 'wait' argument with a ternary 'mode' in all
> > > smp_call_function_*() and derived methods.
> >
> > I don't see a user of this...
> 
> This is actually something for which I was looking for feedback:
> 
> my use case is similar to a periodic garbage collect request:
> the caller tells targets that it may be time to do some work,
> but it does not matter if the request is dropped because the
> caller knows who was busy and will reissue pending requests later.
> 
> I would expect something like the above could be useful e.g.
> in various kinds of resource manager.
> 
> However, a grep for on_each_cpu_*() and smp_call_function_*()
> mostly returns synchronous calls (wait=1).
> 
> Any possible candidates that people can think of ?

We mostly try and avoid using this stuff wherever possible. Only when
no other choice is left do we send IPIs.

NOHZ_FULL already relies on this and gets massively unhappy when a new
user comes and starts to spray IPIs.

So no; mostly we send an IPI because we _HAVE_ to, not because giggles.

That said; there's still some places left where we can avoid sending
IPIs, but in all those cases correctness mandates we actually handle
things and not randomly not do anything.

For example, look at arch/x86/kernel/alternative.c:text_poke_sync(). The
purpose of that is to ensure all CPUs observe modified *kernel* code.
Now, if that CPU is currently running userspace, it doesn't much care
kernel code is changed, however that does mean it needs to call
sync_core() upon entering kernel, *BEFORE* hitting any code that's
possibly modified (and self modifying code is everywhere today,
ironically also very much in the NOHZ_FULL entry paths).

So untangling all that should be possible, but is something that
requires quite a bit of care and doesn't benefit from anything like the
proposed.

Mostly it sounds like you shouldn't be using IPIs either.
