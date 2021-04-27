Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E862136C7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbhD0O2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238380AbhD0O2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:28:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B498B61158;
        Tue, 27 Apr 2021 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619533680;
        bh=2IcaD0+CH0g/Xpybebx6LGjGKK6FZwcHxJlrhy8sVls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yhP9Hv6Le9f0q7zSRqMkVzWjCuBVmNaThrDgv9ad+VgF3U5646oQY8ufkLNWPfE73
         8dGXgyhQPqONmLKMM6nPFTrGPUiCMznAruKoXqdXDSP4mJepF2yJACXMMcy0Y13DM+
         8spT3p710GdQGshaD0mxJVuXdhvPI8zwee6kUVvk=
Date:   Tue, 27 Apr 2021 16:27:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 037/190] Revert "RDMA/core: Fix several reference count
 leaks."
Message-ID: <YIgfbZDo9eQ2tKvc@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-38-gregkh@linuxfoundation.org>
 <20210421141444.GL1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421141444.GL1370958@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:14:44AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 21, 2021 at 02:58:32PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 0b8e125e213204508e1b3c4bdfe69713280b7abd.
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
> > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/infiniband/core/sysfs.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> The original commit is certainly moving things closer to being correct
> but I'm concerned the entire area is still not bug free, it will take
> me some time to check the whole code. Reverting seems reasonable for
> now

I just re-reviewed it, and it looks like the original commit is ok, so I
will drop this.

But ugh, this is horrid code, you should NOT be dealing with "raw"
kobjects here at all, just to try to make a subdirectory tree.  That
causes a total mess as this function shows and probably should be
cleaned up sometime as obviously userspace tools are not properly seeing
the objects you are creating here (hint, you can not put a kobject below
a 'struct device' in the device tree and have udev and others see it
properly...)

But that's a topic for a later time, dropping this now.

greg k-h
