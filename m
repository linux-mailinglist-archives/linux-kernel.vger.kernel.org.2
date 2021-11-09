Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A49744AC8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245733AbhKIL0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:26:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:34592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245705AbhKIL0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:26:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD38161181;
        Tue,  9 Nov 2021 11:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636457026;
        bh=7yOP8/YFYpmYUy84lxW+LgKf3s7D5M3pRMq8+O3DB4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hxK7Mnee6ylsYGTmO3PSM7u4ZAIJjFsSUFUb/DTrw6jOhPZpnRGyH7pRocgWCZU4G
         fC7pZNQ18gIUe1Gkh8D2x4gsATS/d7UplGOEzM+YOZkLYo3j52/ENm7iGrrgXiXObl
         qQFKrc8Eovta5IyCGjNdOThnK+L8E50kPOaxapI0=
Date:   Tue, 9 Nov 2021 12:23:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vihas Mak <makvihas@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: ppdev: fixed a validation issue
Message-ID: <YYpaP1fAg7jrFyhJ@kroah.com>
References: <20211108185818.GA73382@makvihas>
 <YYoUYOyyP4EFYTSJ@kroah.com>
 <CAH1kMwSqfNT-jB70c6Md_Wa6Sn6GJKr2=LOunSaZwEk2TKzraA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH1kMwSqfNT-jB70c6Md_Wa6Sn6GJKr2=LOunSaZwEk2TKzraA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 04:11:20PM +0530, Vihas Mak wrote:
> > On Tue, Nov 09, 2021 at 12:28:18AM +0530, Vihas Mak wrote:
> > > Make sure the mode is a valid IEEE1284 mode.
> > What is a valid mode?
> 
> The valid IEEE1284 modes are the ones defined in
> <uapi/linux/parport.h>. Currently there are 10 modes. Namely nibble
> mode, byte mode, ECP, ECPRLE, EPP and some specials.

But what happens today if code has not been sending those values
properly?  This is a very old driver for very old hardware.

> > How did you test this?  And why is this needed now?  What hardware was
> > working that is now not going to work with this driver?
> 
> I tested this on my local pc using a parallel port and read the
> incoming data on my Raspberry PI.
> I also used https://github.com/strezh/VPPSniffer. It's a simple
> virtual parallel port used for debugging and sniffing.
> 
> The mainline code wasn't validating the mode when a user-space program
> does a ioctl call to change the current mode. It might
> create some bugs if the new mode isn't one of the IEEE1284 modes
> defined in <uapi/linux/parport.h>. So it's better to throw a EINVAL
> beforehand, if the mode is invalid.

What happens today if the mode is not set properly?  Will the code paths
error out eventually, or will the call succeed?  The problem is that
there might be code that is working today that would break with a change
like this, as again, this is a very old driver.

thanks,

greg k-h
