Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95F9359F84
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 15:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhDINGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 09:06:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:48023 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhDINGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:06:38 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 139D3gVC014409;
        Fri, 9 Apr 2021 08:03:42 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 139D3gug014404;
        Fri, 9 Apr 2021 08:03:42 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 9 Apr 2021 08:03:42 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-toolchains@vger.kernel.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org
Subject: Re: static_branch/jump_label vs branch merging
Message-ID: <20210409130342.GF26583@gate.crashing.org>
References: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG80wg/2iZjXfCDJ@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 06:52:18PM +0200, Peter Zijlstra wrote:
> Is there *any* way in which we can have the compiler recognise that the
> asm_goto only depends on its arguments and have it merge the branches
> itself?
> 
> I do realize that asm-goto being volatile this is a fairly huge ask, but
> I figured I should at least raise the issue, if only to raise awareness.

"volatile" should not be an impediment to this at all, volatile means
there is an unspecified side effect, nothing more, nothing less.  But
yes this currently does not work with GCC:

void f(int x)
{       if (x)
                asm volatile("ojee %0" :: "r"(x));
        else
                asm volatile("ojee %0" :: "r"(x));
}

or even

static inline void h(int x)
{
        asm volatile("ojee %0" :: "r"(x));
}

void f1(int x)
{       if (x)
                h(x);
        else
                h(x);
}

which both emit silly machine code.


Segher
