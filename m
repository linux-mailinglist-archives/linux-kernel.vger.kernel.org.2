Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5DF3A14A7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhFIMmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:42:17 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:50367 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbhFIMmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1623242422; x=1654778422;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=5zFddy7XzQ7kQ5Mr+nWnyexNNlueuTF7XbqLXWbdygk=;
  b=qA8g0p47OsMzPJO9E+zeCG0N/ZTgvPjDaFFT/hyJpFvZLE5q8Hx1IXSp
   hjtChppeeF/eYhp504SqZq6Kb5nIp5s8oitSogQ7yxycndYKMnRsqu0Qa
   ERnuSaDClOlpHdC3Qr31Ovem4z+DQBOZ7ZxBKB1ngtrGdBai9W40CiizW
   K7TQpEI3uccZMuwmk4GYAkbde/BwoH6y2UQatW7ULvRGPH1huq2NwuUBc
   roGN6bOwspIBgvG5klHPx92Ba/CDJTJhnAmt7LP6i2joA6Q3xfX4jg46c
   +wC7RUZSeEffwCGxiw3bGr596GP1T7Gkp11EYiK8RnuvzVRFLrdWKsHd5
   g==;
IronPort-SDR: 3x7DKgYbgTGAMfPgmsNKBP1qv3u11OS4L5HpC7VXRqi48chqvY75rYXyBZcHjLiaQv9RjZOrZR
 Ha5RTC9DSONLrRSlc5hwM5L7ejqlUC3Px9pyf2xrIH1Lp2XhIkUbzmxZIC7H5LaZwHE25dgawH
 HOYBmqOptP1O0TN3dZr5MzrDPofwDQHgSwCz36hqxBaaXw+7sq1LBDHHCkY6ZbB4Cbyy2MziYe
 9mk0k0uk4uYmCCMikkol1FNV8KoRPa237mBRd1Tx2RbJpHCGKcKuw/7/0xg5O4J2H7qW3yQ9kb
 BWU=
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="120692322"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2021 05:40:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 05:40:21 -0700
Received: from [10.12.74.10] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Wed, 9 Jun 2021 05:40:19 -0700
Subject: Re: [PATCH] usb: host: ohci-at91: suspend/resume ports after/before
 OHCI accesses
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <cristian.birsan@microchip.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210609121027.70951-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <21280c02-0dd2-461a-1baf-464f280d2f0e@microchip.com>
Date:   Wed, 9 Jun 2021 14:40:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210609121027.70951-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2021 at 14:10, Claudiu Beznea wrote:
> On SAMA7G5 suspending ports will cut the access to OHCI registers and
> any subsequent access to them will lead to CPU being blocked trying to
> access that memory. Same thing happens on resume: if OHCI memory is
> accessed before resuming ports the CPU will block on that access. The
> OCHI memory is accessed on suspend/resume though
> ohci_suspend()/ohci_resume().
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Claudiu,

Your patch look good to me.

In addition, I see ohci_at91_port_suspend() function also used in 
ohci_at91_hub_control(). It might suffer the same problem as I see 
accesses to ohci register, at first glance.

Can you please double check that we are not in such condition with calls 
to ohci_at91_hub_control()?

Best regards,
   Nicolas


> ---
> 
> The patch was tested on SAMA7G5, SAMA5D2 and SAM9X60.
> 
> Thank you,
> Claudiu Beznea
> 
>   drivers/usb/host/ohci-at91.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index b3a6a497dcb1..7c6202b05ff4 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -666,8 +666,6 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
>   	if (ohci_at91->wakeup)
>   		enable_irq_wake(hcd->irq);
>   
> -	ohci_at91_port_suspend(ohci_at91, 1);
> -
>   	ret = ohci_suspend(hcd, ohci_at91->wakeup);
>   	if (ret) {
>   		if (ohci_at91->wakeup)
> @@ -687,7 +685,10 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
>   		/* flush the writes */
>   		(void) ohci_readl (ohci, &ohci->regs->control);
>   		msleep(1);
> +		ohci_at91_port_suspend(ohci_at91, 1);
>   		at91_stop_clock(ohci_at91);
> +	} else {
> +		ohci_at91_port_suspend(ohci_at91, 1);
>   	}
>   
>   	return ret;
> @@ -699,6 +700,8 @@ ohci_hcd_at91_drv_resume(struct device *dev)
>   	struct usb_hcd	*hcd = dev_get_drvdata(dev);
>   	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
>   
> +	ohci_at91_port_suspend(ohci_at91, 0);
> +
>   	if (ohci_at91->wakeup)
>   		disable_irq_wake(hcd->irq);
>   	else
> @@ -706,8 +709,6 @@ ohci_hcd_at91_drv_resume(struct device *dev)
>   
>   	ohci_resume(hcd, false);
>   
> -	ohci_at91_port_suspend(ohci_at91, 0);
> -
>   	return 0;
>   }
>   
> 


-- 
Nicolas Ferre
