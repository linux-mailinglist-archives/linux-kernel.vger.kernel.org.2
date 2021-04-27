Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4271736C692
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhD0M74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235426AbhD0M7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:59:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E52B61078;
        Tue, 27 Apr 2021 12:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619528351;
        bh=ESKTBZsp+jdcnnEU+hs5tiFXVi31SwaiDmt++kqSFSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJ4DHVKUW7CgxJukxkD/A53N+16wSq4QSOABZo2cB1X9ZwUToUB7V9J9wO3pBj+eb
         VqcDVENvIPsDw0JeB1AEv1s2pmU6Xzxdj99b2nl2nyAwQpBvulTi8YOjjrmE4XjE2n
         ClTzqymidbpgO/hLGBh+msRGZWFpmtTC6FXa3Fmk=
Date:   Tue, 27 Apr 2021 14:59:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 095/190] Revert "rtlwifi: fix a potential NULL pointer
 dereference"
Message-ID: <YIgKnKwtiUUCxX2d@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-96-gregkh@linuxfoundation.org>
 <20210427010457.rk7t6p2zs3d2eudn@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427010457.rk7t6p2zs3d2eudn@bryanbrattlof.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 01:21:49AM +0000, Bryan Brattlof wrote:
> On Wed, Apr 21, 2021 at 02:59:30PM +0200, Greg Kroah-Hartman wrote:
> >
> >This reverts commit 765976285a8c8db3f0eb7f033829a899d0c2786e.
> >
> >Commits from @umn.edu addresses have been found to be submitted in "bad
> >faith" to try to test the kernel community's ability to review "known
> >malicious" changes.  The result of these submissions can be found in a
> >paper published at the 42nd IEEE Symposium on Security and Privacy
> >entitled, "Open Source Insecurity: Stealthily Introducing
> >Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> >of Minnesota) and Kangjie Lu (University of Minnesota).
> >
> >Because of this, all submissions from this group must be reverted from
> >the kernel tree and will need to be re-reviewed again to determine if
> >they actually are a valid fix.  Until that work is complete, remove this
> >change to ensure that no problems are being introduced into the
> >codebase.
> >
> >Cc: Kangjie Lu <kjlu@umn.edu>
> >Cc: Kalle Valo <kvalo@codeaurora.org>
> >Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >---
> > drivers/net/wireless/realtek/rtlwifi/base.c | 5 -----
> > 1 file changed, 5 deletions(-)
> >
> >diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
> >index 6e8bd99e8911..1d067536889e 100644
> >--- a/drivers/net/wireless/realtek/rtlwifi/base.c
> >+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
> >@@ -452,11 +452,6 @@ static void _rtl_init_deferred_work(struct ieee80211_hw *hw)
> > 	/* <2> work queue */
> > 	rtlpriv->works.hw = hw;
> > 	rtlpriv->works.rtl_wq = alloc_workqueue("%s", 0, 0, rtlpriv->cfg->name);
> >-	if (unlikely(!rtlpriv->works.rtl_wq)) {
> >-		pr_err("Failed to allocate work queue\n");
> >-		return;
> >-	}
> >-
> >
> 
> Hey Greg!
> 
> If you're still working on this series, this patch looks to be a 
> legitimate fix for the potential NULL pointer.
> 
> However we should probably inform 'rtw_init_core()' of this failure in 
> addition to printing about it.
> 
> Do you want to apply this revert and I send a fix after this has made 
> its way through?

I'll keep this revert as the "unlikely()" should never be used for
something trivial like this (the compiler and CPU does a better job),
and printing an error message also doesn't help much.

I'll fix this up with a "simpler" version that does this properly by
propagating the error backwards...

thanks,

greg k-h
