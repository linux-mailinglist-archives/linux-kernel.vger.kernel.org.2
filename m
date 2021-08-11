Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3653E89EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 07:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhHKFzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 01:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbhHKFyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 01:54:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C32C0613D5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 22:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ximqsP9eH81bjVTaLK5J8CTiAXmX0UXkr88CH/kujB0=; b=cqQCYTwO/n7keDf+DqW61O3WA7
        zquidGQy0kxeH+7gbrGWVqsa7V3686YeaBXzKuBAdl0fJoxWBxVuoRsb9QKKYiY+5VgPvDgyk0TGc
        lBAmlaWNvUXrFE5ahOzTMmz0/4HEIqdFhYOnYKylUxwF+UpWhX6c9G1wffuBtd9ANpeez5ToumXOG
        a11j6UgDrHIFNB9OMZD1kbBTGiBhnLqIZ4g+7KHW2ZpGrQd59c4Rwrv/isWwFomaTqGtw8FYdlSHj
        Rz629UwJJ/E2PrQNXA73arwYJKoZ6UyU+9wskQSPTTVYPbFdks/jZISMTGOLgI/WeNmwI7azg17na
        ZQzT/Z+w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDhAf-00D27X-99; Wed, 11 Aug 2021 05:53:05 +0000
Date:   Wed, 11 Aug 2021 06:52:57 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Baoquan He <bhe@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>, brijesh.singh@amd.com,
        x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        rientjes@google.com
Subject: Re: [PATCH RFC 0/2] dma-pool: allow user to disable atomic pool
Message-ID: <YRNluS1qt1YL2r7p@infradead.org>
References: <20210624052010.5676-1-bhe@redhat.com>
 <YNQ258KHlzlajqo/@infradead.org>
 <20210624092930.GA802261@MiWiFi-R3L-srv>
 <8b3d4e02-6e94-ad59-a480-fed8e55c009a@arm.com>
 <20210805065410.GA2051@MiWiFi-R3L-srv>
 <5df93c4e-ffdd-88c5-db4a-1a09826d047a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5df93c4e-ffdd-88c5-db4a-1a09826d047a@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 03:52:25PM -0500, Tom Lendacky via iommu wrote:
> I think the atomic pool is used by the NVMe driver. My understanding is
> that driver will do a dma_alloc_coherent() from interrupt context, so it
> needs to use GFP_ATOMIC. The pool was created because dma_alloc_coherent()
> would perform a set_memory_decrypted() call, which can sleep. The pool
> eliminates that issue (David can correct me if I got that wrong).

Not just the NVMe driver.  We have plenty of drivers doing that, just
do a quick grep for dma_alloc_* dma_poll_alloc, dma_pool_zalloc with
GFP_ATOMIC (and that won't even find multi-line strings).
