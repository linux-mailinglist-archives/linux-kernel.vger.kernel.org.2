Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0D9403D32
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 18:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352301AbhIHQBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 12:01:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:52079 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349719AbhIHQBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:01:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="200050286"
X-IronPort-AV: E=Sophos;i="5.85,278,1624345200"; 
   d="scan'208";a="200050286"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 09:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,278,1624345200"; 
   d="scan'208";a="547885610"
Received: from gupta-dev2.jf.intel.com (HELO gupta-dev2.localdomain) ([10.54.74.119])
  by fmsmga002.fm.intel.com with ESMTP; 08 Sep 2021 09:00:34 -0700
Date:   Wed, 8 Sep 2021 09:02:06 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tsx: clear RTM and HLE when MSR_IA32_TSX_CTRL is not
 supported
Message-ID: <20210908160206.7jncf45ptn7bwamf@gupta-dev2.localdomain>
References: <CAPm50aJyfxobKhTrS=dC3pQmM5EbwY2xunet3X5XgnnFUEMmBA@mail.gmail.com>
 <20210907051454.56eocxfxeuqixlf6@gupta-dev2.localdomain>
 <CAPm50aLWUJZbgmvrt09S9LKowuH28NQpn7ZSuCkJGf_=jKFjXg@mail.gmail.com>
 <20210907225912.2i6cmprvauyxrhlu@gupta-dev2.localdomain>
 <CAPm50aLFvP=F6Lz9M-a5aNcrx+cEkAZ6NPWwEShEx2yKk64c_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPm50aLFvP=F6Lz9M-a5aNcrx+cEkAZ6NPWwEShEx2yKk64c_g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.09.2021 13:06, Hao Peng wrote:
>On Wed, Sep 8, 2021 at 6:57 AM Pawan Gupta
><pawan.kumar.gupta@linux.intel.com> wrote:
>>
>> On 07.09.2021 14:36, Hao Peng wrote:
>> >On Tue, Sep 7, 2021 at 1:13 PM Pawan Gupta
>> ><pawan.kumar.gupta@linux.intel.com> wrote:
>> >>
>> >> On 06.09.2021 10:46, Hao Peng wrote:
>> >> >If hypervisor does not support MSR_IA32_TSX_CTRL, but guest supports
>> >> >RTM and HLE features, it will affect TAA mitigation.
>> >>
>> >> Guests are on purpose not allowed to control TSX via MSR_IA32_TSX_CTRL,
>> >> otherwise a malicious guest can enable TSX and attack host or other
>> >> guests. The TAA mitigation within a guest is same as MDS i.e.
>> >> micro-architectural buffer clear using VERW instruction. Support for
>> >> VERW is added by the microcode update and enumerate by
>> >> MSR_ARCH_CAP[MD_CLEAR] bit.
>> >>
>> >> >Signed-off-by: Peng Hao <flyingpeng@tencent.com>
>> >> >---
>> >> > arch/x86/kernel/cpu/tsx.c | 7 +++++++
>> >> > 1 file changed, 7 insertions(+)
>> >> >
>> >> >diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
>> >> >index 9c7a5f049292..5e852c14fef2 100644
>> >> >--- a/arch/x86/kernel/cpu/tsx.c
>> >> >+++ b/arch/x86/kernel/cpu/tsx.c
>> >> >@@ -122,6 +122,13 @@ void __init tsx_init(void)
>> >> >
>> >> >        if (!tsx_ctrl_is_supported()) {
>> >> >                tsx_ctrl_state = TSX_CTRL_NOT_SUPPORTED;
>> >> >+
>> >> >+               /* If hypervisor does not support MSR_IA32_TSX_CTRL emulation,
>> >> >+                * but guest supports RTM and HLE features, it will affect TAA
>> >> >+                * （tsx_async_abort）mitigation.
>> >> >+                */
>> >> >+               setup_clear_cpu_cap(X86_FEATURE_RTM);
>> >> >+               setup_clear_cpu_cap(X86_FEATURE_HLE);
>> >>
>> >> This is not correct. TSX feature can exist without TSX_CTRL MSR.
>> >> Moreover, clearing the cached bits with setup_clear_cpu_cap() doesn't
>> >> disable the TSX feature in CPU.
>> >>
>> >After applying this patch, the output of
>> >/sys/devices/system/cpu/vulnerabilities/tsx_async_abort
>> >becomes “Mitigation: TSX disabled”.Do you mean that tsx is still
>> >enabled in this case in guest?
>>
>> If the host has TSX enabled, guest can use TSX instructions irrespective
>> of what cpu capabilities in the guest says.
>>
>I understand that guest cannot produce any actual effects on the hardware,
>so if the host has resolved the TAA bug on the hardware, does the guest actually
>have no vulnerability no matter what TAA status is displayed?

Yes, if the host does not have TAA bug, guest also does not have it.
