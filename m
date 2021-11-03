Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EA2443D5B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 07:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhKCGnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 02:43:42 -0400
Received: from verein.lst.de ([213.95.11.211]:58411 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhKCGng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 02:43:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 66A3C68AA6; Wed,  3 Nov 2021 07:40:56 +0100 (CET)
Date:   Wed, 3 Nov 2021 07:40:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/29] drm/i915/gvt: convert to use
 vfio_register_group_dev()
Message-ID: <20211103064056.GA30216@lst.de>
References: <20211102070601.155501-1-hch@lst.de> <20211102070601.155501-29-hch@lst.de> <20211102164136.GI2744544@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102164136.GI2744544@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 01:41:36PM -0300, Jason Gunthorpe wrote:
> On Tue, Nov 02, 2021 at 08:06:00AM +0100, Christoph Hellwig wrote:
> > This is straightforward conversion, the intel_vgpu already has a pointer
> > to the vfio_dev, which can be replaced with the embedded structure and
> > we can replace all the mdev_get_drvdata() with a simple container_of().
> 
> This should be using vfio_register_emulated_iommu_dev(), right?

Yes, once rebased to 5.16-rc where this function appears.
