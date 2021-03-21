Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713183432BD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 14:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCUNYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 09:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhCUNXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 09:23:51 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A23C061574;
        Sun, 21 Mar 2021 06:23:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i26so1273657lfl.1;
        Sun, 21 Mar 2021 06:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owL9mJRymkaxsBM/wrbRae0nkr164G+jrzlFAlennLA=;
        b=t9WQaangaSaF6vzeS1h+r7N6o4ElFBJ190jcNYWGkhCmPGHmaBaTBqk1GN/bYUVh5A
         omI+UP+l//jkjTyWF+gPwxt6GLld7yo9iVObl0BUGnpmVkLHur/jXxfw8jUlrU4Z8mqC
         2lgRzCPJaPLyFdlU4M8ZeFkXlbBI+kk/VLGwJHwP3s2urLz2/CSGQm8jtevDFSUsrR3U
         R8jsD/P2ETKaLmUQYaI7emZYnG+YGdHhaigEjuQP3yFXx9pbx2gbbBRXAxqDj8EKamad
         vjxa6u9gAqRGmbbmzeFlCaQHeb1i2wMywWfWjWGEwPG73ZLICjfmgi3G55tjTuyq3+bs
         Izuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owL9mJRymkaxsBM/wrbRae0nkr164G+jrzlFAlennLA=;
        b=GtegolPeJIwPxXsjdV6obFdhYafTN/ot8nCu94ti8zOcW1+RiNPNpztTx2FiHKWyyc
         RmLRJH130Qfe0o2YuexG5rCyvGfQdtfQcrmlt1JCtWToRaMbUtN5ybSeEeycfFpkebNi
         U15N7jDZWowewepXol2LTTfpLxZAn14DHGV1d0SDmuJsfXUP74Ee1tNJ2i2g2/Q81be9
         DytxJuzSy24GBWEu5U6qkHC08lorUQCKYx2BkzhsbFzTcTDBsgprXkSr6blv+cR8WhOR
         6jKo4aSCmeGzjvN8sQoaqK0rD4r8jpWjzsUdYhUPAKW6VzMkBuvYxD+XJzyWYYE8tjLA
         HSMQ==
X-Gm-Message-State: AOAM533xQf57BQxm0b0XYSj0fGofY0CodmBKCevjC0vwgpd8AGO/tE8A
        4dSS/ij8NeEsG83v9AxudxMBL6L/Uog0I/9nh2k=
X-Google-Smtp-Source: ABdhPJxFyfbomBzaKEmTx6h8QvI9EB1wl4WbYtNe/MIM9y9LAnEQRRQIK39qYUmjBGgSXM+ea5DiHmFG/6nESItWNGU=
X-Received: by 2002:a19:f614:: with SMTP id x20mr6251768lfe.229.1616333028494;
 Sun, 21 Mar 2021 06:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210319205041.15579-1-tharvey@gateworks.com>
In-Reply-To: <20210319205041.15579-1-tharvey@gateworks.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 21 Mar 2021 10:23:37 -0300
Message-ID: <CAOMZO5C5dmNsXODbXL7nKJY3QdYAG6xCweDAQPQ_X=T5J4KWvA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: imx: add imx8mm gw7901 support
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 5:50 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
> The Gateworks GW7901 is an ARM based single board computer (SBC)
> featuring:
>  - i.MX8M Mini SoC
>  - LPDDR4 DRAM
>  - eMMC FLASH
>  - SPI FRAM
>  - Gateworks System Controller (GSC)
>  - Atmel ATECC Crypto Authentication
>  - USB 2.0
>  - Microchip GbE Switch
>  - Multiple multi-protocol RS232/RS485/RS422 Serial ports
>  - onboard 802.11ac WiFi / BT
>  - microSD socket
>  - miniPCIe socket with PCIe, USB 2.0 and dual SIM sockets
>  - Wide range DC power input
>  - 802.3at PoE
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
