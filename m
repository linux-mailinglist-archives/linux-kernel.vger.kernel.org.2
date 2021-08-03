Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1CA3DE6E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 08:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhHCGtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 02:49:49 -0400
Received: from foss.arm.com ([217.140.110.172]:43746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231386AbhHCGtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 02:49:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A939D6E;
        Mon,  2 Aug 2021 23:49:37 -0700 (PDT)
Received: from [10.163.67.68] (unknown [10.163.67.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 866F03F70D;
        Mon,  2 Aug 2021 23:49:33 -0700 (PDT)
Subject: Re: [PATCH v5 00/12] mm/debug_vm_pgtable: Enhancements
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@linux.ibm.com,
        aneesh.kumar@linux.ibm.com, christophe.leroy@csgroup.eu,
        cai@lca.pw, catalin.marinas@arm.com, will@kernel.org,
        vgupta@synopsys.com, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210802060419.1360913-1-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b1e180b7-5ead-5423-9724-aaed0b539497@arm.com>
Date:   Tue, 3 Aug 2021 12:20:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210802060419.1360913-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/21 11:34 AM, Gavin Shan wrote:
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
> v5:
>    * Pick r-bs from Anshuman and rebase to 5.14.rc4          (Gavin)
>    * Use args->start_p4dp to free p4d entries                (Anshuman)
>    * Introduce helper to allocate huge page in init_arg()    (Anshuman)
>    * Bail early if the allocated page doesn't exist in
>      swap_migration_tests() and correct the comments         (Anshuman)
>    * Add fixes tag to PATCH[v4 12/12]                        (Christophe)
>    * Address misc comments                                   (Anshuman)

Apart from the proposed changes discussed for the first patch [PATCH 1/12],
this series overall looks good now. It clears build tests on all supported
platforms. I was able to test this on arm64 and x86 platforms with various
functional config combinations. It would be still great if others can take
a look as well.

- Anshuman
