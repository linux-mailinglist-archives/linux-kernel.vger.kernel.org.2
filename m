Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250793CD091
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 11:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhGSIl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 04:41:59 -0400
Received: from verein.lst.de ([213.95.11.211]:48676 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235031AbhGSIl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:41:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 11E6C67373; Mon, 19 Jul 2021 11:22:36 +0200 (CEST)
Date:   Mon, 19 Jul 2021 11:22:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Roman Skakun <rm.skakun@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Andrii Anisov <andrii_anisov@epam.com>,
        Roman Skakun <Roman_Skakun@epam.com>
Subject: Re: [PATCH v2] dma-mapping: use vmalloc_to_page for vmalloc
 addresses
Message-ID: <20210719092235.GA31566@lst.de>
References: <20210715170011.GA17324@lst.de> <20210716083934.154992-1-rm.skakun@gmail.com> <20210716093551.GA17981@lst.de> <CADu_u-OYA+Z_y-DBLxyUYGhmLVMtLggmZ_SnRiEtw9EGrO4oGg@mail.gmail.com> <alpine.DEB.2.21.2107160828430.3916@sstabellini-ThinkPad-T480s> <CADu_u-Psn5QpOyZ18_NCPx14DYxmGmSqVod=_RBC3A_A93tGUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADu_u-Psn5QpOyZ18_NCPx14DYxmGmSqVod=_RBC3A_A93tGUw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 11:39:21AM +0300, Roman Skakun wrote:
> > We can merge this patch and create a new one for
> > xen_swiotlb_free_coherent() later.
> > Yeah, no worries, I didn't know that exposing dma_common_vaddr_to_page
> > was problematic.
> >
> > This patch is fine by me.
> 
> Good. I'm agreed too. Waiting for Christoph.

Fine with.  I've queued up the modified patch.
