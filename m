Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C1C43A463
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbhJYUYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbhJYUYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:24:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED93C0432F2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IQfu5VLXdk6QO/J/gt3oRIHkUz7y5fV8KHYoUMu07Bc=; b=VdNFNExAYjZ3ARJVolUsRV4RrB
        9b6svX6pEXH3SLwpG6C9pbIZbq6H7Sj59vp6vZTJuiPIUnoTS3FfDGPOMZmvDjtjXNK9xW4REwiid
        2yoXewOe3DYATLyupTqMmsGq6mIdE8JRiGP0ZAAw5aKo6fWU4OKHmhxK0XQuW12mRx0UqCBq7XRoa
        rDcNU2JLswJtFlvDL5V2vZ3NlufRLMNn7RP/Agiu6M1udzoxoqKcITKRFX3iM9eGjfwmyvhLS0Waf
        pMmHk0QqSwsm2A6cGmeXIgbGwAF6rWh42RKW0h1/r59a7Cb+6d2nnshHUtMqvE9NTDqCT/pxfm6jh
        W4LilEfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mf69V-00GOfN-Vq; Mon, 25 Oct 2021 20:01:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EE64300230;
        Mon, 25 Oct 2021 22:01:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 353792C33EC01; Mon, 25 Oct 2021 22:01:01 +0200 (CEST)
Date:   Mon, 25 Oct 2021 22:01:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Rob Landley <rob@landley.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Commit 0d989ac2c90b broke my x86-64 build.
Message-ID: <YXcM/a8TUJYPcaGI@hirez.programming.kicks-ass.net>
References: <53f767cd-9160-1015-d1b8-0230b5566574@landley.net>
 <CAK7LNAQFEi=4nky4nxRA8s+ODaf89Wa5kwDhe9dppKWX0UiFJA@mail.gmail.com>
 <20211024192742.uo62mbqb6hmhafjs@treble>
 <66ed460c-ac48-2b5a-e8e4-07613cf69ab0@landley.net>
 <YXZzIUqdWW9wwlpr@hirez.programming.kicks-ass.net>
 <20211025144656.fqqneysf72wwxp3m@treble>
 <YXbFpfJwXJXABDup@hirez.programming.kicks-ass.net>
 <20211025185945.ywcvhqypzoaxohyc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025185945.ywcvhqypzoaxohyc@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 11:59:45AM -0700, Josh Poimboeuf wrote:
> Plus it's a good idea to make the dependencies more explicit.  We've
> already been looking at modularizing, like creating a new CONFIG_OBJTOOL
> option and splitting stack validation out from some of the other
> features.  This could be a nice extension of that.
> 
> Which reminds me, I'm still thinking we need to make the interface more
> easily combinable, like:
> 
> objtool run				\
> 	[--validate]			\
> 	[--noinstr]			\
> 	[--retpoline]			\
> 	[--orc]				\
> 	[--mcount]			\
> 	[--static-call]			\
> 	[--kcov]			\
> 	[--frame-pointer]		\
> 	[--vmlinux]			\
> 	[--uaccess]			\
> 	[--module]			\
> 	[--no-unreachable]		\
> 	[--backup]			\
> 	[--stats]			\
> 	[--backtrace]
> 
> objtool dump				\
> 	[--orc]				\
> 	[--mcount]			\
> 	[--static-call]			\
> 	[--alternatives]		\
> 	[--whatever]
> 
> I can hopefully get to it one of these weeks...

Yes, that would be nice.

Also, unrelated, were you going to do that .fixup cleanup for x86_64 or
should I try and squeeze it in?
