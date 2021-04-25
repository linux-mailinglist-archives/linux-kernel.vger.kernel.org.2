Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CD236A57A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 09:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhDYHUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 03:20:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhDYHUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 03:20:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34E5261154;
        Sun, 25 Apr 2021 07:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619335204;
        bh=t3uBLdKj3RwD8AUUCKgSTXuCvucTl9G7gRfYDcygyuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kDBJ9u5v83yTj0knDFg6TvMz5f6BIJsd5rsSHucko8FJYyP8hKzwbwbOeAb6OL6Gh
         xuMRIZMu2D7nophxm+LihrlmsW4f48MmVnU5drdb6ipiRoj2CfzFMY4bqVjRwTx+6+
         9B8S/FvKzlV2QmLlv6vwkSb85kMbbQAUg5Ws0vHGlUxYCuu41Y/R1qdnE8VMWYARiB
         eU/aJN90HOkPrlG+urZD6/bIOwPewBRhGwTRmrMmDhrq3YSFL8yzn36gO4laglg+3R
         ZUY8d+WHppFIJYrchBcOIcGak8HLE6382dK4LN+EZDuaW37/HlFcQKcwQ8f7VWdTWT
         TrycNCi498ltA==
Date:   Sun, 25 Apr 2021 10:19:55 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: arm32: panic in move_freepages (Was [PATCH v2 0/4] arm64: drop
 pfn_valid_within() and simplify pfn_valid())
Message-ID: <YIUYG8N9T3/C/tSG@kernel.org>
References: <20210421065108.1987-1-rppt@kernel.org>
 <9aa68d26-d736-3b75-4828-f148964eb7f0@huawei.com>
 <YIEl8aKr8Ly0Zd3O@kernel.org>
 <33fa74c2-f32d-f224-eb30-acdb717179ff@huawei.com>
 <2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 04:11:16PM +0800, Kefeng Wang wrote:
> 
> I tested this patchset(plus arm32 change, like arm64 does) based on lts
> 5.10，add
> 
> some debug log, the useful info shows below, if we enable HOLES_IN_ZONE, no
> panic,
> 
> any idea, thanks.
 
Are there any changes on top of 5.10 except for pfn_valid() patch?
Do you see this panic on 5.10 without the changes?
Can you see stack backtrace beyond move_freepages_block?

> Zone ranges:
>   Normal   [mem 0x0000000080a00000-0x00000000b01fffff]
>   HighMem  [mem 0x00000000b0200000-0x00000000ffffefff]
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000080a00000-0x00000000855fffff]
>   node   0: [mem 0x0000000086a00000-0x0000000087dfffff]
>   node   0: [mem 0x000000008bd00000-0x000000008c4fffff]
>   node   0: [mem 0x000000008e300000-0x000000008ecfffff]
>   node   0: [mem 0x0000000090d00000-0x00000000bfffffff]
>   node   0: [mem 0x00000000cc000000-0x00000000dc9fffff]
>   node   0: [mem 0x00000000de700000-0x00000000de9fffff]
>   node   0: [mem 0x00000000e0800000-0x00000000e0bfffff]
>   node   0: [mem 0x00000000f4b00000-0x00000000f6ffffff]
>   node   0: [mem 0x00000000fda00000-0x00000000ffffefff]
> 
> ----> free_memmap, start_pfn = 85800,  85800000 end_pfn = 86a00, 86a00000
> ----> free_memmap, start_pfn = 8c800,  8c800000 end_pfn = 8e300, 8e300000
> ----> free_memmap, start_pfn = 8f000,  8f000000 end_pfn = 90000, 90000000
> ----> free_memmap, start_pfn = dcc00,  dcc00000 end_pfn = de700, de700000
> ----> free_memmap, start_pfn = dec00,  dec00000 end_pfn = e0000, e0000000
> ----> free_memmap, start_pfn = e0c00,  e0c00000 end_pfn = e4000, e4000000
> ----> free_memmap, start_pfn = f7000,  f7000000 end_pfn = f8000, f8000000
> === >move_freepages: start_pfn/end_pfn [de601, de7ff], [de600000, de7ff000]
> :  pfn =de600 pfn2phy = de600000 , page = ef3cc000, page-flags = ffffffff
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address fffffffe
> pgd = 5dd50df5
> [fffffffe] *pgd=affff861, *pte=00000000, *ppte=00000000
> Internal error: Oops: 37 [#1] SMP ARM
> Modules linked in: gmac(O)
> CPU: 2 PID: 635 Comm: test-oom Tainted: G           O      5.10.0+ #31
> Hardware name: Hisilicon A9
> PC is at move_freepages_block+0x150/0x278
> LR is at move_freepages_block+0x150/0x278
> pc : [<c02383a4>]    lr : [<c02383a4>]    psr: 200e0393
> sp : c4179cf8  ip : 00000000  fp : 00000001
> r10: c4179d58  r9 : 000de7ff  r8 : 00000000
> r7 : c0863280  r6 : 000de600  r5 : 000de600  r4 : ef3cc000
> r3 : ffffffff  r2 : 00000000  r1 : ef5d069c  r0 : fffffffe
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 1ac5387d  Table: 83b0c04a  DAC: 55555555
> Process test-oom (pid: 635, stack limit = 0x25d667df)
> 

-- 
Sincerely yours,
Mike.
