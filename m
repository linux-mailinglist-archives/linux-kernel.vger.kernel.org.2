Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D7A3A8B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhFOVeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFOVeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:34:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7687C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:32:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623792735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cRCLZ+ASV1LhD0HIdD+zuLHJeLCBmnyjypiNSx38540=;
        b=c572isNHPCMvxGC2WvAPXs9aNQ9Qq5mRBQG0kbzRKaTgNHPYuZo00ecwmTanow7AGAs/9a
        xrFR01E0mpYh2OD4d2IAxXqDfsgPEL6VjJzDG/X87l0jyOSpzR6JqFqCH8GNl72bsEecA/
        D3MYTj8U+9L0YEgJxnE0v3xD+FMQUJWFhDFRCVWieCI6lxAphbP5GpK786cdsnAztjMD69
        uEc5eK2bLF9bH1Q1b4lqJZLNcX2D778xVAz4Ik+FLY4pMVF7wFaZpFkK+HOi9Pf+mQhyO/
        TWCQ37S5L8GF8bUbP3us1Udm5hx13j6NSAcSJXdICdLCYmRZZxhxZSDsRewfnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623792735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cRCLZ+ASV1LhD0HIdD+zuLHJeLCBmnyjypiNSx38540=;
        b=WPOnp4HMoNfDAl+V8Jnlx1NfSohoHLEltWTd7EsJZ2nRkkm3oo1oFZS6kf5l4proA3aEVX
        rtFQAqVEXChMd1AQ==
To:     Borislav Petkov <bp@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V2 08/52] x86/fpu: Sanitize xstateregs_set()
In-Reply-To: <YMjmHcW1HPbHfkMF@zn.tnic>
References: <20210614154408.673478623@linutronix.de> <20210614155354.534061373@linutronix.de> <YMjmHcW1HPbHfkMF@zn.tnic>
Date:   Tue, 15 Jun 2021 23:32:14 +0200
Message-ID: <87bl86hl0h.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15 2021 at 19:40, Borislav Petkov wrote:
> On Mon, Jun 14, 2021 at 05:44:16PM +0200, Thomas Gleixner wrote:
>> @@ -108,10 +110,10 @@ int xstateregs_set(struct task_struct *t
>>  		  const void *kbuf, const void __user *ubuf)
>>  {
>>  	struct fpu *fpu = &target->thread.fpu;
>> -	struct xregs_state *xsave;
>> +	struct xregs_state *tmpbuf = NULL;
>>  	int ret;
>>  
>> -	if (!boot_cpu_has(X86_FEATURE_XSAVE))
>> +	if (!static_cpu_has(X86_FEATURE_XSAVE))
>
> cpu_feature_enabled() - we're going to use only that thing from now on
> for simplicity.

Sure, I just run sed over the set.

>> +	fpu__prepare_write(fpu);
>
> Yikes, why isn't this function called
>
> fpu_invalidate_state(fpu)

Because...

>> +	/* mxcsr reserved bits must be masked to zero for historical reasons. */
>
> Wasn't that comment supposed to get some love?

See the next patch ...
