Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E98E336D50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCKHwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:52:35 -0500
Received: from foss.arm.com ([217.140.110.172]:58626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhCKHwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:52:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C9801FB;
        Wed, 10 Mar 2021 23:52:19 -0800 (PST)
Received: from [10.163.66.3] (unknown [10.163.66.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9E2B3F70D;
        Wed, 10 Mar 2021 23:52:16 -0800 (PST)
Subject: Re: [RFC] mm: Enable generic pfn_valid() to handle early sections
 with memmap holes
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1615174073-10520-1-git-send-email-anshuman.khandual@arm.com>
 <YEXme5SI+GxsYli8@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <003d8a4b-9687-3e9a-c27b-908db280b44c@arm.com>
Date:   Thu, 11 Mar 2021 13:22:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YEXme5SI+GxsYli8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/21 2:25 PM, Mike Rapoport wrote:
> Hi Anshuman,
> 
> On Mon, Mar 08, 2021 at 08:57:53AM +0530, Anshuman Khandual wrote:
>> Platforms like arm and arm64 have redefined pfn_valid() because their early
>> memory sections might have contained memmap holes caused by memblock areas
>> tagged with MEMBLOCK_NOMAP, which should be skipped while validating a pfn
>> for struct page backing. This scenario could be captured with a new option
>> CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES and then generic pfn_valid() can be
>> improved to accommodate such platforms. This reduces overall code footprint
>> and also improves maintainability.
> 
> I wonder whether arm64 would still need to free parts of its memmap after

free_unused_memmap() is applicable when CONFIG_SPARSEMEM_VMEMMAP is not enabled.
I am not sure whether there still might be some platforms or boards which would
benefit from this. Hence lets just keep this unchanged for now.

> the section size was reduced. Maybe the pain of arm64::pfn_valid() is not
> worth the memory savings anymore?

arm64 pfn_valid() special case was primarily because of MEMBLOCK_NOMAP tagged
memory areas, which are reserved by the firmware.

> 
>> Commit 4f5b0c178996 ("arm, arm64: move free_unused_memmap() to generic mm")
>> had used CONFIG_HAVE_ARCH_PFN_VALID to gate free_unused_memmap(), which in
>> turn had expanded its scope to new platforms like arc and m68k. Rather lets
>> restrict back the scope for free_unused_memmap() to arm and arm64 platforms
>> using this new config option i.e CONFIG_HAVE_EARLY_SECTION_MEMMAP.
> 
> The whole point of 4f5b0c178996 was to let arc and m68k to free unused
> memory map with FLATMEM so they won't need DISCONTIGMEM or SPARSEMEM. So
> whatever implementation there will be for arm/arm64, please keep arc and
> m68k functionally intact.

Okay. Will protect free_unused_memmap() on HAVE_EARLY_SECTION_MEMMAP_HOLES
config as well.

diff --git a/mm/memblock.c b/mm/memblock.c
index d9fa2e62ab7a..11b624e94127 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1927,8 +1927,11 @@ static void __init free_unused_memmap(void)
        unsigned long start, end, prev_end = 0;
        int i;
 
-       if (!IS_ENABLED(CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES) ||
-           IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
+       if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
+               return;
+
+       if (!IS_ENABLED(CONFIG_HAVE_EARLY_SECTION_MEMMAP_HOLES) &&
+           !IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID))
                return;
