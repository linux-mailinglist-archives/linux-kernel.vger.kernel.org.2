Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74CF340085
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 08:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhCRH5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 03:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhCRH5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:57:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFEAC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 00:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A1er3V1YzHkEnZaOnMGI2G3xRUP5+HvSSE8iU7+kGK0=; b=JyXsVO+boZgSMF08xBcN8mpbK1
        oy6uXjMTld0N+Y8jYw4u7+fftwiOyEuqtBs0TF4uHu/6WMBD9HYKS2S75fxN/R3hzarp/G4NriSQK
        IYOjXKZRFJGlRFph3ELDDh3wXmKWGu6m1Qwy1YxgtGkUNF3ZycVBMZeWOhgULTmcX5ZakzZmtLakI
        WFkyuKYR1hE1KXbMCsVmZbPyP1g5c6SZ9sq/mO9oafIiIKetJWhzjWDBZagkk4Y0MoOGVzNYFVpnI
        rmiuqxUN3kL53V5/Zz6GAadUe4qxcB8UQa0wdbdfAGtF8KXl15ElwK2fYFIyn1L48Ar7A+mF1G3C4
        jG+JRCjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMnW2-002ivA-OG; Thu, 18 Mar 2021 07:56:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7DC6B3050F0;
        Thu, 18 Mar 2021 08:56:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A16A200CF9FB; Thu, 18 Mar 2021 08:56:21 +0100 (CET)
Date:   Thu, 18 Mar 2021 08:56:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, x86@kernel.org, jgross@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] objtool: Add elf_create_undef_symbol()
Message-ID: <YFMHpdsq1mnZqXak@hirez.programming.kicks-ass.net>
References: <20210312171613.533405394@infradead.org>
 <20210312171653.710872453@infradead.org>
 <alpine.LSU.2.21.2103171444570.23081@pobox.suse.cz>
 <YFIOl/3NcnnV0jDa@hirez.programming.kicks-ass.net>
 <20210318004614.thfvkh3oickkgk4q@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318004614.thfvkh3oickkgk4q@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 07:46:14PM -0500, Josh Poimboeuf wrote:
> On Wed, Mar 17, 2021 at 03:13:43PM +0100, Peter Zijlstra wrote:
> > On Wed, Mar 17, 2021 at 02:52:23PM +0100, Miroslav Benes wrote:
> > 
> > > > +	if (!elf_symbol_add(elf, sym, SHN_XINDEX)) {
> > > > +		WARN("elf_symbol_add");
> > > > +		return NULL;
> > > > +	}
> > > 
> > > SHN_XINDEX means that the extended section index is used. Above you seem 
> > > to use it in the opposite sense too (assigning to shndx when shndx_data is 
> > > NULL). While it makes the code easier to handle, it is a bit confusing 
> > > (and maybe I am just confused now). Could you add a comment about that, 
> > > please? elf_symbol_add() seems like a good place.
> > 
> > Yes, that was a horrible thing to do :/ And you understood it right.
> > 
> > Looking at it again, I'm not sure it is actually correct tho; shouldn't
> > elf_create_undef_symbol() also look at gelf_getsymshndx() of symtab ?
> > 
> > What toolchain generates these extended sections and how? That is, how
> > do I test this crud..
> 
> SHN_XINDEX is basically a special-case extension to original ELF for
> supporting more than 64k sections.

Yeah, I figured it all out again last night; the patch as presented is
hideous but correct(ish). But I've rewritten it and it's all much better
now. Will post later.
