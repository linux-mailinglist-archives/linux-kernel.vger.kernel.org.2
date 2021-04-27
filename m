Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65B436C7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbhD0OpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236368AbhD0OpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:45:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F4C561076;
        Tue, 27 Apr 2021 14:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619534670;
        bh=/Flk0L8IOLTvYCME65GEziwXGgXOfECVlbalrQ9kBjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K2JxEhvfeUFIgE6r8zxuBsj9wbktwKO1QscB0S30giUq0Yl6fFikX6AO8gRvfsg7x
         DIzPzffvy+6Nffj0gmVsOyLLJtEGh3gUIyu9fTp0VHcNhlT6nQX2izolcLua9DOVvG
         89wwh6M30yevc4H5A3ch76D91uuns9IF1xCdFLR0=
Date:   Tue, 27 Apr 2021 16:44:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 142/190] Revert "rtc: hym8563: fix a missing check of
 block data read"
Message-ID: <YIgjS7glkOaVxUYK@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-143-gregkh@linuxfoundation.org>
 <YIA2cnzudsZJJI+Y@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIA2cnzudsZJJI+Y@piout.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 04:28:02PM +0200, Alexandre Belloni wrote:
> Hello,
> 
> On 21/04/2021 15:00:17+0200, Greg Kroah-Hartman wrote:
> > This reverts commit 9a20b5e35a536d6bb4b2d4a3b14a0457e205356c.
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
> 
> There is really nothing wrong in the patch, it was not completely useful
> but not wrong either.

Thanks for the review, I'll drop it.

greg k-h
