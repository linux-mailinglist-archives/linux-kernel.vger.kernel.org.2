Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B1131F032
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhBRTnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhBRTIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:08:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1ABC061756
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 11:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FaA9xC+xqsyYC5zJ3D9y4d2If5YE+KoR85oRIJVxsLc=; b=F51AI2FsxLhPAB219k4Kt363M1
        L3KYbrkIbY8csewcAoFsYwrfyCrgMHzMsoX9PB5UrNHoUGL6s+NQKC19GgGHlIclqNXSRhEQQAzA6
        MEz1GVm7kKkmC+7tuo5sFj5VpBpx2eO0U3P94cZAenkqDw5fup6pNQQMk2IbqweKqJV+LdjDmVApu
        kPBBitWkqZa6CTXoRNsf8Wbt9JCS0oKX2B0GC3A4S+X0CloiYgl7x4pTNXa0pRWI+c1yHHNB1JUSO
        91OvU5Km4sj7adAVHMFxEI/ucXrYoFz95rOAyfpyRx23WDjrPEQg027EChCIRc/F70XqN9Ayhr/pq
        U7tKdFmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lCoZL-001zdX-UC; Thu, 18 Feb 2021 19:02:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2CF0A9864D6; Thu, 18 Feb 2021 20:02:31 +0100 (CET)
Date:   Thu, 18 Feb 2021 20:02:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, tony.luck@intel.com, pjt@google.com,
        linux-kernel@vger.kernel.org, r.marek@assembler.cz,
        jpoimboe@redhat.com, jikos@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [RFC PATCH] x86/retpolines: Prevent speculation after RET
Message-ID: <20210218190231.GA59023@worktop.programming.kicks-ass.net>
References: <20210218165938.213678824@infradead.org>
 <20210218184639.GF4214@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218184639.GF4214@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 07:46:39PM +0100, Borislav Petkov wrote:
> Both vendors speculate after a near RET in some way:
> 
> Intel:
> 
> "Unlike near indirect CALL and near indirect JMP, the processor will not
> speculatively execute the next sequential instruction after a near RET
> unless that instruction is also the target of a jump or is a target in a
> branch predictor."

Right, the way I read that means it's not a problem for us here.

> AMD:
> 
> "Some AMD processors when they first encounter a branch do not stall
> dispatch and use the branches dynamic execution to determine the target.
> Therefore, they will speculatively dispatch the sequential instructions
> after the branch. This happens for near return instructions where it is
> not clear what code may exist sequentially after the return instruction.
> This behavior also occurs with jmp/call instructions with indirect
> targets. Software should place a LFENCE or another dispatch serializing
> instruction after the return or jmp/call indirect instruction to prevent
> this sequential speculation."
> 
> The AMD side doesn't really need the LFENCE because it'll do LFENCE;
> JMP/CALL <target> due to X86_FEATURE_RETPOLINE_AMD, before it reaches
> the RET.

It never reached the RET.

So all in all, I really don't see why we'd need this.

Now, if AMD were to say something like: hey, that retpoline is pretty
awesome, we ought to use that instead of an uconditional LFENCE, then
sure, but as is, I don't think so.
