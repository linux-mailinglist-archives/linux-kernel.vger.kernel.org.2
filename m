Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F37E3F8A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242884AbhHZOqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242881AbhHZOqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:46:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DF1661037;
        Thu, 26 Aug 2021 14:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629989136;
        bh=D721hoo0OlAPTZxfjPhisfZr5kf0WZ/Pis63ZLb1rzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kn2lQw4kcH17EOIBQnR915kqCgdmXGkMZnCvYFr9cevO+mUYH02617JFbEnXm3aB+
         y7PaGxdY4f/M8z4gA6UIpcGelTVXJAa6LQrngSeeJe6W9Upizh3XgQruK08AdVE/n4
         W4A0rtNE9D+9DcmKa9hQlMi+y4dyL3dFsjwdnM9g=
Date:   Thu, 26 Aug 2021 16:45:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 1/2] staging: r8188eu: Use usb_control_msg_recv/send()
 in usbctrl_vendorreq()
Message-ID: <YSepDdf+nHekuIxA@kroah.com>
References: <20210825035311.8910-1-fmdefrancesco@gmail.com>
 <20210825035311.8910-2-fmdefrancesco@gmail.com>
 <YSdxhfNjxOcJwxFg@kroah.com>
 <47945171.69uSEkksVi@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47945171.69uSEkksVi@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 04:24:35PM +0200, Fabio M. De Francesco wrote:
> On Thursday, August 26, 2021 12:48:37 PM CEST Greg Kroah-Hartman wrote:
> > On Wed, Aug 25, 2021 at 05:53:10AM +0200, Fabio M. De Francesco wrote:
> > > Replace usb_control_msg() with the new usb_control_msg_recv() and
> > > usb_control_msg_send() API of USB Core in usbctrl_vendorreq().
> > > Remove no more needed variables. Move out of an if-else block
> > > some code that it is no more dependent on status < 0. Remove
> > > redundant code depending on status > 0 or status == len.
> > > 
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > > 
> > > v2->v3: Restore the test for success of usb_control_message_recv/send
> > > that was inadvertently removed. Issue reported by Pavel Skripkin.
> > > 
> > > v1->v2: According to suggestions by Christophe JAILLET 
> > > <christophe.jaillet@wanadoo.fr>, remove 'pipe' and pass an explicit 0
> > > to the new API. According to suggestions by Pavel Skripkin 
> > > <paskripkin@gmail.com>, remove an extra if-else that is no more needed, 
> > > since status can be 0 and < 0 and there is no 3rd state, like it was before.
> > > Many thanks to them and also to Phillip Potter <phil@philpotter.co.uk>
> > > who kindly offered his time for the purpose of testing v1.
> > > 
> > >  drivers/staging/r8188eu/hal/usb_ops_linux.c | 45 ++++++++-------------
> > >  1 file changed, 17 insertions(+), 28 deletions(-)
> > 
> > This doesn't apply to my tree at all.  Please rebase and resend.
> 
> This series cannot apply to your tree until another one of mine is applied 
> ("staging: r8188eu: Remove _enter/_exit_critical_mutex()"). This series builds
> on the previous patch.

When you do that, please let me know somehow that this is the case,
otherwise how am I supposed to guess that?

> > But first, are you sure you want to use these new functions here?  This
> > is a "common" function that is called from different places for
> > different things.  How about unwinding the callers of this function
> > first, to see if they really need all of the complexity in this function
> > at all, and if not, then call the real USB function in those locations
> > instead.
> 
> I think it could be fine to simply refactor usbctrl_vendorreq() to use the newer
> API with no necessity to directly use them at least in six different places in
> hal/usb_ops_linux.c. The only users of this helper are usb_read8/16/32() and
> usb_write8/16/32(). Why do you prefer using usb_control_msg_recv/send() 
> directly in the callers? I guess it would lead to redundant code, more or less
> the same code repeated again and again within the above-mentioned six callers.
> What do we improve by doing as you suggest? What am I missing?

If you unwind the mess, you will find that the code will be much easier
to understand.

As an example, look at usb_write8().  Where is it ever called?  Why do
we have it at all?  It's only used in 1 place, and then that function
unwinds into rtw_write8(), which is used in a lot of places, and never
checked at all, making the majority of the logic in this function
totally unneeded and useless.

Same for rtw_write16() and rtw_write32().  After unwinding the mess you
see that the logic you are working to try to clean up in this patch
series is pretty much not used / needed at all, right?  So why do it?

Unwind the mess into a useful set of functions the driver can actually
call that is not 2-4 function pointers deep and then we can talk about
unifying things, if they are really needed.  But right now, it's
impossible to tell.

good luck!

greg k-h
