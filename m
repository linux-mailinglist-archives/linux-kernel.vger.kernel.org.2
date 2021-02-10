Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E67316C02
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhBJRC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbhBJRCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:02:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402BCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 09:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aUh0dYLcs0EmmNljHRiNDUD7+xy/uR4TKWhhdzvoI4Y=; b=ncD6hRh69zMf7I+/WfTq42FLV5
        Bpy3g4+Ri6k6uQ8XVMoLg+YpNnd0oo5NZ4qsA2v5q3/+yIRJKzMr07sfmrzNfAUPsk8gpD0fMDQk7
        hSC2wFZlSJJ1bp1ghJl5sI78dISR6hu3qOuzDU0Kh8pd+q1h/o58AQj/FU76Y5Y3rPedBSfWKcyNe
        zaDvrNhyRUfDYQFaRZByt+OIfb/KJyvwGnV6D/QrjOHdbpFukhbFdEzh0n+ylUdDEW7KEeCRJ0uSc
        +jEt1gYJT3kUS7OQsLgqaj2F0oa/luXfTm/AuLrGleewtpqT2sc0gQXHKsN/CpqH7/cBKJs2mzBPQ
        GNZzEVJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l9srV-0097sr-Rz; Wed, 10 Feb 2021 17:01:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66D1D301EFB;
        Wed, 10 Feb 2021 18:01:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58371207C4A13; Wed, 10 Feb 2021 18:01:07 +0100 (CET)
Date:   Wed, 10 Feb 2021 18:01:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        yu-cheng.yu@intel.com
Subject: Re: [RFC][PATCH] objtool: WARN about ENDBR instructions
Message-ID: <YCQRU+b6b6iGGsev@hirez.programming.kicks-ass.net>
References: <YCOb2byLJhLOjhrL@hirez.programming.kicks-ass.net>
 <20210210160945.73n5zhlfcii5t637@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210160945.73n5zhlfcii5t637@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 10:09:45AM -0600, Josh Poimboeuf wrote:
> On Wed, Feb 10, 2021 at 09:39:53AM +0100, Peter Zijlstra wrote:
> > 
> > 
> > Given all the ENDBR fun we recently had, do we want the below? Until
> > someone comes and fixes up kprobes/ftrace/livepatch etc.. having them is
> > a giant pain and we'd better warn about it.
> 
> Meh...
> 
> Is there a point in doing this, now that we killed it with
> -fcf-protection=none?
> 
> That said, the patch is nicely small and localized.

Yeah, paranoia, just making absolutely sure it doesn't sneak back in
unexpected.
