Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091E54111EF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhITJd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233719AbhITJdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:33:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26E3660F70;
        Mon, 20 Sep 2021 09:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632130348;
        bh=QtIbrVxChQ8x2+rrnisFBg18QvRgKQ8XOzzmsXcPUsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCuwAAQzWiUIOvELmqRMQN3et2Jowt6cP+0z3WYiZkN0oixigT8cALdtgb5zdkCF9
         4uvjzPT40/gNidN45WkUI3TiE0SLo/tKhNSizbCbTUnAL3Oa41JczabuemVn/YvORT
         FFrj0n/vqzydeoH6rN5vuaEppIPDAhgbdaiIkQadeMkENaI2eWX+up3OWhzg1O/n6Y
         8MvutxmiIvibanviyTBoz7SWZbBhv1BbEWAUhDiZi166jLt/WYiKr2ZCLFhQk5D1mh
         SZr7+2unLTEhSbaugkZuo+z5hDaNMiyg8jKIMmaMI6+Fqilhp5gqJ4uC8hTa2hIUBe
         zF2DqzY0/nPxw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mSFf0-0000mn-TX; Mon, 20 Sep 2021 11:32:26 +0200
Date:   Mon, 20 Sep 2021 11:32:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB:serial:option Add Foxconn T99W265
Message-ID: <YUhVKrRJ8M2hKJil@hovoldconsulting.com>
References: <20210917110106.9852-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917110106.9852-1-slark_xiao@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 07:01:06PM +0800, Slark Xiao wrote:
> Adding support for Foxconn device T99W265 for enumeration with
> PID 0xe0db.
> 
> usb-devices output for 0xe0db
> T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 19 Spd=5000 MxCh= 0
> D:  Ver= 3.20 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
> P:  Vendor=0489 ProdID=e0db Rev=05.04
> S:  Manufacturer=Microsoft
> S:  Product=Generic Mobile Broadband Adapter
> S:  SerialNumber=6c50f452
> C:  #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=896mA
> I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
> I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
> I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> I:  If#=0x3 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> I:  If#=0x4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> 
> if0/1: MBIM, if2:Diag, if3:GNSS, if4: Modem
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Thanks for the patch and for including all the necessary details in the
commit message.

First, a minor style nit: Please add spaces after the ':'s in the patch
Subject.

> ---
>  drivers/usb/serial/option.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 29c765cc8495..fde599fa2d73 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2068,6 +2068,8 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
>  	{ USB_DEVICE(0x0489, 0xe0b5),						/* Foxconn T77W968 ESIM */
>  	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
> +	{ USB_DEVICE(0x0489, 0xe0db),						/* Foxconn T99W265 MBIM extension*/
> +	  .driver_info = RSVD(0) | RSVD(1) | RSVD(3) },

If you use USB_DEVICE_INTERFACE_CLASS() instead you don't need to
explicitly reserve the MBIM interfaces. 

Also, why are you reserving the GNSS interface (e.g. unlike T77W968)?

>  	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
>  	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
>  	{ USB_DEVICE(0x2cb7, 0x0104),						/* Fibocom NL678 series */

Johan
