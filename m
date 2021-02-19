Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E49B32012C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 23:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBSWHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 17:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhBSWHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 17:07:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20CEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 14:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g0Jvmf6LJ034kDLDkJfT+bSPIXgjmaXr0o0s3eOCRhM=; b=RCVbswE43uXOxQNX1MtLJ8xQTA
        MwkwjHxE2f/5OQVocPJPX6ACr108oIgP/H4OIFeDRzLYzuAeKo8z38qKFsTNQ0CYR9dLbrqqXcSlE
        EoYiju2x5JkMneW7OrBjcKe+1iUfB2Zmii4GbM0cplWPFrR0oUbqJfV54v9au+T1mfwh59Vn8hJ8x
        SVBLPRAJCDCYRMJeWoHh6Q2DSwK5ven2cLs0Rrg8FqTwo7ZR7pLC5CqA/iZPEohzKqgBiAxTEyHxr
        IvyMiYjv6uyXrWxH0YkB6tfSM36dGsHaQ+vNWL7YZjFzMBSZDqkhkRpzIztNg0q9A6OY3zfb0yQ4S
        t/u6gvSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lDDqZ-003K80-MB; Fri, 19 Feb 2021 22:03:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD4BD9864D6; Fri, 19 Feb 2021 23:01:58 +0100 (CET)
Date:   Fri, 19 Feb 2021 23:01:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, pjt@google.com, mbenes@suze.cz, jgross@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 6/6] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210219220158.GD59023@worktop.programming.kicks-ass.net>
References: <20210219204300.749932493@infradead.org>
 <20210219210535.492733466@infradead.org>
 <20210219215530.ivzzv3oavhuip6un@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219215530.ivzzv3oavhuip6un@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 03:55:30PM -0600, Josh Poimboeuf wrote:
> On Fri, Feb 19, 2021 at 09:43:06PM +0100, Peter Zijlstra wrote:
> > Arguably it would be simpler to do the other way around, but
> > unfortunately alternatives don't work that way, we cannot say:
> > 
> > 	ALTERNATIVE "call __x86_indirect_thunk_\reg",
> > 		    "call *%reg", ~X86_FEATURE_RETPOLINE
> > 
> > That is, there is no negative form of alternatives.
> 
> X86_FEATURE_NO_RETPOLINE?

We could, but it so happens Joerg is also wanting negative features. So
I was thikning that perhaps we can convince Boris they're not really all
that aweful after all :-)
