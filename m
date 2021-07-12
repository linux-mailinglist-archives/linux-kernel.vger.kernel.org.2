Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E933C42BB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 06:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhGLEQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 00:16:49 -0400
Received: from foss.arm.com ([217.140.110.172]:44888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhGLEQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:16:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7661C6D;
        Sun, 11 Jul 2021 21:14:00 -0700 (PDT)
Received: from [10.163.65.188] (unknown [10.163.65.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 430903F766;
        Sun, 11 Jul 2021 21:13:58 -0700 (PDT)
Subject: Re: [PATCH 00/12] mm/debug_vm_pgtable: Enhancements
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, shan.gavin@gmail.com,
        chuhu@redhat.com
References: <20210706061748.161258-1-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <42a26202-10f7-e744-3fc5-c9e5a7445193@arm.com>
Date:   Mon, 12 Jul 2021 09:44:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210706061748.161258-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gavin,

Though I have not jumped into the details for all individual
patches here but still have some high level questions below.

On 7/6/21 11:47 AM, Gavin Shan wrote:
> There are couple of issues with current implementations and this series
> tries to resolve the issues:
> 
>   (a) All needed information are scattered in variables, passed to various
>       test functions. The code is organized in pretty much relaxed fashion.
All these variables are first prepared in debug_vm_pgtable(), before
getting passed into respective individual test functions. Also these
test functions receive only the required number of variables not all.
Adding a structure that captures all test parameters at once before
passing them down will be unnecessary. I am still wondering what will
be the real benefit of this large code churn ?

> 
>   (b) The page isn't allocated from buddy during page table entry modifying
>       tests. The page can be invalid, conflicting to the implementations
>       of set_{pud, pmd, pte}_at() on ARM64. The target page is accessed
>       so that the iCache can be flushed when execution permission is given
>       on ARM64. Besides, the target page can be unmapped and access to
>       it causes kernel crash.

Using 'start_kernel' based method for struct page usage, enabled this
test to run on platforms which might not have enough memory required
for various individual test functions. This method is not a problem for
tests that just need an aligned pfn (which creates a page table entry)
not a real struct page.

But not allocating and owning the struct page might be problematic for
tests that expect a real struct page and transform its state via set_
{pud, pmd, pte}_at() functions as reported here.

> 
> "struct vm_pgtable_debug" is introduced to address issue (a). For issue
> (b), the used page is allocated from buddy in page table entry modifying
> tests. The corresponding tets will be skipped if we fail to allocate the
> (huge) page. For other test cases, the original page around to kernel
> symbol (@start_kernel) is still used.

For all basic pfn requiring tests, existing 'start_kernel' based method
should continue but allocate a struct page for other tests which change
the passed struct page. Skipping the tests when allocation fails is the
right thing to do.

- Anshuman
