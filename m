Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B52403497
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 08:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347863AbhIHGz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 02:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244241AbhIHGzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 02:55:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1056C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 23:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mNv6jBhL0dwmk4rDDYf4ikhCU0kC8phJg4t0M4uQRDc=; b=aE5y0hGlp2Xj4xb952dvEVdScM
        KnAkeo8HeySFYAkHcdp37IMVTE1i0gtREK8+yHbyQ5UCZahHa1/ncIMqtviCOSYTzL/AmK9KAmrfa
        GbkJD7rJALGnUYk7MMG+5GPjSi3u2vcTySZWbKcHBhIaTZfX4KhIV1b8fYvgn6mid2qUVy57Zv+xj
        bT3JLbdCLI2NEQBhgA864/cN0ICBGxedybXpxHkTrhaXYJUYyO3bprAOlD7SGZz90vpWEEFcJpiki
        keuEbK6oYViBMYnqTQotJTIhoHqzVhJ17AvLP/tLzLc46VGBhDiVNvg6j04I7IECrcc9WRWQ0W5gg
        EL39LFfg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNrSS-008a0O-5n; Wed, 08 Sep 2021 06:53:45 +0000
Date:   Wed, 8 Sep 2021 07:53:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 03/12] swiotlb-xen: maintain slab count properly
Message-ID: <YThd4HDvB3pBD2/F@infradead.org>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com>
 <dc054cb0-bec4-4db0-fc06-c9fc957b6e66@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc054cb0-bec4-4db0-fc06-c9fc957b6e66@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 02:05:12PM +0200, Jan Beulich wrote:
> Generic swiotlb code makes sure to keep the slab count a multiple of the
> number of slabs per segment. Yet even without checking whether any such
> assumption is made elsewhere, it is easy to see that xen_swiotlb_fixup()
> might alter unrelated memory when calling xen_create_contiguous_region()
> for the last segment, when that's not a full one - the function acts on
> full order-N regions, not individual pages.
> 
> Align the slab count suitably when halving it for a retry. Add a build
> time check and a runtime one. Replace the no longer useful local
> variable "slabs" by an "order" one calculated just once, outside of the
> loop. Re-use "order" for calculating "dma_bits", and change the type of
> the latter as well as the one of "i" while touching this anyway.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
