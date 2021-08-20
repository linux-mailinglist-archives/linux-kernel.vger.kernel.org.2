Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1123F29BE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbhHTKDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:03:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236384AbhHTKDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:03:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E27C860EBD;
        Fri, 20 Aug 2021 10:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629453777;
        bh=1lcJS69Kvr4vG8Ke2KPzouMNReGhqqojmBfH3Ucj2A8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1hM/jWYEMNnjnlLjL0PoWn1u5QnXj7XA/WUAghmdsVungubhw2G0f8gkJrMIaVBp1
         0G/n4eyZx/rc8xGChiorbQpBfAaRMF77V9DlnntCjOzKtN15ypjCVKtNLidLX8/BLJ
         HRPHC0yt5uohQMlDYEy/Xtg5E6e7/jgtYVggtnCs=
Date:   Fri, 20 Aug 2021 12:02:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] habanalabs pull request for kernel 5.15
Message-ID: <YR99zh43GD3AylRY@kroah.com>
References: <20210819110209.GA115485@ogabbay-vm2.habana-labs.com>
 <YR6PIvwYbYG20ZY0@kroah.com>
 <CAPM=9tyT_iouVE2v8J0SMJOLV=pr=QJOm88ud=bht4=5Ms2Y2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tyT_iouVE2v8J0SMJOLV=pr=QJOm88ud=bht4=5Ms2Y2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 04:48:18AM +1000, Dave Airlie wrote:
> On Fri, 20 Aug 2021 at 03:07, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 19, 2021 at 02:02:09PM +0300, Oded Gabbay wrote:
> > > Hi Greg,
> > >
> > > This is habanalabs pull request for the merge window of kernel 5.15.
> > > The commits divide roughly 50/50 between adding new features, such
> > > as peer-to-peer support with DMA-BUF or signaling from within a graph,
> > > and fixing various bugs, small improvements, etc.
> >
> > Pulled and pushed out, thanks!
> 
> NAK for adding dma-buf or p2p support to this driver in the upstream
> kernel. There needs to be a hard line between
> "I-can't-believe-its-not-a-drm-driver" drivers which bypass our
> userspace requirements, and I consider this the line.

Damm, the first time I try to take a vacation in 1 1/2 years, and stuff
like this happens :(

I've now dropped this from my branch and will write more next week when
I get a chance, sorry, don't have the chance to right now.

thanks,

greg k-h
