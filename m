Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBD3305EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhA0OvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:51:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232701AbhA0OuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:50:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4D6B207E2;
        Wed, 27 Jan 2021 14:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611758960;
        bh=Hz9DGXvQCdiByk6/l51un6j62XKj8MeDDozTnsmWZWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCyJgI7hdzAQ66Rnug7lQlMI046KnUimo4hxkpPd5f2/zDcD9N1qQM5pqfcgOaD42
         vP+Yk4EMybY5uJni3Iea6fGXin4cE+AIIer6SNmCx1y6lUjjGd4mova6oPZs/KO1El
         2y7YPJkOkoPJCJ9MKeolllijj32qb9enOjHiP3L1buZR01ptRuhNIzhT0x7ou80Pm6
         NYP8EaMoIcMOZv1TF6eCSvImVynoXjKecBWEWAq7t/GBST2C38jrlnnbiyxxsNL3IP
         x0q8vcRvM6S6vb3Q8r/+niOh8fivvC6LlsSZ4y08/GmcLDntNow2HM1drKTxIOZia3
         a1dmHTeaIyOeQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l4m8R-0001v7-NV; Wed, 27 Jan 2021 15:49:32 +0100
Date:   Wed, 27 Jan 2021 15:49:31 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/12] usb: misc: ehset: update to use the
 usb_control_msg_{send|recv}() API
Message-ID: <YBF9exziI12OCSuA@hovoldconsulting.com>
References: <20210126183403.911653-1-anant.thazhemadam@gmail.com>
 <20210126183403.911653-5-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126183403.911653-5-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:03:55AM +0530, Anant Thazhemadam wrote:
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treated
> as an error, data can be used off the stack, and raw usb pipes need not be
> created in the calling functions.
> For this reason, instances of usb_control_msg() have been replaced with
> usb_control_msg_{recv|send}() appropriately.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> Reviewed-by: Peter Chen <peter.chen@nxp.com>
> ---
>  drivers/usb/misc/ehset.c | 76 +++++++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/usb/misc/ehset.c b/drivers/usb/misc/ehset.c
> index 2752e1f4f4d0..f87890f9cd26 100644
> --- a/drivers/usb/misc/ehset.c
> +++ b/drivers/usb/misc/ehset.c
> @@ -24,68 +24,57 @@ static int ehset_probe(struct usb_interface *intf,
>  	int ret = -EINVAL;
>  	struct usb_device *dev = interface_to_usbdev(intf);
>  	struct usb_device *hub_udev = dev->parent;
> -	struct usb_device_descriptor *buf;
> +	struct usb_device_descriptor buf;
>  	u8 portnum = dev->portnum;
>  	u16 test_pid = le16_to_cpu(dev->descriptor.idProduct);
>  
>  	switch (test_pid) {
>  	case TEST_SE0_NAK_PID:
> -		ret = usb_control_msg(hub_udev, usb_sndctrlpipe(hub_udev, 0),
> -					USB_REQ_SET_FEATURE, USB_RT_PORT,
> -					USB_PORT_FEAT_TEST,
> -					(USB_TEST_SE0_NAK << 8) | portnum,
> -					NULL, 0, 1000);
> +		ret = usb_control_msg_send(hub_udev, 0, USB_REQ_SET_FEATURE,
> +					   USB_RT_PORT, USB_PORT_FEAT_TEST,
> +					   (USB_TEST_SE0_NAK << 8) | portnum,
> +					   NULL, 0, 1000, GFP_KERNEL);
>  		break;

>  	case TEST_SINGLE_STEP_GET_DEV_DESC:
>  		/* Test: wait for 15secs -> GetDescriptor request */
>  		msleep(15 * 1000);
> -		buf = kmalloc(USB_DT_DEVICE_SIZE, GFP_KERNEL);
> -		if (!buf)
> -			return -ENOMEM;
>  
> -		ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
> -					USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
> -					USB_DT_DEVICE << 8, 0,
> -					buf, USB_DT_DEVICE_SIZE,
> -					USB_CTRL_GET_TIMEOUT);
> -		kfree(buf);
> +		ret = usb_control_msg_recv(dev, 0, USB_REQ_GET_DESCRIPTOR,
> +					   USB_DIR_IN, USB_DT_DEVICE << 8, 0,
> +					   &buf, USB_DT_DEVICE_SIZE,
> +					   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);

Ok, here you now test for a short device descriptor (which USB core
should already have fetched if you get to probe this driver), but which
wasn't verified again here before. You may want to mention that in the
commit message.

And the buffer is small enough that moving it to the stack also for the
other test cases isn't an issue (and the redundant memcpy() introduced
by the helper is in the noise).

So, this looks ok (with an amended commit message dropping the short
write bit):

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
