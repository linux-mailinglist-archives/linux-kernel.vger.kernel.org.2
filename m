Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5846736C742
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbhD0NuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235652AbhD0NuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:50:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8A956101C;
        Tue, 27 Apr 2021 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619531370;
        bh=8NJBq5u9dPfD+l/DcWGIoZcpJqpM43/cqhPQGmIRgXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pcx/wXcri8+iffH/IcvAz8Isb522YtRnBbSXimO/oWJ2gwSlyCPhWwwZ6SBbpy5Ds
         v/h7KdCp8j2P3ofI4/Xqiyv/XTgZhxDrFD9bAUYwbTX7JV2JuY2vUayPyyAY8lyVZN
         UyuN+2a22GysFfihWsvUzAGdhq6Vp0CdYT0PUuMY=
Date:   Tue, 27 Apr 2021 15:49:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>
Subject: Re: [PATCH 080/190] Revert "ALSA: usx2y: fix a double free bug"
Message-ID: <YIgWZ2fSLKPT4GGw@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-81-gregkh@linuxfoundation.org>
 <s5hczunaa54.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hczunaa54.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:13:27PM +0200, Takashi Iwai wrote:
> On Wed, 21 Apr 2021 14:59:15 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > This reverts commit cbb88db76a1536e02e93e5bd37ebbfbb6c4043a9.
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
> > Cc: Wenwen Wang <wang6495@umn.edu>
> > Cc: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I examined the change again, and confirmed that this code change
> itself is correct, so it's not necessary to revert.
> 
> OTOH, it's just a tip of iceberg in this driver, and maybe it's better
> to cover all in a better way.  So it's fine to revert this, either.

I'll drop the revert, many thanks for the review.

greg k-h
