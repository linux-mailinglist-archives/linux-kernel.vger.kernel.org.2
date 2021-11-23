Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994F8459F74
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhKWJsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 04:48:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232003AbhKWJsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:48:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF8D06102A;
        Tue, 23 Nov 2021 09:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637660731;
        bh=AlwtikS3L92PCsITr4uzkWSQJ2IjjDIRzxa8qJnHQSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XYPClwNde9s2HeEd+C1/zFyH9SG+LrOin7VRZ1qBqhxMZLKcNSLLbf1zFH46NA92B
         tRHqb5VPVH27qHDWItqtDMIvWTKxzVW2y9e1CMikQN25BXxYpxU2VQMPzPq3HDMpqx
         jKyRFxWxeT1zu11FvdU7iLjXcDRA09cNNdClgtXDlOdgPZbR+MKTudfzmQZrWSSC3s
         eJTE8hF+LdWcdf4hPxtFXoL1N4z7sGgids2TKlCz6/f09rs2jiFRVf7uHddO7N9Uqz
         NSRp0/9Dwx4TqWnSE3sUeDMRggdB6C3JdashD0K3PuNlr5Z5ML/A7JGMPscUQ0/NQl
         lO5CZVdUI8rXg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mpSMR-0008Je-2f; Tue, 23 Nov 2021 10:45:11 +0100
Date:   Tue, 23 Nov 2021 10:45:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mingjie Zhang <superzmj@fibocom.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: option: add Fibocom FM101-GL variants
Message-ID: <YZy4J5vzBjeXsugn@hovoldconsulting.com>
References: <20211123082634.21498-1-superzmj@fibocom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123082634.21498-1-superzmj@fibocom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 04:26:34PM +0800, Mingjie Zhang wrote:
> Update the USB serial option driver support for the Fibocom
> FM101-GL Cat.6
> LTE modules as there are actually several different variants.
> - VID:PID 2cb7:01a4, FM101-GL for laptop debug M.2 cards(with
>   adb interfaces for /Linux/Chrome OS)
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
> 
> 0x01a2: mbim, tty, tty, diag, gnss
> 
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
> 
> 0x01a4: mbim, diag, tty, adb, gnss, gnss
> 
> Signed-off-by: Mingjie Zhang <superzmj@fibocom.com>
> ---
> Changes in v2:
>   - Add the description of the corresponding interface

Thanks for the v2. You forgot to mention that you also blacklisted the
adb interface here.

> ---
>  drivers/usb/serial/option.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 29c765cc8495..8ef8d588d007 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2074,9 +2074,12 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(4) | RSVD(5) },
>  	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0105, 0xff),			/* Fibocom NL678 series */
>  	  .driver_info = RSVD(6) },
> +	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
> +	  .driver_info = RSVD(4) },

Are the interface numbers stable so that you can use RSVD() for this
(i.e. instead of adding two separate entries)?

This entry is still not in sort order (VID, PID) however.

>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0xff, 0x30) },	/* Fibocom FG150 Diag */
>  	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0, 0) },		/* Fibocom FG150 AT */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
> +	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */

But this one is.

>  	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */

Please fix in a v3.

Johan
