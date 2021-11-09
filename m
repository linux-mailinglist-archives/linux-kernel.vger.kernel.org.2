Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C70E44A7DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 08:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243753AbhKIHxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 02:53:54 -0500
Received: from verein.lst.de ([213.95.11.211]:48879 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235217AbhKIHxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 02:53:51 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7B51568AFE; Tue,  9 Nov 2021 08:51:01 +0100 (CET)
Date:   Tue, 9 Nov 2021 08:51:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Zhi Wang <zhi.wang.linux@gmail.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jgg@nvidia.com,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        hch@lst.de
Subject: Re: [PATCH 1/3] i915/gvt: seperate tracked MMIO table from
 handlers.c
Message-ID: <20211109075100.GA27284@lst.de>
References: <20211108212718.10576-1-zhi.a.wang@intel.com> <875yt17qzs.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yt17qzs.fsf@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 09:00:39AM +0200, Jani Nikula wrote:
> On Mon, 08 Nov 2021, Zhi Wang <zhi.wang.linux@gmail.com> wrote:
> > From: Zhi Wang <zhi.wang.linux@gmail.com>
> >
> > To support the new mdev interfaces and the re-factor patches from
> > Christoph, which moves the GVT-g code into a dedicated module, the GVT-g
> > MMIO snapshot still needs to be saved in i915 so that the inital clean HW
> > state can be used for the further vGPU. Seperate the tracked MMIO table
> > from GVT-g, so that GVT-g and i915 can both use it.
> 
> Do you really have to both put code in a header and then include that in
> multiple places?
> 
> I think you may need to rethink the whole approach, maybe make them
> actual tables instead of code.

Without understanding this code too well: an approach that makes in
actual table and uses an accessor seems more useful to me as well.
