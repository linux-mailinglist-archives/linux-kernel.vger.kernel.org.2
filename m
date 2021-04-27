Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A6C36C78E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbhD0OLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236226AbhD0OLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:11:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2987F613D9;
        Tue, 27 Apr 2021 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619532630;
        bh=uYZ2tZ69QyJAs3Q0rJ2tLT7GUXtURR5Ic9wP2sFVpos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQxEmMjcnKHb9xGCG0RBpAptESouXPO5EZWiHTOMVxIEFLCdcBXecFa0apbzQs28D
         CFG89QWGopmlGW2EjXUyxJQrCjjYAchETagMtBxN+suLMx6x5PMNe3C8lh0YuR12pw
         i45asQb1Q3zPr+dVhElD9PYppEAWmIzja0Xw1O3Q=
Date:   Tue, 27 Apr 2021 16:10:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, stable@kernel.org,
        Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 051/190] Revert "power: supply: core: fix memory leak in
 HWMON error path"
Message-ID: <YIgbVJYH1GVbymjo@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-52-gregkh@linuxfoundation.org>
 <20210421155101.n2mbmhj6x42i3a4l@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421155101.n2mbmhj6x42i3a4l@earth.universe>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 05:51:01PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Apr 21, 2021 at 02:58:46PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 1d7a7128a2e9e1f137c99b0a44e94d70a77343e3.
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
> > Cc: stable@kernel.org
> > Cc: Qiushi Wu <wu000273@umn.edu>
> > Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> 
> Change is quite simple, so doing another review now:
> 
> It is correct that power_supply_hwmon_bitmap_free() must be called
> when devm_add_action() fails. This is not already done in the error
> path, so the original patch is correct and the revert reintroduces a
> memory leak in error path.
> 
> I suggest dropping the revert.

Now dropped, thanks!

greg k-h
