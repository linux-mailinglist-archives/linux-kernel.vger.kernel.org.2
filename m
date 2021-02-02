Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE0730BD79
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhBBLxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:53:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231199AbhBBLxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:53:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 949E264EDA;
        Tue,  2 Feb 2021 11:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612266787;
        bh=BRH68+6vOxOQ4LInf/FRWhZDyh3A94ESv/43pW43Yt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJ8N1X8f4o+yVH+a6dN3B/AyPw/cXpDy9CSfhpaCFB9Pa2HmmOTPmoaihArZTNnal
         TmR/WYbIOe25gnkHYcuWdIdweGqctOyJgUioqJreKa2g9TO4uxZrNsAJa2EbDxh24A
         xiEodTo2bHyB5/pstyzXoaX6qrNTA/sMppxDmtLo=
Date:   Tue, 2 Feb 2021 12:53:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jianxiong Gao <jxgao@google.com>
Cc:     erdemaktas@google.com, marcorr@google.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        saravanak@google.com, heikki.krogerus@linux.intel.com,
        rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, bgolaszewski@baylibre.com,
        jroedel@suse.de, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com, kbusch@kernel.org, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/3] SWIOTLB: Preserve swiotlb map offset when needed.
Message-ID: <YBk9HsrdvcUb50Kz@kroah.com>
References: <20210201183017.3339130-1-jxgao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201183017.3339130-1-jxgao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 10:30:14AM -0800, Jianxiong Gao wrote:
> NVMe driver and other applications may depend on the data offset
> to operate correctly. Currently when unaligned data is mapped via
> SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. This
> patch adds an option to make sure the mapped data preserves its
> offset of the orginal addrss.
> 
> Without the patch when creating xfs formatted disk on NVMe backends,
> with swiotlb=force in kernel boot option, creates the following error:
> meta-data=/dev/nvme2n1   isize=512    agcount=4, agsize=131072 blks
>          =               sectsz=512   attr=2, projid32bit=1
>          =               crc=1        finobt=1, sparse=0, rmapbt=0, refl
> ink=0
> data     =               bsize=4096   blocks=524288, imaxpct=25
>          =               sunit=0      swidth=0 blks
> naming   =version 2      bsize=4096   ascii-ci=0 ftype=1
> log      =internal log   bsize=4096   blocks=2560, version=2
>          =               sectsz=512   sunit=0 blks, lazy-count=1
> realtime =none           extsz=4096   blocks=0, rtextents=0
> mkfs.xfs: pwrite failed: Input/output error
> 
> Jianxiong Gao (3):
>   Adding page_offset_mask to device_dma_parameters
>   Add swiotlb offset preserving mapping when
>     dma_dma_parameters->page_offset_mask is non zero.
>   Adding device_dma_parameters->offset_preserve_mask to NVMe driver.
> 
>  drivers/nvme/host/pci.c     |  4 ++++
>  include/linux/device.h      |  1 +
>  include/linux/dma-mapping.h | 17 +++++++++++++++++
>  kernel/dma/swiotlb.c        | 16 +++++++++++++++-
>  4 files changed, 37 insertions(+), 1 deletion(-)
> 
> -- 
> 2.27.0
> 

You forgot to mention somewhere, what changed from v1 to v2 :(
