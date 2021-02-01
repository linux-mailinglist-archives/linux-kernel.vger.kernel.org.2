Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBDC30B39E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 00:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhBAXei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:34:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBAXef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:34:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5DA564D90;
        Mon,  1 Feb 2021 23:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612222435;
        bh=IPcG23HxLRgvFstqvEFHiosYl3MWryDjBRJYYpKzO2Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ca/ruHFPXeRYJjJEHJZHSmK0v9XNR8c3pSbUAJN8BwFLo7ITTnwLCzWI8YASvX7Q1
         l8mJndST3G86imADhoeSfUp3Ouvo7sePbOQgo/ZAPHsjMee8BhrlV8cGkrUd3MZIIm
         hhfIOUjfUMhIKtO+1zgXfiV6GFd3DJ2OfoGt9oFY=
Date:   Mon, 1 Feb 2021 15:33:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: simplify the VM_BUG_ON condition in
 pmdp_huge_clear_flush()
Message-Id: <20210201153354.e640247cb5ab306e909322d0@linux-foundation.org>
In-Reply-To: <20210201114319.34720-1-linmiaohe@huawei.com>
References: <20210201114319.34720-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 06:43:19 -0500 Miaohe Lin <linmiaohe@huawei.com> wrote:

> The condition (A && !C && !D) || !A is equivalent to !A || (A && !C && !D)
> and can be further simplified to !A || (!C && !D).
> 
> ..
>
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -135,8 +135,8 @@ pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
>  {
>  	pmd_t pmd;
>  	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> -	VM_BUG_ON((pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
> -			   !pmd_devmap(*pmdp)) || !pmd_present(*pmdp));
> +	VM_BUG_ON(!pmd_present(*pmdp) || (!pmd_trans_huge(*pmdp) &&
> +					  !pmd_devmap(*pmdp)));
>  	pmd = pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
>  	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>  	return pmd;

True, and the resulting code is still readable enough.

But a problem with such a complex expression is that the developer will
have trouble figuring out why the BUG actually triggered.

If we had a VM_BUG_ON_PMD() then we could print the pmd's value and
permit diagnosis from that.  But we don't have such a thing.

So I suggest that it would be better to have

	VM_BUG_ON((pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
			   !pmd_devmap(*pmdp)));
	VM_BUG_ON(!pmd_present(*pmdp));

This way, the BUG()'s file-n-line output will tell us more about why the
kernel went splat.


I suppose maybe this could be optimized the same way, as

	VM_BUG_ON(!pmd_present(*pmdp));
	/* Below assumes pmd_present() is true */
	VM_BUG_ON(!pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));

Which works because VM_BUG_ON is, depending up Kconfig, either a no-op
or a noreturn-if-it-triggered.  I'm not sure if I like this trick much though.

