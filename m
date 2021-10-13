Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC68B42CD1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhJMVy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:54:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40357 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJMVy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634161942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=avX9+mknrQamceG9eCidHSvDtUPJ1G21ehILe0M/8Pc=;
        b=Y6ZngUiMJfMAAcLlcU2bvnv+s/OvcmDdzbsLeQFdyn4NzFQy0X3FqIp3qlmA9Dy6wq+U7O
        FTVUIREsFnajZhvXE+SiJgBTG6vDBUQhawQzZIc1VruqwF0wSQ3MgiVWVXKjxtxdbGl2Aq
        RIfUjT9FoIUu9SeQGfl5nrIcfy4SS08=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-AWgD1dutMz-wyfHyo3-Ptg-1; Wed, 13 Oct 2021 17:52:20 -0400
X-MC-Unique: AWgD1dutMz-wyfHyo3-Ptg-1
Received: by mail-qv1-f70.google.com with SMTP id gi5-20020a056214248500b00382f7a7c7e6so3815548qvb.21
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=avX9+mknrQamceG9eCidHSvDtUPJ1G21ehILe0M/8Pc=;
        b=IKWCYw5baRDUtzLtmJIePTIZ1fVMF6LdY5xNbsTbkmjn2eBVD2bKhzaNWK4v6SS/I9
         lN5P2097B6v9JrVkUgJAa/1mWF3WvSJhL64upMwjPsDWRGFTp8ybixC3YPzsi9NFDhRj
         gfeaNyfbZ3WPF9qHUweKFLlV0iC6J9pMzi6BBi4BN49HNROJejYriAziETWHZQ5exS2u
         xbT5ozSWP2fNo2XFvmwSds271MqfEdD9JqDcfb1Md8LvuOkk50MwRWWmF+HkM2YRUz5M
         n9eeuhNSerdw26WbTYO19WSE42nking0LZBPtTt5nVoNSTV6qkDMGljHcmTAo9+xtEIw
         twvw==
X-Gm-Message-State: AOAM531sWcoP2P8HEiyC0l2W5z5vtpwuIKc9U0E7Day+h7S1+gXcQZLL
        /2h2FFUmcucuU8cs9ival8FvrHHAoC0HAjxoZxpf8uhp41UrZh6u5HT7hLlaQy+gZlzwjuPB14K
        globHRxPLiS8ZsZqbs99UORr3
X-Received: by 2002:a05:622a:1804:: with SMTP id t4mr2237313qtc.251.1634161940466;
        Wed, 13 Oct 2021 14:52:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0Q71erJd4RX6u+3hlrNax7Gxx6mWG3Skvgwp0Tpp/GzBqjoZ9NBHb3CsbrrnGNMh036cvFA==
X-Received: by 2002:a05:622a:1804:: with SMTP id t4mr2237303qtc.251.1634161940264;
        Wed, 13 Oct 2021 14:52:20 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id l3sm461789qkj.110.2021.10.13.14.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 14:52:19 -0700 (PDT)
Date:   Wed, 13 Oct 2021 14:52:17 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <20211013215217.pjs53a65reicn72d@treble>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <20211013203927.zbruy2ux7dug6ljk@treble>
 <YWdNgt47MhYTttux@hirez.programming.kicks-ass.net>
 <20211013214907.pqr3mr2m4xrh426y@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013214907.pqr3mr2m4xrh426y@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:49:10PM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 13, 2021 at 11:20:02PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 13, 2021 at 01:39:27PM -0700, Josh Poimboeuf wrote:
> > > On Wed, Oct 13, 2021 at 02:22:21PM +0200, Peter Zijlstra wrote:
> > > > +static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
> > > > +{
> > > > +	void (*target)(void);
> > > > +	int reg, i = 0;
> > > > +
> > > > +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> > > > +		return -1;
> > > 
> > > Better to do this check further up the call stack in apply_retpolines()
> > > before looping through all the call sites?
> > 
> > In fact, I've pushed it further down, in order to always validate the
> > absense of rsp.
> > 
> > > > +
> > > > +	target = addr + insn->length + insn->immediate.value;
> > > > +	reg = (target - &__x86_indirect_thunk_rax) /
> > > > +	      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);
> > > > +
> > > > +	if (WARN_ON_ONCE(reg & ~0xf))
> > > > +		return -1;
> > > 
> > > It would be more robust and less magical to just have a basic lookup
> > > table array which converts a thunk address to a reg.  Then you can just
> > > avoid all the safety checks because it's no longer insane ;-)
> > 
> > Andrew suggested the reverse lookup to validate. That should give the
> > same robustness but lacks the linear lookup.
> 
> So you've got a WARN_ON_ONCE, a BUG_ON, and a too-deep feature check,
> all in the name of supporting this scheme.  ok...

Not to mention the extra silly rsp thunks...

> If performance of the linear lookup were a real concern then you could
> just put rax and r11 at the beginning of the array.

-- 
Josh

