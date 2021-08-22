Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135A03F3FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 16:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhHVOdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 10:33:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233083AbhHVOdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 10:33:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F95C6108F;
        Sun, 22 Aug 2021 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629642793;
        bh=/M5M7M3uw6bD5MioVp4OF7lrydKW9ZZEFDacWYufkr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vWAkUtJCQLnIwksGvXDOZap94qbPWwjhfCMpsbJWxz8vW1T3NU7PnzMrtWyyAvjM2
         Co7o4jjfhRZBCwn4SD444ghrdd0yvNT5XC6kiu31Gn6FwriROgaxD3SgrJTFpFn4Uh
         rs/hbPk9rABbkfowHUPdpxB0tDoCv9YTHZ4BbrX8=
Date:   Sun, 22 Aug 2021 16:33:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: TODO list for staging/r8188eu
Message-ID: <YSJgJFEIGQEo30jB@kroah.com>
References: <1897566.d8lQ4HMSh1@localhost.localdomain>
 <YSJE6aoH96kh777R@kroah.com>
 <2099975.VbY6Rib6K3@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2099975.VbY6Rib6K3@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 03:50:14PM +0200, Fabio M. De Francesco wrote:
> On Sunday, August 22, 2021 2:36:57 PM CEST Greg Kroah-Hartman wrote:
> > On Sun, Aug 22, 2021 at 09:41:20AM +0200, Fabio M. De Francesco wrote:
> > > Dear Larry, Philip,
> > > 
> > > >From what I understand how the development process works, drivers in 
> staging
> > > 
> > > should have a to-do list in the TODO file. Please read https://
> www.kernel.org/
> > > doc/html/latest/process/2.Process.html?highlight=todo#staging-trees.
> > > 
> > > Could you (as the maintainers of the r8188eu driver) please compile and
> > > provide the above mentioned list?
> > 
> > Why don't you provide an initial list for people to work off of if you
> > feel it is needed here?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Unfortunately I'm not able to tell what is needed to do to have a driver 
> improved so that it can be moved off staging. This work should be better 
> addressed by someone who is much more experienced.
> 
> For example, I read from other drivers TODO lists that cfg80211 and lib80211 
> are required but I don't know what they are.

Those are two things that are also required here as well, like all
in-kernel wifi drivers.

