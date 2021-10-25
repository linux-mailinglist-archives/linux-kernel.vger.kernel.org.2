Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FE2439AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhJYQB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbhJYQBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:01:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF909C061745;
        Mon, 25 Oct 2021 08:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5y7mYSiruE0cjysowYo7+0jNcIRmxjtJRrRLlmuIF+o=; b=QXT6Sw24DXrC/psY8+sN1Li2XS
        X1huPXRn/qDo1HnmsuBUFcbunf0kWqQXlhN+z6chxaTIdt8hxz9nWytKt2DlAZ5gzqr1qxaxImfyf
        PxnxGk7tzyTkUTccZB0NvwsVeqKo3xbXVggsekcvOCJAaHSupHm5jwR4CeHW+ehwW4L/YkVFA7fxw
        xncOolmkjmCZPKRfNvPHankG+wrRBFDL01kPxYO/ulAIE2zRZqyKIYT1QqWJIWw4STAH9KhE78KS8
        Vh7eDzj6hKkoRmOoOldUn6jqiCS3HVz1L+ZoY+GXq/eWoCJ5nYU9/tuL8umRjUTHSIFqo/FGLINHE
        DhnolPJw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mf2Mu-00GwhK-7N; Mon, 25 Oct 2021 15:58:36 +0000
Date:   Mon, 25 Oct 2021 08:58:36 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Geoff Levand <geoff@infradead.org>
Cc:     axboe@kernel.dk, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, jim@jtan.com, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, richard@nod.at,
        miquel.raynal@bootlin.com, vigneshr@ti.com,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
        nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] block: add_disk() error handling stragglers
Message-ID: <YXbULG63hZcBdoQD@bombadil.infradead.org>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <a31970d6-8631-9d9d-a36f-8f4fcebfb1e6@infradead.org>
 <YW2duaTqf3qUbTIm@bombadil.infradead.org>
 <24bc86d0-9d8d-8c8a-7f74-a87f9089342b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24bc86d0-9d8d-8c8a-7f74-a87f9089342b@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 08:10:49PM -0700, Geoff Levand wrote:
> Hi Luis,
> 
> On 10/18/21 9:15 AM, Luis Chamberlain wrote:
> > On Sun, Oct 17, 2021 at 08:26:33AM -0700, Geoff Levand wrote:
> >> Hi Luis,
> >>
> >> On 10/15/21 4:52 PM, Luis Chamberlain wrote:
> >>> This patch set consists of al the straggler drivers for which we have
> >>> have no patch reviews done for yet. I'd like to ask for folks to please
> >>> consider chiming in, specially if you're the maintainer for the driver.
> >>> Additionally if you can specify if you'll take the patch in yourself or
> >>> if you want Jens to take it, that'd be great too.
> >>
> >> Do you have a git repo with the patch set applied that I can use to test with?
> > 
> > Sure, although the second to last patch is in a state of flux given
> > the ataflop driver currently is broken and so we're seeing how to fix
> > that first:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20211011-for-axboe-add-disk-error-handling
> 
> That branch has so many changes applied on top of the base v5.15-rc4
> that the patches I need to apply to test on PS3 with don't apply.
> 
> Do you have something closer to say v5.15-rc5?  Preferred would be
> just your add_disk() error handling patches plus what they depend
> on.

If you just want to test the ps3 changes, I've put this branch together
just for yo, its based on v5.15-rc6:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20211025-ps3-add-disk

  Luis
