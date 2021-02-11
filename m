Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF43191B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhBKR54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:57:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:46190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231281AbhBKR3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:29:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7013364E7A;
        Thu, 11 Feb 2021 17:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613064535;
        bh=YGhTFXKEWgd7dqY4W1LGarZMEsIro2Rz2rQ+w3qtQCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YkGs0ryRSaWrxTpFIGLjnqYiIXSNCPu9jB6l9ax+VY1KUUS+dCriGAzI3JqQxCR61
         DjcsTjgIrSUvLs8xrBMoE+O5QSEqZmTB8l8Xi6EUXa0py4vPFbTwlY3GFDmffguq4h
         KYQJA79MAISKexkwmuI9sXcbpIF+YNQXzYtC3T/0=
Date:   Thu, 11 Feb 2021 18:28:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Mairo P. Rufus" <akoudanilo@gmail.com>
Cc:     devel@driverdev.osuosl.org, trivial@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Fix comments typos
Message-ID: <YCVpVDrga1QYbKWN@kroah.com>
References: <YCQSKNYU7zhcKHHl@kroah.com>
 <C96UXUQZSWD6.1BZ2DYOVBDNYL@uncertain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C96UXUQZSWD6.1BZ2DYOVBDNYL@uncertain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 05:55:18PM +0100, Mairo P. Rufus wrote:
> > Hi,
> >
> > This is the friendly patch-bot of Greg Kroah-Hartman. You have sent him
> > a patch that has triggered this response. He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created. Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> >
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> >
> > - You did not specify a description of why the patch is needed, or
> > possibly, any description at all, in the email body. Please read the
> > section entitled "The canonical patch format" in the kernel file,
> > Documentation/SubmittingPatches for what is needed in order to
> > properly describe the change.
> >
> > - You did not write a descriptive Subject: for the patch, allowing Greg,
> > and everyone else, to know what this patch is all about. Please read
> > the section entitled "The canonical patch format" in the kernel file,
> > Documentation/SubmittingPatches for what a proper Subject: line should
> > look like.
> >
> > If you wish to discuss this problem further, or you have questions about
> > how to resolve this issue, please feel free to respond to this email and
> > Greg will reply once he has dug out from the pending patches received
> > from other developers.
> >
> > thanks,
> >
> > greg k-h's patch email bot
> 
> After double checking, I still can't figure out what I did wrong. I'm
> sorry for abusing your time, but can you help me on this one?

You don't quote your changelog text here, so it's hard to determine what
needs to be done.

But your subject line could use a lot of work, don't you agree?  Read
the above links for how to write a good one.

thanks,

greg k-h
