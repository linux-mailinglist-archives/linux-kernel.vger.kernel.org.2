Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A4B36C809
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbhD0OyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236943AbhD0OyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:54:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8D75613DE;
        Tue, 27 Apr 2021 14:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619535199;
        bh=Cg9dZ/bwJ+LH6mBl7V28r68SIjlSlF2kK6y9UVYKAsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o61yF0XqA4UU/SrYZTTOLaKmB2eHHhsobYyy+c5nbUlTYrgq54dyl7TlDd0bGAklD
         G73bpXd3Zxid0cPhB9bM8QgIYh1nnoppUwAK8ToeUcmRpH/Z1FvmZGg+UcTMCKF25v
         n522W03oGJp6vs3sN37q65e1jW49K2Z3QFDdoN6k=
Date:   Tue, 27 Apr 2021 16:53:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 092/190] Revert "power: charger-manager: fix a potential
 NULL pointer dereference"
Message-ID: <YIglXcChwL4M78mz@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-93-gregkh@linuxfoundation.org>
 <20210421160248.fveahtwspxa53fft@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421160248.fveahtwspxa53fft@earth.universe>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:02:48PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Apr 21, 2021 at 02:59:27PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 75cf4f5aa903604e1bd7bec2c0988d643c6fb946.
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
> > Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> 
> Doing another review:
> 
> create_freezable_workqueue can return NULL when allocations fails
> and it is the first call in late init call, so it's fine to just
> exit with -ENOMEM.
> 
> I suggest to drop the revert.

Many thanks for doing the review, I have now dropped it.

greg k-h
