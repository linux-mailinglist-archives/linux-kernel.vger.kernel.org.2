Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679E336C7AE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbhD0OYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236173AbhD0OYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:24:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8311D613DD;
        Tue, 27 Apr 2021 14:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619533444;
        bh=m6Lf8x6CvrTavho0MtOyI6pNKYhwTlMlVg8ySs6c9tQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XE2ySLvKkZrGwxXE1xg2112VBPypPP5uUf075wcAVo1/ElU9opLSQqWLafPYAUihf
         tiS1Jrkx4vF2uJlwqecMA3WE/J2UPnmmPfZ2frBuWkSiYXd452KIqTKEQfIlBRcQMO
         KMVNPcaHbSFiJxq9msP+EQzLn/0Qy/9pKqfi8nRI=
Date:   Tue, 27 Apr 2021 16:24:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 059/190] Revert "RDMA/srpt: Remove unnecessary assertion
 in srpt_queue_response"
Message-ID: <YIgege5WK+jwOXXA@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-60-gregkh@linuxfoundation.org>
 <20210421140247.GG1370958@nvidia.com>
 <20210421140553.GA2268573@nvidia.com>
 <ab214d8e-bc80-ddfe-10e9-25389f84471b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab214d8e-bc80-ddfe-10e9-25389f84471b@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 09:05:44AM -0700, Bart Van Assche wrote:
> On 4/21/21 7:05 AM, Jason Gunthorpe wrote:
> > On Wed, Apr 21, 2021 at 11:02:47AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Apr 21, 2021 at 02:58:54PM +0200, Greg Kroah-Hartman wrote:
> > > > This reverts commit 9f48db0d4a08624bb9ba847ea40c8abad753b396.
> > > > 
> > > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > > faith" to try to test the kernel community's ability to review "known
> > > > malicious" changes.  The result of these submissions can be found in a
> > > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > > > 
> > > > Because of this, all submissions from this group must be reverted from
> > > > the kernel tree and will need to be re-reviewed again to determine if
> > > > they actually are a valid fix.  Until that work is complete, remove this
> > > > change to ensure that no problems are being introduced into the
> > > > codebase.
> > > > 
> > > > Cc: https
> > > > Cc: Aditya Pakki <pakki001@umn.edu>
> > > > Cc: Bart Van Assche <bvanassche@acm.org>
> > > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >   drivers/infiniband/ulp/srpt/ib_srpt.c | 2 ++
> > > >   1 file changed, 2 insertions(+)
> > > 
> > > I think this one is fine
> > 
> > Sorry, I realize that is unclear. I mean I don't see a reason to
> > revert this patch.
> 
> Greg, I share Jason's opinion and would like to see this revert dropped. The
> function srpt_queue_response() dereferences the 'ch' pointer before the
> BUG_ON(ch) statement is reached. I think this makes the BUG_ON() statement
> that would be reintroduced by this revert superfluous.

Thanks for the review, I will go drop this commit from my tree.

greg k-h
