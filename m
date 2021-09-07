Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D69D402314
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 07:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbhIGFh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 01:37:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:25171 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhIGFhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 01:37:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="218240856"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="218240856"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 22:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="430088006"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2021 22:36:46 -0700
Date:   Mon, 6 Sep 2021 22:38:16 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, Borislav Petkov <bp@alien8.de>,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tsx: clear RTM and HLE when MSR_IA32_TSX_CTRL is not
 supported
Message-ID: <20210907053816.qldtcxkxxv7hkzgv@gupta-dev2.localdomain>
References: <CAPm50aJyfxobKhTrS=dC3pQmM5EbwY2xunet3X5XgnnFUEMmBA@mail.gmail.com>
 <YTXfmRIwWREJgEU9@zn.tnic>
 <CAPm50aLBt=YkFLi==-9U88YzwoJsmMTfEtj2v3+vx7fSRdDMLA@mail.gmail.com>
 <f89e1eee-aea8-7c59-3af5-8859a43e121c@intel.com>
 <CAPm50aLiB+O85mgcKcOZwO6J-DXjwK=p+7npBH-qVdkL-77Huw@mail.gmail.com>
 <77e8d483-4395-0017-300e-0886f75217bb@intel.com>
 <CAPm50aL_eJm2s5GJD1OMFK3vt_iHLQrBueiz-NWS38H=Zz378w@mail.gmail.com>
 <cae10a15-1c21-4cf4-dff5-2123613f1b41@intel.com>
 <CAPm50a+crBuP9wH2zCqcD22+wmsb4pj3A9rT_G+64=EV9KLg5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPm50a+crBuP9wH2zCqcD22+wmsb4pj3A9rT_G+64=EV9KLg5w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.2021 12:39, Hao Peng wrote:
>On Tue, Sep 7, 2021 at 12:26 PM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>
>> On 9/7/2021 11:40 AM, Hao Peng wrote:
>> > On Tue, Sep 7, 2021 at 10:56 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>> >>
>> >> On 9/7/2021 10:35 AM, Hao Peng wrote:
>> >>> On Tue, Sep 7, 2021 at 10:08 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>> >>>>
>> >>>> On 9/7/2021 9:47 AM, Hao Peng wrote:
>> >>>>> On Mon, Sep 6, 2021 at 5:30 PM Borislav Petkov <bp@alien8.de> wrote:
>> >>>>>>
>> >>>>>> On Mon, Sep 06, 2021 at 10:46:05AM +0800, Hao Peng wrote:
>> >>>>>>> If hypervisor does not support MSR_IA32_TSX_CTRL, but guest supports
>> >>>>>>> RTM and HLE features, it will affect TAA mitigation.
>> >>>>>>>
>> >>>>>>> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
>> >>>>>>> ---
>> >>>>>>>     arch/x86/kernel/cpu/tsx.c | 7 +++++++
>> >>>>>>>     1 file changed, 7 insertions(+)
>> >>>>>>>
>> >>>>>>> diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
>> >>>>>>> index 9c7a5f049292..5e852c14fef2 100644
>> >>>>>>> --- a/arch/x86/kernel/cpu/tsx.c
>> >>>>>>> +++ b/arch/x86/kernel/cpu/tsx.c
>> >>>>>>> @@ -122,6 +122,13 @@ void __init tsx_init(void)
>> >>>>>>>
>> >>>>>>>            if (!tsx_ctrl_is_supported()) {
>> >>>>>>>                    tsx_ctrl_state = TSX_CTRL_NOT_SUPPORTED;
>> >>>>>>> +
>> >>>>>>> +               /* If hypervisor does not support MSR_IA32_TSX_CTRL emulation,
>> >>>>>>> +                * but guest supports RTM and HLE features, it will affect TAA
>> >>>>>>> +                * （tsx_async_abort）mitigation.
>> >>>>>>> +                */
>> >>>>>>> +               setup_clear_cpu_cap(X86_FEATURE_RTM);
>> >>>>>>> +               setup_clear_cpu_cap(X86_FEATURE_HLE);
>> >>>>
>> >>>> anyway, IMHO, we shouldn't do anything here for TAA. It should be in
>> >>>> taa_select_mitigation()
>> >>>>
>> >>>>>>>                    return;
>> >>>>>>>            }
>> >>>>>>
>> >>>>>> How does that even happen - the hypervisor does not support the MSR but
>> >>>>>> "guest supports" TSX features?!
>> >>>>>>
>> >>>>>> I guess the guest is detecting it wrong.
>> >>>>>>
>> >>>>>> What hypervisor, what guest, how do I reproduce?
>> >>>>>>
>> >>>>> hypervisor is kvm, guest is linux too.
>> >>>>>> Please give full details.
>> >>>>>>
>> >>>>> The host I used is kernel-5.4, and guest is kernel-5.13.
>> >>>>> MSR_IA32_TSX_CTRL is exposed
>> >>>>> to guest and guest to support RTM and HLE features, no direct
>> >>>>> dependence. at the qemu I
>> >>>>> started guest with -cpu host-model.
>> >>>>> I have viewed the code of kernel-5.4, and MSR_IA32_TSX_CTRL is not
>> >>>>> exposed to guest.
>> >>>>
>> >>>> Does guest see TAA_NO bit?
>> >>>>
>> >>> Guest can't see taa_no, which requires updating qemu to solve. But I think
>> >>> there is a compatibility process here.
>> >>
>> >> Anyway, there should be some existing code in kernel already to handle
>> >> the case that CPUID reports TRM while MSR_IA32_CORE_CAPABILITIES doesn't
>> >> report MSR_TSX_CTRL nor TAA_NO.
>> >>
>> > Can you point out which patches ? At present, guest is kernel-5.13
>> > still has this problem.
>>
>> What's the output of 'cat
>> /sys/devices/system/cpu/vulnerabilities/tsx_async_abort' on your guest?
>>
>Vulnerable: Clear CPU buffers attempted, no microcode; SMT Host state unknown.

This suggests that the microcode is old. Can you please share the output
of below cmds on host and guest:

	$ grep . /sys/devices/system/cpu/vulnerabilities/*
	$ lscpu
	$ grep microcode /proc/cpuinfo | uniq
	$ cat /proc/cmdline

Thanks,
Pawan
