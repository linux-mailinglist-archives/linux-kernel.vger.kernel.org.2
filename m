Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71863A6E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhFNTJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhFNTJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:09:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2000C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jHMfvfn96Syem9p1AP7b59njyn4/ckJ/ZaF1o8/iL74=; b=DS6M5F0A8qXoVGrL6KIhJZ557i
        qVXd4AjQmSZywsN6TKU6Pe9k3Uq5Zv3yF2azMLfHIiJrj1koXw6xpbdrDuYMINXGEAIy6FvWT58tS
        k5+v6RIy/RFyEcX3YTBWW/+xF3SpI5jlI3tb+CTPntCcHPoBk0HqKEXWFN6HEtU6E/+bFSDibQCem
        meVPH3J0ylY3AybeU3kotAeNWqq6tv72R6mCHhvxxdoZiXUpw33Fnp7SwUviWnMJe0iJ0+WkXBzqF
        gmeRsiZokbxEKql/env3crCnHZwVq/GzhkrXMoYOJpnG8sxDiEhNZzW+sX7INx1tVOsA083SOxJGU
        ICh0Y5ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lsrvJ-005jnj-VU; Mon, 14 Jun 2021 19:07:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 94E4D982D9F; Mon, 14 Jun 2021 21:07:00 +0200 (CEST)
Date:   Mon, 14 Jun 2021 21:07:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fangrui Song <maskray@google.com>
Cc:     ndesaulniers@google.com, x86@kernel.org, oberpar@linux.ibm.com,
        linux-kernel@vger.kernel.org, johannes.berg@intel.com,
        nathan@kernel.org, keescook@chromium.org, elver@google.com,
        mark.rutland@arm.com
Subject: Re: [PATCH] gcov,x86: Mark GCOV broken for x86
Message-ID: <20210614190700.GF68749@worktop.programming.kicks-ass.net>
References: <CAKwvOdmPTi93n2L0_yQkrzLdmpxzrOR7zggSzonyaw2PGshApw@mail.gmail.com>
 <20210614183135.hfuaowojnq4alo44@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614183135.hfuaowojnq4alo44@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 11:31:35AM -0700, Fangrui Song wrote:
> __attribute__((no_instrument_function)) seems specific to
> -finstrument-functions.  Somehow -pg uses it as well. The name may not be
> generic, so it may be odd to exclude various instrumentations (there are a ton)
> under this generic attribute.
> 
> I'd like to understand the definition of notrace and noinstr.

notrace came first; it disallows tracing (fentry/mcount) on specific
functions where tracing is unsafe, like inside the tracer itself.

noinstr is fairly recent, we lifted a whole bunch of code from asm to C
(because it's something that every arch ends up having to do and pretty
much every arch did it wrong, so we're slowly lifting it into arch
neutral code).

We now call into C before the full (kernel) C runtime is properly setup.
Consider it crt0 if you will. But it's sprinkled throughout arch code
and not nicely isolated to a few .c files.

For this we require that noinstr avoids any and all compiler
instrumentation; this really is C as C was intended, portable assembler
style usage (/me runs).

> With value profiling disabled, clang -fprofile-generate/gcc
> -fprofile-arcs don't add function calls. They just increment a counter
> in a writable section.  Why isn't that allowed for noinstr functions?

Because you can get exceptions from memory accesses just fine, which, if
you're inside an exception handler and haven't dealt with recursion
conditions yet, can be fatal.

> I can understand why -fpatchable-function-entry= is excluded:
> -fpatchable-function-entry= causes the section
> __patchable_function_entries and the kernel may change the nops into
> call instructions. And a function call may not be suitable for certain
> functions.  But I don't understand why incrementing a counter should
> be disallowed.

A memory access can generate #PF, #DB, #VE, #VC, #MC from the top of my
head.

Also that's what you do today, GCC emits calls, and those can cause even
more 'fun'.

