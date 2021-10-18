Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D468243183B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhJRL5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:57:36 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:17771 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhJRL5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634558124; x=1666094124;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+0EWDsZwiYy0mDEZmM3uryHSjoVyUGQg/QrDSKmA3PU=;
  b=aM7yRmqKpVK5ao87V74OC0svY+IO8oqt6KolWfiSl79b7BKtYiKyI2pn
   3C6H4dEP9spS8riXjY3Y4DHWk/MLx6Ns8c7x81PLIx7y7+N5yrVq+IHpF
   AfM9Sw2ogSgr3xxQvcKQbRD8FQEN4K3MI1DspohvtGYp2W0yD8AYdo21n
   09/g0yMWjRlQiMCmxuhBfPdCqU+HLrzfWtZntdia7qYO9UytkrbQcWZ3/
   WRvUa3JJQ1VjVrWFjnSiJUc6VNseW81+jomg5oh1Na4vP1ju2tHvSU6Mk
   1UexeMrYx668TCp1JrfFNP2g/fF3HcItS45iCll00pRGXUaPA1c852ZOf
   A==;
IronPort-SDR: TBu+nh9jvmmFEES4nwx7YMPIyWL9UjIaPObAsYW17g3ingyOuCec34qqJMOp+RNSkrUW22mylr
 0ZpVDjXJ91iA316K6Pz3ZZgPrJlqWxaDTnaFYZK/IB3Ir+wcV0JFSWknuIvEyi5im/I7QX146o
 sEiRnbv9v8klQD++ohZiq3g0agsz9lFBcFl1+FL1IEmiMwKPbx+LQZe5HgP63qc84alfb9cOui
 q6T/ZX5FQtcR+Rg0uLzU751Z7MBFSPP+2PUI2eMCIUSfDbkMylGJpzzH+oVcrZWegG3sOLAAFv
 JYubtvpKvYXIZE5AGrBzVxgt
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="140726522"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Oct 2021 04:55:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 18 Oct 2021 04:55:23 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Mon, 18 Oct 2021 04:55:21 -0700
Subject: Re: [PATCH v8 1/3] dt-bindings: clock: lan966x: Add binding includes
 for lan966x SoC clock IDs
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Manohar.Puri@microchip.com>
References: <20211008082635.31774-1-kavyasree.kotagiri@microchip.com>
 <20211008082635.31774-2-kavyasree.kotagiri@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <b236a54b-3291-b361-52e4-fa0ba6d38d0c@microchip.com>
Date:   Mon, 18 Oct 2021 13:55:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211008082635.31774-2-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2021 at 10:26, Kavyasree Kotagiri wrote:
> LAN966X supports 14 clock outputs for its peripherals.
> This include file is introduced to use identifiers for clocks.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> Acked-by: Rob Herring <robh@kernel.org>

If mine is missing:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
> v7 -> v8:
> - No changes.
> 
> v6 -> v7:
> - No changes.
> 
> v5 -> v6:
> - Added Acked-by.
> 
> v4 -> v5:
> - No changes.
> 
> v3 -> v4:
> - No changes.
> 
> v2 -> v3:
> - No changes.
> 
> v1 -> v2:
> - Updated license.
> 
>   include/dt-bindings/clock/microchip,lan966x.h | 28 +++++++++++++++++++
>   1 file changed, 28 insertions(+)
>   create mode 100644 include/dt-bindings/clock/microchip,lan966x.h
> 
> diff --git a/include/dt-bindings/clock/microchip,lan966x.h b/include/dt-bindings/clock/microchip,lan966x.h
> new file mode 100644
> index 000000000000..fe36ed6d8b5f
> --- /dev/null
> +++ b/include/dt-bindings/clock/microchip,lan966x.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2021 Microchip Inc.
> + *
> + * Author: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_LAN966X_H
> +#define _DT_BINDINGS_CLK_LAN966X_H
> +
> +#define GCK_ID_QSPI0		0
> +#define GCK_ID_QSPI1		1
> +#define GCK_ID_QSPI2		2
> +#define GCK_ID_SDMMC0		3
> +#define GCK_ID_PI		4
> +#define GCK_ID_MCAN0		5
> +#define GCK_ID_MCAN1		6
> +#define GCK_ID_FLEXCOM0		7
> +#define GCK_ID_FLEXCOM1		8
> +#define GCK_ID_FLEXCOM2		9
> +#define GCK_ID_FLEXCOM3		10
> +#define GCK_ID_FLEXCOM4		11
> +#define GCK_ID_TIMER		12
> +#define GCK_ID_USB_REFCLK	13
> +
> +#define N_CLOCKS		14
> +
> +#endif
> 


-- 
Nicolas Ferre
