Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEFC41416C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhIVF7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:59:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231908AbhIVF7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:59:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F592611B0;
        Wed, 22 Sep 2021 05:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632290289;
        bh=LrT3tr598zJ9vJU3Swz4fIs3o7DKvvrlc/v5qjZ64iE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bN40WsyekkK02DVq8gYu3oAqdh9TxJTYhl+ysYWEpobm0kXxB4QHUhmmCCa1ldS22
         q6kHb/t2Yh5AAiLsQ1gpkQCl81kuniew4qB07AR9yL7FTeCJSJO4WVnfQQ3puCNS9h
         TJHPwK4sQ1yKczXUyXXVM5pwfTQj/1KGbxOLVL+w=
Date:   Wed, 22 Sep 2021 07:58:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Update min() to min_t()
Message-ID: <YUrF7sF7+a6LZQ/B@kroah.com>
References: <20210921055246.GA11535@matrix-ESPRIMO-P710>
 <YUl1067kvLA5KkGC@kroah.com>
 <a6185b27-a461-84e4-1301-485b88cddd02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6185b27-a461-84e4-1301-485b88cddd02@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 09:11:25PM +0200, Philipp Hortmann wrote:
> On 9/21/21 8:04 AM, Greg KH wrote:
> > On Tue, Sep 21, 2021 at 07:52:46AM +0200, Philipp Hortmann wrote:
> > > diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
> > > index 2dc58766273a..d87deee3e26e 100644
> > > --- a/drivers/usb/usb-skeleton.c
> > > +++ b/drivers/usb/usb-skeleton.c
> > > @@ -363,7 +363,7 @@ static ssize_t skel_write(struct file *file, const char *user_buffer,
> > >   	int retval = 0;
> > >   	struct urb *urb = NULL;
> > >   	char *buf = NULL;
> > > -	size_t writesize = min(count, (size_t)MAX_TRANSFER);
> > > +	size_t writesize = min_t(size_t, count, MAX_TRANSFER);
> > >   	dev = file->private_data;
> > > -- 
> > > 2.25.1
> > > 
> > 
> > Has anyone actually built this driver in a while?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> Hi,
> 
> I have build and loaded the driver. To me this seems OK.
> 
> dmesg from loading:
> usb_skeleton: loading out-of-tree module taints kernel.
> usb_skeleton: module verification failed: signature and/or required key
> missing - tainting kernel
> usbcore: registered new interface driver skeleton
> 
> dmesg from unloading:
> usbcore: deregistering interface driver skeleton
> 
> Used kernel 5.15.0-rc1+

Great, can you resend a v2 of this with a fixed up subject line please?

thanks,

greg k-h
