Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17C53F94E3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbhH0HNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 03:13:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhH0HNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:13:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86E9460F92;
        Fri, 27 Aug 2021 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630048354;
        bh=CNm1k9Yuyu0Cujjer61BVkr+/veDq0OstmL8jEynAHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=By4UIGIJCwA38IiTikDWwyMoyXdkgAonVUn+0tpLQ9/rEJdTOA0VFrHIY7w6Ss9iV
         /h0NS/JN0AXlygYSmfJK2JeqV7rQxVP26bEXdBTJdjygeMuip62XHZKbqMAhuBuWkz
         zdcM7NCYztBgeRLFFuIzE88RcV0CGQrPTJ7J9Ajg=
Date:   Fri, 27 Aug 2021 09:12:30 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "straube.linux@gmail.com" <straube.linux@gmail.com>,
        "fmdefrancesco@gmail.com" <fmdefrancesco@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/6] staging: r8188eu: add error handling of rtw_read32
Message-ID: <YSiQXpzswaRhvD4P@kroah.com>
References: <cover.1629789580.git.paskripkin@gmail.com>
 <93bf46ce2d0ce12e94672acf28b64dc341fde038.1629789580.git.paskripkin@gmail.com>
 <27f5e52d520b453cbcabb3d72f0f5d15@AcuMS.aculab.com>
 <20210826122221.5d2b0f37@gmail.com>
 <685618ac-8de1-4eb1-57dd-9d43b96e872e@gmail.com>
 <64112dfd8e8b472ab78ca8b4837dc9e9@AcuMS.aculab.com>
 <0eb2bbc6-9d35-9ff3-acde-fd89bbe0ca27@gmail.com>
 <6e864f9d133d4db3923190f5acacc32a@AcuMS.aculab.com>
 <fb29e9f2-3662-c365-7427-a91a298ef10f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb29e9f2-3662-c365-7427-a91a298ef10f@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 11:03:04PM +0300, Pavel Skripkin wrote:
> On 8/26/21 1:59 PM, David Laight wrote:
> > From: Pavel Skripkin
> > > Sent: 26 August 2021 11:55
> > > 
> > > On 8/26/21 1:22 PM, David Laight wrote:
> > > > From: Pavel Skripkin
> > > >> Sent: 26 August 2021 10:28
> > > >>
> > > >> On 8/26/21 12:22 PM, Pavel Skripkin wrote:
> > > >> > On Thu, 26 Aug 2021 08:51:23 +0000
> > > >> > David Laight <David.Laight@ACULAB.COM> wrote:
> > > > ...
> > > >> >> ...
> > > >> >> > -static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
> > > >> >> > +static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32
> > > >> >> > *data) {
> > > >> >> >  	u8 requesttype;
> > > >> >> >  	u16 wvalue;
> > > >> >> >  	u16 len;
> > > >> >> > -	__le32 data;
> > > >> >> > +	int res;
> > > >> >> > +	__le32 tmp;
> > > >> >> > +
> > > >> >> > +	if (WARN_ON(unlikely(!data)))
> > > >> >> > +		return -EINVAL;
> > > >> >> >
> > > >> >>
> > > >> >> Kill the NULL check - it is a silly coding error.
> > > >> >> An OOPS is just as easy to debug.
> > > >> >>
> > > >> >
> > > >> >
> > > >> > I don't think that one single driver should kill the whole system. It's
> > > >> > 100% an error, but kernel can recover from it (for example disconnect
> > > >> > the driver, since it's broken).
> > > >> >
> > > >> >
> > > >> > AFIAK, Greg and Linus do not like BUG_ONs in recoverable state...
> > > >> > Correct me, if I am wrong
> > > >> >
> > > >> Oops, I thought about BUG_ON() instead of WARN_ON(), sorry for
> > > >> confusion. My point is "we should not let the box boom".
> > > >
> > > >
> > > > There is no point checking for NULL that just can't happen.
> > > > In this case all the callers will pass the address of a local.
> > > > There really is no point checking.
> > > >
> > > 
> > > We not always read in local variable, there are few places, where we
> > > read into passed buffer.
> > 
> > It is still a very local coding bug.
> > 
> > 	David
> > 
> 
> Sure, but is defensive programming so bad?

Yes it is, for when it is not needed.

> Greg, what your opinion about this NULL check?

Never check for things that you know are not going to happen.  Otherwise
the kernel would just be full of pointless checks everywhere.

And why are you waiting for me to tell you this?  Why do you not believe
David?

thanks,

greg k-h
