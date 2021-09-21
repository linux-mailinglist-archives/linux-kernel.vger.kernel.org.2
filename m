Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC95641309E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 11:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhIUJQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 05:16:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:53651 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhIUJQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 05:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632215676; x=1663751676;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=sU/uZ/ub9rAjgqiY4V+Ue2xuUKcXk4fJXKL0f2tFZ1E=;
  b=tHdt28e336Rne1AInXN/wtJ+QcT47SOt/CKhGR114bVrwMRw911fVmMt
   dh3Cjtu+OfI4QRoDAJ88tDpvcc9Car/atfmzmkjhUxC4jIHfRW+I2wNAQ
   qvbZU1HHj3UZBw6QX2OwN3RCXlUgwGQFxIQ4p5o0X47+dscNC0C6Y1EQR
   lWaiBuAwigss7YX6geuBEaCennB6zgXyauBqVZPHBqfaxR2r8wID2Vx3w
   +pgB40ofZFlOELzKbvrHtpUeA1JIbJrIPWIMRz4OQHdzuw1BtSaYIbgAF
   sOp3bRYHWsjdJaWggVdYsObz0ZbydP2oHlMXO03EHMThtLpSBlYONTRbK
   A==;
IronPort-SDR: 3htDqfALrfKxq6LJmZlloORI6FhZDLMMWaRuT6dStSts4JqtIPxYvhGLBtf8kkk6kSmfo2gWW0
 P8P8NxXV8WAQj2lH8vRykeV7+ARBteDJ7vnnK+XWz7V2kOid7kt3nrAoUtULzUrSnGt2MYZqxs
 sqAIHARmoZUI2UWJPZELqKkS06nNhaHwZoaBVopbNKzp62JoexwrpjiGVIXo8/jro3Xb8moRZ8
 AdmKVM8C7b74Y4v/ETs5a1CscbLiaYzWcXeCCa76U0IfRAkGa91tmLEFdaZoF7z4rP3UwOAfTT
 JQvl2GYJ+KxAxIVI/HM76Ivz
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="136731459"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Sep 2021 02:14:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Sep 2021 02:14:34 -0700
Received: from [10.171.246.85] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 21 Sep 2021 02:14:32 -0700
Subject: Re: [PATCH] ARM: dts: at91: tse850: the emac<->phy interface is rmii
To:     Peter Rosin <peda@axentia.se>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <ea781f5e-422f-6cbf-3cf4-d5a7bac9392d@axentia.se>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <a1ec7070-d35b-9439-f509-7c05a94f9741@microchip.com>
Date:   Tue, 21 Sep 2021 11:14:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ea781f5e-422f-6cbf-3cf4-d5a7bac9392d@axentia.se>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2021 at 22:37, Peter Rosin wrote:
>>From d5ff443099cdf29a34128a6440e8debd71202aaa Mon Sep 17 00:00:00 2001
> From: Peter Rosin <peda@axentia.se>
> 
> This went unnoticed until commit 7897b071ac3b ("net: macb: convert
> to phylink") which tickled the problem. The sama5d3 emac has never
> been capable of rgmii, and it all just happened to work before that
> commit.
> 
> Fixes: 21dd0ece34c2 ("ARM: dts: at91: add devicetree for the Axentia TSE-850")
> Signed-off-by: Peter Rosin <peda@axentia.se>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
and queued to at91-dt for 5.16.

Thanks, best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/at91-tse850-3.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91-tse850-3.dts b/arch/arm/boot/dts/at91-tse850-3.dts
> index 3ca97b47c69c..7e5c598e7e68 100644
> --- a/arch/arm/boot/dts/at91-tse850-3.dts
> +++ b/arch/arm/boot/dts/at91-tse850-3.dts
> @@ -262,7 +262,7 @@
>   &macb1 {
>          status = "okay";
> 
> -       phy-mode = "rgmii";
> +       phy-mode = "rmii";
> 
>          #address-cells = <1>;
>          #size-cells = <0>;
> --
> 2.20.1
> 


-- 
Nicolas Ferre
