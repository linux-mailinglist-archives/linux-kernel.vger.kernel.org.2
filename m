Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851873240D5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbhBXP3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhBXOxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:53:40 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630B0C061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=64cQywZ1MpmZpOKuyYCXIuKG27+NxSFMl6KgGWIRMBk=; b=kN3RfplYFi8OjSXadb7gIWOj4q
        VYm7xlUFB55IdNkLf63s5p3LT7mYZmwnxy/7996elunamGZJkISOrJqbccr40/qT4aals7HTxqgpq
        wxUzVQS5bUtDvLXpcql6PoPvRx/sw7/HNVwNh2HDYbDEX6whMNWeRUyJjqmermVFPT8DNC2SabdJU
        blmo7C1L7w2y6L8YntKy4TiN1hGPNTHqdZ8dYkFti9H/Ku+ir3hnfJN46SIH6WaSK1m3uI1efocRz
        dp41z1Kro6DtGvt3UAzQfRbuG3Pd0xv3bAg7gHK/r5sZmajtX1M8caq+TSEC+sTXXA1TvKtdNVXUJ
        h6SKPy2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lEvWH-0005cc-1Z; Wed, 24 Feb 2021 14:52:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68BE030799A;
        Wed, 24 Feb 2021 15:52:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 548BA206D9577; Wed, 24 Feb 2021 15:52:01 +0100 (CET)
Date:   Wed, 24 Feb 2021 15:52:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ivan Babrou <ivan@cloudflare.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] x86/unwind/orc: Silence warnings caused by missing
 ORC data
Message-ID: <YDZoEehURLLI/lWq@hirez.programming.kicks-ass.net>
References: <cover.1612534649.git.jpoimboe@redhat.com>
 <06d02c4bbb220bd31668db579278b0352538efbb.1612534649.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06d02c4bbb220bd31668db579278b0352538efbb.1612534649.git.jpoimboe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 08:24:03AM -0600, Josh Poimboeuf wrote:
> The ORC unwinder attempts to fall back to frame pointers when ORC data
> is missing for a given instruction.  It sets state->error, but then
> tries to keep going as a best-effort type of thing.  That may result in
> further warnings if the unwinder gets lost.
> 
> Until we have some way to register generated code with the unwinder,
> missing ORC will be expected, and occasionally going off the rails will
> also be expected.  So don't warn about it.

I recently ran into another variant of missing ORC data, some files are
simply not processed by objtool, eg. arch/x86/realmode/init.c. Would it
make sense to have the vmlinux pass (when it isn't used to generate orc
in the first place) also check that all code it finds has ORC data?

It's not fool proof, but it should help find files we're missing for
some raisin.
