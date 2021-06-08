Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD9939F981
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhFHOtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:49:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:34602 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233288AbhFHOtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:49:46 -0400
IronPort-SDR: zW40cu/NiVtF04V0Og58Ua+2OfLanUHV+cUeEaTa8x0uFU+ckpgFJVkGqZhm0xpGlt/kHAKObD
 pxbZPh3Nfk2g==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="290487698"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="290487698"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 07:47:53 -0700
IronPort-SDR: c5iW+XRYk6tdKb/CLbJVQhiL0xz4jYzmy9nkSVuqkZNkJ9WVC5ZQ2q7TDGBAM6Zb/RZydDCbFg
 CVFCuOFHPG+A==
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="637655818"
Received: from ciball-mobl1.amr.corp.intel.com (HELO [10.252.140.48]) ([10.252.140.48])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 07:47:52 -0700
Subject: Re: [patch V2 00/14] x86/fpu: Mop up XSAVES and related damage
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20210605234742.712464974@linutronix.de>
 <87h7i9zv3r.ffs@nanos.tec.linutronix.de>
 <eca0add1-849e-6a1a-8ea6-f6b72650c9c8@intel.com>
 <87eeddzs0l.ffs@nanos.tec.linutronix.de>
 <37df631f-9d3d-3035-6eeb-85ef33e580d5@intel.com>
 <87bl8hz3sl.ffs@nanos.tec.linutronix.de>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <6ca1fbfe-8c7d-88ba-9066-cc30ffde1fa8@intel.com>
Date:   Tue, 8 Jun 2021 07:47:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87bl8hz3sl.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/21 3:51 PM, Thomas Gleixner wrote:
...
> But it creates a few new problems:
> 
>   1) Where to put the PKRU value in the sigframe?
> 
>      For 64bit sigframes that's easy as there is padding space, for
>      32bit sigframes that's a problem because there is no space.
> 
>   2) Backward compatibility
> 
>      As much as we wish to have a time machine there is a rule not to
>      break existing user space.
> 
> Now fortunately there is a way out:
> 
>   1) User space cannot rely on PKRU being XSTATE managed unless PKRU is
>      enabled in XCR0. XCR0 enablement is part of the UABI so any
>      complaint about missing XCR0 support is futile

So...  One more gem from the manpages:

> It is recommended that
>        applications wanting to use protection keys should simply call
>        pkey_alloc(2) and test whether the call succeeds, instead of
>        attempting to detect support for the feature in any other way.

I kinda wrote that thinking that folks could avoid doing the
CPUID/XGETBV dance and just use the syscall instead.  *If* they do what
is suggested, they'll never notice the lack of PKRU in XCR0.

The pkey selftest, for instance, blindly assumes that pkeys is enabled
in XCR0.  It would probably end up scribbling somewhere on the stack.
Now the same person who wrote that also wrote the manpages, so those are
not exactly two separate data points.

...
> So the proposed solution is to:
> 
>    A) Exclude PKRU from XSTATE managed state, i.e. do not set the PKRU
>       bit in XCR0
> 
>    B) Exclude 32bit applications on 64bit kernels from using PKEYS by
>       returning an error code from pkey_alloc(). That's fine because the
>       man page requires them to handle the fail which they need to do
>       anyway because 32bit kernel do not support PKEYS and never will.
> 
>    C) Replace the current context switch mechanism which is partially
>       XSAVE based by a software managed one.
> 
>    D) Store the PKRU value in one of the reserved slots of the 64bit
>       signal frame which is possible because of #B so that a signal
>       handler has the chance to override the interrupted task's PKRU
>       setting.
> 
> Thoughts?

The thing that makes me most nervous is changing the signal stack ABI
for PKRU.  Careful apps (not the selftest) will probably have more
careful enumeration and might bug out due to the missing XCR0 bit.  Or,
they might at least check xfeatures (aka. XSTATE_BV) in the signal stack
XSAVE buffer.

On the bright side, rudely masking PKRU out of XCR0:

	xcr0 &= ~XFEATURE_MASK_PKRU;

still results in a kernel that boots.
