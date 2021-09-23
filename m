Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4368415B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 11:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbhIWJkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 05:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238217AbhIWJkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:40:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F3B26121F;
        Thu, 23 Sep 2021 09:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632389927;
        bh=d58N7onB8KeEx4agVz+GvbDHkrznYzV8nRj9L2MqL0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tiAXdAJ7enQ389Q76nQGOdetsK/JVjHd1rHVrbyLxaY19sn5zlRUaXr4BnC6+UQDu
         xI2MSTmaqol2L1Q/UUUvs7qKj0tFE/e7XaJ8mulF8UXCZwu8k3VNSxsOmFoL9VbG04
         JBrl+JJqJwzn3NF1GrS6NT751p52HVEvlkCcB+rdpdxHrgV1c2k6kG2Kd2Xx/UuJC9
         /+P4wttc7fKaa4y8pwhYoMRn3qTrr3vDA6IDevJYZrhoNY/uQM/rpYd1yf0r9TR/MW
         Nvk0oI0fla7C+tskDrYZjIHYDRtbMXyyzs4M2zGLHqbnQYAHDAgpXZm3GehBmcBk5Y
         Kh/euxUxNm1LQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mTLBo-0000e0-KD; Thu, 23 Sep 2021 11:38:49 +0200
Date:   Thu, 23 Sep 2021 11:38:48 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] USB:serial:option Add Foxconn T99W265
Message-ID: <YUxLKCGd0Icl+Mbv@hovoldconsulting.com>
References: <20210917110106.9852-1-slark_xiao@163.com>
 <YUhVKrRJ8M2hKJil@hovoldconsulting.com>
 <2992805f.bc9.17c0b33a78e.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2992805f.bc9.17c0b33a78e.Coremail.slark_xiao@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please configure your mail client to wrap lines at 72 columns or so. ]

On Wed, Sep 22, 2021 at 09:51:47AM +0800, Slark Xiao wrote:
> At 2021-09-20 17:32:26, "Johan Hovold" <johan@kernel.org> wrote:
> >On Fri, Sep 17, 2021 at 07:01:06PM +0800, Slark Xiao wrote:
> >> Adding support for Foxconn device T99W265 for enumeration with
> >> PID 0xe0db.
> >> 
> >> usb-devices output for 0xe0db
> >> T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 19 Spd=5000 MxCh= 0
> >> D:  Ver= 3.20 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
> >> P:  Vendor=0489 ProdID=e0db Rev=05.04
> >> S:  Manufacturer=Microsoft
> >> S:  Product=Generic Mobile Broadband Adapter
> >> S:  SerialNumber=6c50f452
> >> C:  #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=896mA
> >> I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
> >> I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> >> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> >> I:  If#=0x3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> >> I:  If#=0x4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> >> 
> >> if0/1: MBIM, if2:Diag, if3:GNSS, if4: Modem
> >> 
> >> Signed-off-by: Slark Xiao <slark_xiao@163.com>

> >> ---
> >>  drivers/usb/serial/option.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> >> index 29c765cc8495..fde599fa2d73 100644
> >> --- a/drivers/usb/serial/option.c
> >> +++ b/drivers/usb/serial/option.c
> >> @@ -2068,6 +2068,8 @@ static const struct usb_device_id option_ids[] = {
> >>  	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
> >>  	{ USB_DEVICE(0x0489, 0xe0b5),						/* Foxconn T77W968 ESIM */
> >>  	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
> >> +	{ USB_DEVICE(0x0489, 0xe0db),						/* Foxconn T99W265 MBIM extension*/
> >> +	  .driver_info = RSVD(0) | RSVD(1) | RSVD(3) },
> >
> >If you use USB_DEVICE_INTERFACE_CLASS() instead you don't need to
> >explicitly reserve the MBIM interfaces. 
> >
> >Also, why are you reserving the GNSS interface (e.g. unlike T77W968)?
> 
> I just want to keep same style as previous products. That would be
> more coordinated, I think.

I understand your point, but it's better to use a more specific matching
rule were possible since it prevents driver core from even trying to
bind the driver.

Note that for T77W968 we couldn't do so since we needed to bind also to
non-vendor-class interfaces.

I'll just change this to USB_DEVICE_INTERFACE_CLASS() when applying.

> And for GNSS port, it can't be supported with serial driver. It
> doesn't like a  NMEA port which is using serial driver.
> I checked it for T77W968(MBIM mode) and found settings as below:
> if0/if1: MBIM, if2: Modem, if3:AT,  if4: NMEA, if5: Diag, if6: GNSS
> GNSS is also reserved.

Ah, thanks for explaining. I only saw that T77W968 had an NMEA port and
thought it was the same one.

Now applied with the change mentioned above.

Johan
