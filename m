Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED603D9E26
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 09:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbhG2HNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 03:13:40 -0400
Received: from foss.arm.com ([217.140.110.172]:41662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234079AbhG2HNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 03:13:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D8D96D;
        Thu, 29 Jul 2021 00:13:36 -0700 (PDT)
Received: from [10.163.65.237] (unknown [10.163.65.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92DF13F73D;
        Thu, 29 Jul 2021 00:13:32 -0700 (PDT)
Subject: Re: [PATCH v4 00/12] mm/debug_vm_pgtable: Enhancements
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, chuhu@redhat.com, shan.gavin@gmail.com
References: <20210727061401.592616-1-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8b969a2a-a883-3ce2-fac4-70ac2e3fd157@arm.com>
Date:   Thu, 29 Jul 2021 12:44:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210727061401.592616-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/21 11:43 AM, Gavin Shan wrote:
> There are couple of issues with current implementations and this series
> tries to resolve the issues:
> 
>   (a) All needed information are scattered in variables, passed to various
>       test functions. The code is organized in pretty much relaxed fashion.
> 
>   (b) The page isn't allocated from buddy during page table entry modifying
>       tests. The page can be invalid, conflicting to the implementations
>       of set_xxx_at() on ARM64. The target page is accessed so that the iCache
>       can be flushed when execution permission is given on ARM64. Besides,
>       the target page can be unmapped and access to it causes kernel crash.
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
> v4:
>    * Determine the page allocation method according to
>      MAX_ORDER                                                   (Anshuman)
>    * Move existing comments to init_args()                       (Anshuman)
>    * Code refactoring as suggested by Anshuman                   (Anshuman)
>    * Improved commit log and add comments for flush_dcache_page()
>      in PATCH[v4 12/12]                                          (Anshuman)
>    * Address misc comments                                       (Anshuman

This series builds ok on all supported platforms but should also be tested
on them as well i.e s390, ppc, arc and riscv. I was able to do some tests
on arm64 and x86 platforms.
