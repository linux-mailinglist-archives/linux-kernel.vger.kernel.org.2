Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F223A6AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhFNPor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232776AbhFNPoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:44:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D2F761185;
        Mon, 14 Jun 2021 15:42:42 +0000 (UTC)
Date:   Mon, 14 Jun 2021 16:42:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com, shan.gavin@gmail.com
Subject: Re: [PATCH] arm64: mm: Pass origial fault address to
 handle_mm_fault()
Message-ID: <20210614154239.GF30667@arm.com>
References: <20210614122701.100515-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614122701.100515-1-gshan@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 08:27:01PM +0800, Gavin Shan wrote:
> Currently, the lower bits of fault address is cleared before it's
> passed to handle_mm_fault(). It's unnecessary since generic code
> does same thing since the commit 1a29d85eb0f19 ("mm: use vmf->address
> instead of of vmf->virtual_address").
> 
> This passes the original fault address to handle_mm_fault() in case
> the generic code needs to know the exact fault address.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 871c82ab0a30..e2883237216d 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -504,7 +504,7 @@ static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
>  	 */
>  	if (!(vma->vm_flags & vm_flags))
>  		return VM_FAULT_BADACCESS;
> -	return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags, regs);
> +	return handle_mm_fault(vma, addr, mm_flags, regs);

This seems to match most of the other architectures (arch/arm also masks
out the bottom bits). So:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
