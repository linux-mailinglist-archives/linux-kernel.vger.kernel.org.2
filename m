Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5923F34D7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbhHTT5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbhHTT5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:57:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA958C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 12:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VbTON6RvZeZhGJt6ehyn/UMw7061NqQ9ISQ7HVHxgAQ=; b=Nz+M9aqAdzrwVlpMtHBAoKM3sQ
        /MC1a1UMn1TH8I0i3RIECs05+soT9W1PjPzTbJ9rJrBlQZiWwYwPq5gPiNraa8QlgzaxsxKTtNK51
        xfHrhec5YI34f1OJr5TdE25HisAWUsCmZJlfg36RHrmqUjwzulPaeZmFyCQjOLZek95gCw4CfmWlT
        +NwsZjpJZ7dW4R+GpB9sCknUYdpVqI5Cy28SWGT6seS6n8qKOZLjSm9RoGhsy/82Rwg4KCVU8B1K7
        vj3/f3pKGq5u6+BekrrvIUuufXlQ8QjCnK+AZbqc6s1HEqxrDWtOgT5+qZjbt4NuQI6nmdeG+FTns
        mYHecTpA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mHAd0-00C0kX-OY; Fri, 20 Aug 2021 19:56:34 +0000
Date:   Fri, 20 Aug 2021 12:56:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: Re: refactor the i915 GVT support
Message-ID: <YSAI8pKAvvW/8S2O@bombadil.infradead.org>
References: <20210728175925.GU1721383@nvidia.com>
 <20210729072022.GB31896@lst.de>
 <20210803094315.GF13928@zhen-hp.sh.intel.com>
 <20210803143058.GA1721383@nvidia.com>
 <20210804052606.GG13928@zhen-hp.sh.intel.com>
 <20210816173458.GA9183@lst.de>
 <20210817010851.GW13928@zhen-hp.sh.intel.com>
 <20210817052203.GX13928@zhen-hp.sh.intel.com>
 <20210819082929.GB13928@zhen-hp.sh.intel.com>
 <20210820141724.GA29034@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820141724.GA29034@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 04:17:24PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 19, 2021 at 04:29:29PM +0800, Zhenyu Wang wrote:
> > I'm working on below patch to resolve this. But I met a weird issue in
> > case when building i915 as module and also kvmgt module, it caused
> > busy wait on request_module("kvmgt") when boot, it doesn't happen if
> > building i915 into kernel. I'm not sure what could be the reason?
> 
> Luis, do you know if there is a problem with a request_module from
> a driver ->probe routine that is probably called by a module_init
> function itself?

Generally no, but you can easily foot yourself in the feet by creating
cross dependencies and not dealing with them properly. I'd make sure
to keep module initialization as simple as possible, and run whatever
takes more time asynchronously, then use a state machine to allow
you to verify where you are in the initialization phase or query it
or wait for a completion with a timeout.

It seems the code in question is getting some spring cleaning, and its
unclear where the code is I can inspect. If there's a tree somewhere I
can take a peak I'd be happy to review possible oddities that may stick
out.

My goto model for these sorts of problems is to abstract the issue
*outside* of the driver in question and implement new selftests to
try to reproduce. This serves two purposes, 1) helps with testing
2) may allow you to see the problem more clearly.

  Luis
