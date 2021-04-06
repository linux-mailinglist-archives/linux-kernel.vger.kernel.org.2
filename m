Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A613355A2C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244491AbhDFRUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:20:11 -0400
Received: from foss.arm.com ([217.140.110.172]:46126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234885AbhDFRUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:20:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6118B1063;
        Tue,  6 Apr 2021 10:20:00 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F4023F792;
        Tue,  6 Apr 2021 10:19:58 -0700 (PDT)
Subject: Re: [PATCH v2 00/24] x86/resctrl: Merge the CDP resources
To:     Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20210312175849.8327-1-james.morse@arm.com>
 <7a6cd831-4a3e-9f2b-b403-9a4d5e1b719d@amd.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <451ec473-8dfa-d2ac-40ef-a4f9bdc23ddc@arm.com>
Date:   Tue, 6 Apr 2021 18:19:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <7a6cd831-4a3e-9f2b-b403-9a4d5e1b719d@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 30/03/2021 21:36, Babu Moger wrote:
> On 3/12/21 11:58 AM, James Morse wrote:
>> This series re-folds the resctrl code so the CDP resources (L3CODE et al)
>> behaviour is all contained in the filesystem parts, with a minimum amount
>> of arch specific code.
>>
>> Arm have some CPU support for dividing caches into portions, and
>> applying bandwidth limits at various points in the SoC. The collective term
>> for these features is MPAM: Memory Partitioning and Monitoring.
>>
>> MPAM is similar enough to Intel RDT, that it should use the defacto linux
>> interface: resctrl. This filesystem currently lives under arch/x86, and is
>> tightly coupled to the architecture.
>> Ultimately, my plan is to split the existing resctrl code up to have an
>> arch<->fs abstraction, then move all the bits out to fs/resctrl. From there
>> MPAM can be wired up.
>>
>> x86 might have two resources with cache controls, (L2 and L3) but has
>> extra copies for CDP: L{2,3}{CODE,DATA}, which are marked as enabled
>> if CDP is enabled for the corresponding cache.
>>
>> MPAM has an equivalent feature to CDP, but its a property of the CPU,
>> not the cache. Resctrl needs to have x86's odd/even behaviour, as that
>> its the ABI, but this isn't how the MPAM hardware works. It is entirely
>> possible that an in-kernel user of MPAM would not be using CDP, whereas
>> resctrl is.
>> Pretending L3CODE and L3DATA are entirely separate resources is a neat
>> trick, but doing this is specific to x86.
>> Doing this leaves the arch code in control of various parts of the
>> filesystem ABI: the resources names, and the way the schemata are parsed.
>> Allowing this stuff to vary between architectures is bad for user space.
>>
>> This series collapses the CODE/DATA resources, moving all the user-visible
>> resctrl ABI into what becomes the filesystem code. CDP becomes the type of
>> configuration being applied to a cache. This is done by adding a
>> struct resctrl_schema to the parts of resctrl that will move to fs. This
>> holds the arch-code resource that is in use for this schema, along with
>> other properties like the name, and whether the configuration being applied
>> is CODE/DATA/BOTH.


> I applied your patches on my AMD box.

Great! Thanks for taking a look,


> Seeing some difference in the behavior.

Ooer,


> Before these patches.
> 
> # dmesg |grep -i resctrl
> [   13.076973] resctrl: L3 allocation detected
> [   13.087835] resctrl: L3DATA allocation detected
> [   13.092886] resctrl: L3CODE allocation detected
> [   13.097936] resctrl: MB allocation detected
> [   13.102599] resctrl: L3 monitoring detected
> 
> 
> After the patches.
> 
> # dmesg |grep -i resctrl
> [   13.076973] resctrl: L3 allocation detected
> [   13.097936] resctrl: MB allocation detected
> [   13.102599] resctrl: L3 monitoring detected
> 
> You can see that L3DATA and L3CODE disappeared. I think we should keep the
> behavior same for x86(at least).

This is the kernel log ... what user-space software is parsing that for an expected value?
What happens if the resctrl strings have been overwritten by more kernel log?

I don't think user-space should be relying on this. I'd argue any user-space doing this is
already broken. Is it just the kernel selftest's filter_dmesg()? It doesn't seem to do
anything useful

Whether resctrl is support can be read from /proc/filesystems. CDP is probably a
try-it-and-see. User-space could parse /proc/cpuinfo, but its probably not a good idea.


Its easy to fix, but it seems odd that the kernel has to print things for user-space to
try and parse. (I'd like to point at the user-space software that depends on this)


> I am still not clear why we needed resctrl_conf_type
> 
> enum resctrl_conf_type {
>         CDP_BOTH,
>         CDP_CODE,
>         CDP_DATA,
> };
> 
> Right now, I see all the resources are initialized as CDP_BOTH.
> 
>  [RDT_RESOURCE_L3] =
>         {
>                 .conf_type                      = CDP_BOTH,
>  [RDT_RESOURCE_L2] =
>         {
>                 .conf_type                      = CDP_BOTH,
>  [RDT_RESOURCE_MBA] =
>         {
>                 .conf_type                      = CDP_BOTH,

Ah, those should have been removed in patch 24. Once all the resources are the same, the
resource doesn't need to describe what kind it is.


> If all the resources are CDP_BOTH, then why we need separate CDP_CODE and
> CDP_DATA?

The filesystem code for resctrl that will eventually move out of arch/x86 needs to be able
to describe the type of configuration change being made back to the arch code. The enum
gets used for that.

x86 needs this as it affects which MSRs the configuration value is written to.


> Are these going to be different for ARM?

Nope. Arm's MPAM ends up emulating CDP with the closid values that get applied to
transactions.


> Also initializing RDT_RESOURCE_MBA as CDP_BOTH does not seem right. I dont
> think there will CDP support in MBA in future.

Its not code or data, which makes it both. 'BOTH' is more of a 'do nothing special', there
may be a better name, but I'm not very good at naming things. (any suggestions?)


Thanks,

James
