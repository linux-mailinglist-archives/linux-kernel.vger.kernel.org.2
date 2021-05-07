Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD813764FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 14:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbhEGMSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 08:18:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEGMR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 08:17:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52F136100C;
        Fri,  7 May 2021 12:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620389820;
        bh=kAX2q89zUtg6sddYFznN3zI0usUIbWNAgbcEr0LdgvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dIh4wS9Hf68ZridKp3QQ+6CswDF7lqGkm/LgDp5KYMHEUl6Miv1rpxCz41sOWurl6
         llgRXoYMhIlGKMTxnTM3o+O4pfSDsUR/apxe2/RTdAQDhOv+tRI02zA4/E9VDoeUZo
         SkLUZv5PzaasJOvguVe/lrbC30Aw52z92ITjbOzs=
Date:   Fri, 7 May 2021 14:16:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rapidio: fix unused variable warning in rio_cm.c
Message-ID: <YJUvuEYDbAWUb27y@kroah.com>
References: <20210506181837.4758-1-mail@anirudhrb.com>
 <YJTgmXwZyOgFPIHf@kroah.com>
 <YJUtHCSm//0PlyYf@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YJUtHCSm//0PlyYf@anirudhrb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 05:35:48PM +0530, Anirudh Rayabharam wrote:
> On Fri, May 07, 2021 at 08:39:21AM +0200, Greg KH wrote:
> > On Thu, May 06, 2021 at 11:48:36PM +0530, Anirudh Rayabharam wrote:
> > > GCC produces an unused variable warning for 'rc':
> > > 
> > > 	drivers/rapidio/rio_cm.c: In function ‘rio_txcq_handler’:
> > > 	drivers/rapidio/rio_cm.c:673:7: warning: variable ‘rc’ set but
> > > 	not used [-Wunused-but-set-variable]
> > > 
> > > The return value of rio_add_outb_message() is assigned to 'rc' but it
> > > is never used. Fix this warning by logging an error if 'rc' is non-zero.
> > > 
> > > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > > ---
> > > 
> > > Changes in v2:
> > > Log an error instead of just removing 'rc'.
> > > 
> > > v1: https://lore.kernel.org/lkml/20210501055018.9244-1-mail@anirudhrb.com/
> > > 
> > > ---
> > >  drivers/rapidio/rio_cm.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
> > > index 50ec53d67a4c..971a36f1a23a 100644
> > > --- a/drivers/rapidio/rio_cm.c
> > > +++ b/drivers/rapidio/rio_cm.c
> > > @@ -677,6 +677,11 @@ static void rio_txcq_handler(struct cm_dev *cm, int slot)
> > >  			cm->tx_buf[cm->tx_slot] = req->buffer;
> > >  			rc = rio_add_outb_message(cm->mport, req->rdev, cmbox,
> > >  						  req->buffer, req->len);
> > > +			if (rc) {
> > > +				riocm_error("Failed to add msg to tx queue (err=%d)",
> > > +						rc);
> > 
> > That's pretty pointless (and no need for {}).
> 
> The point is that this fixes the compiler warning.

Don't blindly fix warnings in ways to just shut a compiler up.  Fix the
issue correctly please.

> > If an error happens, properly recover from it, don't just punt and tell
> > the user something bad happened and then ignore it.
> 
> The primary motivation behind this patch is to fix the compiler warning.
> This error is ignored even in the current tree. My patch at least logs it
> so that people know that it's happening. And once they know that it's
> happening and someone wants to propagate the error code to userspace or
> handle it differently they can write a patch to do so.

Please write that patch, as-is, this change is pointless.

thanks,

greg k-h
