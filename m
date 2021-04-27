Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B97F36C7AB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbhD0OXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236173AbhD0OXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:23:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F788601FC;
        Tue, 27 Apr 2021 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619533341;
        bh=52cuv9rgliQItGFwo3D9r66WHR+fWima4w/b2GrPkng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=au1g00UVgrgsrx8ItHAzqCyjEbvHnpk0yqvKzfptlSd8cxLOvPcmf5izXr10JEkQu
         EHBHl4fE/XH3WoDhyMIuKnzJvgC6ed/hiSNi4vtSoomBztgyGNpcmtChJkJvrZrxmV
         Ik6K5QugIkI3DsSUX6H0EvmKLO7dE5XOBiuECOBQ=
Date:   Tue, 27 Apr 2021 16:22:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH 028/190] Revert "RDMA/rvt: Fix potential memory leak
 caused by rvt_alloc_rq"
Message-ID: <YIgeGqV7cV8YpNmQ@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-29-gregkh@linuxfoundation.org>
 <20210421141105.GK1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421141105.GK1370958@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:11:05AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 21, 2021 at 02:58:23PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 90a239ee25fa3a483facec3de7c144361a3d3a51.
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
> > Cc: Aditya Pakki <pakki001@umn.edu>
> > Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/infiniband/sw/rdmavt/qp.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> While I don't see anything obviously wrong here it is tricky enough
> that I would revert it unless Dennis says otherwise.

Thanks for the review, now dropped.

greg k-h
