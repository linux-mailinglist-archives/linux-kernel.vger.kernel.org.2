Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E70366094
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhDTUEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:04:23 -0400
Received: from netrider.rowland.org ([192.131.102.5]:52755 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233660AbhDTUEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:04:22 -0400
Received: (qmail 186097 invoked by uid 1000); 20 Apr 2021 16:03:49 -0400
Date:   Tue, 20 Apr 2021 16:03:49 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     chris.chiu@canonical.com
Cc:     gregkh@linuxfoundation.org, m.v.b@runbox.com, hadess@hadess.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: Add reset-resume quirk for WD19's Realtek Hub
Message-ID: <20210420200349.GB185805@rowland.harvard.edu>
References: <20210420174651.6202-1-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420174651.6202-1-chris.chiu@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 01:46:51AM +0800, chris.chiu@canonical.com wrote:
> From: Chris Chiu <chris.chiu@canonical.com>
> 
> Realtek Hub (0bda:5487) in Dell Dock WD19 sometimes fails to work
> after the system resumes from suspend with remote wakeup enabled
> device connected:
> [ 1947.640907] hub 5-2.3:1.0: hub_ext_port_status failed (err = -71)
> [ 1947.641208] usb 5-2.3-port5: cannot disable (err = -71)
> [ 1947.641401] hub 5-2.3:1.0: hub_ext_port_status failed (err = -71)
> [ 1947.641450] usb 5-2.3-port4: cannot reset (err = -71)
> 
> Information of this hub:
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 10 Spd=480  MxCh= 5
> D:  Ver= 2.10 Cls=09(hub  ) Sub=00 Prot=02 MxPS=64 #Cfgs=  1
> P:  Vendor=0bda ProdID=5487 Rev= 1.47
> S:  Manufacturer=Dell Inc.
> S:  Product=Dell dock
> C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=01 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms
> I:* If#= 0 Alt= 1 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=02 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms
> 
> The failure results from the ETIMEDOUT by chance when turning on
> the suspend feature for the specified port of the hub. The port
> seems to be in an unknown state so the hub_activate during resume
> fails the hub_port_status, then the hub will fail to work.
> 
> The quirky hub needs the reset-resume quirk to function correctly.
> 
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> ---
>  drivers/usb/core/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 76ac5d6555ae..4e2483e34250 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -406,6 +406,7 @@ static const struct usb_device_id usb_quirk_list[] = {
>  
>  	/* Realtek hub in Dell WD19 (Type-C) */
>  	{ USB_DEVICE(0x0bda, 0x0487), .driver_info = USB_QUIRK_NO_LPM },
> +	{ USB_DEVICE(0x0bda, 0x5487), .driver_info = USB_QUIRK_RESET_RESUME },
>  
>  	/* Generic RTL8153 based ethernet adapters */
>  	{ USB_DEVICE(0x0bda, 0x8153), .driver_info = USB_QUIRK_NO_LPM },

Acked-by: Alan Stern <stern@rowland.harvard.edu>
