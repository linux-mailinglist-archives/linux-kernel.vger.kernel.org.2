Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C7E3DCD0A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 20:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhHASBR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 1 Aug 2021 14:01:17 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38047 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhHASBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 14:01:16 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id B636ECECDF;
        Sun,  1 Aug 2021 20:01:06 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2] bluetooth: bcm203x: update the reference count of udev
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210731154102.GA908767@pc>
Date:   Sun, 1 Aug 2021 20:01:06 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oliver@neukum.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <9B2209B6-D371-432B-A3F5-F1CD7C7967A3@holtmann.org>
References: <20210731154102.GA908767@pc>
To:     Salah Triki <salah.triki@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Salah,

> Use usb_get_dev() to increment the reference count of the usb device
> structure in order to avoid releasing the structure while it is still in
> use. And use usb_put_dev() to decrement the reference count and thus,
> when it will be equal to 0 the structure will be released.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
> Change since v1:
> 	Modification of the description
> 
> drivers/bluetooth/bcm203x.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
> index e667933c3d70..547d35425d70 100644
> --- a/drivers/bluetooth/bcm203x.c
> +++ b/drivers/bluetooth/bcm203x.c
> @@ -166,7 +166,7 @@ static int bcm203x_probe(struct usb_interface *intf, const struct usb_device_id
> 	if (!data)
> 		return -ENOMEM;
> 
> -	data->udev  = udev;
> +	data->udev  = usb_get_dev(udev);
> 	data->state = BCM203X_LOAD_MINIDRV;
> 
> 	data->urb = usb_alloc_urb(0, GFP_KERNEL);
> @@ -244,6 +244,8 @@ static void bcm203x_disconnect(struct usb_interface *intf)
> 
> 	usb_set_intfdata(intf, NULL);
> 
> +	usb_put_dev(data->udev);
> +
> 	usb_free_urb(data->urb);
> 	kfree(data->fw_data);
> 	kfree(data->buffer);

I do not understand this. If this is something broken, then it is broken in
btusb.c as well and that driver is heavily used by all sorts of devices. So
we should have seen bug reports about this.

Regards

Marcel

