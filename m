Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629B13A0483
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbhFHTgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbhFHT1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:27:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF4CC061145
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 12:15:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623179743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xpUTcgt9Db4fGK9KLuaGCNDp2pGb6o/dByUyoxYEx5U=;
        b=BN5IH59vh1e+DPYuw49sUZHDEeTnd/lgi6bnTCKxffoKYfQkk+e74PKwOJnEYfS5beq81i
        U+TJ5xez9btTFBsrx83Y3PyWxU2n/Qb3jL9c1H94lb2uZYAE/YIIJEKmQSA9mAQugnyhz/
        eAPIddcs9K8yqJFe/xL3kvN7AJhg0AD9ae9Z7pVUZ6X/q2ENVVCPQAd7W0sVJw1WgNRR4L
        pr8nJ8OKsG8kWyE/SS/gFcug6fJuqkjuRJngls2TTkCMTRCT2r9019jJpeuRgOReTXrgMJ
        zMyFX4urhYwWQIH2IbXBB6NzdCc9TJzhhC4rYTw5XitMGyxA/PCFeiCeBxvydQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623179743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xpUTcgt9Db4fGK9KLuaGCNDp2pGb6o/dByUyoxYEx5U=;
        b=qL9aq7S4s62MSQ6Cp23mIMKAHT5Qe8+COVCh9KkSAyTyLY0Yksg5JAfUHp+s6JiXO7DbRS
        EFJ1OKT0W4LyFCAQ==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [patch V3 4/6] x86/pkru: Make PKRU=0 actually work
In-Reply-To: <YL+PYz/cZPhSVmf2@zn.tnic>
References: <20210608143617.565868844@linutronix.de> <20210608144346.045616965@linutronix.de> <YL+PYz/cZPhSVmf2@zn.tnic>
Date:   Tue, 08 Jun 2021 21:15:42 +0200
Message-ID: <87tum8xj4x.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08 2021 at 17:40, Borislav Petkov wrote:
> Just typos:
>
> On Tue, Jun 08, 2021 at 04:36:21PM +0200, Thomas Gleixner wrote:
>> So that wreckages any copy_to/from_user() on the way back to user space
>
> wrecks
>
>> which hits memory which is protected by the default PKRU value.
>> 
>> Assumed that this does not fail (pure luck) then T1 goes back to user
>> space and because TIF_NEED_FPU_LOAD is set it ends up in
>> 
>> switch_fpu_return()
>>     __fpregs_load_activate()
>>       if (!fpregs_state_valid()) {
>> 	 load_XSTATE_from_task();
>>       }
>> 
>> But if nothing touched the FPU between T1 scheduling out and in the
> 							       ^^
>
> 							s/in/if/ it
> 							seems.

No. It should be 

But if nothing touched the FPU between T1 scheduling out and back in,
then the fpregs_state is still valid which means switch_fpu_return()
does nothing and just clears TIF_NEED_FPU_LOAD. Back to user space with
DEFAULT_PKRU loaded. -> FAIL #2!

>> +		 * XRSTOR will set PKRU to 0. If the bit is not set then
>> +		 * get_xsave_addr() will return NULL because the PKRU value
>> +		 * in memory is not valid. This means pkru_val has to be
>> +		 * set to 0 and not to init_pkru_value.
>> +		 */
>>  		pk = get_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
>> -		if (pk)
>> -			pkru_val = pk->pkru;
>> +		pkru_val = pk ? pk->pkru : 0;
>>  	}
>
> Hohumm, let's see who cries out... :-\

Why? It was clearly wrong and I can reproduce it with a hack which
forces a schedule to a kernel thread and it fails all the way back to
user space.

I chased that because I observed sporadic failures when forcing PKRU to
init state and then observed the default key being written. I had some
extra trace_printks there to analyze something completely different :)

Thanks,

        tglx
