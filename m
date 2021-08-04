Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361223DFB2C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 07:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhHDFkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 01:40:22 -0400
Received: from verein.lst.de ([213.95.11.211]:45964 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234387AbhHDFkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 01:40:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E550367373; Wed,  4 Aug 2021 07:40:06 +0200 (CEST)
Date:   Wed, 4 Aug 2021 07:40:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>
Subject: Re: refactor the i915 GVT support
Message-ID: <20210804054006.GA5769@lst.de>
References: <20210721155355.173183-1-hch@lst.de> <DM4PR11MB55496531B246A4604FC86998CAE49@DM4PR11MB5549.namprd11.prod.outlook.com> <20210722112636.wj277vqhg4dez5ug@sirius.home.kraxel.org> <20210727121224.GA2145868@nvidia.com> <DM4PR11MB5549EC882AA6076F3468274DCAEA9@DM4PR11MB5549.namprd11.prod.outlook.com> <20210728175925.GU1721383@nvidia.com> <20210729072022.GB31896@lst.de> <20210803094315.GF13928@zhen-hp.sh.intel.com> <20210803143058.GA1721383@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803143058.GA1721383@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 11:30:58AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 03, 2021 at 05:43:15PM +0800, Zhenyu Wang wrote:
> > Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>
> > 
> > Thanks a lot for this effort!
> 
> Great, do we have a submission plan for this? how much does it clash
> with my open_device/etc patch? ie does the whole thing have to go
> through the vfio tree?

The two series merge cleanly and build fine.  So if we don't need
the actual conversion of the i915 gvt code to the new mdev registration
scheme this merge window there is no need to synchronize.
