Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533E040230B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 07:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhIGF1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 01:27:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:24585 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhIGF1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 01:27:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="218239811"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="218239811"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 22:26:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="478534983"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by orsmga008.jf.intel.com with ESMTP; 06 Sep 2021 22:26:31 -0700
Date:   Mon, 6 Sep 2021 22:28:01 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Hao Peng <flyingpenghao@gmail.com>, Borislav Petkov <bp@alien8.de>,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tsx: clear RTM and HLE when MSR_IA32_TSX_CTRL is not
 supported
Message-ID: <20210907052801.jluqt35ajqgxqjig@gupta-dev2.localdomain>
References: <CAPm50aJyfxobKhTrS=dC3pQmM5EbwY2xunet3X5XgnnFUEMmBA@mail.gmail.com>
 <YTXfmRIwWREJgEU9@zn.tnic>
 <CAPm50aLBt=YkFLi==-9U88YzwoJsmMTfEtj2v3+vx7fSRdDMLA@mail.gmail.com>
 <f89e1eee-aea8-7c59-3af5-8859a43e121c@intel.com>
 <CAPm50aLiB+O85mgcKcOZwO6J-DXjwK=p+7npBH-qVdkL-77Huw@mail.gmail.com>
 <77e8d483-4395-0017-300e-0886f75217bb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77e8d483-4395-0017-300e-0886f75217bb@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.2021 10:56, Xiaoyao Li wrote:
>On 9/7/2021 10:35 AM, Hao Peng wrote:
>>On Tue, Sep 7, 2021 at 10:08 AM Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>>
>>>On 9/7/2021 9:47 AM, Hao Peng wrote:
>>>>On Mon, Sep 6, 2021 at 5:30 PM Borislav Petkov <bp@alien8.de> wrote:
>>>>>
>>>>>On Mon, Sep 06, 2021 at 10:46:05AM +0800, Hao Peng wrote:
>>>>>>If hypervisor does not support MSR_IA32_TSX_CTRL, but guest supports
>>>>>>RTM and HLE features, it will affect TAA mitigation.
>>>>>>
>>>>>>Signed-off-by: Peng Hao <flyingpeng@tencent.com>
>>>>>>---
>>>>>>   arch/x86/kernel/cpu/tsx.c | 7 +++++++
>>>>>>   1 file changed, 7 insertions(+)
>>>>>>
>>>>>>diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
>>>>>>index 9c7a5f049292..5e852c14fef2 100644
>>>>>>--- a/arch/x86/kernel/cpu/tsx.c
>>>>>>+++ b/arch/x86/kernel/cpu/tsx.c
>>>>>>@@ -122,6 +122,13 @@ void __init tsx_init(void)
>>>>>>
>>>>>>          if (!tsx_ctrl_is_supported()) {
>>>>>>                  tsx_ctrl_state = TSX_CTRL_NOT_SUPPORTED;
>>>>>>+
>>>>>>+               /* If hypervisor does not support MSR_IA32_TSX_CTRL emulation,
>>>>>>+                * but guest supports RTM and HLE features, it will affect TAA
>>>>>>+                * （tsx_async_abort）mitigation.
>>>>>>+                */
>>>>>>+               setup_clear_cpu_cap(X86_FEATURE_RTM);
>>>>>>+               setup_clear_cpu_cap(X86_FEATURE_HLE);
>>>
>>>anyway, IMHO, we shouldn't do anything here for TAA. It should be in
>>>taa_select_mitigation()
>>>
>>>>>>                  return;
>>>>>>          }
>>>>>
>>>>>How does that even happen - the hypervisor does not support the MSR but
>>>>>"guest supports" TSX features?!
>>>>>
>>>>>I guess the guest is detecting it wrong.
>>>>>
>>>>>What hypervisor, what guest, how do I reproduce?
>>>>>
>>>>hypervisor is kvm, guest is linux too.
>>>>>Please give full details.
>>>>>
>>>>The host I used is kernel-5.4, and guest is kernel-5.13.
>>>>MSR_IA32_TSX_CTRL is exposed
>>>>to guest and guest to support RTM and HLE features, no direct
>>>>dependence. at the qemu I
>>>>started guest with -cpu host-model.
>>>>I have viewed the code of kernel-5.4, and MSR_IA32_TSX_CTRL is not
>>>>exposed to guest.
>>>
>>>Does guest see TAA_NO bit?
>>>
>>Guest can't see taa_no, which requires updating qemu to solve. But I think
>>there is a compatibility process here.
>
>Anyway, there should be some existing code in kernel already to handle 
>the case that CPUID reports TRM while MSR_IA32_CORE_CAPABILITIES 
>doesn't report MSR_TSX_CTRL nor TAA_NO.

When TSX_CTRL MSR is not supported, TAA mitigation is same as MDS, and
it is deployed automatically provided the system has a recent microcode.

Thanks,
Pawan
