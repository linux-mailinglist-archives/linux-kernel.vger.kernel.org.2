Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081D336B75D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhDZRAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235086AbhDZRAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:00:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9251661165;
        Mon, 26 Apr 2021 17:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456410;
        bh=VO5/qIz1PxXpNEZeHnFflkxMsc36usf8qPI5vXrDsE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AvnqyIDFA7IMsZpt6fhA+YxYrzeU6c1zux4bdukJgDiu/+jIFFY7g6UG8BNBxq8M3
         pFByVF1Bo1mGrPYeB80VGOJ4tyjd3Uc9ZdbJeDrlH1+N5g1gOFiBodn5LkXo4CUHoT
         hyVlszw5X9lVEwqWFjbVu3x060+0DB7DyQIQGiSg=
Date:   Mon, 26 Apr 2021 19:00:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org,
        Kangjie Lu <kjlu@umn.edu>, Steven Price <steven.price@arm.com>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH 101/190] Revert "PCI: xilinx: Check for
 __get_free_pages() failure"
Message-ID: <YIbxl4xKyeci1lis@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-102-gregkh@linuxfoundation.org>
 <20210422104224.GB20094@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422104224.GB20094@lpieralisi>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 11:42:24AM +0100, Lorenzo Pieralisi wrote:
> On Wed, Apr 21, 2021 at 02:59:36PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 699ca30162686bf305cdf94861be02eb0cf9bda2.
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
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Steven Price <steven.price@arm.com>
> > Cc: Mukesh Ojha <mojha@codeaurora.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/pci/controller/pcie-xilinx.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> Hi Greg,
> 
> For this revert - the commit we are reverting looked and looks OK
> to me even though honestly I'd revert it just on principle given
> the nuisance it is causing.
> 
> Actually, we have code in -next that is removing the reverted content
> anyway (but not because it is bogus, code in -next is a nice clean-up
> for all PCI drivers from Marc):
> 
> https://git.kernel.org/lpieralisi/pci/c/161260e7f7bc
> 
> Again, happy to go ahead with the revert and rework the queued code
> on top of it, just let me know please.

I'll just drop this revert from my tree so as to not mess up your
follow-up cleanups, thanks for the review!

greg k-h
