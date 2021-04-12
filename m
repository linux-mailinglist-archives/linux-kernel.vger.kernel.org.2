Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EC835C977
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbhDLPM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:12:26 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49849 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S237526AbhDLPMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:12:24 -0400
Received: (qmail 1422005 invoked by uid 1000); 12 Apr 2021 11:12:05 -0400
Date:   Mon, 12 Apr 2021 11:12:05 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     chris.chiu@canonical.com
Cc:     gregkh@linuxfoundation.org, m.v.b@runbox.com, hadess@hadess.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: Don't set USB_PORT_FEAT_SUSPEND on WD19's Realtek
 Hub
Message-ID: <20210412151205.GB1420451@rowland.harvard.edu>
References: <20210412150006.53909-1-chris.chiu@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412150006.53909-1-chris.chiu@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 11:00:06PM +0800, chris.chiu@canonical.com wrote:
> From: Chris Chiu <chris.chiu@canonical.com>
> 
> Realtek Hub (0bda:5413) in Dell Dock WD19 sometimes fails to work
> after the system resumes from suspend with remote wakeup enabled
> device connected:
> [ 1947.640907] hub 5-2.3:1.0: hub_ext_port_status failed (err = -71)
> [ 1947.641208] usb 5-2.3-port5: cannot disable (err = -71)
> [ 1947.641401] hub 5-2.3:1.0: hub_ext_port_status failed (err = -71)
> [ 1947.641450] usb 5-2.3-port4: cannot reset (err = -71)
> 
> Information of this hub:
> T:  Bus=01 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#=  9 Spd=480  MxCh= 6
> D:  Ver= 2.10 Cls=09(hub  ) Sub=00 Prot=02 MxPS=64 #Cfgs=  1
> P:  Vendor=0bda ProdID=5413 Rev= 1.21
> S:  Manufacturer=Dell Inc.
> S:  Product=Dell dock
> C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=01 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms
> I:* If#= 0 Alt= 1 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=02 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=256ms
> 
> The failure results from the ETIMEDOUT by chance when turning on
> the suspend feature of the hub. The usb_resume_device will not be
> invoked since the device state is not set to suspended, then the
> hub fails to activate subsequently.
> 
> The USB_PORT_FEAT_SUSPEND is not really necessary due to the
> "global suspend" in USB 2.0 spec. It's only for many hub devices
> which don't relay wakeup requests from the devices connected to
> downstream ports. For this realtek hub, there's no problem waking
> up the system from connected keyboard.

What about runtime suspend?  That _does_ require USB_PORT_FEAT_SUSPEND.

> This commit bypasses the USB_PORT_FEAT_SUSPEND for the quirky hub.
> 
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> ---


> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 7f71218cc1e5..8478d49bba77 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3329,8 +3329,11 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
>  	 * descendants is enabled for remote wakeup.
>  	 */
>  	else if (PMSG_IS_AUTO(msg) || usb_wakeup_enabled_descendants(udev) > 0)
> -		status = set_port_feature(hub->hdev, port1,
> -				USB_PORT_FEAT_SUSPEND);
> +		if (udev->quirks & USB_QUIRK_NO_SET_FEAT_SUSPEND)

You should test hub->hdev->quirks, here, not udev->quirks.  The quirk 
belongs to the Realtek hub, not to the device that's plugged into the 
hub.

Alan Stern
