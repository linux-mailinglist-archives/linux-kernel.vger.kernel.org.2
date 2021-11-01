Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCA6441B4C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 13:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhKAMvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 08:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232467AbhKAMvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 08:51:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B91560EE3;
        Mon,  1 Nov 2021 12:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635770909;
        bh=+SBk+SYjceFJkTq8C08W0GYFlIzex7exv2uuONzJ/AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GX3iuQ+MYB8VQXKve+uwP/BpakNk11zhXlpKFoKMMptJcpGEDgR2S27KZt3GdK+ii
         0P+UqJcX3m3RHayEcQOCh/HjJv358Z8b55erptWDW6u81d3NAKl7s4BIg/CkxqthBk
         h+EIfh54x7iMazpQxGqDQ1h5XzxbMzmGuwd+Q6Rs=
Date:   Mon, 1 Nov 2021 13:48:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5bi45buJ5b+X?= <changlianzhi@uniontech.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "dmitry.torokhov" <dmitry.torokhov@gmail.com>,
        jirislaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        282827961 <282827961@qq.com>
Subject: Re: [PATCH v9] tty: Fix the keyboard led light display problem
Message-ID: <YX/iGfXdc8UKUFCx@kroah.com>
References: <tencent_10C69A8D3BC51F781F21A754@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_10C69A8D3BC51F781F21A754@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:35:47PM +0800, 常廉志 wrote:
> > Switching from the desktop environment to the tty environment,
> > the state of the keyboard led lights and the state of the keyboard
> > lock are inconsistent. This is because the attribute kb->kbdmode
> > of the tty bound in the desktop environment (Xorg) is set to
> > VC_OFF, which causes the ledstate and kb->ledflagstate
> > values of the bound tty to always be 0, which causes the switch
> > from the desktop When to the tty environment, the LED light
> > status is inconsistent with the keyboard lock status.
> > 
> > Signed-off-by: lianzhi chang <changlianzhi@uniontech.com>
> > ---
> >  v7-->v8:
> >  Optimize the implementation of kbd_update_ledstate function
>  > 
> >  Why not adopt the opinions of Greg KH and Andy Shevchenko:
> >  (1) In the structure struct input_dev, the definition of led is
> >  like this: unsigned long led[BITS_TO_LONGS(LED_CNT)]; If you
> >  define it like this: unsigned long newstate = *dev->led; I
> >  always feel that there is still big end and Little endian problem.
> >  (2) The test_bit function is used to avoid the problem of large
> >  and small ends, and the current algorithm (v8) also exists
> >  elsewhere in the kernel: the atkbd_set_leds function (drivers/
> >  input/keyboard/atkbd.c).
> >  (3) In the current keyboard.c code, the code is already very good,
> >  and it is already relatively independent. If you modify the type
> >  of ledstate to u64 or modify the macro definitions such as
> >  VC_NUMLOCK, it feels that it is not very meaningful, and this It
> >  will also cause other related modifications. Of course, this is
> >  only my current opinion. If everyone still feels that it is
> >  necessary to modify, I will do it this way. Of course, this
> >  process may be a bit longer, and I think it is necessary to
> >  conduct more tests.
> >  
> >  v9: Change description information: xorg-->Xorg
> > ……
> 
> Hi, friends, I would like to ask whether this version of patch is possible, if not,
> I will try my best to find a way to complete the next version!

It's the merge window right now, we can't do anything with this until
after 5.16-rc1 is out.  So give us until then at the least please, then
I will review it again.

thanks,

greg k-h
