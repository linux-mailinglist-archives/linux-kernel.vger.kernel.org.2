Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBB53EDC78
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 19:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhHPRfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:35:36 -0400
Received: from verein.lst.de ([213.95.11.211]:55563 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhHPRff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:35:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 853F568AFE; Mon, 16 Aug 2021 19:34:59 +0200 (CEST)
Date:   Mon, 16 Aug 2021 19:34:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20210816173458.GA9183@lst.de>
References: <20210721155355.173183-1-hch@lst.de> <DM4PR11MB55496531B246A4604FC86998CAE49@DM4PR11MB5549.namprd11.prod.outlook.com> <20210722112636.wj277vqhg4dez5ug@sirius.home.kraxel.org> <20210727121224.GA2145868@nvidia.com> <DM4PR11MB5549EC882AA6076F3468274DCAEA9@DM4PR11MB5549.namprd11.prod.outlook.com> <20210728175925.GU1721383@nvidia.com> <20210729072022.GB31896@lst.de> <20210803094315.GF13928@zhen-hp.sh.intel.com> <20210803143058.GA1721383@nvidia.com> <20210804052606.GG13928@zhen-hp.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804052606.GG13928@zhen-hp.sh.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 01:26:06PM +0800, Zhenyu Wang wrote:
> On 2021.08.03 11:30:58 -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 03, 2021 at 05:43:15PM +0800, Zhenyu Wang wrote:
> > > Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>
> > > 
> > > Thanks a lot for this effort!
> > 
> > Great, do we have a submission plan for this? how much does it clash
> > with my open_device/etc patch? ie does the whole thing have to go
> > through the vfio tree?
> > 
> 
> I think Alex would determine when to merge open_device series, gvt part
> can be through vfio tree without problem. For this refactor, I would first
> merge for gvt staging to do more regression testing before sending through
> i915 tree.

Any updates on this?  I'd really hate to miss this merge window.
