Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3238633F0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 13:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCQMtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 08:49:03 -0400
Received: from smtp65.iad3a.emailsrvr.com ([173.203.187.65]:55168 "EHLO
        smtp65.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229944AbhCQMsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1615985332;
        bh=rvdGFH0sUjTPgyoQVuY1JrGXdy6YzrQiw9ETvD6KUrM=;
        h=Subject:To:From:Date:From;
        b=kTC/ZEJ+y2BazYsb2sIuM+iffENwPmqjHf591hEoBs39mdqJQxn/PbHkp501ie1/T
         6C1fn6IsEAg3E/MpxRXNBQT3SvZQPIpWMpzRVQ1ToKypP/6FsWtBO/Uh3DDQh2FYKJ
         2gZbC0kLW6Kh8mxSUTivepms960wGwt4ARpQ3SzA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp9.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 9C58D4392;
        Wed, 17 Mar 2021 08:48:51 -0400 (EDT)
Subject: Re: [PATCH] staging: comedi: das800: fix request_irq() warn
To:     Tong Zhang <ztong0001@gmail.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <92b7c57b-b645-9965-8157-4ca76a803cba@mev.co.uk>
 <20210316224227.348310-1-ztong0001@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <8c65b02e-4315-153f-de2c-153862f195be@mev.co.uk>
Date:   Wed, 17 Mar 2021 12:48:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316224227.348310-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: a5d326e6-cc0f-4e4e-a1aa-d226702d259e-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2021 22:42, Tong Zhang wrote:
> request_irq() wont accept a name which contains slash so we need to
> repalce it with something else -- otherwise it will trigger a warning
> and the entry in /proc/irq/ will not be created
> since the .name might be used by userspace and we don't want to break
> userspace, so we are changing the parameters passed to request_irq()
> 
> Suggested-by: Ian Abbott <abbotti@mev.co.uk>
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>   drivers/staging/comedi/drivers/das800.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/drivers/das800.c b/drivers/staging/comedi/drivers/das800.c
> index 2881808d6606..bc08324f422f 100644
> --- a/drivers/staging/comedi/drivers/das800.c
> +++ b/drivers/staging/comedi/drivers/das800.c
> @@ -668,7 +668,7 @@ static int das800_attach(struct comedi_device *dev, struct comedi_devconfig *it)
>   	dev->board_name = board->name;
>   
>   	if (irq > 1 && irq <= 7) {
> -		ret = request_irq(irq, das800_interrupt, 0, dev->board_name,
> +		ret = request_irq(irq, das800_interrupt, 0, "das800",
>   				  dev);
>   		if (ret == 0)
>   			dev->irq = irq;
> 

Looks good (apart from the minor spelling niggle spotted by Dan 
Carpenter), thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
