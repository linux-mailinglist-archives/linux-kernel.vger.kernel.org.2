Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2346240348B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 08:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347817AbhIHGxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 02:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347778AbhIHGxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 02:53:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3959EC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 23:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dBfrdwNivWqqlCKmJ0ASZqHL/mKJ+iqsG8FTGZNie28=; b=D6unVWGGt0nhN9vNLt5bPN4XJ6
        H5YeTJ6wPEjXfqN4OQvde23ebXYK4ScG4iV7RuMd/m2BDecE+805+QIOyDDJIjDMyQpo4eYaj4QmT
        F5gpCSBn3mbFzriE/4gNmiFAEKCw8EFJTlqjfosMVn+/7NyuTmPOcaj/pSI3twWgrK3D3gLCgPrMe
        ka5oWI1awXDsLFEZBWksAMt1lCG3nYEk5JDPx/M4rxdsFFQs1qr52K4DUKb7c+e381aB2rZA5g8eZ
        E72vmwrF3bYOH4V0FUjxdhgtQPxBvK92pTAIHZbOja/YjfQKbYEWK4Z0FzwpkGP7d/t2qsuf7If0X
        4CAEntbw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNrPl-008Ztv-5x; Wed, 08 Sep 2021 06:50:43 +0000
Date:   Wed, 8 Sep 2021 07:50:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 02/12] swiotlb-xen: fix late init retry
Message-ID: <YThdOdg3VoPAl7xI@infradead.org>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com>
 <778299d6-9cfd-1c13-026e-25ee5d14ecb3@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <778299d6-9cfd-1c13-026e-25ee5d14ecb3@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 02:04:47PM +0200, Jan Beulich wrote:
> The commit referenced below removed the assignment of "bytes" from
> xen_swiotlb_init() without - like done for xen_swiotlb_init_early() -
> adding an assignment on the retry path, thus leading to excessively
> sized allocations upon retries.
> 
> Fixes: 2d29960af0be ("swiotlb: dynamically allocate io_tlb_default_mem")
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: stable@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
