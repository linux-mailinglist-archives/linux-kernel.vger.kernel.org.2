Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A9E37AC92
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhEKRCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:02:22 -0400
Received: from verein.lst.de ([213.95.11.211]:37566 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231437AbhEKRCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:02:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 14EDB67373; Tue, 11 May 2021 19:01:02 +0200 (CEST)
Date:   Tue, 11 May 2021 19:01:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Julien Grall <julien@xen.org>,
        f.fainelli@gmail.com,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        linux-kernel@vger.kernel.org,
        osstest service owner <osstest-admin@xenproject.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        iommu@lists.linux-foundation.org
Subject: Re: Regression when booting 5.15 as dom0 on arm64 (WAS: Re:
 [linux-linus test] 161829: regressions - FAIL)]
Message-ID: <20210511170101.GA20936@lst.de>
References: <osstest-161829-mainreport@xen.org> <4ea1e89f-a7a0-7664-470c-b3cf773a1031@xen.org> <20210510084057.GA933@lst.de> <alpine.DEB.2.21.2105101818260.5018@sstabellini-ThinkPad-T480s> <20210511063558.GA7605@lst.de> <alpine.DEB.2.21.2105110925430.5018@sstabellini-ThinkPad-T480s> <20210511164933.GA19775@lst.de> <alpine.DEB.2.21.2105110950580.5018@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2105110950580.5018@sstabellini-ThinkPad-T480s>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 09:51:20AM -0700, Stefano Stabellini wrote:
> On Tue, 11 May 2021, Christoph Hellwig wrote:
> > On Tue, May 11, 2021 at 09:47:33AM -0700, Stefano Stabellini wrote:
> > > That's a much better plan. It is also not super urgent, so maybe for now
> > > we could add an explicit check for io_tlb_default_mem != NULL at the
> > > beginning of xen_swiotlb_init? So that at least we can fail explicitly
> > > or ignore it explicitly rather than by accident.
> > 
> > Fine with me.  Do you want to take over from here and test and submit
> > your version?
> 
> I can do that. Can I add your signed-off-by for your original fix?

Sure:

Signed-off-by: Christoph Hellwig <hch@lst.de>
