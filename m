Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEB03E294E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245381AbhHFLQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:16:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3604 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhHFLQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:16:27 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gh2w70PJGz6BCPp;
        Fri,  6 Aug 2021 19:15:51 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 13:16:09 +0200
Received: from localhost (10.52.123.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 6 Aug 2021
 12:16:08 +0100
Date:   Fri, 6 Aug 2021 12:15:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <20210806121538.00004e7d@Huawei.com>
In-Reply-To: <CAPcyv4g1oBU3J3qpd+hDy9cKMYqn0FAsAO4BxxfrNCnpaxzO9g@mail.gmail.com>
References: <YQuYCePPZEmVbkfc@kroah.com>
        <YQuZdVuaGG/Cr62y@kroah.com>
        <YQuaJ78y8j1UmBoz@kroah.com>
        <fdf8b6b6-58c3-8392-2fc6-1908a314e991@linux.intel.com>
        <YQwlHrJBw79xhTSI@kroah.com>
        <21db8884-5aa1-3971-79ef-f173a0a95bef@linux.intel.com>
        <YQwpa+LAYt7YZ5dh@kroah.com>
        <7d6751b1-c476-51d3-25c6-b65c0e93d23b@linux.intel.com>
        <YQw4AEwIUGe3RpCx@kroah.com>
        <CAPcyv4gV9GK93rgtoHxhshzDGk0ueJn0d9LXYitJ8=wJWzmWHg@mail.gmail.com>
        <YQw71hBx4/w14Fir@kroah.com>
        <CAPcyv4g1oBU3J3qpd+hDy9cKMYqn0FAsAO4BxxfrNCnpaxzO9g@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.57]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 12:52:30 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> [ add Jonathan ]
> 
> On Thu, Aug 5, 2021 at 12:28 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 05, 2021 at 12:18:12PM -0700, Dan Williams wrote:  
> > > On Thu, Aug 5, 2021 at 12:12 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:  
> > > >
> > > > On Thu, Aug 05, 2021 at 11:53:52AM -0700, Kuppuswamy, Sathyanarayanan wrote:  
> > > > > I am not sure how USB and Thunderbolt "authorzied" model works. But I
> > > > > don't think it prevents built-in driver probes during kernel boot right?  
> > > >
> > > > Yes it does.
> > > >
> > > > Again Intel created this framework well over a decade ago for busses
> > > > that it deemed that it did not want to "trust" to instantly probe
> > > > drivers for and made it part of the Wireless USB specification.
> > > >
> > > > Then Intel went and added the same framework to Thunderbolt for the same
> > > > reason.
> > > >
> > > > To ignore this work is quite odd, you might want to talk to your
> > > > coworkers...  
> > >
> > > Sometimes we need upstream to connect us wayward drones back into the
> > > hive mind. Forgive me for not immediately recognizing that the
> > > existing 'authorized' mechanisms might be repurposed for this use
> > > case.  
> >
> > Not your fault, I'm more amazed that Andi doesn't remember this, he's
> > been around longer :)
> >  
> 
> In the driver core? No, not so much, and I do remember it flying by,
> just did not connect the dots. In fact, it had just gone upstream when
> you and I had that thread about blocking PCI drivers [1], September
> 2017 vs June 2017 when the Thunderbolt connection manager was merged.
> There was no internal review process back then so I failed to
> internalize its implications for this TDX filter. You had taken the
> time to review it in a way that I had not.
> 
> > But the first instinct should not be "let's go add a new feature", but
> > rather, "how has this problem been solved by others first" because,
> > really, this is not a new issue at all.  You should not rely on just me
> > to point out existing kernel features, we do have documentation you
> > know...  
> 
> I have added, "review driver core attribute proposal for duplication
> of bus-local capabilities" to my review checklist.
> 
> The good news is I think this generic authorization support in the
> core may answer one of Jonathan's questions about how to integrate PCI
> SPDM/CMA support [2].

Definitely an interesting discussion, and the SPDM stuff
feeds into Greg's point about establishing trust with hardware.

If anyone is looking at the USB authentication specification (which is
more or less SPDM), would be good to align on that.

My current model is really basic (driver checks and fails probe if
failure occurs). Definitely better to bolt into standard approach.

*Goes off to read up on this topic*

Thanks for highlighting this thread Dan,

Jonathan

> 
> [1]: https://lore.kernel.org/lkml/20170928090901.GC12599@kroah.com/
> [2]: https://lore.kernel.org/r/20210804161839.3492053-1-Jonathan.Cameron@huawei.com

