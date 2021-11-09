Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF9F44A7EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 08:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243802AbhKIH6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 02:58:38 -0500
Received: from verein.lst.de ([213.95.11.211]:48900 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243795AbhKIH6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 02:58:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9444E68AA6; Tue,  9 Nov 2021 08:55:45 +0100 (CET)
Date:   Tue, 9 Nov 2021 08:55:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/29] drm/i915/gvt: integrate into the main Makefile
Message-ID: <20211109075545.GA27339@lst.de>
References: <20211102070601.155501-1-hch@lst.de> <20211102070601.155501-3-hch@lst.de> <163602902009.4807.3745093259631583283@jlahtine-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163602902009.4807.3745093259631583283@jlahtine-mobl.ger.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 02:30:20PM +0200, Joonas Lahtinen wrote:
> Quoting Christoph Hellwig (2021-11-02 09:05:34)
> > Remove the separately included Makefile and just use the relative
> > reference from the main i915 Makefile as for source files in other
> > subdirectories.
> 
> The thinking behind the split is to avoid any merge conflicts as the
> gvt/ subdirectory is handled through separate pull request flow and
> are note part of drm-tip.
> 
> The other subdirectories are part of drm-intel-next/drm-intel-gt-next
> and are part of drm-tip.
> 
> So I would rather still see the Makefile live in gvt/ directory.

So the reason I did this is because the include broke doing nice
little subdir makes or me.  It would also require renaming the kvmgvt.c
source file later on.
