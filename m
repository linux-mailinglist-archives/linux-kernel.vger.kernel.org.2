Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B033F9C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245537AbhH0QLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:11:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:57559 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234299AbhH0QLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:11:18 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17RG4ccs010710;
        Fri, 27 Aug 2021 11:04:38 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 17RG4ajV010707;
        Fri, 27 Aug 2021 11:04:36 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 27 Aug 2021 11:04:36 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        Paul Mackerras <paulus@samba.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [RFC PATCH] powerpc: Investigate static_call concept
Message-ID: <20210827160436.GQ1583@gate.crashing.org>
References: <8077899fee81f08a7dffbf185569d3a1f7a2ab68.1630057495.git.christophe.leroy@csgroup.eu> <YSj0R6g6HeboSk9n@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSj0R6g6HeboSk9n@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 04:18:47PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 27, 2021 at 09:45:37AM +0000, Christophe Leroy wrote:
> > This RFC is to validate the concept of static_call on powerpc.
> > 
> > Highly copied from x86.
> > 
> > It replaces ppc_md.get_irq() which is called at every IRQ, by
> > a static call.
> 
> The code looks saner, but does it actually improve performance? I'm
> thinking the double branch also isn't free.

It isn't, but it is very cheap, while the branch-to-count is not, even
*if* it is correctly predicted.

> The paranoid in me would've made it:
> 
> 	BUG_ON(patch_branch(...));
> 
> just to make sure to notice the target not fitting. Ohh, patch_branch()
> doesn't return the create_branch() error, perhaps that wants to be
> fixed?

Should that be allowed to fail ever?  I.e., should a failure be a fatal
error?  Sounds very fragile otherwise.


Segher
