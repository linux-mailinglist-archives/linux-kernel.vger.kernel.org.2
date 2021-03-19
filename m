Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B5E3418DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCSJyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCSJyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:54:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2073C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MhH4rpsGM2XA7X36wvRsyFt97Iw1VT2IBFvdHtXi3/w=; b=bVrABq2uBJQ045h6fn9h5oUJLm
        xRa7jEmIfsRpmzubed4FulN4BYFdDnFtLd3orEFXSS4kNxkJHhdzg85asEGUcyIRyJs/aVEwF7RVQ
        THEgS9OkZyFXz5OReknLS//T4EJgrxraM27TfHW38NQPAsK0dANzjEZqc6zAIGV+mv/8MVCj5axSr
        LO8mwF4K0O0XgrnTxPmrj3vRqkXESUpxiGPj4fw8jm2l1FEQMkAF3Ny5ZtXcLnIG4yXhBF9R9RaC1
        xC/nMOIpmTHB2MEnru0C7fit5Bo/wRW4+kklTKpkd5b0C+EjY2/SgkKBJzNfaW5k+H+0fUhe+54lP
        0q5XjfmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNBpV-006zGJ-Ki; Fri, 19 Mar 2021 09:54:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EE183003E1;
        Fri, 19 Mar 2021 10:54:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 37B552B4C3BE3; Fri, 19 Mar 2021 10:54:05 +0100 (CET)
Date:   Fri, 19 Mar 2021 10:54:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/14] objtool: Extract elf_symbol_add()
Message-ID: <YFR0vesRq5DDFCSE@hirez.programming.kicks-ass.net>
References: <20210318171103.577093939@infradead.org>
 <20210318171920.007925810@infradead.org>
 <20210319021403.idfcvrzuj3ywbxhx@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319021403.idfcvrzuj3ywbxhx@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 09:14:03PM -0500, Josh Poimboeuf wrote:
> On Thu, Mar 18, 2021 at 06:11:13PM +0100, Peter Zijlstra wrote:
> > Create a common helper to add symbols.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  tools/objtool/elf.c |   57 ++++++++++++++++++++++++++++++----------------------
> >  1 file changed, 33 insertions(+), 24 deletions(-)
> > 
> > --- a/tools/objtool/elf.c
> > +++ b/tools/objtool/elf.c
> > @@ -290,12 +290,41 @@ static int read_sections(struct elf *elf
> >  	return 0;
> >  }
> >  
> > +static bool elf_symbol_add(struct elf *elf, struct symbol *sym)
> 
> How about "elf_add_symbol()" for consistency with my other suggestions
> (elf_add_reloc() and elf_add_string()).  And return an int.

Changed the nane, how about void? This latest incarnation doesn't
actually have an error path. Still doesn't hurt to have one and not use
it I suppose...
