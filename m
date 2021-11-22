Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B639458A56
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 09:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbhKVINA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 03:13:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhKVIM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 03:12:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD75C604DA;
        Mon, 22 Nov 2021 08:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637568590;
        bh=mJJqJORPWCmLpcjF5yalLL1RBSkNwRigh/h+2T38K9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ig9VUmupWKImu99k2HN3E5oQl0GvT8St1sP+orPD5gcy5Mjr6vGinySmmr0sIYcOo
         1pFjZZOiEc1O9EIjk8qxbIzYEgsuLdEVJzcbv26ekiULbax2lHyPQWJHGBfkTDly/m
         sozpSqOpDwVsW3M56J9F3+dpXl/wiSYjXDwW+mJ8FD2rPd5i44zCYDHMf3DP0QA/GG
         GXRFnr1sLvh7VoiiV6vZQgKM9e/Vn/28Q0NpBeS1FpnQEaoHw4IEGqj4H8g1JKh30k
         pUrKrw1wRSRCOsNySDWJ0rCx4OLOVCzFdIdqY1opYR16z6Cityr9zyrsOMJI1Xwdyw
         NoY04CclTbD9Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mp4OJ-0007q1-07; Mon, 22 Nov 2021 09:09:31 +0100
Date:   Mon, 22 Nov 2021 09:09:30 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mingjie Zhang <superzmj@fibocom.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB:serial:option:add Fibocom FM101-GL variants
Message-ID: <YZtQOtPEuLWKQfoH@hovoldconsulting.com>
References: <20211115135906.52702-1-superzmj@fibocom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115135906.52702-1-superzmj@fibocom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nit: Please add spaces after the colons (:) in the Subject line.

On Mon, Nov 15, 2021 at 09:59:06PM +0800, Mingjie Zhang wrote:
> Update the USB serial option driver support for the Fibocom
> FM101-GL Cat.6
> LTE modules as there are actually several different variants.
> - VID:PID 2cb7:01a4, FM101-GL for laptop debug M.2 cards(adb interface)
> - VID:PID 2cb7:01a2, FM101-GL are laptop M.2 cards (with
>   MBIM interfaces for /Linux/Chrome OS)
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> P:  Vendor=2cb7 ProdID=01a2 Rev= 5.04
> S:  Manufacturer=Fibocom Wireless Inc.
> S:  Product=Fibocom FM101-GL Module
> S:  SerialNumber=86bffe63
> C:* #Ifs= 7 Cfg#= 1 Atr=a0 MxPwr=896mA
> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=(none)
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
> I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
> I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
> I:* If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=(none)

Could you add here what each vendor interface is used for?

> T:  Bus=02 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  3 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> P:  Vendor=2cb7 ProdID=01a4 Rev= 5.04
> S:  Manufacturer=Fibocom Wireless Inc.
> S:  Product=Fibocom FM101-GL Module
> S:  SerialNumber=86bffe63
> C:* #Ifs= 7 Cfg#= 1 Atr=a0 MxPwr=896mA
> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=(none)
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=(none)
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=(none)
> I:* If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=(none)

Same here.

> Signed-off-by: Mingjie Zhang <superzmj@fibocom.com>
> ---
>  drivers/usb/serial/option.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 29c765cc8495..8f5c98a75429 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2081,6 +2081,8 @@ static const struct usb_device_id option_ids[] = {
>  	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
> +	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
> +	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff) },			/* Fibocom FM101-GL (laptop adb) */

You shouldn't bind to the ADB interface so you'll need two entries for
0x01a4 (cf. Fibocom FG150).

Please also add these in sort order (VID, PID) where the other Fibocom
entries are a few lines above.

>  	{ } /* Terminating entry */
>  };
>  MODULE_DEVICE_TABLE(usb, option_ids);

Johan
