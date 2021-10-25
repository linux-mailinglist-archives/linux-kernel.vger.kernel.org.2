Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FC74391F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhJYJJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbhJYJJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:09:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70917C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 02:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eLz6CvSAHIZYP8bX5Q/PFMo/fENVcXDR/Xri+Pjzzgg=; b=lxakpkQBtB0ZzLg221DYurGYT/
        VHfg9ZFhBUSdxktwfUTFFL//vfhocGaaG4l0rWwVeGrdmORL74wGPZVwTU8ufSA9zmg7ARl8QhdYJ
        mq7IF7dInn16romov2GduSAvBFhbqSyN+WeZ8qnK6e0jlko5h016gN0zi0OyMDdaEkOQ+h6x/rLS5
        lAmYtndESBZB75IedhNpBvhzBPCxqg6ecAPBebAbJkpIa8VuS0Lf9bLqJjfZuIqdGx9VPkIqB3zc5
        F+PLPg/ieC1htqxjS5dFj+Nnkx4fJL3QY6DoQJhLoPHN8iBxLUwHXh93yuFUJgr4lzoSAgKSSzgmw
        +TRWO5tA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mevuE-00FyME-PP; Mon, 25 Oct 2021 09:05:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC94C3001BF;
        Mon, 25 Oct 2021 11:04:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF4C720C6C14E; Mon, 25 Oct 2021 11:04:33 +0200 (CEST)
Date:   Mon, 25 Oct 2021 11:04:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rob Landley <rob@landley.net>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Commit 0d989ac2c90b broke my x86-64 build.
Message-ID: <YXZzIUqdWW9wwlpr@hirez.programming.kicks-ass.net>
References: <53f767cd-9160-1015-d1b8-0230b5566574@landley.net>
 <CAK7LNAQFEi=4nky4nxRA8s+ODaf89Wa5kwDhe9dppKWX0UiFJA@mail.gmail.com>
 <20211024192742.uo62mbqb6hmhafjs@treble>
 <66ed460c-ac48-2b5a-e8e4-07613cf69ab0@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66ed460c-ac48-2b5a-e8e4-07613cf69ab0@landley.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 09:51:45PM -0500, Rob Landley wrote:
> > Unfortunately I think CONFIG_STACK_VALIDATION is no longer optional on
> > x86-64 these days, because of static calls and retpolines.
> 
> Does it need stack validation, or just a frame unwinder?

static_calls rely on objtool to find all "call __SCT*" instructions and
write their location in a .static_call_sites section.

The having of static calls is not optional on x86_64, and I have zero
interest in trying to work out what not having static_call() does, or to
maintain that option.

We have too damn many daft configurations as is.
