Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0B83A8632
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhFOQSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:18:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:39896 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhFOQSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:18:33 -0400
IronPort-SDR: gg/nElMzdfw2o3fbc2MxXQbST+UeErYqi9jXrxBXwct+fOTh7dT3iyl4WIh8dZW86152PAEmdX
 OGnstrWTjFdw==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206058713"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="206058713"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 09:16:28 -0700
IronPort-SDR: fsyKbGifdqE0wpviHHTveo7Gkd1sZqSj30rjA3TOvQb8EI2szo5NpvyJZ2Yb5q/KAv2KTCKLSY
 +I6rW0EGfm0Q==
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="554497724"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.184.247]) ([10.212.184.247])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 09:16:26 -0700
Subject: Re: [PATCH v4 00/24] x86/resctrl: Merge the CDP resources
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, "Luck, Tony" <tony.luck@intel.com>
References: <20210614200941.12383-1-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <cc452592-491f-3ddf-983a-8669ad12df9a@intel.com>
Date:   Tue, 15 Jun 2021 09:16:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614200941.12383-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 6/14/2021 1:09 PM, James Morse wrote:
> This series re-folds the resctrl code so the CDP resources (L3CODE et al)
> behaviour is all contained in the filesystem parts, with a minimum amount
> of arch specific code.
> 
> Arm have some CPU support for dividing caches into portions, and
> applying bandwidth limits at various points in the SoC. The collective term
> for these features is MPAM: Memory Partitioning and Monitoring.
> 
> MPAM is similar enough to Intel RDT, that it should use the defacto linux
> interface: resctrl. This filesystem currently lives under arch/x86, and is
> tightly coupled to the architecture.
> Ultimately, my plan is to split the existing resctrl code up to have an
> arch<->fs abstraction, then move all the bits out to fs/resctrl. From there
> MPAM can be wired up.
> 
> x86 might have two resources with cache controls, (L2 and L3) but has
> extra copies for CDP: L{2,3}{CODE,DATA}, which are marked as enabled
> if CDP is enabled for the corresponding cache.
> 
> MPAM has an equivalent feature to CDP, but its a property of the CPU,
> not the cache. Resctrl needs to have x86's odd/even behaviour, as that
> its the ABI, but this isn't how the MPAM hardware works. It is entirely
> possible that an in-kernel user of MPAM would not be using CDP, whereas
> resctrl is.
> 
> Pretending L3CODE and L3DATA are entirely separate resources is a neat
> trick, but doing this is specific to x86.
> Doing this leaves the arch code in control of various parts of the
> filesystem ABI: the resources names, and the way the schemata are parsed.
> Allowing this stuff to vary between architectures is bad for user space.
> 
> This series collapses the CODE/DATA resources, moving all the user-visible
> resctrl ABI into what becomes the filesystem code. CDP becomes the type of
> configuration being applied to a cache. This is done by adding a
> struct resctrl_schema to the parts of resctrl that will move to fs. This
> holds the arch-code resource that is in use for this schema, along with
> other properties like the name, and whether the configuration being applied
> is CODE/DATA/BOTH.
> 
> This lets us fold the extra resources out of the arch code so that they
> don't need to be duplicated if the equivalent feature to CDP is missing, or
> implemented in a different way.
> 
> 
> The first two patches split the resource and domain structs to have an
> arch specific 'hw' portion, and the rest that is visible to resctrl.
> Future series massage the resctrl code so there are no accesses to 'hw'
> structures in the parts of resctrl that will move to fs, providing helpers
> where necessary.
> 
> This series adds temporary scaffolding, which it removes a few patches
> later. This is to allow things like the ctrlval arrays and resources to be
> merged separately, which should make is easier to bisect. These things
> are marked temporary, and should all be gone by the end of the series.
> 
> This series is a little rough around the monitors, would a fake
> struct resctrl_schema for the monitors simplify things, or be a source
> of bugs?
> 
> This series is based on v5.12-rc6, and can be retrieved from:
> git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_merge_cdp/v4
> 
> v3: https://lore.kernel.org/lkml/20210519162424.27654-1-james.morse@arm.com/
> v2: https://lore.kernel.org/lkml/20210312175849.8327-1-james.morse@arm.com/
> v1: https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/
> 
> Parts were previously posted as an RFC here:
> https://lore.kernel.org/lkml/20200214182947.39194-1-james.morse@arm.com/
> 

For the most part I think this series looks good. The one thing I am 
concerned about is the resctrl user interface change. On a system that 
supports L3 CDP there is a visible change when CDP is not enabled:

Before this series:
# cat schemata
     L3:0=fffff;1=fffff

After this series:
# cat schemata
L3:0=fffff;1=fffff

There are a few user space tools that parse the resctrl schemata file 
and it may be easier to keep the interface consistent than to find and 
audit them all to ensure they will keep working.

Apart from that, I do think that the dmesg change that Babu pointed out 
deserves a mention in the cover letter. I agree with your response in 
this regard but this is indeed a user visible change and if anybody has 
issue with that then mentioning it in the cover letter will hopefully 
catch it sooner.

A heads-up is that there are some kernel-doc fixups in the works that 
will conflict with your series. You yourself fix at least one of these 
kernel-doc issues in this series - the description of mbm_width in the 
first patch. I will ask the submitter of the kernel-doc fixups to use 
your text to help with the merging.

Finally, I did catch a few typos that I will respond to individually.

Thank you very much James

Reinette













