Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BAC334060
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhCJOac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbhCJOaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:30:08 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34ACC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rm9J/C574jgcTKjLZ+JZ8HyxabeU1qnnBxPkGVf3hGM=; b=k9aVCB55HjbnU7LECB108qMPvm
        xaIMU9rwGHkWM7NsiZqmBpyiuCKin6FTcLShn2XzwwR/w24sDVoHX5stxr9wG/k/nFuzj3gIUEcFw
        mu7qeJtU+AxUrg3r4kHexuPT1bTWWlyejKLLn2ByMiF2mYrswBZ51gBI3Cp9jQJ9PH+FnIEcrZvUn
        QKId6UA1s19mD4MKQnPfgwH+y7/B8VnVLLWshGeEjiB+Vx/fQAoX7ogHS+t4ZAl/vCWjM+IDIQ/Vj
        Qpp/MtkRw5xmlmimBKOj4gTvPKmwNWGff3iJR6VVJnH7oAL3ZSVy1jqpOddTGlPHe4+uwp0bsc4KQ
        ipXT3zlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJzqe-00722F-0P; Wed, 10 Mar 2021 14:30:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C7483011F0;
        Wed, 10 Mar 2021 15:30:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1CE012366366B; Wed, 10 Mar 2021 15:30:03 +0100 (CET)
Date:   Wed, 10 Mar 2021 15:30:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: The killing of ideal_nops[]
Message-ID: <YEjX609saW5oX0te@hirez.programming.kicks-ass.net>
References: <YEepKVHc5kkDybu6@hirez.programming.kicks-ass.net>
 <20210309120519.7c6bbb97@gandalf.local.home>
 <YEfnnFUbizbJUQig@hirez.programming.kicks-ass.net>
 <362BD2A4-016D-4F6B-8974-92C84DC0DDB4@zytor.com>
 <YEiN+/Zp4uE/ISWD@hirez.programming.kicks-ass.net>
 <YEiS8Xws0tTFmMJp@hirez.programming.kicks-ass.net>
 <YEiZXtB74cnsLTx/@hirez.programming.kicks-ass.net>
 <YEid+HQnqgnt3iyY@hirez.programming.kicks-ass.net>
 <20210310091324.0c346d5f@oasis.local.home>
 <YEjWryS/9uB2y62O@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEjWryS/9uB2y62O@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 03:24:47PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 10, 2021 at 09:13:24AM -0500, Steven Rostedt wrote:
> > On Wed, 10 Mar 2021 11:22:48 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > After this FEATURE_NOPL is unused except for required-features for
> > > x86_64. FEATURE_K8 is only used for PTI and FEATURE_K7 is unused.
> > > 
> > > AFAICT this negatively affects lots of 32bit (DONTCARE) and 32bit on
> > > 64bit CPUs (CARELESS) and early AMD (K8) which is from 2003 and almost
> > > 2 decades old by now (SHRUG).
> > > 
> > > Everything x86_64 since AMD K10 (2007) was using p6_nops.
> > > 
> > > And per FEATURE_NOPL being required for x86_64, all those CPUs can use
> > > p6_nops. So stop caring about NOPs, simplify things and get on with life
> > > :-)
> > 
> > Before ripping out all the ideal_nop logic, I wonder if we should just
> > force the nops you want now (that is, don't change the selected
> > ideal_nops, just "pretend" that the CPU wants p6_nops), and see if anyone
> > complains. After a few releases, if there's no complaints, then we can
> > rip out the ideal_nop logic.
> 
> Nah, just rip the entire thing out. You should be happy about
> deterministic NOPs :-)
> 
> NOP encoding is not something CPUs should differentiate on, that's just
> bollocks.

Also, you seem to have fallen off of IRC. Anyway, weren't you the one
that was complaining x86 was 'special' for having different NOPs the
other day?

Fixed it ;-)
