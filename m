Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD1373E9F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 17:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhEEPhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 11:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhEEPhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 11:37:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9368C061574;
        Wed,  5 May 2021 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BHjn+8BJGc2uHiH1xODfkxmvyV8IDwFLyUOp2gE2Us8=; b=PxFJqWL+155H6nniAkd3Jsspot
        gYFM/i3hrVtTk2vLE86VMH7UCPyrz4I2uI/YEjSb/R38kZfLQtiyBJ47bgU5p48G8YhrM1hbnD9sy
        ZlyJeb/HIzVXtSK3XRV+S0vEXZuH5wCHNNIqozK8HaNzjprMAjAS9max4K5Wxn5CR6qSwRZK4n+XP
        dJcZiqjv9ZjwlRY1GQj5mHA34HIp+sZSDazvV86vIflP7LjYaCsCcQGnC5fosLhVnfmKHUXetyEwp
        v4fqtvLzDBk4JmZaIwq4J5Cq91skt0ZsCYQ8DOK/zF9fbCbyDPtdmP+W//t8ytXdDuRudW9TB40ay
        jxjs77Wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leJY7-000VYK-Eu; Wed, 05 May 2021 15:35:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 80C363001D0;
        Wed,  5 May 2021 17:34:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D3E92B8FD1E1; Wed,  5 May 2021 17:34:54 +0200 (CEST)
Date:   Wed, 5 May 2021 17:34:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH] sched: Work around undefined behavior in sched class
 checking
Message-ID: <YJK7HlQYAIFVj9fL@hirez.programming.kicks-ass.net>
References: <20210505033945.1282851-1-ak@linux.intel.com>
 <YJI/OwoflyY2IXvf@hirez.programming.kicks-ass.net>
 <20210505143442.GR4032392@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505143442.GR4032392@tassilo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 07:34:42AM -0700, Andi Kleen wrote:
> > > Use RELOC_HIDE to make this work. This hides the symbols from gcc,
> > > so the optimizer won't make these assumption. I also split
> > > the BUG_ONs in multiple.
> > 
> > Urgh, that insanity again :/ Can't we pretty please get a GCC flag to
> > disable that?
> 
> Even if that was done (I could totally see the gcc people pushing back on this;
> why should they add special flags just for Linux developers not understanding
> ISO-C?)

I understand C fine, I just don't agree with it. I also want to
explicitly define as much UB as is possible, because UB is just utter
garbage.

So just like we do with -fwrapv and others, add more knobs that
explictly define away UB. Less UB is more better. This being C it's
unlikely we'll ever get to no UB, but we should damn well try :-)

> you would still need the fix for already shipping compilers.

Yes, there is that.
