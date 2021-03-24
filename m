Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79F6347009
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhCXDPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:15:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:51073 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232136AbhCXDPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:15:04 -0400
IronPort-SDR: DhZgdWW8ArjYg1b432Lixe9LPSsstxMwri191SxjXBY9nnSFJ64xnreSyVBj9J0zLZkpqxUe/e
 JXacLLl7PI4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="170584401"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="170584401"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 20:15:04 -0700
IronPort-SDR: 3p9tg3af0W5TyL5lS8A2Ca/RncKlDU0SfcTQYhiOzINQIgTSpeTV6Qcw1Xy55pSKP6DfCOHWGc
 AfW6MrHSxFgg==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="442014527"
Received: from liujing-mobl.ccr.corp.intel.com (HELO [10.255.28.87]) ([10.255.28.87])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 20:15:00 -0700
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
To:     Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-15-chang.seok.bae@intel.com>
 <87o8fda2ye.fsf@nanos.tec.linutronix.de>
 <CALCETrVaCmG4jzLCSuy7WYP2K7r-MVZntfugWa8HiVxQ7LpF_A@mail.gmail.com>
 <CAJvTdKmz7aePcpi4i+d3vnqLuNAJEuJCjpGDv5WTYcSUfuxoDg@mail.gmail.com>
From:   "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <6ed9d725-a6cb-4147-9c8a-2fe240e4bb10@linux.intel.com>
Date:   Wed, 24 Mar 2021 11:14:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAJvTdKmz7aePcpi4i+d3vnqLuNAJEuJCjpGDv5WTYcSUfuxoDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/2021 5:01 AM, Len Brown wrote:
>> I have an obnoxious question: do we really want to use the XFD mechanism?
> Obnoxious questions are often the most valuable! :-)
>
> [...]
> cheers,
> Len Brown, Intel Open Source Technology Center
>
> ps. I agree that un-necessary XINUSE=1 is possible.
> Notwithstanding the issues initially deploying AVX512, I am skeptical
> that it is common today.
Sorry, I'm trying to understand from...
> IMO, the problem with AVX512 state
> is that we guaranteed it will be zero for XINUSE=0.
> That means we have to write 0's on saves.
why "we have to write 0's on saves" when XINUSE=0.

Since due to SDM, if XINUSE=0, the XSAVES will *not* save the data and
xstate_bv bit is 0; if use XSAVE, it need save the state but
xstate_bv bit is also 0.
>   It would be better
> to be able to skip the write -- even if we can't save the space
> we can save the data transfer.  (This is what we did for AMX).
With XFD feature that XFD=1, XSAVE command still has to save INIT state
to the area. So it seems with XINUSE=0 and XFD=1, the XSAVE(S) commands
do the same that both can help save the data transfer.

The reason I'm interested in XINUSE denotation is that it might be helpful
for the XFD MSRs context switch cost during vmexit and vmenter.

Thanks,
Jing
>
> pps. your idea of requiring the user to allocate their own signal stack
> is interesting.   It isn't really about allocating the stack, though --
> the stack of the task that uses the feature is generally fine already.
> The opportunity is to allow tasks that do *not* use the new feature to
> get away with minimal data transfer and stack size.  As we don't
> have the 0's guarantee for AMX, we bought the important part
> of that back.

