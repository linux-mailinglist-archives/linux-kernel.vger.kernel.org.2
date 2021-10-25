Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE4C43996B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhJYO7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhJYO7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:59:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8C0C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zmLK+AKV4g2Qg/lbEfGjPewbRorji9DedTnXtifc7bU=; b=HxM0ibGfAlXgx4A71JCfpTjSQ8
        dCCSkxk6gablTyCZv2MUNysEgUWQhyqswsfsTEnZdQXPU4TklZUUQSmSX8NehDbXXM/bERq8vmPIv
        Yg+i9ggQi+s/hdpvk5VHlgtU0XoqKEKvldANEyqlqL9KFg7HrL4yHgR+BgKJcoREI7PULt5HTji2r
        WZ2AnGrziyVXc/iIjcuMA9xQ7qiHKrlVwwU4LYvfOld0Hz97S+2nYVYsMc9xTVeXS++fWKSI8SIoE
        RHPv9WXzokwxyLuVolT1mh+9P6T8g2Q1pWlmzORBpGxrpBY0AwH3oG5NrRvioWUEPq3M28CFg6HYx
        Te0/OLQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mf1Ox-00CA5K-Sf; Mon, 25 Oct 2021 14:56:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ED33D3003A9;
        Mon, 25 Oct 2021 16:56:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D597329DEC068; Mon, 25 Oct 2021 16:56:37 +0200 (CEST)
Date:   Mon, 25 Oct 2021 16:56:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Rob Landley <rob@landley.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Commit 0d989ac2c90b broke my x86-64 build.
Message-ID: <YXbFpfJwXJXABDup@hirez.programming.kicks-ass.net>
References: <53f767cd-9160-1015-d1b8-0230b5566574@landley.net>
 <CAK7LNAQFEi=4nky4nxRA8s+ODaf89Wa5kwDhe9dppKWX0UiFJA@mail.gmail.com>
 <20211024192742.uo62mbqb6hmhafjs@treble>
 <66ed460c-ac48-2b5a-e8e4-07613cf69ab0@landley.net>
 <YXZzIUqdWW9wwlpr@hirez.programming.kicks-ass.net>
 <20211025144656.fqqneysf72wwxp3m@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025144656.fqqneysf72wwxp3m@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 07:46:56AM -0700, Josh Poimboeuf wrote:
> On Mon, Oct 25, 2021 at 11:04:33AM +0200, Peter Zijlstra wrote:
> > On Sun, Oct 24, 2021 at 09:51:45PM -0500, Rob Landley wrote:
> > > > Unfortunately I think CONFIG_STACK_VALIDATION is no longer optional on
> > > > x86-64 these days, because of static calls and retpolines.
> > > 
> > > Does it need stack validation, or just a frame unwinder?
> > 
> > static_calls rely on objtool to find all "call __SCT*" instructions and
> > write their location in a .static_call_sites section.
> > 
> > The having of static calls is not optional on x86_64, and I have zero
> > interest in trying to work out what not having static_call() does, or to
> > maintain that option.
> 
> What I meant was, make STATIC_CALL_INLINE optional.  Then it would use
> out-of-line static calls which should just work, no?

Yeah, I suppose so... I think we're then missing a STACK_VALIDATION
dependency for KCOV. We rely on objtool to nop out those
__sanitizer_cov_* calls.

I had really hoped to just make objtool an unconditional part of x86_64.
