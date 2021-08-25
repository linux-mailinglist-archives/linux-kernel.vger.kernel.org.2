Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297F83F7BED
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 20:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242352AbhHYSAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 14:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234684AbhHYSAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 14:00:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F4EF60F35;
        Wed, 25 Aug 2021 17:59:56 +0000 (UTC)
Date:   Wed, 25 Aug 2021 18:59:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     will@kernel.org, ryabinin.a.a@gmail.com, andreyknvl@gmail.com,
        dvyukov@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, elver@google.com
Subject: Re: [PATCH v3 1/3] vmalloc: Choose a better start address in
 vm_area_register_early()
Message-ID: <20210825175953.GI3420@arm.com>
References: <20210809093750.131091-1-wangkefeng.wang@huawei.com>
 <20210809093750.131091-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809093750.131091-2-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 05:37:48PM +0800, Kefeng Wang wrote:
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d5cd52805149..1e8fe08725b8 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2238,11 +2238,17 @@ void __init vm_area_add_early(struct vm_struct *vm)
>   */
>  void __init vm_area_register_early(struct vm_struct *vm, size_t align)
>  {
> -	static size_t vm_init_off __initdata;
> -	unsigned long addr;
> -
> -	addr = ALIGN(VMALLOC_START + vm_init_off, align);
> -	vm_init_off = PFN_ALIGN(addr + vm->size) - VMALLOC_START;
> +	struct vm_struct *head = vmlist, *curr, *next;
> +	unsigned long addr = ALIGN(VMALLOC_START, align);
> +
> +	while (head != NULL) {

Nitpick: I'd use the same pattern as in vm_area_add_early(), i.e. a
'for' loop. You might as well insert it directly than calling the add
function and going through the loop again. Not a strong preference
either way.

> +		next = head->next;
> +		curr = head;
> +		head = next;
> +		addr = ALIGN((unsigned long)curr->addr + curr->size, align);
> +		if (next && (unsigned long)next->addr - addr > vm->size)

Is greater or equal sufficient?

> +			break;
> +	}
>  
>  	vm->addr = (void *)addr;

Another nitpick: it's very unlikely on a 64-bit architecture but not
impossible on 32-bit to hit VMALLOC_END here. Maybe some BUG_ON.

-- 
Catalin
