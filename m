Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503E036C7AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbhD0OYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236173AbhD0OYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:24:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 540CF613CA;
        Tue, 27 Apr 2021 14:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619533411;
        bh=wxMCk6FE42glzCVLyNcAkgEYdiz3Sb9zPTFwq+jkznQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXxbCPK2BWuqIN3IIwLWKxiOcQ89xeGCXC3cAPm5lzHc7MTlXAcQNUTgfLC01498k
         EeIr6tTVgqKyf56HypAHQ6JiK8sRthbsZAGFm6zKs4P4mvNPOtKjF+FRCOjWeJkzta
         1koPCM7YO8tmhicAJsDPBYNOpDns+K95L8X7qMoU=
Date:   Tue, 27 Apr 2021 16:23:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH 107/190] Revert "RDMA/i40iw: Handle workqueue allocation
 failure"
Message-ID: <YIgeYbg3wTPOtZO1@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-108-gregkh@linuxfoundation.org>
 <20210421140700.GH1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421140700.GH1370958@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:07:00AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 21, 2021 at 02:59:42PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit e2a438bd7116889af36304903b92e56d0f347228.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Kangjie Lu <kjlu@umn.edu>
> > Cc: Shiraz, Saleem <shiraz.saleem@intel.com>
> > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/infiniband/hw/i40iw/i40iw.h      |  2 +-
> >  drivers/infiniband/hw/i40iw/i40iw_cm.c   | 18 +++---------------
> >  drivers/infiniband/hw/i40iw/i40iw_main.c |  5 +----
> >  3 files changed, 5 insertions(+), 20 deletions(-)
> 
> I don't see a reason to revert this one, the new code structure
> appears OK

Thanks, now dropped.

greg k-h
