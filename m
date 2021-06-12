Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1D63A5116
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 00:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhFLWHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 18:07:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47168 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLWHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 18:07:49 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623535548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TKdCZh9SvxgzQB6iVtRXjUp3kVW7DM7n7Xey3zoCZhw=;
        b=bAR1jOpDYNxQ1NEUEiDc9qspXhgPlUTy4V5wkvUECEQwd8Bev5b3Fy+Grx4hOqwgmw+13S
        DczgU3VXJlz6vdCb5uKn9r7Ikj7D6VPaQhgtS680wtwkVD+yH2nbOsP050kzYT6eud34b4
        s3wBysPH41hF/89Rqz0Ln895VIsFI+blH3xFmgq1qjRS+52MsMA3K+D/O12aFoG+j9rvG9
        tD0Bb0v6zZGtNl6m6/RMw+r0EwUpX/2uGb49SrV/yl9sGnJyhw3x6yp6F365pxaTIGUYGB
        Y1dtKPl+Md5Rp2/F5/HX5gvdsr4okVHg58XaePK52GxWtt58ENutVO2AP1wl0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623535548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TKdCZh9SvxgzQB6iVtRXjUp3kVW7DM7n7Xey3zoCZhw=;
        b=EuxqYYVpVMc9sw9PZ27FwQgI8axkT7zeOCRuG4YRn6yvzPCoQWoH2HWkq0UN6hQMK5YAZF
        R5jZFUHptfd+rrBQ==
To:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch 08/41] x86/fpu: Restrict fpstate sanitizing to legacy components
In-Reply-To: <874ke4vynu.ffs@nanos.tec.linutronix.de>
References: <20210611161523.508908024@linutronix.de> <20210611163111.820639606@linutronix.de> <2be2ef6c-fcb8-46cf-976c-2b3a9537b660@kernel.org> <874ke4vynu.ffs@nanos.tec.linutronix.de>
Date:   Sun, 13 Jun 2021 00:05:47 +0200
Message-ID: <87mtruviv8.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12 2021 at 00:12, Thomas Gleixner wrote:
> On Fri, Jun 11 2021 at 12:03, Andy Lutomirski wrote:
>> On 6/11/21 9:15 AM, Thomas Gleixner wrote:
>>> + *
>>> + * This is required for the legacy regset functions.
>>> + */
>>> +static void fpstate_sanitize_legacy(struct fpu *fpu)
>>> +{
>>> +	struct fxregs_state *fx = &fpu->state.fxsave;
>>> +	u64 xfeatures;
>>> +
>>> +	if (!use_xsaveopt())
>>> +		return;
>>
>> This is confusing, since we never use xsaveopt.  It's also wrong -- see
>> above.  How about just removing it?
>
> We do and this code is buggy because xsaves does not clear the component
> storage either. Neither does xsavec which we in fact do not use in the
> kernel.
>
> So here is how the different opcodes behave on a buffer filled with 0xff
> when looking the first four 64bit words of the buffer after doing a
> xrstor with all feature bits cleared
>
> Intel SKLX
>  
> XSAVE    000000000000037f 0000000000000000 0000000000000000 0000ffff00001f80
> XSAVEOPT ffffffffffffffff ffffffffffffffff ffffffffffffffff 0000ffff00001f80
> XSAVEC   ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> XSAVES   ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
>
> AMD ZEN2
>
> XSAVE    000000000000037f 0000000000000000 0000000000000000 0002ffff00001f80
> XSAVEOPT ffffffffffffffff ffffffffffffffff ffffffffffffffff 0002ffff00001f80
> XSAVEC   ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> XSAVES   ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
>
> I verified that all saved buffers have xstate.header.xstate_bv == 0
>
> So nothing about any of this is consistent and correct. But it magically
> works for unknown reasons.

What's even worse is the following. setup_init_fpu_buf() does:

	copy_kernel_to_xregs_booting(&init_fpstate.xsave);
	/*
	 * Dump the init state again. This is to identify the init state
	 * of any feature which is not represented by all zero's.
	 */
	copy_xregs_to_kernel_booting(&init_fpstate.xsave);

That comment is blatantly wrong with XSAVES/XRSTORS. init_fpstate is
initially all zeros and it stays that way with XRSTORS. Oh well.

And as the intialization values at least for mxcsr_mask differ on AMD
and INTEL making them hardcoded is just wrong. Sigh...

So we could save the state with XSAVE into a different buffer and copy
the components to the correct place in the compacted init_fpstate, but
the only interesting part of all this with any variant of XSAVE is the
legacy part. Everything else is just zeros (except for HDC and HWP
states which we do not use and they can be accessed via MSRs if the need
ever arises). We could just save the legacy part with fxsave and be done
with it.

Aside of that this whole _booting() stuff is complete nonsense. It's
completely sufficient to XRSTOR from an all zeroes buffer which brings
every components into init state and then do all the other muck _after_
alternatives have been patched. Absolutely nothing uses FPU muck before
that point.

While staring at all this I figured out why that sanitizing does not and
_cannot_ touch MXCSR and MXCSR_MASK.

MXCSR and MXCSR_MASK are located in the FP component storage and used by
SSE. But MXCSR is also XSAVEd when AVX is in use.

So the sanitizing cannot touch it without checking whether AVX is in
use. This is really all well thought out in hardware _AND_ software.

Let me try to beat some more sense into this trainwreck.

Thanks,

        tglx
