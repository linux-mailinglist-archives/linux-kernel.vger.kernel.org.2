Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6F640AA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhINJTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:19:32 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35166
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229581AbhINJTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:19:30 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3A70D3F332
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631611092;
        bh=aRxLbL6hEiGe6xganEKR1lyiW6DB54cMIWpJYFs9yww=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Yz7nBN8BgbAQWPYoyyWXE2ceEeG2Sxvp0BR1FZ6c3xuF2SBTv72adgWRdpFjpP04O
         fDJSU8v0bAfKmrco7akps9yaV9uNwyWb+DP8pxCBnde43fFAj81iBa+vgQpQz6ysnz
         TkiSY9SsWEUhlhESLYz5wK5N8uLa5N3cF37akfxMyci4HnAReeeazLM7s9VB7Om9sw
         KH8+rMAKl92qTrqUIfa6agaZjSga3X+/z4+jW0Fd1x5K2r7vGutyQgc1b9U6S8b4cG
         nRkwOYUPYNjcc2w4cKUujYzlX95c/57kyj032weSzmBFXH8VGoLvIEYJ9wDHXTTCEp
         V/uYMTCSUYirg==
Received: by mail-ed1-f70.google.com with SMTP id y17-20020a50e611000000b003d051004603so5753211edm.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 02:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aRxLbL6hEiGe6xganEKR1lyiW6DB54cMIWpJYFs9yww=;
        b=AKhmORFw08ylgmH6kS8vlKJma0z/RAEf19CdpoMA8iHGWKNYfN0jR4gUWKCh8d+f3t
         7oz7Cy3G/Q5nbskKkQKumDiTrSN1cvMducq0z930tk8gyNkWyRH2Gxjus3XzgMiZ1ggP
         FdZ33e/IlcFJf0GsfuisckY+WjE/+lCdTts1y/QVdO/LxBhzF9SMecKftyJNbYodlElj
         4dRjeUcEmOS7FE66c2/hAI4sWs6EaJ+kPMza8PQi7SFGsGWRzzKIeyGKSLYOGkCixX3I
         i9QFq76sq1Uw6XGvsAnXONhrJK7k/9qT1s+vnMGHLabXrk+9GbB3S5a3fbNq8zdxQYnj
         bd3A==
X-Gm-Message-State: AOAM530J12TjXFgZjT/V9uElGQA2lrZotQLKwonZ1JwxmIdBnvsnD+do
        6XAm3b0z3TJICBj2K+TrOaAKnzvNkfPtti9qyFbX1XApH7umu1va/aaQ5jwu1aB3cDAjoKFm7Kr
        F16WsYsTuLRpjVAhrufoqPEeH3BE+tPm3tQZCxrbVFg==
X-Received: by 2002:adf:9f0d:: with SMTP id l13mr17852466wrf.328.1631611081603;
        Tue, 14 Sep 2021 02:18:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyzQztBzbBrYTaOhN+AokKj5GVs0m53CtmIkzfLqV3EcR+H0RZPuNBjuVmjpdyhO8bDxCc7A==
X-Received: by 2002:adf:9f0d:: with SMTP id l13mr17852425wrf.328.1631611081418;
        Tue, 14 Sep 2021 02:18:01 -0700 (PDT)
