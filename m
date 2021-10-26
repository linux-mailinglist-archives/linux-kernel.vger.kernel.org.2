Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099AF43B63E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbhJZP7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:59:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237173AbhJZP7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:59:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C0EF603E9;
        Tue, 26 Oct 2021 15:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635263835;
        bh=VYQq+e605O6Wf5bVvGMiK9obi4XNY/4uYmZtUWaw35E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=slyf/tjT23TqD1DhC4NxxzR41AbUMtYKfaj/oKJte4PJUcleNO/Sy1S/RKV3SVIkB
         31fMZK1VswONfm7Q9+k7HfkNSxP+q6lkmEFb/0HT+UumUwjM1HkQF5hM+66cvOARR0
         4UbWQqPUuV104cE47hp+FxGCuuI/DBI9tv7rBn+A=
Date:   Tue, 26 Oct 2021 17:57:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5bi45buJ5b+X?= <changlianzhi@uniontech.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "dmitry.torokhov" <dmitry.torokhov@gmail.com>,
        jirislaby <jirislaby@kernel.org>, 282827961 <282827961@qq.com>
Subject: Re: [PATCH v7] tty: Fix the keyboard led light display problem
Message-ID: <YXglWDgtWZdZhhUe@kroah.com>
References: <20211026024032.15897-1-changlianzhi@uniontech.com>
 <YXgPZw3eluaaVvRc@smile.fi.intel.com>
 <YXgWbG30THLgS5zJ@kroah.com>
 <tencent_6F6E7845648EC1B76421AE7A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_6F6E7845648EC1B76421AE7A@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 11:41:17PM +0800, 常廉志 wrote:
> On Tue, Oct 26, 2021 at 05:23:35PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 26, 2021 at 10:40:32AM +0800, lianzhi chang wrote:
> > > Switching from the desktop environment to the tty environment,
> > > the state of the keyboard led lights and the state of the keyboard
> > > lock are inconsistent. This is because the attribute kb->kbdmode
> > > of the tty bound in the desktop environment (xorg) is set to
> >
> > Xorg
> >
> > I think I already pointed that out.
> >
> > > VC_OFF, which causes the ledstate and kb->ledflagstate
> > > values of the bound tty to always be 0, which causes the switch
> > > from the desktop When to the tty environment, the LED light
> > > status is inconsistent with the keyboard lock status.
> >
> > ...
> >
> > > +static void kbd_update_ledstate(struct input_dev *dev)
> > > +{
> > > + if (!!test_bit(LED_NUML, dev->led) !=
> > > +     !!(ledstate & BIT(VC_NUMLOCK)))
> > > + ledstate ^= BIT(VC_NUMLOCK);
> > > + if (!!test_bit(LED_CAPSL, dev->led) !=
> > > +     !!(ledstate & BIT(VC_CAPSLOCK)))
> > > + ledstate ^= BIT(VC_CAPSLOCK);
> > > + if (!!test_bit(LED_SCROLLL, dev->led) !=
> > > +     !!(ledstate & BIT(VC_SCROLLOCK)))
> > > + ledstate ^= BIT(VC_SCROLLOCK);
> >
> > This looks ugly.
> 
> I think it can be done like this:
>  static void kbd_update_ledstate(struct input_dev *dev)
>  {
>     ledstate = (test_bit(LED_SCROLL,dev->led) ？1 ：0）
>          | (test_bit(LED_NUML,dev->led) ？2 ：0）
>          | (test_bit(LED_CAPSL,dev->led) ？3 ：0）
>  }

Please write code for developers to read first, and compilers second.
That ? : stuff is a mess, do not do that.

thanks,

greg k-h
