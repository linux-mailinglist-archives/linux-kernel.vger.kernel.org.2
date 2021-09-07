Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3C0402E9C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbhIGS6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:58:48 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:33362 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237636AbhIGS6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:58:46 -0400
Received: by mail-oi1-f169.google.com with SMTP id n27so252761oij.0;
        Tue, 07 Sep 2021 11:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fVi6pes3fZQLzF+z2PRa1UMXoBWQHeJ7kqWgiCNEvBY=;
        b=NcpBbLEM/NGH7TTwvCenNrsLHs/1It/VIq0UgR/Tfg+ALe7p+0XwPtvbx40bc96e5A
         ujEwmODTzN9vZC+u81YsJzfXxoanA0oIrSp1bOufuV6G0yPqfq/Wna+KFOaejql9l7d4
         himIXeDsk20ywCadrf4IEW1eRcbQeSLdK5eGaBtzZqPfchBH6o3tdvBvanw2JIu6+WYk
         +Z4FUfNHocrOK9Etn+BC0NKe4iG57dDFjCQ+CU3oXaceY8LbU21lYaAoHTnO5ZTG+jHt
         +qPg1KjhPRfo8PXr0jvXvKNdA6+vIT7Iiz8whMvx6FQpSDadzvNK7SFcSsMrknm8RS6V
         aHrw==
X-Gm-Message-State: AOAM533RNACt7CC46YFqHME07MDTx3+JFso3f02M5dpCWtOuH2uHHK8b
        v6YRGiXlrKOuv7TWvvRqpw==
X-Google-Smtp-Source: ABdhPJwMEOIJHBQtdq35ND4b2qQiYeBMY8emOgOgAikR5kMvFTpuabYZWx5rzGSriJYYItw+Lh1mqg==
X-Received: by 2002:a05:6808:158d:: with SMTP id t13mr4007576oiw.27.1631041059963;
        Tue, 07 Sep 2021 11:57:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z18sm2305470oib.27.2021.09.07.11.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 11:57:39 -0700 (PDT)
Received: (nullmailer pid 154595 invoked by uid 1000);
        Tue, 07 Sep 2021 18:57:38 -0000
Date:   Tue, 7 Sep 2021 13:57:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     kavyasree.kotagiri@microchip.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Eugen.Hristev@microchip.com, Manohar.Puri@microchip.com
Subject: Re: [PATCH 1/3] dt-bindings: clock: lan966x: Add binding includes
 for lan966x SoC clock IDs
Message-ID: <YTe2IhcupZFnypSZ@robh.at.kernel.org>
References: <20210902092908.28264-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902092908.28264-1-kavyasree.kotagiri@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 02:59:08PM +0530, kavyasree.kotagiri@microchip.com wrote:
> From: Kavyasree Kotagiri <Kavyasree.Kotagiri@microchip.com>
> 
> LAN966X supports 14 clock outputs for its peripherals.
> This include file is introduced to use identifiers for clocks.
> 
> Signed-off-by: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  include/dt-bindings/clock/microchip,lan966x.h | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 include/dt-bindings/clock/microchip,lan966x.h
> 
> diff --git a/include/dt-bindings/clock/microchip,lan966x.h b/include/dt-bindings/clock/microchip,lan966x.h
> new file mode 100644
> index 000000000000..97dd9d6480a8
> --- /dev/null
> +++ b/include/dt-bindings/clock/microchip,lan966x.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Dual license please.

Where's the rest of the series? Lore only finds 1/3.


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
> --
> 2.17.1
> 
> 
