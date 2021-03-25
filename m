Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1E6348A24
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhCYH0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:26:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:6371 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhCYH0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:26:15 -0400
IronPort-SDR: M+pd+nCG5c7YBvlqyOv7H32KokVtfkeJ4uTscnzMRMJ54OgEf+dBtHkCuGxD4RJOK6QQ3mXYMs
 aulZPyJQ1q3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="187570299"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="187570299"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 00:26:14 -0700
IronPort-SDR: 5YUFgyEOmHp/+MWrN7JiWpc6CggC+fZhcCS9g7MCs9puzXcGvQ41vXaUw9ODLfEgKGWFXk1e8n
 qEK6gUaHOmZg==
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="415870120"
Received: from unknown (HELO [10.238.130.187]) ([10.238.130.187])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 00:26:10 -0700
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        X86 ML <x86@kernel.org>, "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-15-chang.seok.bae@intel.com>
 <87o8fda2ye.fsf@nanos.tec.linutronix.de>
 <CALCETrVaCmG4jzLCSuy7WYP2K7r-MVZntfugWa8HiVxQ7LpF_A@mail.gmail.com>
 <CAJvTdKmz7aePcpi4i+d3vnqLuNAJEuJCjpGDv5WTYcSUfuxoDg@mail.gmail.com>
 <6ed9d725-a6cb-4147-9c8a-2fe240e4bb10@linux.intel.com>
 <CAJvTdKm_uP-RqoprWWatg725WZOm3T-BHZU8S08dpWe2=1apGw@mail.gmail.com>
 <87fb254f-a904-303e-daee-c9a3e9bf13b7@linux.intel.com>
 <A2F31E33-4F15-431B-8407-438750186895@intel.com>
From:   "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <84047b4a-48e3-6efc-643a-06cfcc0630cc@linux.intel.com>
Date:   Thu, 25 Mar 2021 15:26:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <A2F31E33-4F15-431B-8407-438750186895@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>> For AMX, we must still reserve the space, but we are not going to write zeros
>>> for clean state.  We so this in software by checking XINUSE=0, and clearing
>>> the xstate_bf for the XSAVE.  As a result, for XINUSE=0, we can skip
>>> writing the zeros, even though we can't compress the space.
>> So my understanding is that clearing xstate_bv will not help prevent saving
>> zeros, but only not masking EDX:EAX, since the following logic. Not sure if
>> this is just what you mean. :)
> FWIW, PATCH21 [1] uses the instruction mask to skip writing zeros on sigframe.
> Then, XSAVE will clear the xstate_bv for the xtile data state bit.
>
> [1] https://lore.kernel.org/lkml/20210221185637.19281-22-chang.seok.bae@intel.com/
Yes, no mask in EDX:EAX works in such case. Thanks for pointing out the 
patch.

BRs,
Jing
>
> Thanks,
> Chang

