Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB851393527
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 19:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhE0Rw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 13:52:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhE0RwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 13:52:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91678613AB;
        Thu, 27 May 2021 17:50:50 +0000 (UTC)
Date:   Thu, 27 May 2021 18:50:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Arm64 crash while reading memory sysfs
Message-ID: <20210527175047.GK8661@arm.com>
References: <DM5PR0201MB355723819DDAC439273F68848E259@DM5PR0201MB3557.namprd02.prod.outlook.com>
 <YK3tQ0a0S/CLxyyb@linux.ibm.com>
 <CY4PR0201MB35539FF5EE729283C4241F5A8E249@CY4PR0201MB3553.namprd02.prod.outlook.com>
 <YK6EXNZHY1xt7Kjs@linux.ibm.com>
 <d55f915c-ad01-e729-1e29-b57d78257cbb@quicinc.com>
 <YK9e0LgDOfCFo6TM@linux.ibm.com>
 <ce5a5920-3046-21b5-42c0-2237ec1eef13@quicinc.com>
 <YK/HKMgajBCwpLt8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK/HKMgajBCwpLt8@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 07:22:00PM +0300, Mike Rapoport wrote:
> On Thu, May 27, 2021 at 10:33:13AM -0400, Qian Cai wrote:
> > On 5/27/2021 4:56 AM, Mike Rapoport wrote:
> > > Let's drop memblock=debug for now and add this instead:
> > 
> > [    0.000000][    T0] Booting Linux on physical CPU 0x0000000000 [0x503f0002]
> > [    0.000000][    T0] Linux version 5.13.0-rc3-next-20210526+ (root@admin5) (gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #31 SMP Thu May 27 12:32:40 UTC 2021
> > [    0.000000][    T0] Inode-cache hash table entries: 4194304 (order: 9, 33554432 bytes, linear)
> > [    0.000000][    T0] mem auto-init: stack:off, heap alloc:on, heap free:off
> > [    0.000000][    T0] MEMBLOCK configuration:
> > [    0.000000][    T0]  memory size = 0x0000001ff0000000 reserved size = 0x0000000421e33ae8
> > [    0.000000][    T0]  memory.cnt  = 0xc
> > [    0.000000][    T0] Memory: 777216K/133955584K available (17984K kernel code, 118722K rwdata, 4416K rodata, 6080K init, 67276K bss, 17379072K reserved, 0K cma-reserved)
> 
> I still cannot understand where most of the memory disappeared, but it
> seems entirely different issue.
>  
> > > Sorry, I've missed that the BUG is apparently triggered for pfn + i. Can
> > > you please try this instead:
> > 
> > [  259.216661][ T1417] test_pages_in_a_zone: pfn 8000 is not valid
> > [  259.226547][ T1417] page:00000000f4aa8c5c is uninitialized and poisoned
> > [  259.226560][ T1417] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> 
> Can you please try Anshuman's patch "arm64/mm: Drop HAVE_ARCH_PFN_VALID":
> 
> https://lore.kernel.org/lkml/1621947349-25421-1-git-send-email-anshuman.khandual@arm.com
> 
> It seems to me that the check for memblock_is_memory() in
> arm64::pfn_valid() is what makes init_unavailable_range() to bail out for
> section parts that are not actually populated and then we have
> VM_BUG_ON_PAGE(PagePoisoned(p)) for these pages.

I acked Anshuman's patch, I think they all need to go in together.

-- 
Catalin
