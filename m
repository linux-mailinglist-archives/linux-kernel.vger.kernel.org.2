Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E8C393470
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 19:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbhE0RCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 13:02:03 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:21538 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhE0RB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 13:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1622134824; x=1653670824;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=HiNVqjxm3qys3CVLirQSiLg09ThgTKZt+rV3bnxp1dc=;
  b=jz9CVWHucnm2Xv8OfvCyG83DL/+1Rs1Pme4iOK384Bj5GUJmXwglFwyi
   JkWeKb5I/L4AXZCXIePoLp9gWh0VdjDIyUREBqjPfVMIznzntd6oQlGkM
   iRrqkxQXxeVmWKuzky8qRfWd+1OsaHkIwjk9iea5yDMaQ6IikcA02bzP4
   g=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 27 May 2021 10:00:24 -0700
X-QCInternal: smtphost
Received: from nalasexr03e.na.qualcomm.com ([10.49.195.114])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 May 2021 10:00:22 -0700
Received: from [10.111.161.43] (10.80.80.8) by nalasexr03e.na.qualcomm.com
 (10.49.195.114) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 27 May
 2021 10:00:21 -0700
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
 <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
 <YK9e0LgDOfCFo6TM@linux.ibm.com>
 <ce5a5920-3046-21b5-42c0-2237ec1eef13@quicinc.com>
 <YK/HKMgajBCwpLt8@linux.ibm.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <f388f2b1-1ea4-f882-d07e-6b641fd63895@quicinc.com>
Date:   Thu, 27 May 2021 13:00:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YK/HKMgajBCwpLt8@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03g.na.qualcomm.com (10.85.0.49) To
 nalasexr03e.na.qualcomm.com (10.49.195.114)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/2021 12:22 PM, Mike Rapoport wrote:
> On Thu, May 27, 2021 at 10:33:13AM -0400, Qian Cai wrote:
>>
>>
>> On 5/27/2021 4:56 AM, Mike Rapoport wrote:
>>> Let's drop memblock=debug for now and add this instead:
>>
>> [    0.000000][    T0] Booting Linux on physical CPU 0x0000000000 [0x503f0002]
>> [    0.000000][    T0] Linux version 5.13.0-rc3-next-20210526+ (root@admin5) (gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #31 SMP Thu May 27 12:32:40 UTC 2021
>> [    0.000000][    T0] Inode-cache hash table entries: 4194304 (order: 9, 33554432 bytes, linear)
>> [    0.000000][    T0] mem auto-init: stack:off, heap alloc:on, heap free:off
>> [    0.000000][    T0] MEMBLOCK configuration:
>> [    0.000000][    T0]  memory size = 0x0000001ff0000000 reserved size = 0x0000000421e33ae8
>> [    0.000000][    T0]  memory.cnt  = 0xc
>> [    0.000000][    T0] Memory: 777216K/133955584K available (17984K kernel code, 118722K rwdata, 4416K rodata, 6080K init, 67276K bss, 17379072K reserved, 0K cma-reserved)
> 
> I still cannot understand where most of the memory disappeared, but it
> seems entirely different issue.

Interesting, it seems those memory did come back after booting.

# cat /proc/meminfo
MemTotal:       116656448 kB
MemFree:        110464000 kB
MemAvailable:   101919872 kB
Buffers:           16320 kB
Cached:           118912 kB
SwapCached:         3136 kB
Active:            63360 kB
Inactive:         199936 kB
Active(anon):       9792 kB
Inactive(anon):   132480 kB
Active(file):      53568 kB
Inactive(file):    67456 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:       8388544 kB
SwapFree:        8344704 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:        125056 kB
Mapped:            44992 kB
Shmem:             14784 kB
KReclaimable:      92160 kB
Slab:            4943424 kB
SReclaimable:      92160 kB
SUnreclaim:      4851264 kB
KernelStack:       24832 kB
PageTables:        10240 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    66716736 kB
Committed_AS:     708096 kB
VmallocTotal:   133143461888 kB
VmallocUsed:       49600 kB
VmallocChunk:          0 kB
Percpu:            45056 kB
HardwareCorrupted:     0 kB
AnonHugePages:         0 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
FileHugePages:         0 kB
FilePmdMapped:         0 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:     524288 kB
Hugetlb:               0 kB

>  
>>> Sorry, I've missed that the BUG is apparently triggered for pfn + i. Can
>>> you please try this instead:
>>
>> [  259.216661][ T1417] test_pages_in_a_zone: pfn 8000 is not valid
>> [  259.226547][ T1417] page:00000000f4aa8c5c is uninitialized and poisoned
>> [  259.226560][ T1417] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> 
> Can you please try Anshuman's patch "arm64/mm: Drop HAVE_ARCH_PFN_VALID":
> 
> https://lore.kernel.org/lkml/1621947349-25421-1-git-send-email-anshuman.khandual@arm.com
> 
> It seems to me that the check for memblock_is_memory() in
> arm64::pfn_valid() is what makes init_unavailable_range() to bail out for
> section parts that are not actually populated and then we have
> VM_BUG_ON_PAGE(PagePoisoned(p)) for these pages.

That patch fixed it.
