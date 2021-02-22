Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF85321456
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 11:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBVKqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 05:46:43 -0500
Received: from smtp75.ord1d.emailsrvr.com ([184.106.54.75]:56112 "EHLO
        smtp75.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230117AbhBVKql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 05:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1613990759;
        bh=MlEdIWr3zQXOMI3lnebQjd7OtiF6wCGdOTLmgA4rsGc=;
        h=Subject:To:From:Date:From;
        b=PGjn8nkSohUk0vz1QYCqr917F38/mIJmKWhfoopUAp0OxGG9jQyAI0+/DJKAGu7UZ
         aKPlOfAb9rR9AYXQjfQE/2HkUmXOV2kiFnnE0Nb3rUzYkCmgrQXm0Va7ru7vbUuF40
         HWPwk0ec8k0aS+YOKymrbveqpRGpL7BXixU6GsaQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1613990759;
        bh=MlEdIWr3zQXOMI3lnebQjd7OtiF6wCGdOTLmgA4rsGc=;
        h=Subject:To:From:Date:From;
        b=KPoeWymt5QWP+kyBa+Qnywi6c/XmJ0zMg4y7OVaYpcEzPo3yEJ4XmdBMdOvAHH8l3
         kEJAaN/GbD8vqMrxoMfdq0st8MfxvfZwmHGvrL45myCZDt6t84Hl8zA+tUWf078jUK
         W4l47+neeqLQ9vJX/tcH75KeGxOIx5+2fRNguHdo=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp18.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 4D249A00AF;
        Mon, 22 Feb 2021 05:45:58 -0500 (EST)
Subject: Re: [PATCH -next] staging: comedi dt2814: Removed unused variables
To:     Fatih Yildirim <yildirim.fatih@gmail.com>,
        hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        grandmaster@al2klimov.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20210221202855.12442-1-yildirim.fatih@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <b4487d85-0657-5f55-1d4e-21264358c86a@mev.co.uk>
Date:   Mon, 22 Feb 2021 10:45:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210221202855.12442-1-yildirim.fatih@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: ccc532c2-53bc-412c-975c-e7b0210c0716-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2021 20:28, Fatih Yildirim wrote:
> Removed unused variables.
> 
> Signed-off-by: Fatih Yildirim <yildirim.fatih@gmail.com>
> ---
>  drivers/staging/comedi/drivers/dt2814.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/dt2814.c b/drivers/staging/comedi/drivers/dt2814.c
> index bcf4d5444faf..bd329d7b4893 100644
> --- a/drivers/staging/comedi/drivers/dt2814.c
> +++ b/drivers/staging/comedi/drivers/dt2814.c
> @@ -186,21 +186,17 @@ static int dt2814_ai_cmd(struct comedi_device *dev, struct comedi_subdevice *s)
>  
>  static irqreturn_t dt2814_interrupt(int irq, void *d)
>  {
> -	int lo, hi;
>  	struct comedi_device *dev = d;
>  	struct dt2814_private *devpriv = dev->private;
>  	struct comedi_subdevice *s = dev->read_subdev;
> -	int data;
>  
>  	if (!dev->attached) {
>  		dev_err(dev->class_dev, "spurious interrupt\n");
>  		return IRQ_HANDLED;
>  	}
>  
> -	hi = inb(dev->iobase + DT2814_DATA);
> -	lo = inb(dev->iobase + DT2814_DATA);
> -
> -	data = (hi << 4) | (lo >> 4);
> +	inb(dev->iobase + DT2814_DATA);
> +	inb(dev->iobase + DT2814_DATA);
>  
>  	if (!(--devpriv->ntrig)) {
>  		int i;
> @@ -229,7 +225,6 @@ static int dt2814_attach(struct comedi_device *dev, struct comedi_devconfig *it)
>  	struct dt2814_private *devpriv;
>  	struct comedi_subdevice *s;
>  	int ret;
> -	int i;
>  
>  	ret = comedi_request_region(dev, it->options[0], 0x2);
>  	if (ret)
> @@ -241,8 +236,8 @@ static int dt2814_attach(struct comedi_device *dev, struct comedi_devconfig *it)
>  		dev_err(dev->class_dev, "reset error (fatal)\n");
>  		return -EIO;
>  	}
> -	i = inb(dev->iobase + DT2814_DATA);
> -	i = inb(dev->iobase + DT2814_DATA);
> +	inb(dev->iobase + DT2814_DATA);
> +	inb(dev->iobase + DT2814_DATA);
>  
>  	if (it->options[1]) {
>  		ret = request_irq(it->options[1], dt2814_interrupt, 0,
> 

I've no objection to this patch.  The interrupt handling to support
Comedi asynchronous commands in this driver has always been broken.  I'm
tempted to remove the code for handling asynchronous commands in this
driver altogether for that reason.  (The naive fix of writing the data
to the Comedi buffer is insufficient without an additional check that
the command is running.  The end-of-conversion interrupt occurs
regardless of any command being active.)

Acked-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
