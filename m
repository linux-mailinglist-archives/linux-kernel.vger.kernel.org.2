Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496893AA7C2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 01:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhFPXyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 19:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbhFPXyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 19:54:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63664C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 16:51:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623887510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M5sjxyG9LNZoqCJyD0+P+Ck/Ix6sywjG/9koempPvNQ=;
        b=sEnxqPgRBtCdphDTT30Rwtal5b1ECfjVQbAis8346Q/jep7ISp2y3qT+w3whSmhqO8R9kT
        dnvMEtj/W733iniD61QLqdoDw1OfKghThN+ZGXU0KzXeJJweNM5vohjHAIRyaBO1Nhh149
        ICbS1EyR9m0xpcdspkmSJePN4tMtpxcIrKQ2Sf1GMY43zWD2ixP+GLaMChVS1IpLqhbzUl
        V7lvVplVQF+NQBDNgGFOLBDPAkbHfHFrS4zFuDyX0Rs7MCkC7EhEeVSaAl0zsRwl0UNZq+
        WP556TaiHlKGEm2hBnlb5x97rICsfn1DbVvPyXRGw20SBA6F7mCstB3GAZjrdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623887510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M5sjxyG9LNZoqCJyD0+P+Ck/Ix6sywjG/9koempPvNQ=;
        b=zQMpDJh2HRzrDDAJJ4HA4LY8JR/AyfLJneSc10blylrfq+WoofHdQZe3PdlLDjoSdAxQMD
        UPZVVEOSCao8zaCg==
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
Subject: Re: [patch V2 09/52] x86/fpu: Reject invalid MXCSR values in copy_kernel_to_xstate()
In-Reply-To: <YMoSlfxR8dbjwnCe@zn.tnic>
References: <20210614154408.673478623@linutronix.de> <20210614155354.630211386@linutronix.de> <YMoSlfxR8dbjwnCe@zn.tnic>
Date:   Thu, 17 Jun 2021 01:51:50 +0200
Message-ID: <871r91gyg9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16 2021 at 17:02, Borislav Petkov wrote:
> On Mon, Jun 14, 2021 at 05:44:17PM +0200, Thomas Gleixner wrote:
>> Instead of masking out reserved bits, check them and reject the provided
>> state as invalid if not zero.
>> 
>> Suggested-by: Andy Lutomirski <luto@kernel.org>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>> V2: New patch
>> ---
>>  arch/x86/kernel/fpu/xstate.c |   11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>> 
>> --- a/arch/x86/kernel/fpu/xstate.c
>> +++ b/arch/x86/kernel/fpu/xstate.c
>> @@ -1166,6 +1166,14 @@ int copy_kernel_to_xstate(struct xregs_s
>>  	if (validate_user_xstate_header(&hdr))
>>  		return -EINVAL;
>>  
>> +	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {
>
> Since we're cleaning up this FPU stinking pile - that function needs to
> have a verb in the name, something like:
>
> 	if (xfeatures_mxcsr_quirk_needed(...))
>
> but that's unrelated to here and as a note to whoever gets to get to it
> first.
>
>> +		const u32 *mxcsr = kbuf + offsetof(struct fxregs_state, mxcsr);
>> +
>> +		/* Reserved bits in MXCSR must be zero. */
>> +		if (*mxcsr & ~mxcsr_feature_mask)
>> +			return -EINVAL;
>> +	}
>
> Btw, that function has another
>
> 	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {
>
> branch already below the loop.
>
> Should we merge both? Diff ontop of yours:

No, because the first usage is wrong. I found that while looking through
this stuff again. Sigh...
