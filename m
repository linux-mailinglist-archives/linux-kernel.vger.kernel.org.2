Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A9D41C01A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 09:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244681AbhI2HuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 03:50:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243252AbhI2HuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 03:50:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A437A613C8;
        Wed, 29 Sep 2021 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632901706;
        bh=Ij6oqmx2xp/RI901C67pBD+5q8ON3zfgXKfYNpsCiZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6viwwTECLzKPuyQTf4O6zpdxfn89eLolf9030cofRx7nsb8in5uCmmhJ9lWIIgjf
         jJLbnVP7269R75lbIsil2IJCyy8c0u6+ftvTDrYllB4wc2avwO2i2UG7nieTV9nE27
         1xe1xI4/BfiIt6aTFpEH3/9ExJ3yKo97DPgY7RG3L+WmrUOyi/8isXK/bmWTl8Amw6
         49vKsrm/HlcYcvzNXPnM2uxqa8J+c6eRT6TayWZR1NJRkWuv3YWO/h9GacL2aDsqPe
         mwhqFQhapzrZORwHtZsHHT5UE4P1Fuq6UMJXaelDDwZ4+XtSq64Nd1CZ5j4MyB32pV
         L/cypBrX93hqQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mVUKI-0006Uw-TS; Wed, 29 Sep 2021 09:48:27 +0200
Date:   Wed, 29 Sep 2021 09:48:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Yu-Tung Chang <mtwget@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Quectel EC200S-CN module support
Message-ID: <YVQaSj+zIaoeZJKs@hovoldconsulting.com>
References: <20210929071713.319751-1-mtwget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210929071713.319751-1-mtwget@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 03:17:13PM +0800, Yu-Tung Chang wrote:
> Add usb product id of the Quectel EC200S-CN module.
> 
> usb-devices output for 0x6002:
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=480 MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2c7c ProdID=6002 Rev=03.18
> S:  Manufacturer=Android
> S:  Product=Android
> S:  SerialNumber=0000
> C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
> I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
> I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> I:  If#=0x2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> I:  If#=0x3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> I:  If#=0x4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> 
> Signed-off-by: Yu-Tung Chang <mtwget@gmail.com>
> ---
>  drivers/usb/serial/option.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 6cfb5d33609f..428d101f6193 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -252,6 +252,7 @@ static void option_instat_callback(struct urb *urb);
>  #define QUECTEL_PRODUCT_EM12			0x0512
>  #define QUECTEL_PRODUCT_RM500Q			0x0800
>  #define QUECTEL_PRODUCT_EC200T			0x6026
> +#define QUECTEL_PRODUCT_EC200S_CN		0x6002

You forgot the actual entry. Also keep the defines sorted by PID·
 
>  #define CMOTECH_VENDOR_ID			0x16d8
>  #define CMOTECH_PRODUCT_6001			0x6001

Johan
