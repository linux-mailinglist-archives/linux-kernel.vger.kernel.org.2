Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E64B43A3EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbhJYUKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:10:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:37768 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236248AbhJYUGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:06:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="210531443"
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="210531443"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 12:57:53 -0700
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="634873331"
Received: from cdsmith3-mobl.amr.corp.intel.com (HELO [10.212.229.230]) ([10.212.229.230])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 12:57:52 -0700
Subject: Re: [PATCH 15/23] x86/fpu: Add sanity checks for XFD
To:     Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, dave.hansen@linux.intel.com, arjan@linux.intel.com,
        ravi.v.shankar@intel.com
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
 <20211021225527.10184-16-chang.seok.bae@intel.com>
 <20d31ed9-be3d-dca6-ceef-ced35f80d131@nextfour.com> <87o87dezwo.ffs@tglx>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <88cb75d3-01b9-38ea-e29f-b8fefb548573@intel.com>
Date:   Mon, 25 Oct 2021 12:57:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87o87dezwo.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/21 11:13 AM, Thomas Gleixner wrote:
> On Mon, Oct 25 2021 at 11:33, Mika Penttilä wrote:
>> On 22.10.2021 1.55, Chang S. Bae wrote:
>>> +#ifdef CONFIG_X86_DEBUG_FPU
>>> +/*
>>> + * Ensure that a subsequent XSAVE* or XRSTOR* instruction with RFBM=@mask
>>> + * can safely operate on the @fpstate buffer.
>>> + */
>>> +static bool xstate_op_valid(struct fpstate *fpstate, u64 mask, bool rstor)
>>> +{
>>> +	u64 xfd = __this_cpu_read(xfd_state);
>>> +
>>> +	if (fpstate->xfd == xfd)
>>> +		return true;
>>> +
>>> +	/* For current's fpstate the XFD state must be correct. */
>>> +	if (fpstate->xfd == current->thread.fpu.fpstate->xfd)
>>> +		return false;
>>> +
>> Should this return true or is the comment confusing?
> Comment might be confusing. The logic here is:
> 
> If fpstate->xfd equal xfd then it's valid.
> 
> So the next check is whether fpstate is the same as current's
> fpstate. If that's the case then the result is invalid because for
> current's fpstate the first condition should be true. But if it is not
> true then the state is not valid.

Maybe I'm just a dummy today, but I spent way too much time looking at
that line of code.  Would a slightly longer comment help.  Perhaps:

	/*
	 * The XFD MSR doesn't match the passed-in fpstate.
 	 * Make sure it at least matches current's fpstate.
	 * If not, XFD was set up wrong and is invalid.
	 */

Below is an even more exhaustive look at it.  Feel free to ignore.

--

In most cases, we are doing a normal old context switch.  XFD is already
set up by this point and the @fpstate is pointed to by
current->thread.fpu.  fpstate->xfd==xfd, life is good and we skip the
rest of the checks.

If they don't match, we have some more checks to do.  Here's a
bit-by-bit walk through it.  Just like the hardware MSR at this point,
assume that only single bit can be set in any of the xfd's.

 MSR | fpstate | cur->fpstate | valid
-------------------------------------
   0 |	   0   |      	  x   |    1  // MSR matches @fpstate
   0 |	   1   |          0   |    1  // MSR matches cur->fpstate
   0 |	   1   |          1   |    0  <- *** MSR matches nothing!
   1 |	   0   |          0   |    0  <- *** MSR matches nothing!
   1 |	   0   |          1   |    1  // MSR matches cur->fpstate
   1 |	   1   |          x   |    1  // MSR matches @fpstate

 (BTW, "valid" here means either return true from earlier, or
  falling through to the later xstate_op_valid() checks)

If a bit is *CLEAR* in the MSR, then it better be *CLEAR* in either
fpstate->xfd or current->...fpstate->xfd.

If a bit is *SET*   in the MSR, then it better be *SET*   in either
fpstate->xfd or current->...fpstate->xfd.

It's bad if the MSR doesn't match *either* fpstate->xfd or
current->...fpstate->xfd.  Because, if it does not match, how did we get
here?  What random fpstate was the MSR set up to work with?
