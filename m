Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CD5324390
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhBXSJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhBXSIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:08:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A43EC061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4CyVpXvHlAs585xhnG2kQ9VRjy+LgRed1HZFwtvjpaA=; b=TcI4at6ji4D4Egi/JfZlkxoZGX
        huLiPT2ZsxLgBrG+iPNw9WGU0y+Y+v/M7KQBC7dh1HJL5OCDv/HHlVmc2VzF7fuNvMMYDhoJQIpdK
        YGawluwyzyj40o+a0WdkSiPZDe1T2TSjuz2GUhVlPBHS7RTdKFMnB/yraJDMZnyHiYLfUJ/jCrfJk
        2DTaoMT+UodsoJtkdp9W3nkMyGpDhvWLhjZDUawyQUqb5WHnwgkZZI9ZAMtBaDD10GaXFR9cnqhgQ
        5wcaC/2wCzmOQdn05Q1Z1oPzDU9lPs1lTXSsj13XsbTK0zH5cgLKKwEDDGJCXT+TuaLfnphWQlSzv
        pvfS4ZKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lEyZQ-009iL3-CD; Wed, 24 Feb 2021 18:07:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2DEF30504E;
        Wed, 24 Feb 2021 19:07:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A872B20D0BF1F; Wed, 24 Feb 2021 19:07:31 +0100 (CET)
Date:   Wed, 24 Feb 2021 19:07:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ivan Babrou <ivan@cloudflare.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] x86/unwind/orc: Silence warnings caused by missing
 ORC data
Message-ID: <YDaV47Cw8AEzsnkg@hirez.programming.kicks-ass.net>
References: <cover.1612534649.git.jpoimboe@redhat.com>
 <06d02c4bbb220bd31668db579278b0352538efbb.1612534649.git.jpoimboe@redhat.com>
 <YDZoEehURLLI/lWq@hirez.programming.kicks-ass.net>
 <20210224151805.zrujocamlb5pxf7m@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224151805.zrujocamlb5pxf7m@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 09:18:05AM -0600, Josh Poimboeuf wrote:
> On Wed, Feb 24, 2021 at 03:52:01PM +0100, Peter Zijlstra wrote:
> > On Fri, Feb 05, 2021 at 08:24:03AM -0600, Josh Poimboeuf wrote:
> > > The ORC unwinder attempts to fall back to frame pointers when ORC data
> > > is missing for a given instruction.  It sets state->error, but then
> > > tries to keep going as a best-effort type of thing.  That may result in
> > > further warnings if the unwinder gets lost.
> > > 
> > > Until we have some way to register generated code with the unwinder,
> > > missing ORC will be expected, and occasionally going off the rails will
> > > also be expected.  So don't warn about it.
> > 
> > I recently ran into another variant of missing ORC data, some files are
> > simply not processed by objtool, eg. arch/x86/realmode/init.c. Would it
> > make sense to have the vmlinux pass (when it isn't used to generate orc
> > in the first place) also check that all code it finds has ORC data?
> > 
> > It's not fool proof, but it should help find files we're missing for
> > some raisin.
> 
> Doesn't validate_reachable_instructions() basically already do that?

Nope, I'm talking about the case where we generate ORC for each .o file
(and 'forget' to run objtool on some of them). And then run objtool
again on vmlinux to validate (things like noinstr).

At that point it might make sense to also check that all code does
indeed have an ORC to double check our initial (per translation unit)
invocation didn't accidentally miss someone.
