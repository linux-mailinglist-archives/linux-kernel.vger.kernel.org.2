Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E93240B271
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbhINPEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:04:43 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:46552 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbhINPEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631631805; x=1663167805;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qz4dR1CgzYGGT0z26GzDEuB5PYVw4P8xOIwzgKSUxx4=;
  b=Bz27UoGJg6mzzCDHrC2+KSczIFYix7I/78MIdO7yRS5b8Oy0+pFhvIpu
   vAO/aVfXE0dIVWMkP1vgrbH309d0XjHfKiDF0OPRqQyvzJV5O7l8ZAvkj
   465LvREbdoI7lacSl4z8SSfAJD5qZnaqdJkpPJZUSGix6r3EmXqyw9HgC
   DsEf96p3etGWRKaJd6fGgHCbCtY9yEfXDBA/LFu3/x0s/P3PHglr3Kphv
   ZCzGb2VdBpu/0eP1KZ9qVRvr2dxkHEOaV6i3k2EACd2X3l+OfGrIAjm7p
   TCJLG1OAkiATnFc/IV4JcQQlMM4ZaG2ICPF/rh+3bvXt2veS5CqBQVaWB
   A==;
IronPort-SDR: K15dS+qzzbY1xjhLJL7gX16f92HHzS9PV9OYHL1A/6qcMySbagr3Bu+xptlD+wjBi7Fr7HgxLT
 hThTAT6UqAMC6uybEvvEjiCWDl53Dz7mvAqvRShRnsLcTBHVCyOudLy0Y+427EwHvKbW2LeiKE
 4g3pyGhVbimKszgkab2GxvCN05jmqJCM4sPqjCJxgqVxJrgSughqNdjaKUz0nluj30oSMlaa4c
 d6bz5ZizMRIf9LKJp7XbM/FQYxL4g8O3G828695PSSHXhqgIaBCrnO1eDOnj10t6ukKyoeH9Zu
 zqfwpqtOKm+6oe95suo1tK3n
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="129271935"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2021 08:03:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 14 Sep 2021 08:03:18 -0700
Received: from [10.171.246.26] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 14 Sep 2021 08:03:16 -0700
Subject: Re: [PATCH] ARM: dts: at91: sama5d2_som1_ek: disable ISC node by
 default
To:     Eugen Hristev <eugen.hristev@microchip.com>
CC:     <robh+dt@kernel.org>, <ludovic.desroches@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210902121358.503589-1-eugen.hristev@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <c3afbdb3-ad68-f277-7405-9e98af1c8f97@microchip.com>
Date:   Tue, 14 Sep 2021 17:03:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210902121358.503589-1-eugen.hristev@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2021 at 14:13, Eugen Hristev wrote:
> Without a sensor node, the ISC will simply fail to probe, as the
> corresponding port node is missing.
> It is then logical to disable the node in the devicetree.
> If we add a port with a connection to a sensor endpoint, ISC can be enabled.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Makes sense:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

And queued for at91-fixes in 5.15 as there is no point continuing to 
have a failing probe on this board.

Thanks, best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> index 614999dcb990..cd4672501add 100644
> --- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> +++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
> @@ -71,7 +71,6 @@ apb {
>   			isc: isc@f0008000 {
>   				pinctrl-names = "default";
>   				pinctrl-0 = <&pinctrl_isc_base &pinctrl_isc_data_8bit &pinctrl_isc_data_9_10 &pinctrl_isc_data_11_12>;
> -				status = "okay";
>   			};
>   
>   			qspi1: spi@f0024000 {
> 


-- 
Nicolas Ferre
