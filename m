Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C560345F0BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378031AbhKZPf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:35:56 -0500
Received: from netrider.rowland.org ([192.131.102.5]:48281 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1352017AbhKZPd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:33:56 -0500
Received: (qmail 218431 invoked by uid 1000); 26 Nov 2021 10:30:42 -0500
Date:   Fri, 26 Nov 2021 10:30:42 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andrew Lunn <andrew@lunn.ch>, Rajat Jain <rajatja@google.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: core: Avoid doing warm reset on disconnect event
Message-ID: <YaD9oubkHPzHtSY4@rowland.harvard.edu>
References: <20211126115652.1134230-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211126115652.1134230-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 07:56:51PM +0800, Kai-Heng Feng wrote:
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
> v2:
>  - Change the variable type to bool.
> 
>  drivers/usb/core/hub.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index a9a04ea967019..4f081df70ecf2 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -5564,6 +5564,7 @@ static void port_event(struct usb_hub *hub, int port1)
>  		__must_hold(&port_dev->status_lock)
>  {
>  	int connect_change;
> +	bool disconnect = false;
>  	struct usb_port *port_dev = hub->ports[port1 - 1];
>  	struct usb_device *udev = port_dev->child;
>  	struct usb_device *hdev = hub->hdev;
> @@ -5579,6 +5580,9 @@ static void port_event(struct usb_hub *hub, int port1)
>  	if (portchange & USB_PORT_STAT_C_CONNECTION) {
>  		usb_clear_port_feature(hdev, port1, USB_PORT_FEAT_C_CONNECTION);
>  		connect_change = 1;
> +		if (!(portstatus & USB_PORT_STAT_CONNECTION) &&
> +		    !(portstatus & USB_PORT_STAT_ENABLE))
> +			disconnect = true;
>  	}

This looks a little strange.  Can there ever be a situation where 
PORT_STAT_CONNECTION is off and PORT_STAT_ENABLE is on?  (It's not allowed in 
USB-2.)

>  	if (portchange & USB_PORT_STAT_C_ENABLE) {
> @@ -5647,7 +5651,7 @@ static void port_event(struct usb_hub *hub, int port1)
>  	 * Warm reset a USB3 protocol port if it's in
>  	 * SS.Inactive state.
>  	 */
> -	if (hub_port_warm_reset_required(hub, port1, portstatus)) {
> +	if (hub_port_warm_reset_required(hub, port1, portstatus) && !disconnect) {
>  		dev_dbg(&port_dev->dev, "do warm reset\n");
>  		if (!udev || !(portstatus & USB_PORT_STAT_CONNECTION)
>  				|| udev->state == USB_STATE_NOTATTACHED) {

Why is it correct to skip doing a warm reset on a disconnected port here, but not 
correct to skip doing a warm reset on a disconnected port in all the other places 
where hub_port_warm_reset_required() gets called?

Alan Stern
