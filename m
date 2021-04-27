Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982C436C75E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbhD0Nz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236144AbhD0Nzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:55:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDBAF6127A;
        Tue, 27 Apr 2021 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619531709;
        bh=HpSDgK/4FUwakRY0wovQfyQIAkiBjWyFDavSqWBNzcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSj0PTvfkdjUAVqvsFW0wJw+DAgPopqy21ZJPLSch62nBXolJxXK4SFv5jB7d9BHl
         Dfs372qCgvHV1FAq/qlItVg0V9+QUNk9xic+t4bRxGxVkFj9e9aUAuwICHqJXyxJqK
         3JVD96fbKppErg2REZ01TvD47jsvKzqOiyO0SfRY=
Date:   Tue, 27 Apr 2021 15:55:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 158/190] Revert "ALSA: sb: fix a missing check of
 snd_ctl_add"
Message-ID: <YIgXuhKeyrfVZ3F1@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-159-gregkh@linuxfoundation.org>
 <s5h8s5ba9jj.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8s5ba9jj.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:26:24PM +0200, Takashi Iwai wrote:
> On Wed, 21 Apr 2021 15:00:33 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > This reverts commit beae77170c60aa786f3e4599c18ead2854d8694d.
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
> > Cc: Aditya Pakki <pakki001@umn.edu>
> > Cc: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> The original code change is fine, it's just adding an error return.
> OTOH, it would be safe even if we ignore the error, too (the mixer
> element is optional), and the driver is quite legacy.
> That said, feel free to revert it.

Thanks for the review, I'll keep it.

greg k-h
