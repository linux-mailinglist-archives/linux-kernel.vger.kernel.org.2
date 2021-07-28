Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165F93D8F51
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbhG1Nnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235314AbhG1Nna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:43:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA7E760F0F;
        Wed, 28 Jul 2021 13:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627479808;
        bh=ym6p3RGqNB6x3xeubxFNxYh9vu1LYrAXPtshO2/JC6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUjPpdpdHxEFElGU+cKgI+cxQhHTkdT9U54AJldRJB5NCg+fWDT8sfuAvs2bXSolW
         jextQ4RM71JTlOcDQWo4TJit5rI8l6W8X7TliADUzgFxXcrHr2YwlRTd5sRosPVm/a
         wP58z7HjpXZVC3TmDq7rRjbHkJLe/FS97wRamWW8=
Date:   Wed, 28 Jul 2021 15:43:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: refactor the i915 GVT support
Message-ID: <YQFe/e9o4OANBVBE@kroah.com>
References: <20210721155355.173183-1-hch@lst.de>
 <DM4PR11MB55496531B246A4604FC86998CAE49@DM4PR11MB5549.namprd11.prod.outlook.com>
 <20210722112636.wj277vqhg4dez5ug@sirius.home.kraxel.org>
 <20210727121224.GA2145868@nvidia.com>
 <DM4PR11MB5549EC882AA6076F3468274DCAEA9@DM4PR11MB5549.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB5549EC882AA6076F3468274DCAEA9@DM4PR11MB5549.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Jul 28, 2021 at 01:38:58PM +0000, Wang, Zhi A wrote:
> Hi Jason:
> 
> I guess those APIs you were talking about are KVM-only. For other hypervisors, e.g. Xen, ARCN cannot use the APIs you mentioned. Not sure if you have already noticed that VFIO is KVM-only right now.

Please wrap your lines properly :(

> GVT-g is designed for many hypervisors not only KVM. In the design, we implemented an abstraction layer for different hypervisors. You can check the link in the previous email which has an example of how the MPT module "xengt" supports GVT-g running under Xen. 
> For example, injecting a msi in VFIO/KVM is via playing with eventfd. But in Xen, we need to issue a hypercall from Dom0. So does others, like querying mappings between GFN and HFN. Some GPU related emulation logic might be implemented differently under different hypervisors because different hypervisors might provide not exact the APIs we want. That's the reason why they get a callback in the MPT (yet not perfect.)  
> 
> As you can see, to survive from this situation, we have to rely on an abstraction layer so that we can prevent introducing coding blocks like in the core logic:
> 
> If (in_hypervisor_xen)
> 	Issue hypercalls
> else if (in_hypervisor_kvm)
> 	Play with eventfds.
> Else if (in_hypervisor_other)
> 	xxxx

That's horrid, and slow, please do this properly.

> Thus some of the APIs have to be wrapped in the MPT module in GVT-g design.
> 
> Sadly, not all customers are motivated or allowed to get their hypervisor-specific modules into the kernel. We have a customer who runs GVT-g with their private hypervisor. In this case, they don't want to get their "xxxgt" MPT module into upstream since their hypervisor has been in the kernel yet. Also, we have customers who ported the GVT-g to QNX which is another widely used commercial hypervisor in the industry. They can't get the "qnxgt" MPT module into upstream since it's not allowed.

Why is it not allowed?

> We do understand the situation and try to figure out a solution that can fulfill expectations from different people in the community and also customers. 
> 
> According to Greg KH's comments, we are collecting the requirements of MPT modules from other open-source hypervisors in the kernel, e.g. ACRN, to see if they can get another MPT module into the kernel, which will show an example that how the MPT abstraction can benefit. Also, we are evaluating the impact on our customers if we have to remove MPT abstraction in the kernel because there is only one MPT module. 

Until that happens, can we please just remove the unneeded layer here as
no one is using it?  Then, when you have a real user for this type of
middle-layer, you can add it back?  We have no need for it now.

thanks,

greg k-h
