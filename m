Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371A432EEE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhCEPde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:33:34 -0500
Received: from netrider.rowland.org ([192.131.102.5]:42317 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230109AbhCEPdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:33:13 -0500
Received: (qmail 39139 invoked by uid 1000); 5 Mar 2021 10:33:12 -0500
Date:   Fri, 5 Mar 2021 10:33:12 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH 16/17] usb: common: add function to get interval
 expressed in us unit
Message-ID: <20210305153312.GA38200@rowland.harvard.edu>
References: <1614934975-15188-1-git-send-email-chunfeng.yun@mediatek.com>
 <1614934975-15188-16-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614934975-15188-16-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 05:02:54PM +0800, Chunfeng Yun wrote:
> Add a new function to convert bInterval into the time expressed
> in 1us unit.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---

> --- a/drivers/usb/common/common.c
> +++ b/drivers/usb/common/common.c
> @@ -165,6 +165,39 @@ enum usb_dr_mode usb_get_dr_mode(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(usb_get_dr_mode);
>  
> +unsigned int usb_decode_interval(const struct usb_endpoint_descriptor *epd,
> +				 enum usb_device_speed speed)
> +{
> +	unsigned int interval = 0;
> +
> +	switch (usb_endpoint_type(epd)) {
> +	case USB_ENDPOINT_XFER_CONTROL:
> +		/* uframes per NAK */
> +		if (speed == USB_SPEED_HIGH)
> +			interval = epd->bInterval;
> +		break;
> +	case USB_ENDPOINT_XFER_ISOC:
> +		interval = 1 << (epd->bInterval - 1);
> +		break;
> +	case USB_ENDPOINT_XFER_BULK:
> +		/* uframes per NAK */
> +		if (speed == USB_SPEED_HIGH && usb_endpoint_dir_out(epd))
> +			interval = epd->bInterval;
> +		break;
> +	case USB_ENDPOINT_XFER_INT:
> +		if (speed >= USB_SPEED_HIGH)
> +			interval = 1 << (epd->bInterval - 1);
> +		else
> +			interval = epd->bInterval;
> +		break;
> +	}
> +
> +	interval *= (speed >= USB_SPEED_HIGH) ? 125 : 1000;
> +
> +	return interval;
> +}
> +EXPORT_SYMBOL_GPL(usb_decode_interval);

> --- a/include/linux/usb/ch9.h
> +++ b/include/linux/usb/ch9.h
> @@ -90,6 +90,17 @@ extern enum usb_ssp_rate usb_get_maximum_ssp_rate(struct device *dev);
>   */
>  extern const char *usb_state_string(enum usb_device_state state);
>  
> +/**
> + * usb_decode_interval - Decode bInterval into the time expressed in 1us unit
> + * @epd: The descriptor of the endpoint
> + * @speed: The speed that the endpoint works as
> + *
> + * Function returns the interval expressed in 1us unit for servicing
> + * endpoint for data transfers.
> + */
> +unsigned int usb_decode_interval(const struct usb_endpoint_descriptor *epd,
> +				 enum usb_device_speed speed);

As a general rule, I believe people expect to find the kerneldoc for a 
function next to the function's definition, not next to the declaration 
in a header file.

Alan Stern
