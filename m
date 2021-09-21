Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2495C4131B5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhIUKgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:36:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:40763 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhIUKgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632220484; x=1663756484;
  h=from:subject:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Rx31vdd/RrSmlgTJVbNEqNylEl36VLncaM1cWWQr0L0=;
  b=kg5BbN4zjr87SdLijGNeuKgdcEkmuuJBj3NjSsE0v9TiSLbhvSqTsvxL
   8SaPu1kLIqOg8KTtw6A4OcZIq/Z2D2TDgeB3/teseiDcBIQg/k4+2La6y
   UNjoscurc0Xw2vDTReoAB+9stoV5NM2eymZ5pKEX1JEAJSIdUXtdz+y8L
   vzUJOrXclvAlofHLkZSipYUQTEJOCY3KlxmA/VIEhNGjh3UyG1vzCmUKq
   7sJZaZaOayz/6fIbwuaDgMGB6Tk1TQNyJscKfAtpNil5OX2igClOaAL41
   TtTdm+wHQjnOHDbwkHuglsondOBGh+X1qUpm0jwfASXrZKgP5cySMlNRY
   Q==;
IronPort-SDR: 40fZUBVLdVuEt+lsKbSQ6u5TBklpIcSqNwohDedZnHykZKO5DLOYZh/YhZcSncZ2RBobQiO8cv
 4U6vjJgFv5kvSBlwObCEyqmZiHwNmaqizw9VuX6neoOqeCVdHsejGMb+TAXVMEk0CglLgaqAp1
 NXjE/wEjQwxCLxxe531fJEDIxfCX8mqTgulsCA1UrZQqnKtz6MZtucf/w0Ru9zJsw9Mivv6pEk
 pfJ6oM6Sip4ou+dsE/eXIrhrCsfNwj2H1OZsi5h/9gZgNODJyGwISU3nIivTeAFOhCrvVQVByL
 BZZM3ahEDTFUKUv6WRYZ7cU+
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="137340616"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Sep 2021 03:34:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Sep 2021 03:34:43 -0700
Received: from [10.171.246.85] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 21 Sep 2021 03:34:41 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 1/2] ARM: at91: dts: sama5d29: Add dtsi file for sama5d29
To:     Hari Prasath <Hari.PrasathGE@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@armlinux.org.uk>
References: <20210812140758.28273-1-Hari.PrasathGE@microchip.com>
Organization: microchip
Message-ID: <37ffc77b-5164-ead0-f162-bf31d2cfaa83@microchip.com>
Date:   Tue, 21 Sep 2021 12:34:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210812140758.28273-1-Hari.PrasathGE@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2021 at 16:07, Hari Prasath wrote:
> A new dtsi file for sama5d29 SoC is added which basically inherits the sama5d2
> dtsi with the mac controller compatible property updated.
> 
> Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
And added to our at91-dt branch for 5.16.

Best regards,
    Nicolas

> ---
>   arch/arm/boot/dts/sama5d29.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>   create mode 100644 arch/arm/boot/dts/sama5d29.dtsi
> 
> diff --git a/arch/arm/boot/dts/sama5d29.dtsi b/arch/arm/boot/dts/sama5d29.dtsi
> new file mode 100644
> index 000000000000..e8cc73c0619f
> --- /dev/null
> +++ b/arch/arm/boot/dts/sama5d29.dtsi
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * sama5d29.dtsi - Device Tree Include file for SAMA5D29 SoC of the SAMA5D2
> + * family.
> + *
> + *  Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
> + *
> + *  Author: Hari Prasath <Hari.PrasathGE@microchip.com>
> + *
> + */
> +
> +#include "sama5d2.dtsi"
> +
> +&macb0 {
> +compatible = "atmel,sama5d29-gem";
> +};
> 


-- 
Nicolas Ferre
