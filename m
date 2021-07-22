Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6157B3D1B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 03:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhGVAp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 20:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhGVAp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 20:45:28 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF73C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 18:26:04 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id x10so4528810ion.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 18:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZEFkgmUTVjeuYsx4VvotXiwOxlNKuQXZvTuRHJTeDJo=;
        b=G735zQvfkBzRI8EIQJf0oY4XgRqua1+SjwAdBzPqM69liydweNYz398t4cwwpUCYV7
         C0lbr2ip/Dux7th/wkG5pcygQhkZ46KM4DvXIE+sFKQhQ2KlObewqc347nMQjytE4Jkg
         P+/hUOqK2QFA8qLI4A4/U8L5SVLm+2omLPkGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZEFkgmUTVjeuYsx4VvotXiwOxlNKuQXZvTuRHJTeDJo=;
        b=C2A2W1OQGHCLN419zNnagpi1W9SiH0Hu/pGTJ71S9Pl51hQ3/+ou98GsT2NmeFhNaZ
         uH8C/y8zsr20CS3Bzn7uYH4Nga0r5GckSusQKbFxCUX+1nMz/RHLLG8U+YzSXpgdHAz+
         VCLINiEwQTHNgxdltEm3WGETUrKSVI/4VdOmWXd/AHx3SaCaActgGCEbxs1t6aEoLbup
         yuC2StWnL/60qrYOu1wgT8sg8RFZubiTXPrAz8Qw7R/2tQhf/ne7hFu5KgxnMO1S0dw0
         3ySjmryfK5bkzzwuj3KYRr9WEooHzsEtRrDRwobC7CnlNaGtUitajGHRVD+Ms6v8NuwV
         8y/w==
X-Gm-Message-State: AOAM533xo2qjBfdnnO45HTQcDJBiIuvUj1BxzAotD1gv/U8HdZ8QxpQp
        aAS87K4U43ufxd6/MT1DkFH6jA==
X-Google-Smtp-Source: ABdhPJw8fKAGoUQfq5BY2iAvaIP+ZksoIF6fV9bb1gbpgRoBURcPuOJ/y28XeydHgaKpvBE7wmzaYg==
X-Received: by 2002:a02:6946:: with SMTP id e67mr33251483jac.4.1626917163888;
        Wed, 21 Jul 2021 18:26:03 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a10sm16118824ioo.9.2021.07.21.18.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 18:26:03 -0700 (PDT)
Subject: Re: [PATCH v2] vhci_hcd: USB port can get stuck in the disabled state
To:     Michael Broadfoot <msbroadf@gmail.com>,
        valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210721235526.10588-1-msbroadf@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7b02cb66-d672-ae95-01ea-c6015725e1ac@linuxfoundation.org>
Date:   Wed, 21 Jul 2021 19:26:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210721235526.10588-1-msbroadf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/21 5:55 PM, Michael Broadfoot wrote:
> When a remote usb device is attached to the local Virtual USB
> Host Controller Root Hub port, the bound device driver may send a
> port reset command. For example to initialize firmware (eg. btusb does this).
> This port reset command can be sent at any time, however the VHCI hcd
> root hub is only expecting reset to occur before the device receives
> SET_ADDRESS. The USB port should always be enabled after a reset
> (because the port is virtual and there is no possibility of hardware errors)
> 
> 
> 
> Signed-off-by: Michael Broadfoot <msbroadf@gmail.com>
> ---
>   drivers/usb/usbip/vhci_hcd.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 4ba6bcdaa8e9..d3cda1b2c15a 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -455,15 +455,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>   			vhci_hcd->port_status[rhport] &= ~(1 << USB_PORT_FEAT_RESET);
>   			vhci_hcd->re_timeout = 0;
>   
> -			if (vhci_hcd->vdev[rhport].ud.status ==
> -			    VDEV_ST_NOTASSIGNED) {
> -				usbip_dbg_vhci_rh(
> -					" enable rhport %d (status %u)\n",
> -					rhport,
> -					vhci_hcd->vdev[rhport].ud.status);
> -				vhci_hcd->port_status[rhport] |=
> -					USB_PORT_STAT_ENABLE;
> -			}

VDEV_ST_NOTASSIGNED status indicates that the vdev is in use without
address assigned - in other words port is initializing.

This is part of the attach request handling when user requests to
attach to a remote device. attach_store() will change the status
to VDEV_ST_NOTASSIGNED and then initiate port_connect sequence.

We don't want to touch the vdev when it is in other states.
   
> +			usbip_dbg_vhci_rh(" enable rhport %d (status %u)\n",
> +					  rhport,
> +					  vhci_hcd->vdev[rhport].ud.status);
> +			vhci_hcd->port_status[rhport] |= USB_PORT_STAT_ENABLE;
>   
>   			if (hcd->speed < HCD_USB3) {
>   				switch (vhci_hcd->vdev[rhport].speed) {
> 

How did you find this problem? Does the port get into stuck state
while attaching to a remote usbip device on the host?

thanks,
-- Shuah
