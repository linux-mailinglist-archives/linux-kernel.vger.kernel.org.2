Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092E236C74A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbhD0NwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236074AbhD0NwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:52:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 753E5613DE;
        Tue, 27 Apr 2021 13:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619531488;
        bh=LsKG6phfVxtit0ggx289nutFu1Nb6sD54qLzAi2d8u8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6cU7s7Ei0FoqPW71mE5jbL2S8y4jUpzKTM3hcly11np9HvJS1LUV8nJ40XUnJKKM
         v5DyveS5J11wBKYDPbn0PRf2vaLtftuBUs4jk0HHDMleFFvJDTem6ub08qZefxX5rn
         a4GzeGRfHiSn6qjuNS/ybREM1QfkV9NQySPrTvf8=
Date:   Tue, 27 Apr 2021 15:51:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 127/190] Revert "ALSA: sb8: add a check for
 request_region"
Message-ID: <YIgW3cupx+Qo2jNT@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-128-gregkh@linuxfoundation.org>
 <s5hbla7a9rt.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hbla7a9rt.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:21:26PM +0200, Takashi Iwai wrote:
> On Wed, 21 Apr 2021 15:00:02 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > This reverts commit dcd0feac9bab901d5739de51b3f69840851f8919.
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
> > Cc: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This code change itself looks OK, OTOH, the original commit message is
> slightly wrong: the code path can never result in NULL deference in
> this case, as it's just an optional resource reservation.  So, it's
> safe to revert this.

Thanks for the review!

greg k-h
