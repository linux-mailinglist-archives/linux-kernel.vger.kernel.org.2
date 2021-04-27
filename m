Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5684F36C7AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbhD0OZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236173AbhD0OZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:25:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFB2161164;
        Tue, 27 Apr 2021 14:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619533488;
        bh=D6/tPVWwdIlVojljBJJ+4c827849byCmpduvyrKp+Ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hXaIUhOykM7OPN14mqkskpRP1x3wb1qK3xpkJKyzDpag0PBsdniKLK3ZLhqzFWU1i
         KQ7iwF6p+DfZRmbrfeKUdqc/D2YCZ38FpppOVyzOuwhBi6X/IYeNioHam7QJ2Z3QKF
         yX7t1EesTrp9jfk/CtSild1kQyQ3mNVjuqeIzkEY=
Date:   Tue, 27 Apr 2021 16:24:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 044/190] Revert "RDMA/pvrdma: Fix missing pci disable in
 pvrdma_pci_probe()"
Message-ID: <YIgereSjCqb3a+SX@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-45-gregkh@linuxfoundation.org>
 <20210421141031.GJ1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421141031.GJ1370958@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:10:31AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 21, 2021 at 02:58:39PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit db857e6ae548f0f4f4a0f63fffeeedf3cca21f9d.
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
> > Cc: https
> > Cc: Qiushi Wu <wu000273@umn.edu>
> > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Can't see a reason to revert this one

thanks for the review, will drop this from my tree.

greg k-h
