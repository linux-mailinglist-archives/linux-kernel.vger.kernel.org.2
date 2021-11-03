Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4C443E4B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhKCIYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhKCIYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:24:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933CFC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 01:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8huLmD98SSL+mzJ3Jm1lG9FgiQpVwJXnN0kffx8m9Zc=; b=ejv5Lm027thQy32eIITKEnby8p
        UqZZ85rHOSGSW9ivQzOncgNh33mvw3J9khqB5XoVctP6MvF0qfI96C1yHartbZtMXYhc6CXUj84GC
        ymIcRDHREX3UKQDpUbhBVyFuusHtN4VyabX06n0ufOVfV4Dz0e/+RvF+Vtpwa1Szu7m5FQRScHRfr
        MyzgrC8GYwAx+nEBD8cvqq7i5Z8lbU86vJWLs1la/s8KpUs1paC2VbCSmAt/Yw7a+Vv3b9mTbuVYi
        3AKoUM4GG6ZB+uql8XT02HEkL3h3tKu9g3dTCE0qpTeAqZml6MrvS697yHnwKhuGgBvVB5ZB9Kcgr
        cIPyzgFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miBUe-0054WQ-4b; Wed, 03 Nov 2021 08:19:54 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 61F2D986378; Wed,  3 Nov 2021 09:19:35 +0100 (CET)
Date:   Wed, 3 Nov 2021 09:19:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Stackleak vs noinstr (Was: [GIT pull] objtool/core for v5.16-rc1)
Message-ID: <20211103081935.GA174703@worktop.programming.kicks-ass.net>
References: <163572864256.3357115.931779940195622047.tglx@xen13>
 <163572864563.3357115.8793939214537874196.tglx@xen13>
 <CAHk-=wgNzL3AaVNruwLv=kcGXi1EbJN9CZC6GoRY66t6WFcfGg@mail.gmail.com>
 <YYDwJORywW2FjprP@hirez.programming.kicks-ass.net>
 <YYD/bpLabfumrvL+@hirez.programming.kicks-ass.net>
 <YYENAKB0igNFnFmK@hirez.programming.kicks-ass.net>
 <A4522E50-B426-4588-A1F8-B27DB579C100@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A4522E50-B426-4588-A1F8-B27DB579C100@linux.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 10:18:22AM +0300, Alexander Popov wrote:
> Yes, this is a correct approach.
> 
> But I'm not sure about removing NOKPROBE_SYMBOL and notrace for
> stackleak_erase. Does the code in noinstr.text disable all those?

Yes, noinstr implies all those and more. Both kprobe and tracing are a
form of instrumentation, and hence noinstr must disallow it.
