Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495D642CDAF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhJMWSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhJMWSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:18:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B975EC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gd4cteDGr6xYmmq8pBoi3SACYwahRg0pd5fYr0WshOM=; b=U+1+Lcg3OrODRzCOxAnG5CRqHg
        DoGaEeQYncnZQcYvHeKo01rxDNHC1ZEP6z6OfNdwAgZgmHLRjigusq/kuN08HHjo6RLvxNxP+K2Cp
        agEkwJGyqKqFRPPcxQUy2kiHZvNfuxxeo0Ge7yOWhYDwqH6KyAIa/uio4LW1dpBU90+A4zORxAltq
        QZ1iKs3L1UtQQrII/7kYnZ/NXaomnr7B7bCLN3ppmWjgJqH8Ls3Ts2yJQGpZCXLTYE0IwvdsdOMjD
        JfXwFbq8silhVRkuLY31qi1RDHqvpY/gOEjPJjlJSH56ylZuqXmLRw1G7WPqt7vx0Es9XIzpZEUY4
        YMAKTVOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mamWR-007qSg-Ld; Wed, 13 Oct 2021 22:15:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACAB9300252;
        Thu, 14 Oct 2021 00:14:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E163207EF0DE; Thu, 14 Oct 2021 00:14:51 +0200 (CEST)
Date:   Thu, 14 Oct 2021 00:14:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <YWdaW0niLW4HPM0W@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <20211013211118.apsj66c6b6abubeo@treble>
 <YWdTDz8Qqs3jjCf1@hirez.programming.kicks-ass.net>
 <20211013220520.xzsp5q2amuwy6n6o@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013220520.xzsp5q2amuwy6n6o@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 03:05:20PM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 13, 2021 at 11:43:43PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 13, 2021 at 02:11:18PM -0700, Josh Poimboeuf wrote:
> > > On Wed, Oct 13, 2021 at 02:22:21PM +0200, Peter Zijlstra wrote:
> > > > +#ifdef CONFIG_X86_64
> > > > +
> > > > +/*
> > > > + * CALL/JMP *%\reg
> > > > + */
> > > > +static int emit_indirect(int op, int reg, u8 *bytes)
> > > 
> > > X86_64 is already equivalent to STACK_VALIDATION these days, but might
> > > as well clarify here where the retpoline_sites dependency comes from by
> > > changing this to '#ifdef CONFIG_STACK_VALIDATION'.
> > 
> > Yeah, I was contemplating having x86_64 unconditionally select that.
> > Maybe we should.
> 
> As far as I can tell, it already does that:
> 
>         select HAVE_STACK_VALIDATION            if X86_64
>         select HAVE_STATIC_CALL_INLINE          if HAVE_STACK_VALIDATION
>         select STACK_VALIDATION                 if HAVE_STACK_VALIDATION && (HAVE_STATIC_CALL_INLINE || RETPOLINE)

Oh right, I thought there was still a possible hole in there, but I
guess that's pretty solid. I suppose we should just remove the && ...
from the last line.
