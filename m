Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5B530DEFF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbhBCQAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:00:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:46410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233434AbhBCPys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:54:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82534ADE5;
        Wed,  3 Feb 2021 15:54:06 +0000 (UTC)
Date:   Wed, 3 Feb 2021 16:54:08 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        luto@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        len.brown@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/fpu: Use consistent test for X86_FEATURE_XSAVES
Message-ID: <20210203155408.GC11823@zn.tnic>
References: <20210203024052.15789-1-chang.seok.bae@intel.com>
 <20210203112340.GA11823@zn.tnic>
 <87e436d0-d2ca-8c28-442b-1b45111b6081@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87e436d0-d2ca-8c28-442b-1b45111b6081@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 07:40:07AM -0800, Dave Hansen wrote:
> On 2/3/21 3:23 AM, Borislav Petkov wrote:
> >> -/*
> >> - * 'XSAVES' implies two different things:
> >> - * 1. saving of supervisor/system state
> >> - * 2. using the compacted format
> >> - *
> >> - * Use this function when dealing with the compacted format so
> >> - * that it is obvious which aspect of 'XSAVES' is being handled
> >> - * by the calling code.
> > @dhansen, are you still hung up on that "obvious aspect" or can we kill
> > this?
> 
> I still want the compacted-format handling code to be marked.  You can
> do that with new comments:
> 
> 	/* Note: XSAVES always uses compacted format: */
> 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
> 
> or, leave it as-is:
> 
> 	if (using_compacted_format()) {
> 	...
> 
> Otherwise, we assume that every human being that looks at this code
> *KNOWS* that XSAVES==compacted.  That's not a great assumption.

Well, the reason why I reacted to this is because I was looking at
using_compacted_format() - aha this, checks X86_FEATURE_XSAVES - but
then other code paths in fpu/ check X86_FEATURE_XSAVES directly. And
this is confusing, making me wonder why is that special oneliner there.
Sure, the comment above it says why...

I guess if you wanna keep it, then we need another oneliner for 1. or
really do comments at each call site.

Hmm.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
