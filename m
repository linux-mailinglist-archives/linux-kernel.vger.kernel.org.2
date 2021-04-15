Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C34C361426
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbhDOVd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:33:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:9219 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235046AbhDOVd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:33:57 -0400
IronPort-SDR: CAQmwJ9l9od4j848d73jT8k24CPJ3CQjfLPGGQR+e/fNHz051Id/MYMoZiltsXEsUjqqySA1qG
 /EUwby9HavVA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="195059079"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="195059079"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 14:33:25 -0700
IronPort-SDR: vbkqct+ThHQF29cjfBjx+eeaifoIHO1mkrDzJ7PG7h1N4TXKj8NdjOkBcRjx/1MYVYjMsaRUOd
 5vdngfQRot/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="425343356"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 15 Apr 2021 14:33:25 -0700
Received: from [10.212.132.71] (kliang2-MOBL.ccr.corp.intel.com [10.212.132.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 762C058088F;
        Thu, 15 Apr 2021 14:33:23 -0700 (PDT)
Subject: Re: [PATCH] perf/x86/intel/uncore: Avoid null dereferences
 (uncore_extra_pci_dev)
From:   "Liang, Kan" <kan.liang@linux.intel.com>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20210415203720.334007-1-steve.wahl@hpe.com>
 <f3789c72-4805-8636-1bcb-38c2a1ec69ea@linux.intel.com>
Message-ID: <f42d70d5-b779-a780-f178-050b855a15d8@linux.intel.com>
Date:   Thu, 15 Apr 2021 17:33:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <f3789c72-4805-8636-1bcb-38c2a1ec69ea@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/2021 5:19 PM, Liang, Kan wrote:
> Hi Steve,
> 
> On 4/15/2021 4:37 PM, Steve Wahl wrote:
>> If an uncore has no pci_init routine, or that routine fails,
>> uncore_pci_init is not called, and memory is not allocated for
>> uncore_extra_pci_dev.
>>
>> So check to make sure uncore_extra_pci_dev is not NULL before use.
>>
> 
> I think more after yesterday's discussion. There may be a better 
> solution than this.
> 
> Actually, we don't have to probe all the PCU devices and stores them 
> into the uncore_extra_pci_dev for the cpu_init().
> We just need to pick up the first PCU device and check the existence of 
> the SBOX once.
> 
> I will send out a patch shortly.

Here is the patch I mentioned.

https://lore.kernel.org/lkml/1618521764-100923-1-git-send-email-kan.liang@linux.intel.com

Thanks,
Kan

> 
>> And fix the case that led us to discover the null derefs; don't fail
>> snbep_pci2phy_map_init if BIOS doesn't supply pcibus_to_node
>> information.
>>
>> Fixes: 9a7832ce3d92 ("perf/x86/intel/uncore: With > 8 nodes, get pci 
>> bus die id from NUMA info")
> 
> In theory, the pci_read_config_dword() may fails as well. It has 
> possible that the issue can still be observed before the "> 8 nodes" patch.
> 
> I think the fixes should be 5306c31c5733 ("perf/x86/uncore/hsw-ep: 
> Handle systems with only two SBOXes")
> 
> Thanks,
> Kan
> 
>> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
>> ---
>>   arch/x86/events/intel/uncore_snbep.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore_snbep.c 
>> b/arch/x86/events/intel/uncore_snbep.c
>> index b79951d0707c..14c24356a2fa 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -1373,11 +1373,11 @@ static int snbep_pci2phy_map_init(int devid, 
>> int nodeid_loc, int idmap_loc, bool
>>           /*
>>            * The nodeid and idmap registers only contain enough
>>            * information to handle 8 nodes.  On systems with more
>> -         * than 8 nodes, we need to rely on NUMA information,
>> +         * than 8 nodes, if available we rely on NUMA information,
>>            * filled in from BIOS supplied information, to determine
>>            * the topology.
>>            */
>> -        if (nr_node_ids <= 8) {
>> +        if ((nr_node_ids <= 8) || (pcibus_to_node(ubox_dev->bus) == 
>> -1)) {
>>               /* get the Node ID of the local register */
>>               err = pci_read_config_dword(ubox_dev, nodeid_loc, &config);
>>               if (err)
>> @@ -2865,7 +2865,9 @@ void hswep_uncore_cpu_init(void)
>>           hswep_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
>>       /* Detect 6-8 core systems with only two SBOXes */
>> -    if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
>> +    if (!uncore_extra_pci_dev)
>> +        hswep_uncore_sbox.num_boxes = 2;
>> +    else if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
>>           u32 capid4;
>>           
>> pci_read_config_dword(uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3],
>> @@ -3243,6 +3245,8 @@ void bdx_uncore_cpu_init(void)
>>       if (boot_cpu_data.x86_model == 86) {
>>           uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
>>       /* Detect systems with no SBOXes */
>> +    } else if (!uncore_extra_pci_dev) {
>> +        bdx_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
>>       } else if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
>>           struct pci_dev *pdev;
>>           u32 capid4;
>>
