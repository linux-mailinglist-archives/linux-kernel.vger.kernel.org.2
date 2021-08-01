Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB3E3DCC47
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 17:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhHAPXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 11:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231940AbhHAPXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 11:23:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 666C560243;
        Sun,  1 Aug 2021 15:23:15 +0000 (UTC)
Date:   Sun, 1 Aug 2021 08:23:12 -0700
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] vmalloc: Choose a better start address in
 vm_area_register_early()
Message-ID: <20210801152311.GB28489@arm.com>
References: <20210720025105.103680-1-wangkefeng.wang@huawei.com>
 <20210720025105.103680-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720025105.103680-2-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 10:51:03AM +0800, Kefeng Wang wrote:
> There are some fixed locations in the vmalloc area be reserved
> in ARM(see iotable_init()) and ARM64(see map_kernel()), but for
> pcpu_page_first_chunk(), it calls vm_area_register_early() and
> choose VMALLOC_START as the start address of vmap area which
> could be conflicted with above address, then could trigger a
> BUG_ON in vm_area_add_early().
> 
> Let's choose the end of existing address range in vmlist as the
> start address instead of VMALLOC_START to avoid the BUG_ON.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/vmalloc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d5cd52805149..a98cf97f032f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2238,12 +2238,14 @@ void __init vm_area_add_early(struct vm_struct *vm)
>   */
>  void __init vm_area_register_early(struct vm_struct *vm, size_t align)
>  {
> -	static size_t vm_init_off __initdata;
> +	unsigned long vm_start = VMALLOC_START;
> +	struct vm_struct *tmp;
>  	unsigned long addr;
>  
> -	addr = ALIGN(VMALLOC_START + vm_init_off, align);
> -	vm_init_off = PFN_ALIGN(addr + vm->size) - VMALLOC_START;
> +	for (tmp = vmlist; tmp; tmp = tmp->next)
> +		vm_start = (unsigned long)tmp->addr + tmp->size;
>  
> +	addr = ALIGN(vm_start, align);
>  	vm->addr = (void *)addr;
>  
>  	vm_area_add_early(vm);

Is there a risk of breaking other architectures? It doesn't look like to
me but I thought I'd ask.

Also, instead of always picking the end, could we search for a range
that fits?

-- 
Catalin
