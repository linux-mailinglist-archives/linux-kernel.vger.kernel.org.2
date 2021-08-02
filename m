Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE3B3DDF33
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhHBSdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhHBSdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:33:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 147CC610A2;
        Mon,  2 Aug 2021 18:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627929177;
        bh=IsZrEx1CwEMeqZpMiK2YFpekI7pm5a/2iZ15VFYnUqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hoyKIFAJX7uof0FRcRYQJhBC08QtSDGXFdxekGT8cTfmkzPucJkBgiY6WYA+2wR6/
         RtoQGbAXAaSc8ZIE9leqdiVfIPZtvFD1CxWjU4HxeqyI82mpWRh+dPEzN41GVqa+na
         S73TWN2UL8mVuWPQ+rDWJQ9+73Iwk1W4BWuICjtY=
Date:   Mon, 2 Aug 2021 16:38:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Subject: Re: kernel BUG in new r8188eu
Message-ID: <YQgDfQczxc6LX5yv@kroah.com>
References: <80042e9f-6811-38f3-010b-1c0951ba88db@lwfinger.net>
 <cef19337-5ff3-c0cd-33ef-4f9990bcd4ec@lwfinger.net>
 <YQfKohnSRWHjlht6@kroah.com>
 <147993920.vpeT8VCmXh@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147993920.vpeT8VCmXh@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 01:45:06PM +0200, Fabio M. De Francesco wrote:
> Hi Greg,
> 
> On Monday, August 2, 2021 12:36:18 PM CEST Greg Kroah-Hartman wrote:
> > On Sun, Aug 01, 2021 at 03:15:52PM -0500, Larry Finger wrote:
> > > On 8/1/21 1:31 AM, Greg Kroah-Hartman wrote:
> > > > I am worried that my "remove the wrapper" logic got something wrong
> > > > here, so if you could test the revert of that, I would appreciate it.
> > > > 
> > > > I think I need to go buy one of these devices so I can test cleanups
> > > > locally...
> > > 
> > > The bad commit was 9ff1cc4ef80e ("staging: r8188eu: remove rtw_buf_free()
> > > function").
> > > 
> > > Looking at it, the only difference between the original wrapper and the 
> new
> > > code is that the wrapper zeros the len variable before the kfree() call, 
> but
> > > making that change did not help. Reverting that patch restores the old
> > > behavior.
> > 
> > Ah, doh, that was my fault, sorry, that patch was incorrect (odd git id,
> > don't know where that came from, it's a different id in my tree.)  Let
> > me revert this commit and then will redo it correctly.
> 
> The commit to revert should be c7e88ecbe328.

Yes, thanks, now reverted.

> > thanks for finding this.
> > 
> > > There are lots of these on Ebay from $2.47 up with free shipping!
> > 
> > Any hints on the name for how to figure out which devices are supported
> > by this driver?
> 
> The following link points to a device that seems to be supported by this 
> driver. It is just $4.99, but I'm not sure whether or not they ship to Europe 
> (I suppose you're here):
> 
> https://www.amazon.com/gp/product/B00L28AN88/ref=ox_sc_act_title_1

Yeah, I'm in Europe, I'll try to find something within the EU to avoid
the mess with importing electronics and duties.  It's a mess everytime I
do that...

> About this item: 
> * Chipset:RTL8188EU 
> * Standard: IEEE 802.11n,IEEE 802.11g, IEEE 802.11b 
> * Supports 64/128 bit WEP, WPA encryption 
> 
> Otherwise, I think that the following uses the same chip as the above. 
> However, it costs a little more and, above all else, I'm not really sure if it 
> works with r8188eu, since they write that the chip is a Realtek RTL8188EUS 
> (please note that final "EUS"):
> 
> https://www.amazon.it/Asus-USB-N10-NANO-N150-compatibile/dp/B081758CWC/
> ref=sr_1_1

Yeah, I found a bunch of "EUS" devices here, will keep digging.

thanks,

greg k-h
