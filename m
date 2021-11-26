Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A4945E81F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 07:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbhKZG62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 01:58:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234932AbhKZG4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 01:56:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49F7F61107;
        Fri, 26 Nov 2021 06:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637909591;
        bh=EkC+31WwzI8sHldf/U1UH0zdUBbQivdaXpJbEwDm3jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRNvCji7VX4ICqh8fVlaGz0yve30ZkW+t/7xkxq9fSZPSyFEdhn9TndWClivJ4Ecu
         lotakZi50YuctBEwvbVJkut24vbxVloW6OXxjzd5NUHYmvkERu4xQ+ABZ5woCiIpwv
         vtkrNb6xR47zn1o1+VNKefaWJNnPOh0/uoifgWWs=
Date:   Fri, 26 Nov 2021 07:53:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        Rajat Jain <rajatja@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Avoid doing warm reset on disconnect event
Message-ID: <YaCEUoB7C7hUiREv@kroah.com>
References: <20211126032622.1101448-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211126032622.1101448-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 11:26:21AM +0800, Kai-Heng Feng wrote:
> Unplugging USB device may cause an incorrect warm reset loop:
> [  143.039019] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, portsc: 0x4202c0
> [  143.039025] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2 port polling.
> [  143.039051] hub 2-0:1.0: state 7 ports 10 chg 0000 evt 0008
> [  143.039058] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x4202c0, return 0x4102c0
> [  143.039092] xhci_hcd 0000:00:14.0: clear port3 connect change, portsc: 0x4002c0
> [  143.039096] usb usb2-port3: link state change
> [  143.039099] xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x2c0
> [  143.039101] usb usb2-port3: do warm reset
> [  143.096736] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2b0, return 0x2b0
> [  143.096751] usb usb2-port3: not warm reset yet, waiting 50ms
> [  143.131500] xhci_hcd 0000:00:14.0: Can't queue urb, port error, link inactive
> [  143.138260] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, portsc: 0x2802a0
> [  143.138263] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2 port polling.
> [  143.160756] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2802a0, return 0x3002a0
> [  143.160798] usb usb2-port3: not warm reset yet, waiting 200ms
> 
> The warm reset is due to its PLS is in eSS.Inactive state. However, USB
> 3.2 spec table 10-13 mentions "Ports can be disabled by either a fault
> condition (disconnect event or other fault condition)", xHCI 1.2 spec
> table 5-27 also states that "This flag shall automatically be cleared to
> ‘0’ by a disconnect event or other fault condition." on PED.
> 
> So use CSC = 0 and PED = 0 as indication that device is disconnecting to
> avoid doing warm reset.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/usb/core/hub.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 86658a81d2844..abd5a83d194b0 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -5530,6 +5530,7 @@ static void port_event(struct usb_hub *hub, int port1)
>  		__must_hold(&port_dev->status_lock)
>  {
>  	int connect_change;
> +	int disconnect = 0;

bool?

>  	struct usb_port *port_dev = hub->ports[port1 - 1];
>  	struct usb_device *udev = port_dev->child;
>  	struct usb_device *hdev = hub->hdev;
> @@ -5545,6 +5546,9 @@ static void port_event(struct usb_hub *hub, int port1)
>  	if (portchange & USB_PORT_STAT_C_CONNECTION) {
>  		usb_clear_port_feature(hdev, port1, USB_PORT_FEAT_C_CONNECTION);
>  		connect_change = 1;
> +		if (!(portstatus & USB_PORT_STAT_CONNECTION) &&
> +		    !(portstatus & USB_PORT_STAT_ENABLE))
> +			disconnect = 1;
>  	}
>  
>  	if (portchange & USB_PORT_STAT_C_ENABLE) {
> @@ -5613,7 +5617,7 @@ static void port_event(struct usb_hub *hub, int port1)
>  	 * Warm reset a USB3 protocol port if it's in
>  	 * SS.Inactive state.
>  	 */
> -	if (hub_port_warm_reset_required(hub, port1, portstatus)) {
> +	if (hub_port_warm_reset_required(hub, port1, portstatus) && !disconnect) {

Why is this problem just showing up now?  What commit caused this
regression?

thanks,

greg k-h
