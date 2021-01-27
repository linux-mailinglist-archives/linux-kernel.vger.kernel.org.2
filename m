Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B0F305462
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhA0HUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:20:17 -0500
Received: from verein.lst.de ([213.95.11.211]:51659 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233087AbhA0HLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 02:11:43 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8FBA767373; Wed, 27 Jan 2021 08:10:59 +0100 (CET)
Date:   Wed, 27 Jan 2021 08:10:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] kernel/dma: remove unnecessary unmap_kernel_range
Message-ID: <20210127071059.GA21133@lst.de>
References: <20210126045404.2492588-1-npiggin@gmail.com> <20210126045404.2492588-3-npiggin@gmail.com> <YBCS7toITTwP04aK@Konrads-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBCS7toITTwP04aK@Konrads-MacBook-Pro.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 05:08:46PM -0500, Konrad Rzeszutek Wilk wrote:
> On Tue, Jan 26, 2021 at 02:54:01PM +1000, Nicholas Piggin wrote:
> > vunmap will remove ptes.
> 
> Should there be some ASSERT after the vunmap to make sure that is the
> case? 

Not really.  removing the PTEs is the whole point of vunmap.  Everything
else is just house keeping.

