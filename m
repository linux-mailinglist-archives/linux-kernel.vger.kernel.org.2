Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7557940B07C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhINOXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:23:44 -0400
Received: from netrider.rowland.org ([192.131.102.5]:52947 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233309AbhINOXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:23:43 -0400
Received: (qmail 156518 invoked by uid 1000); 14 Sep 2021 10:22:24 -0400
Date:   Tue, 14 Sep 2021 10:22:24 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Ondrej Zary <linux@zary.sk>
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb-storage: Add quirk for ScanLogic SL11R-IDE older
 than 2.6c
Message-ID: <20210914142224.GB155245@rowland.harvard.edu>
References: <20210913210106.12717-1-linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913210106.12717-1-linux@zary.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 11:01:06PM +0200, Ondrej Zary wrote:
> ScanLogic SL11R-IDE with firmware older than 2.6c (the latest one) has
> broken tag handling, preventing the device from working at all:
> usb 1-1: new full-speed USB device number 2 using uhci_hcd
> usb 1-1: New USB device found, idVendor=04ce, idProduct=0002, bcdDevice= 2.60
> usb 1-1: New USB device strings: Mfr=1, Product=1, SerialNumber=0
> usb 1-1: Product: USB Device
> usb 1-1: Manufacturer: USB Device
> usb-storage 1-1:1.0: USB Mass Storage device detected
> scsi host2: usb-storage 1-1:1.0
> usbcore: registered new interface driver usb-storage
> usb 1-1: reset full-speed USB device number 2 using uhci_hcd
> usb 1-1: reset full-speed USB device number 2 using uhci_hcd
> usb 1-1: reset full-speed USB device number 2 using uhci_hcd
> usb 1-1: reset full-speed USB device number 2 using uhci_hcd
> 
> Add US_FL_BULK_IGNORE_TAG to fix it. Also update my e-mail address.
> 
> 2.6c is the only firmware that claims Linux compatibility.
> The firmware can be upgraded using ezotgdbg utility:
> https://github.com/asciilifeform/ezotgdbg
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/storage/unusual_devs.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
> index efa972be2ee3..c6b3fcf90180 100644
> --- a/drivers/usb/storage/unusual_devs.h
> +++ b/drivers/usb/storage/unusual_devs.h
> @@ -416,9 +416,16 @@ UNUSUAL_DEV(  0x04cb, 0x0100, 0x0000, 0x2210,
>  		USB_SC_UFI, USB_PR_DEVICE, NULL, US_FL_FIX_INQUIRY | US_FL_SINGLE_LUN),
>  
>  /*
> - * Reported by Ondrej Zary <linux@rainbow-software.org>
> + * Reported by Ondrej Zary <linux@zary.sk>
>   * The device reports one sector more and breaks when that sector is accessed
> + * Firmwares older than 2.6c (the latest one and the only that claims Linux
> + * support) have also broken tag handling
>   */
> +UNUSUAL_DEV(  0x04ce, 0x0002, 0x0000, 0x026b,
> +		"ScanLogic",
> +		"SL11R-IDE",
> +		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> +		US_FL_FIX_CAPACITY | US_FL_BULK_IGNORE_TAG),
>  UNUSUAL_DEV(  0x04ce, 0x0002, 0x026c, 0x026c,
>  		"ScanLogic",
>  		"SL11R-IDE",

Too bad the manufacturer didn't understand that 0x026c is not a valid 
bcdDevice value...
