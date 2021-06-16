Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9C13A9425
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhFPHhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhFPHhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:37:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D9FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tBkdyBvssbB26l8OwNvWpFnMG7gfD6M7+NbkQD+lW/0=; b=j7HcOUOWaM7jy1+syfaU8rzcPO
        FXmfQe8ZR8ALTJN/RdEBWi6Jwl7vo9HsOwTN4k3SpOYDIbtPpDejXQsVQWQNUaUSzMLJxROZ1wteA
        6sggWbqz9tH730Wu7lvQFS7zXBw/2ZJT9CTra1Jvab5zh2K0EDuaOVLfIBfLzd8tLs7iw+gT+6c+r
        qDNWDnanmkiFSM9GfzGHPmFIXQa+KTnwSgaQUxULjpIuDsDnVXeESeMlVIZiIMi3uPsSzV6J1ScKf
        KaWhmOG6KkpLXW6hK1V2FwoY7WtohLs2DeJvatMrSl8d9hZKC8pBdxzEA1BSbf77ViwcLszMC6e4y
        rewIhSdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltQ58-008GOH-EB; Wed, 16 Jun 2021 07:35:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9DF433001E3;
        Wed, 16 Jun 2021 09:35:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 867C020277F84; Wed, 16 Jun 2021 09:35:32 +0200 (CEST)
Date:   Wed, 16 Jun 2021 09:35:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 4/8] membarrier: Make the post-switch-mm barrier explicit
Message-ID: <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623816595.myt8wbkcar.astroid@bobo.none>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 02:19:49PM +1000, Nicholas Piggin wrote:
> Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:
> > membarrier() needs a barrier after any CPU changes mm.  There is currently
> > a comment explaining why this barrier probably exists in all cases.  This
> > is very fragile -- any change to the relevant parts of the scheduler
> > might get rid of these barriers, and it's not really clear to me that
> > the barrier actually exists in all necessary cases.
> 
> The comments and barriers in the mmdrop() hunks? I don't see what is 
> fragile or maybe-buggy about this. The barrier definitely exists.
> 
> And any change can change anything, that doesn't make it fragile. My
> lazy tlb refcounting change avoids the mmdrop in some cases, but it
> replaces it with smp_mb for example.

I'm with Nick again, on this. You're adding extra barriers for no
discernible reason, that's not generally encouraged, seeing how extra
barriers is extra slow.

Both mmdrop() itself, as well as the callsite have comments saying how
membarrier relies on the implied barrier, what's fragile about that?
