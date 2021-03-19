Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B9C3417F5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCSJHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhCSJHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:07:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CCAC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ls3qn0Z6984EPsNNdxwUq+UFIVqMWzafH9aA8jGxC/M=; b=lIg96ElzUeCq3Ue/9BlQZYMAHR
        Z+5NQnAYm1pOiS5MtsqnTQrC6qXMjWag/A9UkZEaeCg+ocKKrTk3orgD4aUtABfo7Xp00Ug0yx8GC
        /dN5D3VJz57sjT2MSVn+uweqqDdAw9l3QvpkDeiAiGQz7l4t+4VaMMn9vlkSigA4tJzY9UWmBogZV
        NgsBN+BALoHMYw/YFzCHrbR4uiBcfXHG+2pf0wcPO0JTeK1fr8To8vobFftp9UsNP3QbVXYTfASfI
        frmdAvz9iSRzdwY8umGw/eQw2anKYBf8etdpPrKXStlkP5nwLrht4/5a9Ov/faY5qiy3N8q7/59qD
        3igMivQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNB6O-006vmS-Ol; Fri, 19 Mar 2021 09:07:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA7423006E0;
        Fri, 19 Mar 2021 10:07:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6D3C213C0F22; Fri, 19 Mar 2021 10:07:27 +0100 (CET)
Date:   Fri, 19 Mar 2021 10:07:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/14] objtool: Per arch retpoline naming
Message-ID: <YFRpz5Ci+jWEWOZl@hirez.programming.kicks-ass.net>
References: <20210318171103.577093939@infradead.org>
 <20210318171919.703716384@infradead.org>
 <20210319023814.ovisg53uc5zy7gwn@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319023814.ovisg53uc5zy7gwn@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 09:38:14PM -0500, Josh Poimboeuf wrote:
> On Thu, Mar 18, 2021 at 06:11:08PM +0100, Peter Zijlstra wrote:
> > @@ -872,7 +877,7 @@ static int add_jump_destinations(struct
> >  		} else if (reloc->sym->type == STT_SECTION) {
> >  			dest_sec = reloc->sym->sec;
> >  			dest_off = arch_dest_reloc_offset(reloc->addend);
> > -		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21)) {
> > +		} else if (arch_is_retpoline(reloc->sym)) {
> >  			/*
> >  			 * Retpoline jumps are really dynamic jumps in
> >  			 * disguise, so convert them accordingly.
> 
> There's another one in add_call_destinations().

Bah, I'm sure I converted all of them at some point, must've lost a hunk
somewhere along the way. Fixed!
