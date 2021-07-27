Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B293D7A65
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhG0QBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:01:44 -0400
Received: from dd38112.kasserver.com ([85.13.154.158]:41750 "EHLO
        dd38112.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhG0QBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:01:41 -0400
Received: from DESKTOP-E8BN1B0.localdomain (089144219199.atnat0028.highway.a1.net [89.144.219.199])
        by dd38112.kasserver.com (Postfix) with ESMTPSA id 412C01F00A4F;
        Tue, 27 Jul 2021 18:01:39 +0200 (CEST)
Date:   Tue, 27 Jul 2021 18:01:36 +0200
From:   Filip Schauer <filip@mg6.at>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers core: Fix oops when driver probe fails
Message-ID: <20210727160136.GA8122@DESKTOP-E8BN1B0.localdomain>
References: <20210727112311.GA7645@DESKTOP-E8BN1B0.localdomain>
 <YP/8jqfW4+HHUL+X@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP/8jqfW4+HHUL+X@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 02:31:10PM +0200, Greg KH wrote:
> On Tue, Jul 27, 2021 at 01:23:11PM +0200, Filip Schauer wrote:
> > dma_range_map is freed to early, which might cause an oops when
> > a driver probe fails.
> >  Call trace:
> >   is_free_buddy_page+0xe4/0x1d4
> >   __free_pages+0x2c/0x88
> >   dma_free_contiguous+0x64/0x80
> >   dma_direct_free+0x38/0xb4
> >   dma_free_attrs+0x88/0xa0
> >   dmam_release+0x28/0x34
> >   release_nodes+0x78/0x8c
> >   devres_release_all+0xa8/0x110
> >   really_probe+0x118/0x2d0
> >   __driver_probe_device+0xc8/0xe0
> >   driver_probe_device+0x54/0xec
> >   __driver_attach+0xe0/0xf0
> >   bus_for_each_dev+0x7c/0xc8
> >   driver_attach+0x30/0x3c
> >   bus_add_driver+0x17c/0x1c4
> >   driver_register+0xc0/0xf8
> >   __platform_driver_register+0x34/0x40
> >   ...
> > 
> > This issue is introduced by commit d0243bbd5dd3 ("drivers core:
> > Free dma_range_map when driver probe failed"). It frees
> > dma_range_map before the call to devres_release_all, which is too
> > early. The solution is to free dma_range_map only after
> > devres_release_all.
> > 
> > Fixes: d0243bbd5dd3 ("drivers core: Free dma_range_map when driver probe failed")
> > Signed-off-by: Filip Schauer <filip@mg6.at>
> > ---
> >  drivers/base/dd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Oh, nice catch!  This is a v2, right?  Next time please be explicit :)
> 
> thanks,
> 
> greg k-h
> 

Thank you for adding the patch.
And my bad, this is indeed a PATCH v2.
I didn't know about the patch revisioning convention.
I'll be more explicit next time.

Thanks,

Filip Schauer
