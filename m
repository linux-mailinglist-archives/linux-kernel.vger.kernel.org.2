Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9A342F391
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbhJONeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239701AbhJONeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:34:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B960C0613E5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 06:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A3Up0VPs/5Twg8BDqyqalxunMtDtIl31N/p4QDrkgRc=; b=Y88qmj9Nz8ZnVnHvOJtPjWYAE5
        TMqFCrBOIOI5clonk6mHn+e3a8PjFfvO+yw27DowO9h7Sj4TFPH0MczhQzfdArS0vEzkGuGrAjjvQ
        YtpkrV6Pc0iD7A51I4Nxncn1O4VsG5uBbz9xPq4lNqNwWx8KXizIDsZP0001TC4WLFBpxyOBNpCH0
        +9Ssz5olFE8vtpOvHLiiIvmP2z4KUhkBHcKBUYPp+8mDz7SjEbzjT1CcpzCz0iWqdJz6pIoRGaamP
        DDVjs8uYcMYXD0spPvGOYYNFGW1QjKcP18qHbPaMBprTvskimBY+WNhvLIQeJGCO+ro/B8iPz5O9x
        SNbmX+rg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbNEx-0092Qw-JF; Fri, 15 Oct 2021 13:27:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8CFDB3004E7;
        Fri, 15 Oct 2021 15:27:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77E3021BE7655; Fri, 15 Oct 2021 15:27:15 +0200 (CEST)
Date:   Fri, 15 Oct 2021 15:27:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, acme@kernel.org, mingo@redhat.com,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH] perf/core: allow ftrace for functions in
 kernel/event/core.c
Message-ID: <YWmBs5fLO3F151cY@hirez.programming.kicks-ass.net>
References: <20211006210732.2826289-1-songliubraving@fb.com>
 <YWWCrYM1I1MtmCkY@hirez.programming.kicks-ass.net>
 <20211013124731.1a8a48ac@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013124731.1a8a48ac@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 12:47:31PM -0400, Steven Rostedt wrote:
> On Tue, 12 Oct 2021 14:42:21 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Oct 06, 2021 at 02:07:32PM -0700, Song Liu wrote:
> > > It is useful to trace functions in kernel/event/core.c. Allow ftrace for
> > > them by removing $(CC_FLAGS_FTRACE) from Makefile.
> > > 
> > > ---
> > > We had some discussions about this last year [1]. Seems that enabling
> > > ftrace in kernel/events won't really cause fatal recursion in the tests.
> > > Shall we give it another try?  
> > 
> > I suppose we can give it a go..
> 
> Did you want me to pull this into my tree? My tests usually stress perf
> along with ftrace.

Hurmph, I just pushed it out, but sure, throw it in.
