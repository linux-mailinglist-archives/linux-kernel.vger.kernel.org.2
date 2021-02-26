Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66B132652E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhBZQCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhBZQC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:02:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BEAC061786;
        Fri, 26 Feb 2021 08:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K+eqvkP8AJTMZD+lmlvgsFHKMBlDoaA3WKhboefhy+0=; b=gF1fSE3K6s1efQMQu0eJjUR6PV
        XRNovWxLRNzb/56kmzR67SWUfqlAiC/1M0OFuGrxuZAYN6YMQX927zF6lg7aRO+6QCS+AS4mPmuMD
        0n11lBCsrTs5Fszlhf+PsaaQSVA0hrheUXtB/HelGBomDgiTK21sl0mPHgrPyPyrSjqNtyEkZA2+j
        PjG4mNC1Kp16wof9FXPBGQHaJB4LMagg9RJTuIV7NMiE/NmHcMyqWWHTZ38XQz9tVNetd9qUNFHC9
        X6FXMaHoIExpPdIrTsNCFxj6jABcTF4NRDJNBwKNLgAa/+gMqszVDSErehvXUlsNJK4ujjqATqtao
        N2xvsrcg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFfYd-00CDEw-0B; Fri, 26 Feb 2021 16:01:35 +0000
Date:   Fri, 26 Feb 2021 16:01:34 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        bskeggs@redhat.com, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, jhubbard@nvidia.com,
        rcampbell@nvidia.com, jglisse@redhat.com, jgg@nvidia.com,
        hch@infradead.org, daniel@ffwll.ch
Subject: Re: [PATCH v3 3/8] mm/rmap: Split try_to_munlock from try_to_unmap
Message-ID: <20210226160134.GC2907711@infradead.org>
References: <20210226071832.31547-1-apopple@nvidia.com>
 <20210226071832.31547-4-apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226071832.31547-4-apopple@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	while (page_vma_mapped_walk(&pvmw)) {
> +		/*
> +		 * If the page is mlock()d, we cannot swap it out.
> +		 * If it's recently referenced (perhaps page_referenced
> +		 * skipped over this mm) then we should reactivate it.
> +		 */
> +		if (vma->vm_flags & VM_LOCKED) {
> +			/* PTE-mapped THP are never mlocked */
> +			if (!PageTransCompound(page)) {
> +				/*
> +				 * Holding pte lock, we do *not* need
> +				 * mmap_lock here
> +				 */
> +				mlock_vma_page(page);
> +			}
> +			ret = false;
> +			page_vma_mapped_walk_done(&pvmw);
> +			break;

Just return false here directly and remove the ret variable?

Very nice cleanup!

Reviewed-by: Christoph Hellwig <hch@lst.de>
