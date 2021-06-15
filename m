Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA93A3A7CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFOLM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:12:29 -0400
Received: from foss.arm.com ([217.140.110.172]:60988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhFOLMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:12:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCD171063;
        Tue, 15 Jun 2021 04:10:20 -0700 (PDT)
Received: from [10.163.86.116] (unknown [10.163.86.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 890503F719;
        Tue, 15 Jun 2021 04:10:18 -0700 (PDT)
Subject: Re: [PATCH] arm64: mm: Pass origial fault address to
 handle_mm_fault()
To:     Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, shan.gavin@gmail.com
References: <20210614122701.100515-1-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9f1c6198-a367-e3dd-f0c6-9cad7c267e39@arm.com>
Date:   Tue, 15 Jun 2021 16:41:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210614122701.100515-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/21 5:57 PM, Gavin Shan wrote:
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
>  }
>  
>  static bool is_el0_instruction_abort(unsigned int esr)
> 

FWIW

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
