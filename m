Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6954034A4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 08:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347941AbhIHG71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 02:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343752AbhIHG7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 02:59:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B2AC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 23:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yqhbwzwdJH8qRS1MarFWp8lRnwDdQKIjHrVncEEHPh8=; b=fgBDwHw7l63tdQPsH7I2iUXyMZ
        u6GLvgy1FAu0zukPtZrZWZAGYTkNv93qLQ0SzlM4o/dSNEZZB34rJlFBTv+g/qg2PSEBxfH0qrtEq
        40iF+eI7p8r9HBX4e+qdIj0FiX5kR8x0Cn7qtaYsW6Hvb2GMjQzPi+kaNS7GQYVkm5RdE447u5hGc
        0550qzIoVi9MtzwZPjO8uku14gwMEt+yVYO9XZqzB0c2z092Fp/J7HiOH1tOmYfikBtfWZVXUaXy0
        tBjOyYM79QvEb39a4jsRkH0T1KaIT2OpzIi4U5yUtMw5Yt8jo0gL7SIhFqjH9BrADxVv9XMb5RgYq
        euwSfHxg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNrWF-008a9l-56; Wed, 08 Sep 2021 06:57:29 +0000
Date:   Wed, 8 Sep 2021 07:57:15 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 04/12] swiotlb-xen: ensure to issue well-formed
 XENMEM_exchange requests
Message-ID: <YThey/iyCxi5NUwC@infradead.org>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com>
 <397bf325-f81e-e104-6142-e8c9c4955475@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <397bf325-f81e-e104-6142-e8c9c4955475@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 02:05:32PM +0200, Jan Beulich wrote:
> While the hypervisor hasn't been enforcing this, we would still better
> avoid issuing requests with GFNs not aligned to the requested order.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> ---
> I wonder how useful it is to include the alignment in the panic()
> message. I further wonder how useful it is to wrap "bytes" in
> PAGE_ALIGN(), when it is a multiple of a segment's size anyway (or at
> least was supposed to be, prior to "swiotlb-xen: maintain slab count
> properly").
> 
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -231,10 +231,10 @@ retry:
>  	/*
>  	 * Get IO TLB memory from any location.
>  	 */
> -	start = memblock_alloc(PAGE_ALIGN(bytes), PAGE_SIZE);
> +	start = memblock_alloc(PAGE_ALIGN(bytes), IO_TLB_SEGSIZE << IO_TLB_SHIFT);
>  	if (!start)
> -		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> -		      __func__, PAGE_ALIGN(bytes), PAGE_SIZE);
> +		panic("%s: Failed to allocate %lu bytes align=%#x\n",
> +		      __func__, PAGE_ALIGN(bytes), IO_TLB_SEGSIZE << IO_TLB_SHIFT);

CAn you avoid the overly long lines here?  A good way to make it more
readable would be a variable to hold the byte count.