Received: from [192.168.3.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n17sm2747552wrp.17.2021.09.14.02.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 02:18:00 -0700 (PDT)
Subject: Re: [PATCH 08/16] tty: drivers/tty/serial/, stop using
 tty_flip_buffer_push
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Al Cooper <alcooperx@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Alexander Shiyan <shc_work@mail.ru>,
        Baruch Siach <baruch@tkos.co.il>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Timur Tabi <timur@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091415.17918-1-jslaby@suse.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <3551622b-31a5-d349-5785-a07fc1241958@canonical.com>
Date:   Tue, 14 Sep 2021 11:17:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914091415.17918-1-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2021 11:14, Jiri Slaby wrote:
> Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
> tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). We are
> going to remove the former, so call the latter directly in
> drivers/tty/serial/.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Al Cooper <alcooperx@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Richard Genoud <richard.genoud@gmail.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Baruch Siach <baruch@tkos.co.il>
> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Kevin Cernekee <cernekee@gmail.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Peter Korsgaard <jacmet@sunsite.dk>
> Cc: Timur Tabi <timur@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/tty/serial/21285.c                  |  2 +-
>  drivers/tty/serial/8250/8250_aspeed_vuart.c |  2 +-
>  drivers/tty/serial/8250/8250_bcm7271.c      |  2 +-
>  drivers/tty/serial/8250/8250_dma.c          |  2 +-
>  drivers/tty/serial/8250/8250_mtk.c          |  2 +-
>  drivers/tty/serial/8250/8250_omap.c         |  2 +-
>  drivers/tty/serial/8250/8250_port.c         |  2 +-
>  drivers/tty/serial/altera_jtaguart.c        |  2 +-
>  drivers/tty/serial/altera_uart.c            |  2 +-
>  drivers/tty/serial/amba-pl010.c             |  2 +-
>  drivers/tty/serial/amba-pl011.c             |  6 +++---
>  drivers/tty/serial/apbuart.c                |  2 +-
>  drivers/tty/serial/ar933x_uart.c            |  2 +-
>  drivers/tty/serial/arc_uart.c               |  2 +-
>  drivers/tty/serial/atmel_serial.c           |  6 +++---
>  drivers/tty/serial/bcm63xx_uart.c           |  2 +-
>  drivers/tty/serial/clps711x.c               |  2 +-
>  drivers/tty/serial/cpm_uart/cpm_uart_core.c |  2 +-
>  drivers/tty/serial/digicolor-usart.c        |  2 +-
>  drivers/tty/serial/dz.c                     |  2 +-
>  drivers/tty/serial/fsl_linflexuart.c        |  2 +-
>  drivers/tty/serial/fsl_lpuart.c             |  6 +++---
>  drivers/tty/serial/icom.c                   |  2 +-
>  drivers/tty/serial/imx.c                    |  6 +++---
>  drivers/tty/serial/ip22zilog.c              |  4 ++--
>  drivers/tty/serial/jsm/jsm_tty.c            |  2 +-
>  drivers/tty/serial/kgdb_nmi.c               |  2 +-
>  drivers/tty/serial/lantiq.c                 |  4 ++--
>  drivers/tty/serial/liteuart.c               |  2 +-
>  drivers/tty/serial/lpc32xx_hs.c             |  2 +-
>  drivers/tty/serial/max3100.c                |  4 ++--
>  drivers/tty/serial/max310x.c                |  2 +-
>  drivers/tty/serial/mcf.c                    |  2 +-
>  drivers/tty/serial/men_z135_uart.c          |  2 +-
>  drivers/tty/serial/meson_uart.c             |  2 +-
>  drivers/tty/serial/milbeaut_usio.c          |  2 +-
>  drivers/tty/serial/mpc52xx_uart.c           |  2 +-
>  drivers/tty/serial/mps2-uart.c              |  4 ++--
>  drivers/tty/serial/msm_serial.c             |  6 +++---
>  drivers/tty/serial/mux.c                    |  2 +-
>  drivers/tty/serial/mvebu-uart.c             |  2 +-
>  drivers/tty/serial/mxs-auart.c              |  4 ++--
>  drivers/tty/serial/omap-serial.c            |  2 +-
>  drivers/tty/serial/owl-uart.c               |  2 +-
>  drivers/tty/serial/pch_uart.c               |  4 ++--
>  drivers/tty/serial/pic32_uart.c             |  2 +-
>  drivers/tty/serial/pmac_zilog.c             |  4 ++--
>  drivers/tty/serial/pxa.c                    |  2 +-
>  drivers/tty/serial/qcom_geni_serial.c       |  4 ++--
>  drivers/tty/serial/rda-uart.c               |  2 +-
>  drivers/tty/serial/rp2.c                    |  2 +-
>  drivers/tty/serial/sa1100.c                 |  2 +-
>  drivers/tty/serial/samsung_tty.c            |  6 +++---

For Samsung:
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

BR,
Krzysztof
