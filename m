Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CE53EA352
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 13:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbhHLLLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 07:11:41 -0400
Received: from foss.arm.com ([217.140.110.172]:41956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236478AbhHLLLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:11:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A24BE1042;
        Thu, 12 Aug 2021 04:11:08 -0700 (PDT)
Received: from [10.163.68.17] (unknown [10.163.68.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0EAC3F718;
        Thu, 12 Aug 2021 04:11:04 -0700 (PDT)
Subject: Re: [PATCH v6 00/12] mm/debug_vm_pgtable: Enhancements
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org,
        Vineet Gupta <vgupta@kernel.org>
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        vgupta@synopsys.com, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210809092631.1888748-1-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b066aea5-6b3e-193a-01d0-32b52d5ac513@arm.com>
Date:   Thu, 12 Aug 2021 16:41:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210809092631.1888748-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/21 2:56 PM, Gavin Shan wrote:
> There are couple of issues with current implementations and this series
> tries to resolve the issues:
> 
>   (a) All needed information are scattered in variables, passed to various
>       test functions. The code is organized in pretty much relaxed fashion.
> 
>   (b) The page isn't allocated from buddy during page table entry modifying
>       tests. The page can be invalid, conflicting to the implementations
>       of set_xxx_at() on ARM64. The target page is accessed so that the
>       iCache can be flushed when execution permission is given on ARM64.
>       Besides, the target page can be unmapped and accessing to it causes
>       kernel crash.
> 
> "struct pgtable_debug_args" is introduced to address issue (a). For issue
> (b), the used page is allocated from buddy in page table entry modifying
> tests. The corresponding tets will be skipped if we fail to allocate the
> (huge) page. For other test cases, the original page around to kernel
> symbol (@start_kernel) is still used.
> 
> The patches are organized as below. PATCH[2-10] could be combined to one
> patch, but it will make the review harder:
> 
>   PATCH[1] introduces "struct pgtable_debug_args" as place holder of all
>            needed information. With it, the old and new implementation
>            can coexist.
>   PATCH[2-10] uses "struct pgtable_debug_args" in various test functions.
>   PATCH[11] removes the unused code for old implementation.
>   PATCH[12] fixes the issue of corrupted page flag for ARM64
> 
> Changelog
> =========
> v6:
>    * Populate saved page table entry pointers after
>      they're allocated in init_args()                        (Anshuman)
>    * Fix imbalanced preemption count issue by replacing
>      pte_alloc_mmap() with pte_alloc() in init_args()        (syzbot)

+ vgupta@kernel.org

Hello Gavin/Vineet,

This series still need to be tested on ARC ?

- Anshuman
