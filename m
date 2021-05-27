Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE7B3923A6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 02:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhE0ARx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 20:17:53 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:4892 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhE0ARw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 20:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1622074580; x=1653610580;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8E8ZWDUWszf5GOxk4bhQ0XlSq3qO59o/2wFl0z5D3hc=;
  b=KO229lYIkFrY3yByd7U3Q47P2PjzzqPsohLKvI8O64d1fvkP9v9gsoQS
   9UMH0HWC+tX96IcgsTZQc3NlGo6iKP4p4IeTLu51ZAevSU96oQ7Rt2iW7
   VD6MjBzdsPvVWo+OjuUFy91kFCo81BQGQYuIKm9enF/5Mr1krY0mfOsjc
   I=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 May 2021 17:16:19 -0700
X-QCInternal: smtphost
Received: from nalasexr03e.na.qualcomm.com ([10.49.195.114])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 May 2021 17:16:18 -0700
Received: from [10.111.175.248] (10.80.80.8) by nalasexr03e.na.qualcomm.com
 (10.49.195.114) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 26 May
 2021 17:16:16 -0700
Subject: Re: Arm64 crash while reading memory sysfs
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <YK3tQ0a0S/CLxyyb@linux.ibm.com>
 <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
 <YK6EXNZHY1xt7Kjs@linux.ibm.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
Date:   Wed, 26 May 2021 20:16:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YK6EXNZHY1xt7Kjs@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03c.na.qualcomm.com (10.85.0.106) To
 nalasexr03e.na.qualcomm.com (10.49.195.114)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/2021 1:24 PM, Mike Rapoport wrote:
> On Wed, May 26, 2021 at 12:09:14PM +0000, Qian Cai (QUIC) wrote:
>>>
>>> On Tue, May 25, 2021 at 03:25:59PM +0000, Qian Cai (QUIC) wrote:
>>>> Reverting the patchset "arm64: drop pfn_valid_within() and simplify pfn_valid()" [1] from today's linux-next fixed a crash while
>>> reading files under /sys/devices/system/memory.
> 
> Does the issue persist of you only revert the latest patch in the series?
> In next-20210525 it would be commit 
> 89fb47db72f2 ("arm64-drop-pfn_valid_within-and-simplify-pfn_valid-fix")
> and commit
> dfe215e9bac2 ("arm64: drop pfn_valid_within() and simplify pfn_valid()").

Reverting those two commits alone is enough to fix the issue.

> 
>>> Can you please send the beginning of the boot log, up to the
>>> 	 "Memory: xK/yK available ..."
>>> line?
>>
>> [    0.000000] NUMA: Failed to initialise from firmware
>> [    0.000000] NUMA: Faking a node at [mem 0x0000000090000000-0x0000009fffffffff]
>> [    0.000000] NUMA: NODE_DATA [mem 0x9ffefbabc0-0x9ffefbffff]
>> [    0.000000] Zone ranges:
>> [    0.000000]   Normal   [mem 0x0000000090000000-0x0000009fffffffff]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000090000000-0x0000000091ffffff]
>> [    0.000000]   node   0: [mem 0x0000000092000000-0x00000000928fffff]
>> [    0.000000]   node   0: [mem 0x0000000092900000-0x00000000fffbffff]
>> [    0.000000]   node   0: [mem 0x00000000fffc0000-0x00000000ffffffff]
>> [    0.000000]   node   0: [mem 0x0000000880000000-0x0000000fffffffff]
>> [    0.000000]   node   0: [mem 0x0000008800000000-0x0000009ff5aeffff]
>> [    0.000000]   node   0: [mem 0x0000009ff5af0000-0x0000009ff5b2ffff]
>> [    0.000000]   node   0: [mem 0x0000009ff5b30000-0x0000009ff5baffff]
>> [    0.000000]   node   0: [mem 0x0000009ff5bb0000-0x0000009ff7deffff]
>> [    0.000000]   node   0: [mem 0x0000009ff7df0000-0x0000009ff7e5ffff]
>> [    0.000000]   node   0: [mem 0x0000009ff7e60000-0x0000009ff7ffffff]
>> [    0.000000]   node   0: [mem 0x0000009ff8000000-0x0000009fffffffff]
>> [    0.000000] Initmem setup node 0 [mem 0x0000000090000000-0x0000009fffffffff]
>> [    0.000000] mem auto-init: stack:off, heap alloc:on, heap free:off
>> [    0.000000] Memory: 777216K/133955584K available (17920K kernel code, 118786K rwdata, 4416K rodata, 6080K init, 67276K bss, 17379072K reserved, 0K cma-reserved)
> 
> The available and reserved sizes look weird. Can you post the log with
> memblock=debug and mminit_loglevel=4 added to the kernel command line?

http://www.lsbug.org/tmp/dmesg.txt

>  
>>>> [1] https://lore.kernel.org/kvmarm/20210511100550.28178-1-rppt@kernel.org/
>>>>
>>>> [  247.669668][ T1443] kernel BUG at include/linux/mm.h:1383!
>>>> [  247.675987][ T1443] Internal error: Oops - BUG: 0 [#1] SMP
>>>> [  247.681472][ T1443] Modules linked in: loop processor efivarfs ip_tables x_tables ext4 mbcache jbd2 dm_mod igb i2c_algo_bit
>>> nvme mlx5_core i2c_core nvme_core firmware_class
>>>> [  247.696894][ T1443] CPU: 15 PID: 1443 Comm: ranbug Not tainted 5.13.0-rc3-next-20210524+ #11
>>>> [  247.705326][ T1443] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
>>>> [  247.713842][ T1443] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
>>>> [  247.720536][ T1443] pc : test_pages_in_a_zone+0x23c/0x300
>>>> [  247.725935][ T1443] lr : test_pages_in_a_zone+0x23c/0x300
> 
> Do we know what PFN triggers it? Can you please run with this patch:

Nothing useful showed up with this patch. Yes, I double-checked that the patch was applied.

> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 70620d0dd923..b9d1dd0dae5f 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1443,6 +1443,12 @@ struct zone *test_pages_in_a_zone(unsigned long start_pfn,
>  				i++;
>  			if (i == MAX_ORDER_NR_PAGES || pfn + i >= end_pfn)
>  				continue;
> +
> +			if (!pfn_valid(pfn))
> +				pr_info("%s: pfn %lx is not valid\n", __func__, pfn);
> +			else if (PagePoisoned(pfn_to_page(pfn)))
> +				dump_page(pfn_to_page(pfn), "");
> +
>  			/* Check if we got outside of the zone */
>  			if (zone && !zone_spans_pfn(zone, pfn + i))
>  				return NULL;
> 
> 
