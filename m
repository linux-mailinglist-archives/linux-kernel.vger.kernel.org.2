Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DED410523
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 10:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237809AbhIRIef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 04:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbhIRIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 04:34:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D15C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 01:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qP8I4c5RZ5eqoGth3x9+VH7S8unuyvZuAzXJKL9Y7rE=; b=PC1L2AF3OuZHF6NdpfAkcKWOY4
        1ONr0nc57MJjuS9UfT8LfjCeacPITBWAlqYYk+6gTG2t8l1L2yyhh/m1+YG9j13HR6bqYed4QDc/D
        blc3f0keGJ2BaHgWFEq21hz1/26s90vg1IXtUEGXWexJkafGftA+uH8v0sW02YGPshwBv0JXoIRiI
        4lAaowECbvksSoS2oTedvgtVnvYlEI3HS8/EVygQYt9dUZPZj7TVc5GzR4qV2rgDzAFJhTPQ+bziP
        4T4xZDBlExVTl0Qa8vz4wjA0ZYswwd1GbOatWl2hGQ++chbVukJ3gX8dSPKrcutL2inC/6FYIeU7l
        NgUV/Yag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRVkn-000zzj-1u; Sat, 18 Sep 2021 08:31:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 91B0F986249; Sat, 18 Sep 2021 10:31:20 +0200 (CEST)
Date:   Sat, 18 Sep 2021 10:31:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     cgel.zte@gmail.com
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        jan.kiszka@siemens.com, jmoyer@redhat.com,
        dan.j.williams@intel.com, neilb@suse.de, yang.guang5@zte.com.cn,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Modify the check condition
Message-ID: <20210918083120.GM4323@worktop.programming.kicks-ass.net>
References: <20210918065232.239336-1-yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918065232.239336-1-yang.guang5@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 06:52:32AM +0000, cgel.zte@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> The vma may be NULL, and accessing the member of vma like "vma->vm_start"
> in calling follow_phys may occur segmentation fault.
> So it should check vma at beginning. If vma is null, it will return. And
> the if condition won't execute "vm->vm_flags".
> 
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> ---
>  arch/x86/mm/pat/memtype.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index 4ba2a3ee4bce..b7108b37b754 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -1089,7 +1089,7 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
>  	resource_size_t paddr;
>  	unsigned long prot;
>  
> -	if (vma && !(vma->vm_flags & VM_PAT))
> +	if (!(vma) || !(vma->vm_flags & VM_PAT))
>  		return;

Yet another braindead patch that shows you don't actually understand C.
