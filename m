Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E69325CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 06:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBZFS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 00:18:29 -0500
Received: from verein.lst.de ([213.95.11.211]:44507 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhBZFSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 00:18:25 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 001F968BEB; Fri, 26 Feb 2021 06:17:40 +0100 (CET)
Date:   Fri, 26 Feb 2021 06:17:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Claire Chang <tientzu@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH v4 12/14] swiotlb: Add restricted DMA alloc/free
 support.
Message-ID: <20210226051740.GB2072@lst.de>
References: <20210209062131.2300005-1-tientzu@chromium.org> <20210209062131.2300005-13-tientzu@chromium.org> <CALiNf298+DLjTK6ALe0mYrRuCP_LtztMGuQQCS90ubDctbS0kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALiNf298+DLjTK6ALe0mYrRuCP_LtztMGuQQCS90ubDctbS0kw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:17:50PM +0800, Claire Chang wrote:
> Do you think I should fix this and rebase on the latest linux-next
> now? I wonder if there are more factor and clean up coming and I
> should wait after that.

Here is my preferred plan:

 1) wait for my series to support the min alignment in swiotlb to
    land in Linus tree
 2) I'll resend my series with the further swiotlb cleanup and
    refactoring, which includes a slightly rebased version of your
    patch to add the io_tlb_mem structure
 3) resend your series on top of that as a baseline

This is my current WIP tree for 2:

  http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb-struct
