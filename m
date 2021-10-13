Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8C242CD16
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhJMVvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47834 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJMVvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634161752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mXoGPaQ3ysexBvLYRRKVzx1dI1q6TUhG9axCCwK8V2w=;
        b=gOw9oHQqUsC3xhw2CHLD8OF8eRBjAH2THNU+sqxXY4FbYYGqS1ePWt59TbwteNseGJPRPJ
        3PpCbWKQ6Pfe36HwSsNcvKtoKJDFrFBoF+nUXyUB/LXXEtogdTJuQG2gUI8E06psLZ1VKB
        j1h4s9OwcLT/ZZufSM3pNg19440CRuo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-0z4eZK2nOz27uIA4Fbu1uQ-1; Wed, 13 Oct 2021 17:49:11 -0400
X-MC-Unique: 0z4eZK2nOz27uIA4Fbu1uQ-1
Received: by mail-qk1-f198.google.com with SMTP id x25-20020a05620a01f900b0045e1c4567ddso2946716qkn.15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mXoGPaQ3ysexBvLYRRKVzx1dI1q6TUhG9axCCwK8V2w=;
        b=oMtXuOaFITFpMIC/ri1By+uT3Zl0CBm8UjUP4cEXQ0rXP8hMJ8S2duICFNz7baAfDD
         jocYy6tJ5d+t06ZlroEpwodjQCqHONLHwryB/hWLwYl5XzwptO0zYMrj88y60I81cWC+
         hrg6Zd5MQzlt1TR0I7r42lf41HwlbbuvmX0Xk9nnXkdc6e+Bm+gcyQM5+MtfGkZATnvQ
         988beg0NI5oaF21EL0tp0DvpK9j81xj2SZLr2x8SA5krRS9s6BXNOuz1XIvsi1FrH65w
         oLhAMhQX9Xkrg/s2jJZ3GU2Uj37xVX7EJelF6ni8ShFoNPTg8j/UZgAPvurq/Vdyks1/
         T9Yg==
X-Gm-Message-State: AOAM530ANAhNqPfAcnglLYJsPLP2P4B3T4oCwBPd5qXqbeewoVVMXhsZ
        05AdYJiE0k4JIs2ZWky56IaXKQCLEP4BssgUUoDOqmrQrl4GDGd/U8b2amHPzGqJaxjJbp0RNre
        Z+N5/3/7IFoqmLaxgqgldPTLF
X-Received: by 2002:a05:620a:190c:: with SMTP id bj12mr1555883qkb.325.1634161750532;
        Wed, 13 Oct 2021 14:49:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe2B7bTbSWC1HTi3gkLstY6LMPYbuTnIMeGW10eArR95pMX1cvAQpcbb7XXZcvcPGGxKIL5Q==
X-Received: by 2002:a05:620a:190c:: with SMTP id bj12mr1555866qkb.325.1634161750281;
        Wed, 13 Oct 2021 14:49:10 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id 101sm484803qta.17.2021.10.13.14.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 14:49:09 -0700 (PDT)
Date:   Wed, 13 Oct 2021 14:49:07 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <20211013214907.pqr3mr2m4xrh426y@treble>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <20211013203927.zbruy2ux7dug6ljk@treble>
 <YWdNgt47MhYTttux@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWdNgt47MhYTttux@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:20:02PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 13, 2021 at 01:39:27PM -0700, Josh Poimboeuf wrote:
> > On Wed, Oct 13, 2021 at 02:22:21PM +0200, Peter Zijlstra wrote:
> > > +static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
> > > +{
> > > +	void (*target)(void);
> > > +	int reg, i = 0;
> > > +
> > > +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> > > +		return -1;
> > 
> > Better to do this check further up the call stack in apply_retpolines()
> > before looping through all the call sites?
> 
> In fact, I've pushed it further down, in order to always validate the
> absense of rsp.
> 
> > > +
> > > +	target = addr + insn->length + insn->immediate.value;
> > > +	reg = (target - &__x86_indirect_thunk_rax) /
> > > +	      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);
> > > +
> > > +	if (WARN_ON_ONCE(reg & ~0xf))
> > > +		return -1;
> > 
> > It would be more robust and less magical to just have a basic lookup
> > table array which converts a thunk address to a reg.  Then you can just
> > avoid all the safety checks because it's no longer insane ;-)
> 
> Andrew suggested the reverse lookup to validate. That should give the
> same robustness but lacks the linear lookup.

So you've got a WARN_ON_ONCE, a BUG_ON, and a too-deep feature check,
all in the name of supporting this scheme.  ok...

If performance of the linear lookup were a real concern then you could
just put rax and r11 at the beginning of the array.

-- 
Josh

