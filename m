Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CDD36C750
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbhD0NyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236074AbhD0NyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:54:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 131AD6101E;
        Tue, 27 Apr 2021 13:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619531611;
        bh=bdayeZlGT44icqqNC/aLu4vVwYiNwhseSegnyWX2UOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KdVtLwhNpZXI1ycVOnSzgSu3T+JJs0Rj+T5Ae/CbCRthXGn5y1U3O6pBTS/l+BpVm
         KWO5nTJqSMLWq0qPl4fKrzqVdttM5Ye1QKE85sODQa2gO79prlMIubHEEB3jnJLme8
         l7POCNtw9ExtogGh9gItFSoI1QUZcY/TCo/fY3Rg=
Date:   Tue, 27 Apr 2021 15:53:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 130/190] Revert "ALSA: usx2y: Fix potential NULL pointer
 dereference"
Message-ID: <YIgXWbaWi3dYlK2Y@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-131-gregkh@linuxfoundation.org>
 <s5ha6pra9oo.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ha6pra9oo.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:23:19PM +0200, Takashi Iwai wrote:
> On Wed, 21 Apr 2021 15:00:05 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > This reverts commit a2c6433ee5a35a8de6d563f6512a26f87835ea0f.
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
> This is same like the revert#80, the code change itself seems correct,
> but it's a pretty minor error path, probably no one would hit.
> So, feel free to revert if it's in doubt.
> 
> 
> thanks,
> 
> Takashi
> 
> > ---
> >  sound/usb/usx2y/usb_stream.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/sound/usb/usx2y/usb_stream.c b/sound/usb/usx2y/usb_stream.c
> > index 091c071b270a..6bba17bf689a 100644
> > --- a/sound/usb/usx2y/usb_stream.c
> > +++ b/sound/usb/usx2y/usb_stream.c
> > @@ -91,12 +91,7 @@ static int init_urbs(struct usb_stream_kernel *sk, unsigned use_packsize,
> >  
> >  	for (u = 0; u < USB_STREAM_NURBS; ++u) {
> >  		sk->inurb[u] = usb_alloc_urb(sk->n_o_ps, GFP_KERNEL);
> > -		if (!sk->inurb[u])
> > -			return -ENOMEM;
> > -
> >  		sk->outurb[u] = usb_alloc_urb(sk->n_o_ps, GFP_KERNEL);
> > -		if (!sk->outurb[u])
> > -			return -ENOMEM;

This leaks memory if the error path is hit, so I'm going to keep this
revert as it it needs to be handled properly.  And really, this code
path is impossible to hit...

thanks,

greg k-h
