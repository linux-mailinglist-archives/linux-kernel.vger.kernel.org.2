Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DFE306868
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 01:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhA1AKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 19:10:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229682AbhA1AKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 19:10:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 151D764DBD;
        Thu, 28 Jan 2021 00:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1611792562;
        bh=GUNbpAFQoRcexAEW65OXiQTw8gUoU09C4H2pJGNY8w8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ejDKEIKjTrhulX74BMX2PUUpa2oAmG/+Kyp6rdJZ038ZUiiK3ANEhEVcwC80PP0zn
         8uqmlayZ+K0Zn6t6PT6IowaLLDtVfSeKns6UgF8MTSzYlZGzSyPN1f79nu4mslGBLz
         yhnxAHJvlbTunaa2wBE+H4M9ZQYu/mwqlw1Pb6RI=
Date:   Wed, 27 Jan 2021 16:09:21 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <mike.kravetz@oracle.com>, <shakeelb@google.com>,
        <hannes@cmpxchg.org>, <vbabka@suse.cz>, <walken@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/rmap: Fix potential pte_unmap on an not mapped pte
Message-Id: <20210127160921.989f01c83d6703148f6bc316@linux-foundation.org>
In-Reply-To: <20210127093349.39081-1-linmiaohe@huawei.com>
References: <20210127093349.39081-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 04:33:49 -0500 Miaohe Lin <linmiaohe@huawei.com> wrote:

> For PMD-mapped page (usually THP), pvmw->pte is NULL. For PTE-mapped THP,
> pvmw->pte is mapped. But for HugeTLB pages, pvmw->pte is not mapped and set
> to the relevant page table entry. So in page_vma_mapped_walk_done(), we may
> do pte_unmap() for HugeTLB pte which is not mapped. Fix this by checking
> pvmw->page against PageHuge before trying to do pte_unmap().
> 

What are the runtime consequences of this?  Is there a workload which
is known to trigger it?

IOW, how do we justify a -stable backport of this fix?

>
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -213,7 +213,8 @@ struct page_vma_mapped_walk {
>  
>  static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
>  {
> -	if (pvmw->pte)
> +	/* HugeTLB pte is set to the relevant page table entry without pte_mapped. */
> +	if (pvmw->pte && !PageHuge(pvmw->page))
>  		pte_unmap(pvmw->pte);
>  	if (pvmw->ptl)
>  		spin_unlock(pvmw->ptl);
> -- 
> 2.19.1
