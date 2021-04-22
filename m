Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066D636859A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbhDVRLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:11:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:52091 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238182AbhDVRLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:11:40 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13MH8Ke3021449;
        Thu, 22 Apr 2021 12:08:21 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 13MH8Kx7021448;
        Thu, 22 Apr 2021 12:08:20 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 22 Apr 2021 12:08:20 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Malcolm <dmalcolm@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        yuanzhaoxiong@baidu.com
Subject: Re: static_branch/jump_label vs branch merging
Message-ID: <20210422170820.GB27473@gate.crashing.org>
References: <YHBCoijoopbsDn29@hirez.programming.kicks-ass.net> <YHBQPr8q0cx4iUfN@hirez.programming.kicks-ass.net> <YHBS70ZQ6gOpMk2K@hirez.programming.kicks-ass.net> <3c062f70ffef2dcd48a661f7c8162fb8fbaf6869.camel@redhat.com> <YHCfgHwDtT7m4ffq@hirez.programming.kicks-ass.net> <0a9da587b0330bafdf612c3d51285e144b0b9e46.camel@redhat.com> <YHC0dgwhYS9hKcRT@hirez.programming.kicks-ass.net> <5a07bde1a9fa9a056a19637399b0635252ddb303.camel@redhat.com> <20210409213949.GA33256@worktop.programming.kicks-ass.net> <YIFilwwzWiSDZU6b@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIFilwwzWiSDZU6b@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 01:48:39PM +0200, Peter Zijlstra wrote:
> Can we please have a __pure__ attribute that is prescriptive and not a
> hint the compiler is free to ignore for $raisins ?

What does that mean?  What actual semantics do you want it to have?

The "pure" attribute means the compiler can assume this function does
not have side effects.  But in general (and in practice in many cases)
there is no way the compiler can actually check that, if that is what
you were asking for.

And any such checking will depend on optimisation level and related
flags, making that a no-go anyway.


Segher
