Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F383EB140
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbhHMHQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:16:35 -0400
Received: from foss.arm.com ([217.140.110.172]:50844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239268AbhHMHQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:16:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F8C81FB;
        Fri, 13 Aug 2021 00:16:08 -0700 (PDT)
Received: from [10.163.69.16] (unknown [10.163.69.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24C0D3F718;
        Fri, 13 Aug 2021 00:16:04 -0700 (PDT)
Subject: Re: [RFC V2 01/10] mm/mmap: Dynamically initialize protection_map[]
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com
References: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
 <1627281445-12445-2-git-send-email-anshuman.khandual@arm.com>
 <20210805170318.GB6719@arm.com>
 <d52e8af9-61af-45c2-837b-5a489e7e2916@arm.com>
Message-ID: <4bbe8b21-cc19-81ac-b53f-8e418a164e1b@arm.com>
Date:   Fri, 13 Aug 2021 12:46:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d52e8af9-61af-45c2-837b-5a489e7e2916@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/21 2:45 PM, Anshuman Khandual wrote:
> 
> 
> On 8/5/21 10:33 PM, Catalin Marinas wrote:
>> On Mon, Jul 26, 2021 at 12:07:16PM +0530, Anshuman Khandual wrote:
>>> The protection_map[] elements (__PXXX and __SXXX) might sometimes contain
>>> runtime variables in certain platforms like arm64 preventing a successful
>>> build because of the current static initialization. So it just defers the
>>> initialization until mmmap_init() via a new helper init_protection_map().
>>>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>  mm/mmap.c | 26 ++++++++++++++++++++++----
>>>  1 file changed, 22 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>> index ca54d36..a95b078 100644
>>> --- a/mm/mmap.c
>>> +++ b/mm/mmap.c
>>> @@ -100,10 +100,7 @@ static void unmap_region(struct mm_struct *mm,
>>>   *								w: (no) no
>>>   *								x: (yes) yes
>>>   */
>>> -pgprot_t protection_map[16] __ro_after_init = {
>>> -	__P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
>>> -	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
>>> -};
>>> +pgprot_t protection_map[16] __ro_after_init;
>>
>> Mips, x86, sparc, arm32, m68k all adjust protection_map[] during boot.
>> Could we do something similar here and avoid changing the generic code?
> 
> If __P[000..111] and __S[000..111] be made dummy values (e.g 0 or something
> standard prot temporarily), hence the compilation problem could be avoided.
> Later in the platform code, protection_map[] could be adjusted with actual
> prot values which would involve variable.
> 

Following change seems to work without any problem. Using __pgprot(0) as an
temporary protection value should be okay, as vm_get_page_prot() which uses
protection_map[] should never be called before mem_init() ?

 arch/arm64/include/asm/pgtable-prot.h | 34 +++++++++++++++++-----------------
 arch/arm64/mm/init.c                  | 22 ++++++++++++++++++++++
 2 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 7032f04..539503a 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -88,23 +88,23 @@ extern bool arm64_use_ng_mappings;
 #define PAGE_READONLY_EXEC	__pgprot(_PAGE_DEFAULT | PTE_USER | PTE_RDONLY | PTE_NG | PTE_PXN)
 #define PAGE_EXECONLY		__pgprot(_PAGE_DEFAULT | PTE_RDONLY | PTE_NG | PTE_PXN)
 
-#define __P000  PAGE_NONE
-#define __P001  PAGE_READONLY
-#define __P010  PAGE_READONLY
-#define __P011  PAGE_READONLY
-#define __P100  PAGE_EXECONLY
-#define __P101  PAGE_READONLY_EXEC
-#define __P110  PAGE_READONLY_EXEC
-#define __P111  PAGE_READONLY_EXEC
-
-#define __S000  PAGE_NONE
-#define __S001  PAGE_READONLY
-#define __S010  PAGE_SHARED
-#define __S011  PAGE_SHARED
-#define __S100  PAGE_EXECONLY
-#define __S101  PAGE_READONLY_EXEC
-#define __S110  PAGE_SHARED_EXEC
-#define __S111  PAGE_SHARED_EXEC
+#define __P000  __pgprot(0)
+#define __P001  __pgprot(0)
+#define __P010  __pgprot(0)
+#define __P011  __pgprot(0)
+#define __P100  __pgprot(0)
+#define __P101  __pgprot(0)
+#define __P110  __pgprot(0)
+#define __P111  __pgprot(0)
+
+#define __S000  __pgprot(0)
+#define __S001  __pgprot(0)
+#define __S010  __pgprot(0)
+#define __S011  __pgprot(0)
+#define __S100  __pgprot(0)
+#define __S101  __pgprot(0)
+#define __S110  __pgprot(0)
+#define __S111  __pgprot(0)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 8490ed2..51662b3 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -448,6 +448,27 @@ void __init bootmem_init(void)
 	memblock_dump_all();
 }
 
+static void init_protection_map(void)
+{
+	protection_map[0] = PAGE_NONE;
+	protection_map[1] = PAGE_READONLY;
+	protection_map[2] = PAGE_READONLY;
+	protection_map[3] = PAGE_READONLY;
+	protection_map[4] = PAGE_READONLY;
+	protection_map[5] = PAGE_READONLY_EXEC;
+	protection_map[6] = PAGE_READONLY_EXEC;
+	protection_map[7] = PAGE_READONLY_EXEC;
+
+	protection_map[8] = PAGE_NONE;
+	protection_map[9] = PAGE_READONLY;
+	protection_map[10] = PAGE_SHARED;
+	protection_map[11] = PAGE_SHARED;
+	protection_map[12] = PAGE_EXECONLY;
+	protection_map[13] = PAGE_READONLY_EXEC;
+	protection_map[14] = PAGE_SHARED_EXEC;
+	protection_map[15] = PAGE_SHARED_EXEC;
+}
+
 /*
  * mem_init() marks the free areas in the mem_map and tells us how much memory
  * is free.  This is done after various parts of the system have claimed their
@@ -489,6 +510,7 @@ void __init mem_init(void)
 		 */
 		sysctl_overcommit_memory = OVERCOMMIT_ALWAYS;
 	}
+	init_protection_map();
 }
 
 void free_initmem(void)
-- 
2.7.4


