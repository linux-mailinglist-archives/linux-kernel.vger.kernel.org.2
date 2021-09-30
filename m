Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FC141D2AC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 07:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348050AbhI3FZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 01:25:50 -0400
Received: from verein.lst.de ([213.95.11.211]:58178 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347973AbhI3FZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 01:25:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 896FC67373; Thu, 30 Sep 2021 07:24:02 +0200 (CEST)
Date:   Thu, 30 Sep 2021 07:24:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
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
        "Nikula, Jani" <jani.nikula@intel.com>
Subject: Re: refactor the i915 GVT support
Message-ID: <20210930052402.GA21841@lst.de>
References: <20210817052203.GX13928@zhen-hp.sh.intel.com> <20210819082929.GB13928@zhen-hp.sh.intel.com> <20210820141724.GA29034@lst.de> <YSAI8pKAvvW/8S2O@bombadil.infradead.org> <20210826061219.GD9942@zhen-hp.sh.intel.com> <55c11f22-99e5-6109-3be3-a04b06b3336e@intel.com> <YVMgGKk1K4gO8ls6@bombadil.infradead.org> <af40291a-de36-b39f-9ded-aaf4ddba641f@intel.com> <20210928150507.GM964074@nvidia.com> <24c7bbec-b425-52fb-d3f9-539a0a391dfa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24c7bbec-b425-52fb-d3f9-539a0a391dfa@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 06:27:16PM +0000, Wang, Zhi A wrote:
> Thanks for the idea. I am not sure i915 guys would take this idea since 
> that it's only for GVT-g, i915 doesn't use this at all. We need to take 
> a snapshot of both PCI configuration space and MMIO registers before 
> i915 driver starts to touch the HW.
> 
> One idea is we capture the registers in intel_gvt.c during the early 
> initialization and do everything else when i915.ko is fully loaded. But 
> how about dependence between i915.ko and kvmgt.ko? We cannot do 
> request_module("kvmgt") in i915.ko.
> 
> Maybe Christoph can give more input on this and how we can deal with 
> this? Before we figure out an solution, we have to pick that patch out 
> since it blocks our pull request schedule.
> 
> Also I was thinking if moving gvt into kvmgt.ko is the right direction. 
> It seems the module loading system in kernel is not designed for "module 
> A loading module B, which needs symbols from module A, in the 
> initialization path of module A".

I have a few idea on how to sort this "deadlock" out.  But I'm completely
swamped until the end of next week, so I won't get to anything before
that.
