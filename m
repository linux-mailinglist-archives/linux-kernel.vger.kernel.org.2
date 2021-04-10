Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9354E35AF31
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 19:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhDJRGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 13:06:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:58088 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234680AbhDJRGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 13:06:30 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13AH2bxh009969;
        Sat, 10 Apr 2021 12:02:37 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 13AH2ara009963;
        Sat, 10 Apr 2021 12:02:36 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 10 Apr 2021 12:02:36 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Florian Weimer <fweimer@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        dmalcolm@redhat.com
Subject: Re: static_branch/jump_label vs branch merging
Message-ID: <20210410170236.GJ26583@gate.crashing.org>
References: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net> <CAMj1kXGngxH0VCHyREKeLau=159sRkWYKVZwOV84r6dvCqXcig@mail.gmail.com> <877dlbzq09.fsf@oldenburg.str.redhat.com> <YHA3iGyT5dMq7/06@hirez.programming.kicks-ass.net> <CAKwvOdnBXyR6gPgQjaXbHF8Ozx9Kk=OKgPv8_P7=jvvsWRVHEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnBXyR6gPgQjaXbHF8Ozx9Kk=OKgPv8_P7=jvvsWRVHEg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 12:33:29PM -0700, Nick Desaulniers wrote:
> Since asm goto is implicitly volatile qualified, it sounds like
> removing the implicit volatile qualifier from asm goto might help?
> Then if there were side effects but you forgot to inform the compiler
> that there were via an explicit volatile qualifier, and it performed
> the suggested merge, oh well.

"asm goto" without outputs is always volatile, just like any other asm
without outputs (if it wasn't, the compiler would always delete every
asm without outputs!)


Segher
