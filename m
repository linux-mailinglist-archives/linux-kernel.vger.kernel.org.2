Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642D7433BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhJSQJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhJSQJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:09:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C25C061746;
        Tue, 19 Oct 2021 09:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bjFjn9EzwfzgnYx2Fzb34FQEEM33mz5hXfFo0ZCanZ4=; b=IQEKj74/zEEPLDe45wuoI2G6/s
        38JC3s1nDJ9ZkiQqh8uZl5e5cgXZeULOQT6nu900dmgcNqGrLdT4I1AJah4Tb1lnUZmTC4nkWyN60
        c6uPfxUWBXcxT8A8FPIBsCqEkEirmG2f5YppFqz05Wj3LTmBvUURDAYdBHNWi50BnZHEHycft05/T
        HQHYE4XzKPoega0+FLqIInQGy2pQS+daXyT+pw2HZ4rri5+qiL1LnqiRbcMXVZS/QdDGFHJWN1D2O
        8WPSgjgB9Sy3pbYvp1RmEgEz9Y3IAbAaaQRDNeaCS8GR7LYKdqQIdwVVJegBXP3vwNv3MiDGsf0zU
        4fN/43MQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcrdP-001pUd-Kx; Tue, 19 Oct 2021 16:06:39 +0000
Date:   Tue, 19 Oct 2021 09:06:39 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jim Paris <jim@jtan.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, senozhatsky@chromium.org,
        Richard Weinberger <richard@nod.at>, miquel.raynal@bootlin.com,
        vigneshr@ti.com, Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-mtd@lists.infradead.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-nvme@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/13] nvdimm/blk: avoid calling del_gendisk() on early
 failures
Message-ID: <YW7tDx/kXvg00T3O@bombadil.infradead.org>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <20211015235219.2191207-7-mcgrof@kernel.org>
 <CAPcyv4j+xLT=5RUodHWgnPjNq6t5OcmX1oM2zK2ML0U+OS_16Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j+xLT=5RUodHWgnPjNq6t5OcmX1oM2zK2ML0U+OS_16Q@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 05:13:48PM -0700, Dan Williams wrote:
> On Fri, Oct 15, 2021 at 4:53 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > If nd_integrity_init() fails we'd get del_gendisk() called,
> > but that's not correct as we should only call that if we're
> > done with device_add_disk(). Fix this by providing unwinding
> > prior to the devm call being registered and moving the devm
> > registration to the very end.
> >
> > This should fix calling del_gendisk() if nd_integrity_init()
> > fails. I only spotted this issue through code inspection. It
> > does not fix any real world bug.
> >
> 
> Just fyi, I'm preparing patches to delete this driver completely as it
> is unused by any shipping platform. I hope to get that removal into
> v5.16.

I'll remove this from my queue, any chance you can review the changes
for nvdimm/btt?

  Luis
