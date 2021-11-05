Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C9C4460A8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhKEIbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232408AbhKEIbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:31:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1EC161212;
        Fri,  5 Nov 2021 08:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636100936;
        bh=d8ClCd+ktXC6e1v43RbHJZ+dioNorMIQdJIcBGJ/ADg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XeP9OBW0SDcsGQZfQT5VVghu9XkoT796Z6Wro/WYvAHmHZiFWJ4FNHbL738VQKGfg
         Fv3fAMd4G1dnxHturxWvfrtrBCDY4UlmvkASl6e/FhExwvcoeGnnjgl0r9Lv1agPh5
         Pf1Xno98bqAFd6Vz2InD/qvkOPQvuhRcFgge5U1A=
Date:   Fri, 5 Nov 2021 09:28:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: r8188eu: hal: else is not useful after a return
Message-ID: <YYTrRfHRaZCJtYsg@kroah.com>
References: <YX7iBmKKNZfj8Gca@Sauravs-MacBook-Air.local>
 <YX/lRMNGsCZMKAV3@kroah.com>
 <5013033b-b1f1-aef7-9fb8-a8431e83960b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5013033b-b1f1-aef7-9fb8-a8431e83960b@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 12:53:33AM +0530, Saurav Girepunje wrote:
> 
> 
> On 01/11/21 6:31 pm, Greg KH wrote:
> > On Mon, Nov 01, 2021 at 12:05:50AM +0530, Saurav Girepunje wrote:
> >> In the function rtl8188eu_hal_init() else after the return statement
> >> of the if section is not useful. As if condition is true function will
> >> return from if section, On the other case if condition is false
> >> function will not return and statement after the if section will
> >> execute, So there is no need to have else in this case. Remove the
> >> else after a return statement of the if section.
> >>
> >> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> >> ---
> >>  drivers/staging/r8188eu/hal/usb_halinit.c | 7 ++++---
> >>  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > 
> > Hi,
> > 
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> > 
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> > 
> > - You sent multiple patches, yet no indication of which ones should be
> >   applied in which order.  Greg could just guess, but if you are
> >   receiving this email, he guessed wrong and the patches didn't apply.
> >   Please read the section entitled "The canonical patch format" in the
> >   kernel file, Documentation/SubmittingPatches for a description of how
> >   to do this so that Greg has a chance to apply these correctly.
> > 
> > If you wish to discuss this problem further, or you have questions about
> > how to resolve this issue, please feel free to respond to this email and
> > Greg will reply once he has dug out from the pending patches received
> > from other developers.
> > 
> > thanks,
> > 
> > greg k-h's patch email bot>
> 
> Hi Greg,
> 
> I have send only one patch for usb_halinit.c.
> However I have send another patch staging: r8188eu: hal: break after the return not useful
> for another file HalPwrSeqCmd.c both are on same path drivers/staging/r8188eu/hal/ 

That's great, but when you send multiple patches at once, you need to
send them as a patch series so they are applied in the correct order.

Please fix that up here and do so.

thanks,

greg k-h
