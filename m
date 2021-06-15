Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652993A7E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhFOMtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:49:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhFOMtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:49:21 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623761234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w1p3ZyXFWrHUss/Tn0aX7ihws1XMm5VUJPU8zRCTu4c=;
        b=lj162KaZeCPga40AmiDi1m/aA9k1jsDN76CfMu/oegFCYxGnyJQUXmAxLgjyy20Viu6PfQ
        g18ZRqGhW3SY9eS6z8/ax0iIE1Xs2iKHvOx6X2UdVZ7Iy2NWnHx8k4dUcC1cV+qD8qbZJ1
        a9Vlnc39aT7CQHaz+2rKGMlCsL1NVSQ88Ku+9RvMH+hYPKLJf7XrcYYeOlym/lSguFl2GX
        QGbwrKtEEKwL4BHi6xeQ1mPDcH/pFGeChn79thzDa3Ed1Zp76WHw0fSPIRptEko+B8gPNb
        xuHgHVyGGS9MoktFI429iCkuA15UbUR4iguPk22AKV38Kr2N9a3ny4lDvCA07w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623761234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w1p3ZyXFWrHUss/Tn0aX7ihws1XMm5VUJPU8zRCTu4c=;
        b=mnOZUDZU+NPhm7nne7LQO01kOfym6qSCqQvd1c8X3+7O30Gh9BPKLLBGinLjOwxbS2l9Wh
        NcSnD345mrTUUUBg==
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
Subject: Re: [patch V2 02/52] x86/fpu: Fix copy_xstate_to_kernel() gap handling
In-Reply-To: <YMiKC09GUaG5vZta@zn.tnic>
References: <20210614154408.673478623@linutronix.de> <20210614155353.825709513@linutronix.de> <YMiKC09GUaG5vZta@zn.tnic>
Date:   Tue, 15 Jun 2021 14:47:14 +0200
Message-ID: <87tulzgur1.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15 2021 at 13:07, Borislav Petkov wrote:
> On Mon, Jun 14, 2021 at 05:44:10PM +0200, Thomas Gleixner wrote:
>>   2) Keeping track of the last copied state in the target buffer and
>>      explicitely zero it when there is a feature or alignment gap.
>
> WARNING: 'explicitely' may be misspelled - perhaps 'explicitly'?
> #93: 
>      explicitely zero it when there is a feature or alignment gap.
>       ^^^^^^^^^^^

I'll never learn that. /me goes to write some elisp.

>> +	membuf_write(to, from_xstate ? xstate : init_xstate, size);
>
> I wonder - since we're making this code more robust anyway - whether
> we should add an additional assertion here to check whether that
> membuf.left is < size and warn.

Nah. The wonder of membug_write() is that it does not write behind the
end of the buffer which is designed to allow partial reads w/o checking
a gazillion times for return values etc.

>> +
>> +	/* Copy MXCSR when SSE or YMM are set in the feature mask */
>> +	copy_feature(header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM),
>> +		     &to, &xsave->i387.mxcsr, &xinit->i387.mxcsr,
>> +		     MXCSR_AND_FLAGS_SIZE);
>
> Yah, this copies a whopping 8 bytes:
>
>         u32                     mxcsr;          /* MXCSR Register State */
>         u32                     mxcsr_mask;     /* MXCSR Mask           */
>
> I know, I know, it was like that before but dammit, that's obscure.

The point is that this gives us the proper init.mxcsr value when SSE and
YMM are not set.

>> +	/* Copy the remaining FP state */
>> +	copy_feature(header.xfeatures & XFEATURE_MASK_FP,
>> +		     &to, &xsave->i387.st_space, &xinit->i387.st_space,
>> +		     sizeof(xsave->i387.st_space));
>> +
>> +	/* Copy the SSE state - shared with YMM */
>> +	copy_feature(header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM),
>> +		     &to, &xsave->i387.xmm_space, &xinit->i387.xmm_space,
>> +		     16 * 16);
>
> Why not
> 	sizeof(xsave->i387.xmm_space)

because I missed that.

Thanks,

        tglx


