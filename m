Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457793EE699
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 08:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhHQGeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 02:34:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhHQGeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 02:34:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6771160F5C;
        Tue, 17 Aug 2021 06:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629182030;
        bh=cLn5wfADaYN3DJlvTSDXWYB/LgMsvZa6P022ePtr49o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xq4IwRnuMlj5J8CXh5nlRhjtTCqhuZAWguilrsdPw8w1WvF/wDHIeZYWe5Zl3IM/H
         b/b989OYLCm4vYN01OOEvD7Z6vQvhr9/KfT7+FjgB1hp7d9+k6kHdJpI9IYMLv5ZRx
         ZCHXJPZleFnKAC7/FYB5SYcRsCee0FDQJZj0/ARM=
Date:   Tue, 17 Aug 2021 08:33:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     Reinhard Speyerer <rspmn@arcor.de>, johan@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: Re: [PATCH] [V2,1/1]USB: serial: option: add Foxconn
 T77W175 composition 0x901d
Message-ID: <YRtYTFFCNn/xp2Hr@kroah.com>
References: <20210816035404.4210-1-slark_xiao@163.com>
 <YRoqAJmGBpV/OuZL@arcor.de>
 <d1d16fd.6f62.17b4e3ffa26.Coremail.slark_xiao@163.com>
 <YRot+wBa6v529Z7q@kroah.com>
 <278bcd0d.7189.17b4e479a3a.Coremail.slark_xiao@163.com>
 <YRpJN414JQyfyEGo@kroah.com>
 <ba9a424.f5f.17b51ef0b9d.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba9a424.f5f.17b51ef0b9d.Coremail.slark_xiao@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 10:27:05AM +0800, Slark Xiao wrote:
> 
> 

<blank lines snipped, please fix your email client...>

>> At 2021-08-16 19:17:11, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >On Mon, Aug 16, 2021 at 05:25:20PM +0800, Slark Xiao wrote:
> >> At 2021-08-16 17:20:59, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >> >On Mon, Aug 16, 2021 at 05:17:00PM +0800, Slark Xiao wrote:
> >> >>   So should I use USB_DEVICE_INTERFACE_NUMBER(QUALCOMM_VENDOR_ID, 0x901d, 0x00) to bind Diag port only?
> >> >
> >> >Why is this device using the QUALCOMM vendor id anyway?  Is this allowed
> >> >by Qualcomm?
> >> >
> >> >thanks,
> >> >
> >> >greg k-h
> >> 
> >> Hi Greg,
> >>   Our product are designed based on Qualcomm SDX55 platform. So it still support Qualcomm vendor ID.
> >>   I think there is no infringement about this ID combo.
> >
> >Do you have permission from Qualcomm to use their vendor id?  I know
> >some vendors get very upset about this...
> >
> >Why not use your own vendor id?
> >
> >thanks,
> >
> >greg k-h
> 
> Hi Greg,
>    As Qualcomm mainly provide service to their customer, like Samsung, Apple, Huawei, Quectel, Foxconn, Sierra and so on, so I believe all available VID/PIDs are allowed to use. 

That is not how USB VIDs work, sorry.  Please get approval from the
company whose VID you wish to use, otherwise they will be using it
themselves for their own devices, and you will have a collision.

thanks,

greg k-h
