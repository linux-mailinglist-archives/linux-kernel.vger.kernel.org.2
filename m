Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B9036C5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbhD0L73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236239AbhD0L71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:59:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F05B0613A9;
        Tue, 27 Apr 2021 11:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619524722;
        bh=5MTMNM5RSDl4Om4CpxSiD96er3h4pL0xwKThZ2dAJNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwHIuycfiLE8SC2/Bq4lpvTvGDkyXC+1JhzOwlxH9JT9gvgv5i3ZFPvHISi38741t
         FPmh6nELrMbuB8Bbar8QKn23dupryqlQDx+FAztE+0+TXRGouiL5wzo4OKs6PHqViP
         33hu/sTvEThnOc3dVczmNrFBpPc1Kq035pE0vfzU=
Date:   Tue, 27 Apr 2021 13:58:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 042/190] Revert "ASoC: fix incomplete error-handling in
 img_i2s_in_probe."
Message-ID: <YIf8b0cHh5THMAjJ@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-43-gregkh@linuxfoundation.org>
 <87im4fa4tn.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im4fa4tn.fsf@tynnyri.adurom.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 09:08:20PM +0300, Kalle Valo wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > This reverts commit 25bf943e4e7b47282bd86ae7d39e039217ebb007.
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
> > Cc: Qiushi Wu <wu000273@umn.edu>
> > Cc: https
> 
> Cc https looks wrong.

My script sucks, sorry about that, will fix up...

thanks,

greg k-h
