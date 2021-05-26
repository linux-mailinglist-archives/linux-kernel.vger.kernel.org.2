Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40369391AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbhEZPCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:02:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51860 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbhEZPCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:02:23 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QF0hHl068220;
        Wed, 26 May 2021 10:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622041243;
        bh=KSn29xqPrlOJE1jBmF6CJiblilNo6FIuGgO5Ml3YlGQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rP13muS1aM3xLsk0EU4c3VFQ47VevpJBov+o/fEmweqlbA/7xqrp48jaX+B0a72AW
         ZaIvjOjkdz7BmE/c0JwCPxaFYG6Isj7NON1aS377noN3zHyt5GoyFvQmKYFeb17859
         2poCgJ0SEBcp39jWT0IoXZU1PPP25RhDQ7NO8wTs=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QF0h9H063129
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 10:00:43 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 10:00:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 10:00:42 -0500
Received: from [10.250.149.110] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QF0b3m052256;
        Wed, 26 May 2021 10:00:38 -0500
Subject: Re: [PATCH] usb: cdns3: Enable TDL_CHK only for OUT ep
To:     Sanket Parmar <sparmar@cadence.com>, <peter.chen@kernel.org>
CC:     <pawell@cadence.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        <gregkh@linuxfoundation.org>, <kishon@ti.com>
References: <1621263912-13175-1-git-send-email-sparmar@cadence.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <e4c41fa3-6739-ab4f-51bf-74ede67749bb@ti.com>
Date:   Wed, 26 May 2021 20:30:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1621263912-13175-1-git-send-email-sparmar@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 17/05/21 8:35 pm, Sanket Parmar wrote:
> ZLP gets stuck if TDL_CHK bit is set and TDL_FROM_TRB is used
> as TDL source for IN endpoints. To fix it, TDL_CHK is only
> enabled for OUT endpoints.
> 
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Reported-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Sanket Parmar <sparmar@cadence.com>
> ---

May I know if this patch will be picked up as a bug fix for -rc.

Thanks,
Aswath

>  drivers/usb/cdns3/cdns3-gadget.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index 105855a..f3c0276 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -2007,7 +2007,7 @@ static void cdns3_configure_dmult(struct cdns3_device *priv_dev,
>  		else
>  			mask = BIT(priv_ep->num);
>  
> -		if (priv_ep->type != USB_ENDPOINT_XFER_ISOC) {
> +		if (priv_ep->type != USB_ENDPOINT_XFER_ISOC  && !priv_ep->dir) {
>  			cdns3_set_register_bit(&regs->tdl_from_trb, mask);
>  			cdns3_set_register_bit(&regs->tdl_beh, mask);
>  			cdns3_set_register_bit(&regs->tdl_beh2, mask);
> @@ -2046,15 +2046,13 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
>  	case USB_ENDPOINT_XFER_INT:
>  		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_INT);
>  
> -		if ((priv_dev->dev_ver == DEV_VER_V2 && !priv_ep->dir) ||
> -		    priv_dev->dev_ver > DEV_VER_V2)
> +		if (priv_dev->dev_ver >= DEV_VER_V2 && !priv_ep->dir)
>  			ep_cfg |= EP_CFG_TDL_CHK;
>  		break;
>  	case USB_ENDPOINT_XFER_BULK:
>  		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_BULK);
>  
> -		if ((priv_dev->dev_ver == DEV_VER_V2  && !priv_ep->dir) ||
> -		    priv_dev->dev_ver > DEV_VER_V2)
> +		if (priv_dev->dev_ver >= DEV_VER_V2 && !priv_ep->dir)
>  			ep_cfg |= EP_CFG_TDL_CHK;
>  		break;
>  	default:
> 

