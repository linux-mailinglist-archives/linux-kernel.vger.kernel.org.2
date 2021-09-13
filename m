Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558D34088C4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238980AbhIMKIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:08:02 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:55353 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbhIMKH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631527603; x=1663063603;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ugfxFKb5skliMN99vpU9+w+62Hn+8o39JeEtRKHHXbw=;
  b=V3gysUEc1AV/Tc3Bjg1UMeeqRYAbMV92okYh5RfhX/tPBr2a9RXukzgQ
   PewWj2X8jngsyih+lFFa/g7qKHnx/wcYTHA59z6AeMAAWioix9X4WPOk0
   05iKXfR0hhURbU4sRoDHDrMtp4FBepRdWeylsk+WuqaUqSknBdYsGG8Am
   LvJfz7MCxQ9KZAaEmm7CKrydwlj+mKMxqJ/NzWD4jiybSEVL4rAi3ZAeL
   8FX82sZtqIVLQZ9W23aaMghBjtz+W31nbjYDPR2bG0Xvx7UR0apr2cbqB
   NEyjmnJc2C5XvMM/ALCLdXT4eOGRoJTRCXYOMUAFl6o91srkVStP5a5q7
   A==;
IronPort-SDR: coCM3j+jIc2nvhoVSF9r50HqBsHWaQOAEqVfSdU0hFdXGURWTjXQQ4/RT1UqUY5dy2zP5c4aWk
 ylpyoaP3WT5tdZU+HcS7DNcdxI/n2eHwFHWgkjHiuWYPkLPi0TjMc7n4TRKQHkmYlw+2wFMN4I
 2smAGg77WJjcNmLuv8CTvrJrqX9pMmFf37C2QoQBBl1mE8A9CSgR9WZIsdfFR6uwsYKcxQyLBj
 geoA5KRcx6gm/KNTYu1Q7Pk5SdS4Fm7YDkfAn46kRKuRfSSFO8+CyNsSDRR7AqG03LcGAJ3foh
 t/4yxFvY1tKWtBCCU7OF+1MR
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="131593959"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2021 03:06:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Sep 2021 03:06:41 -0700
Received: from [10.171.246.60] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Mon, 13 Sep 2021 03:06:39 -0700
Subject: Re: [PATCH] clk: at91: check pmc node status before registering
 syscore ops
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210913082633.110168-1-clement.leger@bootlin.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <531a3155-42a8-d31b-a611-80c1c56a93e3@microchip.com>
Date:   Mon, 13 Sep 2021 12:06:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210913082633.110168-1-clement.leger@bootlin.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2021 at 10:26, Clément Léger wrote:
> Currently, at91 pmc driver always register the syscore_ops whatever
> the status of the pmc node that has been found. When set as secure
> and disabled, the pmc should not be accessed or this will generate
> abort exceptions.
> To avoid this, add a check on node availability before registering
> the syscore operations.
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>

Yes, indeed,
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
   Nicolas

> ---
>   drivers/clk/at91/pmc.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index 20ee9dccee78..b40035b011d0 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -267,6 +267,11 @@ static int __init pmc_register_ops(void)
>          if (!np)
>                  return -ENODEV;
> 
> +       if (!of_device_is_available(np)) {
> +               of_node_put(np);
> +               return -ENODEV;
> +       }
> +
>          pmcreg = device_node_to_regmap(np);
>          of_node_put(np);
>          if (IS_ERR(pmcreg))
> --
> 2.33.0
> 


-- 
Nicolas Ferre
