Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2BC3B28A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 09:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhFXHbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 03:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231630AbhFXHbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 03:31:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BB806023B;
        Thu, 24 Jun 2021 07:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624519741;
        bh=QvbfkFPqbdVYI2vQ6XJWPcJ3DP/t0747GD4/aq152Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQPdZDQNFuGEbjdQjMpBp52gSF8RYN7JkDmaNLFSgITt0rc4oe86gnuIyz8RUXi24
         dLdbOCvL8mAeu68VSWfHTxEfQiAfYlnQQqDQk13waEQp48C4h6BSDIzQctpYFec4JM
         Ays/+XtWg6B7eO0nx7Lndk6zUFa2et7+/YxSIVKIo1cBhT6+gx6LvPPmEpTJgNcf8F
         bebRFbhPHbkyfHNzPx2BMD8xWoMrW+pPeINVixvQwB3G+pPB2b+IliMmHbXYrLNLXa
         1jlVu/Fe/RDOpjM/4i98s2UCwZo1VZmv6ihpxWw28TSJgV5GMqKd6/a5ec2rCuE9Ai
         l2ZUQ9CyDp2Zw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lwJnH-0005cY-BJ; Thu, 24 Jun 2021 09:29:00 +0200
Date:   Thu, 24 Jun 2021 09:28:59 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Stefan =?utf-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniele Palmas <dnlplm@gmail.com>,
        =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Subject: Re: [PATCH v2] USB: serial: qcserial: Support for SDX55 based Sierra
 Wireless 5G modules
Message-ID: <YNQ0O0vhtpStp0n/@hovoldconsulting.com>
References: <20210611134507.8780-1-stefan.bruens@rwth-aachen.de>
 <20210611135842.14415-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210611135842.14415-1-stefan.bruens@rwth-aachen.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +CC: Daniele and Bjørn ]

On Fri, Jun 11, 2021 at 03:58:41PM +0200, Stefan Brüns wrote:
> The devices exposes two different interface compositions:
> - QDL mode, single interface
> - MBIM mode, MBIM class compliant plus AT/DM(/ADB)
> 
> Current firmware versions (up to 01.07.19) do not expose an NMEA port.

We already have at least one SDX55 based modem (FN980) supported by the
option driver. Any particular reason why you chose to add it to qcserial
instead of option?

Note that the FN980 also needs the ZLP flag set in QDL (flashing) mode,
I'd assume this one needs it too.

Could you please also post the output of usb-devices (or lsusb -v) for
this device in MBIM mode?

> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
> ---
>  drivers/usb/serial/qcserial.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
> index 83da8236e3c8..4ff325a14c98 100644
> --- a/drivers/usb/serial/qcserial.c
> +++ b/drivers/usb/serial/qcserial.c
> @@ -26,12 +26,15 @@ enum qcserial_layouts {
>  	QCSERIAL_G1K = 1,	/* Gobi 1000 */
>  	QCSERIAL_SWI = 2,	/* Sierra Wireless */
>  	QCSERIAL_HWI = 3,	/* Huawei */
> +	QCSERIAL_SWI2 = 4,	/* Sierra Wireless */
>  };
>  
>  #define DEVICE_G1K(v, p) \
>  	USB_DEVICE(v, p), .driver_info = QCSERIAL_G1K
>  #define DEVICE_SWI(v, p) \
>  	USB_DEVICE(v, p), .driver_info = QCSERIAL_SWI
> +#define DEVICE_SWI2(v, p) \
> +	USB_DEVICE(v, p), .driver_info = QCSERIAL_SWI2
>  #define DEVICE_HWI(v, p) \
>  	USB_DEVICE(v, p), .driver_info = QCSERIAL_HWI
>  
> @@ -181,6 +184,10 @@ static const struct usb_device_id id_table[] = {
>  	{DEVICE_SWI(0x413c, 0x81d1)},   /* Dell Wireless 5818 */
>  	{DEVICE_SWI(0x413c, 0x81d2)},   /* Dell Wireless 5818 */
>  
> +	/* SDX55 based Sierra Wireless devices */
> +	{DEVICE_SWI2(0x1199, 0x90d2)},	/* Sierra Wireless EM919x QDL */
> +	{DEVICE_SWI2(0x1199, 0x90d3)},	/* Sierra Wireless EM919x */
> +
>  	/* Huawei devices */
>  	{DEVICE_HWI(0x03f0, 0x581d)},	/* HP lt4112 LTE/HSPA+ Gobi 4G Modem (Huawei me906e) */
>  
> @@ -359,6 +366,28 @@ static int qcprobe(struct usb_serial *serial, const struct usb_device_id *id)
>  			break;
>  		}
>  		break;
> +	case QCSERIAL_SWI2:
> +		/*
> +		 * Sierra Wireless SDX55 in MBIM mode:
> +		 * 0/1: MBIM Control/Data
> +		 * 3: AT-capable modem port
> +		 * 4: DM/DIAG (use libqcdm from ModemManager for communication)
> +		 * 5: ADB
> +		 */
> +		switch (ifnum) {
> +		case 3:
> +			dev_dbg(dev, "Modem port found\n");
> +			sendsetup = true;
> +			break;
> +		case 4:
> +			dev_dbg(dev, "DM/DIAG interface found\n");
> +			break;
> +		default:
> +			/* don't claim any unsupported interface */
> +			altsetting = -1;
> +			break;
> +		}
> +		break;
>  	case QCSERIAL_HWI:
>  		/*
>  		 * Huawei devices map functions by subclass + protocol

Johan
