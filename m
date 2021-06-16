Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861453AA046
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbhFPPry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:47:54 -0400
Received: from verein.lst.de ([213.95.11.211]:55050 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235760AbhFPPqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:46:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 71B3B67357; Wed, 16 Jun 2021 17:44:36 +0200 (CEST)
Date:   Wed, 16 Jun 2021 17:44:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Roman Skakun <rm.skakun@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Roman Skakun <roman_skakun@epam.com>,
        Andrii Anisov <andrii_anisov@epam.com>
Subject: Re: [PATCH 2/2] swiotlb-xen: override common mmap and get_sgtable
 dma ops
Message-ID: <20210616154436.GA7619@lst.de>
References: <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com> <20210616114205.38902-1-roman_skakun@epam.com> <20210616114205.38902-2-roman_skakun@epam.com> <2834cdc0-534c-4f07-1901-e468a7713c1f@oracle.com> <20210616142148.GA764@lst.de> <83353b34-2abb-9dfc-bed6-21d500abf49f@oracle.com> <20210616153519.GA6476@lst.de> <d4e8c822-3f92-d552-018c-611a44299e28@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4e8c822-3f92-d552-018c-611a44299e28@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:39:07AM -0400, Boris Ostrovsky wrote:
> 
> On 6/16/21 11:35 AM, Christoph Hellwig wrote:
> > On Wed, Jun 16, 2021 at 11:33:50AM -0400, Boris Ostrovsky wrote:
> >> Isn't the expectation of virt_to_page() that it only works on non-vmalloc'd addresses? (This is not a rhetorical question, I actually don't know).
> > Yes.  Thus is why I'd suggest to just do the vmalloc_to_page or
> > virt_to_page dance in ops_helpers.c and just continue using that.
> 
> 
> Ah, OK, so something along the lines of what I suggested. (I thought by "helpers" you meant virt_to_page()).

Yes.  Just keeping it contained in the common code without duplicating it
into a xen-specific version.
