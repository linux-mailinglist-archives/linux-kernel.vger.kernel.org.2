Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1938C79C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhEUNRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232709AbhEUNRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:17:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98FBA60FEF;
        Fri, 21 May 2021 13:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621602970;
        bh=FBX0bD/QwvdgDqyMyPHYv4EF0W+AaSMy4yVziaV6zK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HaynOVFrEGFp1JGLp8Yz2xZ71bQcR33Q0y0Imfy2P9XO4VAt04su53WlB0UeCQOsp
         467Rbb3nEXq4oAPmk+jJxPmhtgrgGD67X/dVZL1JNxSBKNt2fvqXKo8RmGTijWzGDF
         VqKokPZxODwfeQnAMUEazZ2qZXhafit4lf4AU7Ws=
Date:   Fri, 21 May 2021 15:16:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        rkovhaev@gmail.com, straube.linux@gmail.com,
        linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
Subject: Re: [PATCH] staging: rtl8712: Fix memory leak in r8712_init_recv_priv
Message-ID: <YKeyl6DL9rZylbKw@kroah.com>
References: <20210521120811.516339-1-mudongliangabcd@gmail.com>
 <YKelBRkGsLFz4byw@kroah.com>
 <CAD-N9QUgYy4j3wnJX1gwq902ggarFaQPBQ3cyUAArYxv22Q-bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD-N9QUgYy4j3wnJX1gwq902ggarFaQPBQ3cyUAArYxv22Q-bQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 08:24:58PM +0800, 慕冬亮 wrote:
> On Fri, May 21, 2021 at 8:18 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, May 21, 2021 at 08:08:11PM +0800, Dongliang Mu wrote:
> > > r871xu_dev_remove failed to call r8712_free_drv_sw() and free the
> > > resource (e.g., struct urb) due to the failure of firmware loading.
> > >
> > > Fix this by invoking r8712_free_drv_sw at the failure site.
> > >
> > > Reported-by: syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
> > > Fixes: b4383c971bc5 ("staging: rtl8712: handle firmware load failure")
> > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > ---
> > >  drivers/staging/rtl8712/usb_intf.c | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
> > > index dc21e7743349..a5190b4250ce 100644
> > > --- a/drivers/staging/rtl8712/usb_intf.c
> > > +++ b/drivers/staging/rtl8712/usb_intf.c
> > > @@ -589,7 +589,7 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
> > >   */
> > >  static void r871xu_dev_remove(struct usb_interface *pusb_intf)
> > >  {
> > > -     struct net_device *pnetdev = usb_get_intfdata(pusb_intf);
> > > +     struct net_device *pnetdev, *newpnetdev = usb_get_intfdata(pusb_intf);
> > >       struct usb_device *udev = interface_to_usbdev(pusb_intf);
> > >
> > >       if (pnetdev) {
> >
> > Did you test this?
> 
> For now, I only tested this patch in my local workspace. The memory
> leak does not occur any more.
> 
> I have pushed a patch testing onto the syzbot dashboard [1]. Now it is
> in the pending state.
> 
> [1] https://syzkaller.appspot.com/bug?id=3a325b8389fc41c1bc94de0f4ac437ed13cce584
> 
> >
> > I think you just broke the code right here :(
> 
> If I broke any code logic, I am sorry. However, this patch only adds
> some code to deallocate some resources when failing to load firmware.
> 
> Do you mean that I replace pnetdev with the variable - newpnetdev?

Yes, and then the first thing the code does is check the value of
pnetdev which is totally undefined :(

