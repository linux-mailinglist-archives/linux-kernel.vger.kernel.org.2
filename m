Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E45236FA00
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 14:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhD3MTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 08:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232736AbhD3MSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 08:18:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7A1A60249;
        Fri, 30 Apr 2021 12:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619785074;
        bh=tOCogmVNxmjV78pkQC6x1nqdqq2lnBYT5qR52UQRme8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0BhLbTXpHz/Ym4Vc/JiWYoou5ncMrdUye22i8s3BCbydUq4WVI2sXlhApILenhrVx
         qEoiSQO8qp+8jj85PX+LZmedsUirbgkGJlotN70F/hLqidRtn3FyTzzDEZma3t+D+u
         78Pi5l6yq3Zq6AEFWGTRUlBimrBfTRlPbBhAuRBM=
Date:   Fri, 30 Apr 2021 14:17:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 074/190] Revert "drm/gma500: fix memory disclosures due
 to uninitialized bytes"
Message-ID: <YIv1cJyvGHiTCE64@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-75-gregkh@linuxfoundation.org>
 <CAKMK7uF6sWeKX0DAaXoT9=xkD9eAAjHtkE0gn+v9YxmYAd3vdg@mail.gmail.com>
 <YIgVDakyru+kuhoV@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIgVDakyru+kuhoV@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 03:43:41PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 21, 2021 at 07:51:49PM +0200, Daniel Vetter wrote:
> > On Wed, Apr 21, 2021 at 3:06 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This reverts commit ec3b7b6eb8c90b52f61adff11b6db7a8db34de19.
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
> > > Cc: Kangjie Lu <kjlu@umn.edu>
> > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Cc: https
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > 
> > gma500 is dead enough I'm not going to spend a single cycle thinking
> > whether this fixes anything or not and hence whether the revert is ok
> > or not.
> 
> Sounds good to me, I'll keep the reverts.

I've re-reviewed this one, and it seems sane, so I'll drop the revert.

thanks,

greg k-h
