Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C3542ABBA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhJLSTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231586AbhJLSTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:19:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A93560462;
        Tue, 12 Oct 2021 18:17:15 +0000 (UTC)
Date:   Tue, 12 Oct 2021 19:17:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     will@kernel.org, ryabinin.a.a@gmail.com, andreyknvl@gmail.com,
        dvyukov@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, elver@google.com,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 3/3] kasan: arm64: Fix pcpu_page_first_chunk crash
 with KASAN_VMALLOC
Message-ID: <YWXRKFrGSkgLXNvt@arm.com>
References: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
 <20210910053354.26721-4-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910053354.26721-4-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 01:33:54PM +0800, Kefeng Wang wrote:
> With KASAN_VMALLOC and NEED_PER_CPU_PAGE_FIRST_CHUNK, it crashs,
> 
> Unable to handle kernel paging request at virtual address ffff7000028f2000
> ...
> swapper pgtable: 64k pages, 48-bit VAs, pgdp=0000000042440000
> [ffff7000028f2000] pgd=000000063e7c0003, p4d=000000063e7c0003, pud=000000063e7c0003, pmd=000000063e7b0003, pte=0000000000000000
> Internal error: Oops: 96000007 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.13.0-rc4-00003-gc6e6e28f3f30-dirty #62
> Hardware name: linux,dummy-virt (DT)
> pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO BTYPE=--)
> pc : kasan_check_range+0x90/0x1a0
> lr : memcpy+0x88/0xf4
> sp : ffff80001378fe20
> ...
> Call trace:
>  kasan_check_range+0x90/0x1a0
>  pcpu_page_first_chunk+0x3f0/0x568
>  setup_per_cpu_areas+0xb8/0x184
>  start_kernel+0x8c/0x328
> 
> The vm area used in vm_area_register_early() has no kasan shadow memory,
> Let's add a new kasan_populate_early_vm_area_shadow() function to populate
> the vm area shadow memory to fix the issue.
> 
> Acked-by: Marco Elver <elver@google.com> (for KASAN parts)
> Acked-by: Andrey Konovalov <andreyknvl@gmail.com> (for KASAN parts)
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

It looks like I only acked patch 2 previously, so here it is:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
