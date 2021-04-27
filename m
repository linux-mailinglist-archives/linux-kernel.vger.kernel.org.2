Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8039B36C7D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238382AbhD0OhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236173AbhD0Og7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:36:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5A19611ED;
        Tue, 27 Apr 2021 14:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619534176;
        bh=yCETJJmxhHYww65mXkY6GWSNZ0gE6JoG/QlayrvFeEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VapxSDZKhIf2kIB5UaY6zoo2xKmKFzFLvQMPjV25vZT4bZxYKV9E/crU2CpjlCkQ1
         /KlEbOB4dOVYpmuHc+zlJWvjOT6rt7xx/DI8HIAhOq8k15mvW8KOiHDvtVfdS+qKJJ
         rU38r+WeSrvgC9l04ompueCoTnkqwuYuy9dQGy8c=
Date:   Tue, 27 Apr 2021 16:36:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 045/190] Revert "usb: gadget: fix potential double-free
 in m66592_probe."
Message-ID: <YIghXoxc/h9/t679@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-46-gregkh@linuxfoundation.org>
 <87czummtnw.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czummtnw.fsf@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 02:43:15PM +0300, Felipe Balbi wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > This reverts commit 44734a594196bf1d474212f38fe3a0d37a73278b.
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
> > Cc: Felipe Balbi <balbi@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/usb/gadget/udc/m66592-udc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/udc/m66592-udc.c b/drivers/usb/gadget/udc/m66592-udc.c
> > index 931e6362a13d..75d16a8902e6 100644
> > --- a/drivers/usb/gadget/udc/m66592-udc.c
> > +++ b/drivers/usb/gadget/udc/m66592-udc.c
> > @@ -1667,7 +1667,7 @@ static int m66592_probe(struct platform_device *pdev)
> >  
> >  err_add_udc:
> >  	m66592_free_request(&m66592->ep[0].ep, m66592->ep0_req);
> > -	m66592->ep0_req = NULL;
> 
> harmless, can be reverted and left reverted, I guess.

I'll drop it, thanks.

greg k-h
