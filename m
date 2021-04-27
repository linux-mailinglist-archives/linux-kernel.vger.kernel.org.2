Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE7136C7C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbhD0O3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236395AbhD0O3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:29:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF0F4611ED;
        Tue, 27 Apr 2021 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619533732;
        bh=qguW6x5iRS4Xzu5FMCao6iMXdBvVld/tXB0kl4A2XkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AKsF0yyMHuiB3Vq/q8SkQKdeoLxp9RY9ux991eX3+BCPREFryNAB2+oeVaX4y+P0z
         B7q2nJa1n0Bt6DUFiElEjC/0kmTWxAny1tTLOs/El8WZq83tYc3WR031NVSCTtgSDP
         ruD+WjS6D5MXp7inP+rmDQ58k9OwMekR7WtkWXu0=
Date:   Tue, 27 Apr 2021 16:28:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 166/190] Revert "infiniband: bnxt_re: qplib: Check the
 return value of send_message"
Message-ID: <YIgforZFaTAYyLy8@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-167-gregkh@linuxfoundation.org>
 <20210421140844.GI1370958@nvidia.com>
 <CANjDDBhAbobpc1nQLoPABCm5onv=qVoJXLyG79RJwxS=cNnijA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBhAbobpc1nQLoPABCm5onv=qVoJXLyG79RJwxS=cNnijA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 07:45:34PM +0530, Devesh Sharma wrote:
> On Wed, Apr 21, 2021 at 7:38 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Wed, Apr 21, 2021 at 03:00:41PM +0200, Greg Kroah-Hartman wrote:
> > > This reverts commit 94edd87a1c59f3efa6fdf4e98d6d492e6cec6173.
> > >
> > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > faith" to try to test the kernel community's ability to review "known
> > > malicious" changes.  The result of these submissions can be found in a
> > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > >
> > > Because of this, all submissions from this group must be reverted from
> > > the kernel tree and will need to be re-reviewed again to determine if
> > > they actually are a valid fix.  Until that work is complete, remove this
> > > change to ensure that no problems are being introduced into the
> > > codebase.
> > >
> > > Cc: Aditya Pakki <pakki001@umn.edu>
> > > Cc: Devesh Sharma <devesh.sharma@broadcom.com>
> > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/qplib_sp.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > Can't see a reason to revert this one, I re-checked the callers error
> > paths and it looks OK
> >
> > Jason
> Acked-By: Devesh Sharma <devesh.sharma@broadcom.com>

Thanks for the review, I'll drop this as the original looks ok for now.

greg k-h
