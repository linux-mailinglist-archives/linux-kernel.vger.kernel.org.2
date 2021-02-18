Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696C131F0E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 21:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhBRURd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 15:17:33 -0500
Received: from smtp116.ord1c.emailsrvr.com ([108.166.43.116]:42025 "EHLO
        smtp116.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229953AbhBRUR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1613666733;
        bh=S1Fq+tox9MWcUqvYO7gs5705kiM9wMsNW7MjUawCZy4=;
        h=Subject:To:From:Date:From;
        b=PhgcptYevAjOOqtTfJe9xAWMQ4jHc9GUy2VcDPCvyyjGhOxENORLlzwO0Ekx5sYhs
         GJHPZan9poZc1GYObbIEhnKkeXd/TAmiZtz0XY84rUdrpXGgg+oZEu00BUu+TuQPLj
         v/apwnpVZbUpMKBvxR3tIb2JnVHt3jhaoj69u8yc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1613666733;
        bh=S1Fq+tox9MWcUqvYO7gs5705kiM9wMsNW7MjUawCZy4=;
        h=Subject:To:From:Date:From;
        b=auWMYbr66PL4muUl7BX5naim5F3JKkx+n2dvf7romJdMyTRGOgCx6BUhZ29EP+ChQ
         aAhXw5rsj9Di7QUt8gQy5Kx1Rw6GkAnjBgXKJqEJUJGLGMYj9bV5O9FuWud7kIQTBP
         X9LAghWP+ec/GctA5gPVU1z0vgW6Anks+YhADaO4=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 88B10A0225;
        Thu, 18 Feb 2021 11:45:31 -0500 (EST)
Subject: Re: [PATCH] Staging: comedi: Replaced strlcpy to strscpy
To:     chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Michel Lespinasse <walken@google.com>,
        B K Karthik <bkkarthik@pesu.pes.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20210218143152.3957-1-chakravarthikulkarni2021@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <43b0f966-9d88-3c92-28ce-6dfce755a1be@mev.co.uk>
Date:   Thu, 18 Feb 2021 16:45:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210218143152.3957-1-chakravarthikulkarni2021@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: d6d0b856-a613-4e54-8f8c-36e84e572270-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2021 14:31, chakravarthikulkarni wrote:
> Warning found by checkpath.pl script.
> 
> Signed-off-by: chakravarthikulkarni <chakravarthikulkarni2021@gmail.com>
> ---
>  drivers/staging/comedi/comedi_fops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
> index 80d74cce2a01..df77b6bf5c64 100644
> --- a/drivers/staging/comedi/comedi_fops.c
> +++ b/drivers/staging/comedi/comedi_fops.c
> @@ -939,8 +939,8 @@ static int do_devinfo_ioctl(struct comedi_device *dev,
>  	/* fill devinfo structure */
>  	devinfo.version_code = COMEDI_VERSION_CODE;
>  	devinfo.n_subdevs = dev->n_subdevices;
> -	strlcpy(devinfo.driver_name, dev->driver->driver_name, COMEDI_NAMELEN);
> -	strlcpy(devinfo.board_name, dev->board_name, COMEDI_NAMELEN);
> +	strscpy(devinfo.driver_name, dev->driver->driver_name, COMEDI_NAMELEN);
> +	strscpy(devinfo.board_name, dev->board_name, COMEDI_NAMELEN);
>  
>  	s = comedi_file_read_subdevice(file);
>  	if (s)
> 

Thanks, but you are too late.  It has already been fixed in linux-next.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
