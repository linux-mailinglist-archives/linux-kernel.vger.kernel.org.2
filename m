Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4249033C978
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 23:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhCOWkC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 Mar 2021 18:40:02 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:1445 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231377AbhCOWjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 18:39:45 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2021 18:39:45 EDT
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 15 Mar 2021 15:24:43 -0700
Received: from [10.200.196.160] (unknown [10.200.196.160])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 323722050D;
        Mon, 15 Mar 2021 15:24:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] x86/vmware: avoid TSC recalibration
From:   Alexey Makhalov <amakhalov@vmware.com>
In-Reply-To: <87im8bildr.fsf@vitty.brq.redhat.com>
Date:   Mon, 15 Mar 2021 15:24:43 -0700
CC:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        <mingo@redhat.com>, <tglx@linutronix.de>, <pv-drivers@vmware.com>,
        <sdeep@vmware.com>
Content-Transfer-Encoding: 8BIT
Message-ID: <84F586C5-EECE-4EE5-8988-64D8E0325D7A@vmware.com>
References: <20210105004752.131069-1-amakhalov@vmware.com>
 <87im8bildr.fsf@vitty.brq.redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Received-SPF: None (EX13-EDG-OU-001.vmware.com: amakhalov@vmware.com does not
 designate permitted sender hosts)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitaly,

I believe, it is responsibility of each guest code to set X86_FEATURE_TSC_KNOWN_FREQ cap.
Regarding VMware guest, there is a case where vmware_tsc_khz is zero (not provided by hypervisor)
and TSC frequency should be calculated.

Sorry for late response.

Regards,
—Alexey

> On Jan 5, 2021, at 5:06 AM, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> 
> Alexey Makhalov <amakhalov@vmware.com> writes:
> 
>> When TSC frequency is known (retrieved from hypervisor), we should skip
>> TSC refined calibration by setting X86_FEATURE_TSC_KNOWN_FREQ.
>> 
>> Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
>> ---
>> arch/x86/kernel/cpu/vmware.c | 2 ++
>> 1 file changed, 2 insertions(+)
>> 
>> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
>> index c6ede3b3d302..83164110ccc5 100644
>> --- a/arch/x86/kernel/cpu/vmware.c
>> +++ b/arch/x86/kernel/cpu/vmware.c
>> @@ -378,6 +378,8 @@ static void __init vmware_set_capabilities(void)
>> {
>> 	setup_force_cpu_cap(X86_FEATURE_CONSTANT_TSC);
>> 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
>> +	if (vmware_tsc_khz)
>> +		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>> 	if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL)
>> 		setup_force_cpu_cap(X86_FEATURE_VMCALL);
>> 	else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL)
> 
> The same trick is being used in Xen/Jailhouse/KVM code already and
> Hyper-V overwrites x86_platform.calibrate_tsc/x86_platform.calibrate_cpu
> hooks to basically achive the same goal. Should we maybe introduce a
> flag in 'struct hypervisor_x86' or something like that to unify all
> this?
> 
> Just a suggestion.
> 
> -- 
> Vitaly

