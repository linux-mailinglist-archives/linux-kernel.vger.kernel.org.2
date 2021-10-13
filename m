Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F7142CD12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhJMVuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhJMVuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:50:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FF1C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HZ56KTHPdvuvUfo/m6ab1r7tDy+YZjwbbIrWO42qRg8=; b=Tt5MSBeGQSYsqjHikpMA7ypEXw
        a+2fYM7CcZMHQ+mV02ptnXLWWGrl/by2EqAzIqvUkc17MnorSklObsMTfE8CHiamk3w/6kaJqNFj9
        Cn+yyCMuV340ce88gXIoZrgwW7hL4vvBkKn/TLgcij5nGpLAxsAG54Ah59M4SiaivtVPwSHsVeHYZ
        8bOitIanF5x9vYUWoDqhRtXWTC4sJwNexzi/pXDpc1oySC3bZdN7/m1aguAI1Yz+BNKgonly3oUyp
        zp7XKGtHIALao/sHQpOa6GzJzA0J4t4lIMyhKrHNTFK1cm3QcI4Gq9YD8IgTjqjVIxYQhahmb92Wt
        dNv9FYLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mam2I-007p69-VS; Wed, 13 Oct 2021 21:44:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3695D300252;
        Wed, 13 Oct 2021 23:43:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2077320193AF3; Wed, 13 Oct 2021 23:43:43 +0200 (CEST)
Date:   Wed, 13 Oct 2021 23:43:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <YWdTDz8Qqs3jjCf1@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <20211013211118.apsj66c6b6abubeo@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013211118.apsj66c6b6abubeo@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:11:18PM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 13, 2021 at 02:22:21PM +0200, Peter Zijlstra wrote:
> > +#ifdef CONFIG_X86_64
> > +
> > +/*
> > + * CALL/JMP *%\reg
> > + */
> > +static int emit_indirect(int op, int reg, u8 *bytes)
> 
> X86_64 is already equivalent to STACK_VALIDATION these days, but might
> as well clarify here where the retpoline_sites dependency comes from by
> changing this to '#ifdef CONFIG_STACK_VALIDATION'.

Yeah, I was contemplating having x86_64 unconditionally select that.
Maybe we should.

Also, I think I've proposed it before, but what about:

 s/STACK_VALIDATION/OBJTOOL/

on all that?
