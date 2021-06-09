Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922433A13B8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhFIMG6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Jun 2021 08:06:58 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:41631 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbhFIMG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:06:57 -0400
Received: by mail-ua1-f41.google.com with SMTP id g34so12762651uah.8;
        Wed, 09 Jun 2021 05:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bB6XM12yprLPFoNwutgUyB3njSDuVRGfpEtvr0UqK8E=;
        b=WVnwFClrFvemeUv92j6sJiLWk/BIsGCP1ohlVDamdpeUJ3hR49+zxDAJQMMYSG2AqJ
         b199t+elARYDqGxJcMm0p4/RMDgozb/NiKY2Kig/Z/ggiR/d15dgNfDQSh8my6el0SvP
         zjwRfZMtEibMJMXozicW/0+BtoAhIm+zXx255ylO0NwPM6wjNT1kCeFVZ2cyLJi/7n4K
         QobdfoTDGADHQQjzP72Ui+0WXeNC/QiPhbdnLpTC0I60w1cTYs6n0LV6RzuYdbC3wHMt
         /vl/th3xADEbKztmWglRgjwot7W6Qoy2n6+eFGc/C2VTNH2q/KJJTZVXRqLCM6BQB41J
         XRNg==
X-Gm-Message-State: AOAM530qOx+KLfTonkiYP+C9OI8A7evB2xVG5jthdQ6PYaUahs7AujIP
        YAV7ETzt4yj3HQuatDxaDydizxBa23Y4R0M7oJ65r+jpJZM=
X-Google-Smtp-Source: ABdhPJxkVHC78nRXOL62apDKXIIiTaPSbYJOa/DdeJsofMRspd3gymywG39zgIcSDYK+yyeVq89bME3aEbJ/ebS9KfI=
X-Received: by 2002:ab0:2a4e:: with SMTP id p14mr9356668uar.2.1623240302138;
 Wed, 09 Jun 2021 05:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623239033.git.michal.simek@xilinx.com> <ea3944deffedd8a09f097a54016bf9f2e9ddcb0e.1623239033.git.michal.simek@xilinx.com>
In-Reply-To: <ea3944deffedd8a09f097a54016bf9f2e9ddcb0e.1623239033.git.michal.simek@xilinx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Jun 2021 14:04:50 +0200
Message-ID: <CAMuHMdX7J5UK1Y_ghqneppFTHDw=MQTUGcBy6GTeeCPZtcJojg@mail.gmail.com>
Subject: Re: [PATCH 31/31] arm64: zynqmp: Add support for Xilinx Kria SOM board
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, Jun 9, 2021 at 1:46 PM Michal Simek <michal.simek@xilinx.com> wrote:
> There are couple of revisions of SOMs (k26) and associated carrier cards
> (kv260).
> SOM itself has two major versions:
> sm-k26 - SOM with EMMC
> smk-k26 - SOM without EMMC used on starter kit with preprogrammed firmware
> in QSPI.
>
> SOMs are describing only devices available on the SOM or connections which
> are described in specification (for example UART, fwuen).
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
> @@ -0,0 +1,371 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for KV260 revA Carrier Card
> + *
> + * (C) Copyright 2020, Xilinx, Inc.
> + *
> + * SD level shifter:
> + * "A" – A01 board un-modified (NXP)
> + * "Y" – A01 board modified with legacy interposer (Nexperia)
> + * "Z" – A01 board modified with Diode interposer
> + *
> + * Michal Simek <michal.simek@xilinx.com>
> + */
> +
> + #include <dt-bindings/gpio/gpio.h>
> + #include <dt-bindings/net/ti-dp83867.h>
> + #include <dt-bindings/phy/phy.h>
> + #include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
> +
> +/dts-v1/;
> +/plugin/;
> +
> +/{
> +       compatible = "xlnx,zynqmp-sk-kv260-revA",
> +                    "xlnx,zynqmp-sk-kv260-revY",
> +                    "xlnx,zynqmp-sk-kv260-revZ",
> +                    "xlnx,zynqmp-sk-kv260", "xlnx,zynqmp";
> +
> +       fragment1 {
> +               target = <&i2c1>; /* I2C_SCK C23/C24 - MIO from SOM */
> +
> +               __overlay__ {

Please use overlay sugar syntax, which is supported by the dtc
supplied with the kernel since v4.15.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
