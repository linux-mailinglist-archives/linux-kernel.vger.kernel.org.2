Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3A93F5F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbhHXNqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237403AbhHXNqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:46:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA1996103B;
        Tue, 24 Aug 2021 13:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629812758;
        bh=Jed18KPEaR+Zuz6QaoXkrJ1/iRgkKIy/q8FOpLXPpfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=If+MJbyHhxgeinHlWa6kCcSoshW7bC+68r1YXAYgextZ8Ec4YFXDRHkqzikXFX333
         37dU7UIExz2LEEi2fDhUusfQB1oNlPCtsTDn0QOc1r8dVCjcbmR1iioLx7K3OoQ/0s
         qXbJsjXXOKlgzNj5tfQZpXveEX9L1nnvvwFXAePDvKMwWgg7h4D0VF17KzTwp8lsCq
         cWJr7EkWQfcSsNlPdf0SsE0GtSfoCFafNV9J2BArfujl2SloLhFbOYArP92Fqri+M4
         5rYei7At2rahLxe5mfdvbi5keddu9pt+7/rK5xgl6jfLSrxUXTeU8LjOoTwt7PzUku
         8bAVfjF/sihQA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mIWkU-0007M8-GL; Tue, 24 Aug 2021 15:45:54 +0200
Date:   Tue, 24 Aug 2021 15:45:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Zhengjun Zhang <zhangzhengjun@aicrobo.com>
Cc:     larsm17@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] USB: serial: option: add new VID/PID to support
 Fibocom FG150
Message-ID: <YST4Eq2zS8+7B5TL@hovoldconsulting.com>
References: <b3285ae0-8b1f-fc9c-3662-634264d704d5@gmail.com>
 <20210809133553.71158-1-zhangzhengjun@aicrobo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809133553.71158-1-zhangzhengjun@aicrobo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 09:35:53PM +0800, Zhengjun Zhang wrote:
> Fibocom FG150 is a 5G module based on Qualcomm SDX55 platform,
> support Sub-6G band.
> 
> Compared with the first patch, I removed the defines of Fibocom 
> VID and PID by following Lars' suggestion.

When revising patches please put such comments below the '---' line so
that it doesn't end up in the commit message.

> Here are the outputs of lsusb -v and usb-devices:
> 
> > T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0
> > D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
> > P:  Vendor=2cb7 ProdID=010b Rev=04.14
> > S:  Manufacturer=Fibocom
> > S:  Product=Fibocom Modem_SN:XXXXXXXX
> > S:  SerialNumber=XXXXXXXX
> > C:  #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=896mA
> > I:  If#=0x0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=rndis_host
> > I:  If#=0x1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
> > I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> > I:  If#=0x3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=(none)
> > I:  If#=0x4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
> 
> > Bus 002 Device 002: ID 2cb7:010b Fibocom Fibocom Modem_SN:XXXXXXXX

> Signed-off-by: Zhengjun Zhang <zhangzhengjun@aicrobo.com>
> ---
> V1 -> V2: Remove the defines of Fibocom VID and PID
> 
>  drivers/usb/serial/option.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 0fbe253dc..4fcf859e9 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2073,6 +2073,8 @@ static const struct usb_device_id option_ids[] = {
>  	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0105, 0xff),			/* Fibocom NL678 series */
>  	  .driver_info = RSVD(6) },
>  	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0xff, 0x30) },	/* Fibocom FG150 Diag */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0, 0) },	/* Fibocom FG150 AT */

And try to keep the entries sorted by VID/PID where possible.

>  	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
>  	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */

I fixed up the above before applying. Thanks.

Johan
