Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8B53C9DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhGOLoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 07:44:39 -0400
Received: from smtp88.ord1d.emailsrvr.com ([184.106.54.88]:34084 "EHLO
        smtp88.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhGOLoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:44:39 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jul 2021 07:44:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1626348867;
        bh=3cztsMwQmMdPTT+daePLLQcpJuknVNxL+D3iQl4SaG4=;
        h=Subject:To:From:Date:From;
        b=M23+6fH0emXzo+TwwyfxUhEVkN/Kj1IdT8u2+VxSvBs848IzUunlMrq/RuQrkJLM3
         c8U9tmaIuvy4Ev6FwvuCHo5Gk8g2BIE37U5fahPJfKMoIQndKRyQmGP7g1KvY5pbW4
         +lS/zkKVnc+9u5fvtZBwVartlKxvRAMGBfaU6gNo=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp20.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id D6A7BC00AA;
        Thu, 15 Jul 2021 07:34:26 -0400 (EDT)
Subject: Re: [PATCH] comedi: usbdux: free allocated memory/urbs on failure
To:     Salah Triki <salah.triki@gmail.com>, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20210715022652.GA2054080@pc>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <5f688e04-80cc-e37b-3f6f-3360b5af89aa@mev.co.uk>
Date:   Thu, 15 Jul 2021 12:34:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715022652.GA2054080@pc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: a242d17c-20e9-4b90-ba75-3c0943789a6f-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2021 03:26, Salah Triki wrote:
> Free allocated memory/urbs on failure in order to prevent memory leaks.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>   drivers/comedi/drivers/usbdux.c | 42 ++++++++++++++++++++++++++++-----
>   1 file changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/usbdux.c b/drivers/comedi/drivers/usbdux.c
> index 0350f303d557..fe388a9a588a 100644
> --- a/drivers/comedi/drivers/usbdux.c
> +++ b/drivers/comedi/drivers/usbdux.c
> @@ -1456,7 +1456,7 @@ static int usbdux_alloc_usb_buffers(struct comedi_device *dev)
>   		/* one frame: 1ms */
>   		urb = usb_alloc_urb(1, GFP_KERNEL);
>   		if (!urb)
> -			return -ENOMEM;
> +			goto free_ai_urbs1;
>   		devpriv->ai_urbs[i] = urb;
>   
>   		urb->dev = usb;
> @@ -1465,7 +1465,7 @@ static int usbdux_alloc_usb_buffers(struct comedi_device *dev)
>   		urb->transfer_flags = URB_ISO_ASAP;
>   		urb->transfer_buffer = kzalloc(SIZEINBUF, GFP_KERNEL);
>   		if (!urb->transfer_buffer)
> -			return -ENOMEM;
> +			goto free_ai_urbs2;
>   
>   		urb->complete = usbduxsub_ai_isoc_irq;
>   		urb->number_of_packets = 1;
> @@ -1478,7 +1478,7 @@ static int usbdux_alloc_usb_buffers(struct comedi_device *dev)
>   		/* one frame: 1ms */
>   		urb = usb_alloc_urb(1, GFP_KERNEL);
>   		if (!urb)
> -			return -ENOMEM;
> +			goto free_ao_urbs1;
>   		devpriv->ao_urbs[i] = urb;
>   
>   		urb->dev = usb;
> @@ -1487,7 +1487,7 @@ static int usbdux_alloc_usb_buffers(struct comedi_device *dev)
>   		urb->transfer_flags = URB_ISO_ASAP;
>   		urb->transfer_buffer = kzalloc(SIZEOUTBUF, GFP_KERNEL);
>   		if (!urb->transfer_buffer)
> -			return -ENOMEM;
> +			goto free_ao_urbs2;
>   
>   		urb->complete = usbduxsub_ao_isoc_irq;
>   		urb->number_of_packets = 1;
> @@ -1504,17 +1504,47 @@ static int usbdux_alloc_usb_buffers(struct comedi_device *dev)
>   	if (devpriv->pwm_buf_sz) {
>   		urb = usb_alloc_urb(0, GFP_KERNEL);
>   		if (!urb)
> -			return -ENOMEM;
> +			goto free_ao_urbs0;
>   		devpriv->pwm_urb = urb;
>   
>   		/* max bulk ep size in high speed */
>   		urb->transfer_buffer = kzalloc(devpriv->pwm_buf_sz,
>   					       GFP_KERNEL);
>   		if (!urb->transfer_buffer)
> -			return -ENOMEM;
> +			goto free_urb;
>   	}
>   
>   	return 0;
> +
> +free_urb:
> +	usb_free_urb(urb);
> +
> +free_ao_urbs0:
> +	i = devpriv->n_ao_urbs;
> +
> +free_ao_urbs1:
> +	i--;
> +
> +free_ao_urbs2:
> +	while (i >= 0) {
> +		kfree(devpriv->ao_urbs[i]->transfer_buffer);
> +		usb_free_urb(devpriv->ao_urbs[i]);
> +		i--;
> +	}
> +	i = devpriv->n_ai_urbs;
> +
> +free_ai_urbs1:
> +	i--;
> +
> +free_ai_urbs2:
> +	while (i >= 0) {
> +		kfree(devpriv->ai_urbs[i]->transfer_buffer);
> +		usb_free_urb(devpriv->ai_urbs[i]);
> +		i--;
> +	}
> +
> +	return -ENOMEM;
> +
>   }
>   
>   static void usbdux_free_usb_buffers(struct comedi_device *dev)
> 

NAK.

Actually, there is no need for this because usbdux_free_usb_buffers() 
will soon be called to clean up when this fails.[*]  Also, it isn't 
cleaning up enough to prevent double frees when 
usbdux_free_usb_buffers() is called later.


[*] The error returned from usbdux_alloc_usb_buffers() is propagated as 
an error returned by usbdux_auto_attach(). The Comedi core calls the 
"detach()" handler (usbdux_detach()) to clean up when the 
"auto_attach()" handler (usbdux_auto_attach()) returns an error. 
usbdux_detach() calls usbdux_free_usb_buffers() to clean up the 
(possibly partial) allocations done by usbdux_alloc_usb_buffers().

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
