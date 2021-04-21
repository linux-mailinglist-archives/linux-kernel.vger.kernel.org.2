Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2CF367023
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242737AbhDUQaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:30:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235145AbhDUQ37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:29:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3679C61409;
        Wed, 21 Apr 2021 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619022564;
        bh=9yMXSjByXWcBItKUjet7O6qBYUE0pB8nGLKv0D6XPps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MkXneijPx3yGKofJXfNH2xyqeokmWs4GCqxs1uUyFEk6aeYjXGNHXrcZsrrocZJWA
         7m3V+ItAfwxnHjxwm/TlCfQe2lvsaeDI+FslMorvOMqXSMN4PnuP0Ld/S4SriYj7SA
         Al+fWX+IlZ4WxC9/KLCbOtgdFeheP6zJDTIXSfHg=
Date:   Wed, 21 Apr 2021 18:29:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 159/190] Revert "ALSA: gus: add a check of the status of
 snd_ctl_add"
Message-ID: <YIBS4jqqPgWy5RRx@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-160-gregkh@linuxfoundation.org>
 <s5h7dkva9go.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h7dkva9go.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:28:07PM +0200, Takashi Iwai wrote:
> On Wed, 21 Apr 2021 15:00:34 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > This reverts commit 0f25e000cb4398081748e54f62a902098aa79ec1.
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
> This code change simply adds an error message print out, so it doesn't
> actually fix anything, per se (although the code change itself is
> fine).  Feel free to revert.

Many thanks for the reviews!

greg k-h
