Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884AF3736B8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 11:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhEEJFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 05:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhEEJFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 05:05:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD4CC061574;
        Wed,  5 May 2021 02:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hZi4ewpCK+lWJiEHygFzyAaJ5g9okvi4iFAZbz7URD4=; b=S/TjwcGJW4mvEfpR6nIld3U6i0
        CyIjLMHdu64BoRAxRHSbjt2wxX48/d8evhD6/+8avByoarKoSYTR3LLQclubCjpyDqgDmspHR9la0
        afjvdQWFEp36KlSS0i6u+v/yf9Zzbfrh3m7KgL16hwi1SV5q0/So85SPgWXf+21kQbTm0C0vCfjyS
        OrLOPfOILtlKYP+BiNTgXrso+kwUB1dYyWrJItONgGFUOTgS/p8PQ8+EtarNSbhIloRZPhEUYJLyU
        OBP5mnDLppgnZj2bEgbmv2XU9BzIukTe2rgUMEyb7R7bDi/yNFClnohIvb30ZREzJWBbZMRQlrHbO
        fVpC+R1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leDRq-000gJa-F5; Wed, 05 May 2021 09:04:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BEF93001CD;
        Wed,  5 May 2021 11:04:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62D54200CAA24; Wed,  5 May 2021 11:04:01 +0200 (CEST)
Date:   Wed, 5 May 2021 11:04:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <andi@firstfloor.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH] sched: Work around undefined behavior in sched class
 checking
Message-ID: <YJJfgaM5ijI8iNKy@hirez.programming.kicks-ass.net>
References: <20210505033945.1282851-1-ak@linux.intel.com>
 <YJI/OwoflyY2IXvf@hirez.programming.kicks-ass.net>
 <875yzxh8j8.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yzxh8j8.fsf@oldenburg.str.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 10:47:07AM +0200, Florian Weimer wrote:
> * Peter Zijlstra:
> 
> > On Tue, May 04, 2021 at 08:39:45PM -0700, Andi Kleen wrote:
> >> From: Andi Kleen <andi@firstfloor.org>
> >> 
> >> The scheduler initialization code checks that the scheduling
> >> classes are consecutive in memory by comparing the end
> >> addresses with the next address.
> >> 
> >> Technically in ISO C comparing symbol addresseses outside different objects
> >> is undefined. With LTO gcc 10 tries to exploits this and creates an
> >> unconditional BUG_ON in the scheduler initialization, resulting
> >> in a boot hang.
> >> 
> >> Use RELOC_HIDE to make this work. This hides the symbols from gcc,
> >> so the optimizer won't make these assumption. I also split
> >> the BUG_ONs in multiple.
> >
> > Urgh, that insanity again :/ Can't we pretty please get a GCC flag to
> > disable that?
> 
> Context:
> 
>   <https://lore.kernel.org/lkml/20210505033945.1282851-1-ak@linux.intel.com/>
> 
> Obviously, GCC doesn't do this in general.  Would you please provide a
> minimal test case?

Andi has this GCC-LTO patch-set that triggers this, but the thing I'd
like fixed is the UB mentioned above. Not this particular instance.

And, we've had the problem before, see all the RELOC_HIDE crud. Having
this pointer arith outside object be UB is just really annoying. And in
the spirit of UB bad, can we please get a flag to remove the UB and have
it do the obvious, just do the arithmetic and don't do daft things.

Pretty please.
