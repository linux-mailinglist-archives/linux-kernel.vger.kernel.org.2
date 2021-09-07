Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C2240225A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 05:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhIGC51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 22:57:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:26240 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhIGC5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 22:57:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="199611961"
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; 
   d="scan'208";a="199611961"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 19:56:19 -0700
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; 
   d="scan'208";a="605033418"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.239.13.122]) ([10.239.13.122])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 19:56:17 -0700
Subject: Re: [PATCH] x86/tsx: clear RTM and HLE when MSR_IA32_TSX_CTRL is not
 supported
To:     Hao Peng <flyingpenghao@gmail.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <CAPm50aJyfxobKhTrS=dC3pQmM5EbwY2xunet3X5XgnnFUEMmBA@mail.gmail.com>
 <YTXfmRIwWREJgEU9@zn.tnic>
 <CAPm50aLBt=YkFLi==-9U88YzwoJsmMTfEtj2v3+vx7fSRdDMLA@mail.gmail.com>
 <f89e1eee-aea8-7c59-3af5-8859a43e121c@intel.com>
 <CAPm50aLiB+O85mgcKcOZwO6J-DXjwK=p+7npBH-qVdkL-77Huw@mail.gmail.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <77e8d483-4395-0017-300e-0886f75217bb@intel.com>
Date:   Tue, 7 Sep 2021 10:56:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPm50aLiB+O85mgcKcOZwO6J-DXjwK=p+7npBH-qVdkL-77Huw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/2021 10:35 AM, Hao Peng wrote:
> On Tue, Sep 7, 2021 at 10:08 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>
>> On 9/7/2021 9:47 AM, Hao Peng wrote:
>>> On Mon, Sep 6, 2021 at 5:30 PM Borislav Petkov <bp@alien8.de> wrote:
>>>>
>>>> On Mon, Sep 06, 2021 at 10:46:05AM +0800, Hao Peng wrote:
>>>>> If hypervisor does not support MSR_IA32_TSX_CTRL, but guest supports
>>>>> RTM and HLE features, it will affect TAA mitigation.
>>>>>
>>>>> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
>>>>> ---
>>>>>    arch/x86/kernel/cpu/tsx.c | 7 +++++++
>>>>>    1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
>>>>> index 9c7a5f049292..5e852c14fef2 100644
>>>>> --- a/arch/x86/kernel/cpu/tsx.c
>>>>> +++ b/arch/x86/kernel/cpu/tsx.c
>>>>> @@ -122,6 +122,13 @@ void __init tsx_init(void)
>>>>>
>>>>>           if (!tsx_ctrl_is_supported()) {
>>>>>                   tsx_ctrl_state = TSX_CTRL_NOT_SUPPORTED;
>>>>> +
>>>>> +               /* If hypervisor does not support MSR_IA32_TSX_CTRL emulation,
>>>>> +                * but guest supports RTM and HLE features, it will affect TAA
>>>>> +                * （tsx_async_abort）mitigation.
>>>>> +                */
>>>>> +               setup_clear_cpu_cap(X86_FEATURE_RTM);
>>>>> +               setup_clear_cpu_cap(X86_FEATURE_HLE);
>>
>> anyway, IMHO, we shouldn't do anything here for TAA. It should be in
>> taa_select_mitigation()
>>
>>>>>                   return;
>>>>>           }
>>>>
>>>> How does that even happen - the hypervisor does not support the MSR but
>>>> "guest supports" TSX features?!
>>>>
>>>> I guess the guest is detecting it wrong.
>>>>
>>>> What hypervisor, what guest, how do I reproduce?
>>>>
>>> hypervisor is kvm, guest is linux too.
>>>> Please give full details.
>>>>
>>> The host I used is kernel-5.4, and guest is kernel-5.13.
>>> MSR_IA32_TSX_CTRL is exposed
>>> to guest and guest to support RTM and HLE features, no direct
>>> dependence. at the qemu I
>>> started guest with -cpu host-model.
>>> I have viewed the code of kernel-5.4, and MSR_IA32_TSX_CTRL is not
>>> exposed to guest.
>>
>> Does guest see TAA_NO bit?
>>
> Guest can't see taa_no, which requires updating qemu to solve. But I think
> there is a compatibility process here.

Anyway, there should be some existing code in kernel already to handle 
the case that CPUID reports TRM while MSR_IA32_CORE_CAPABILITIES doesn't 
report MSR_TSX_CTRL nor TAA_NO.

And the Patch itself makes no sense.

>>> Thanks.
>>>> --
>>>> Regards/Gruss,
>>>>       Boris.
>>>>
>>>> https://people.kernel.org/tglx/notes-about-netiquette
>>

